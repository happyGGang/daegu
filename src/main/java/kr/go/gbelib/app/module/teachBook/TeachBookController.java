package kr.go.gbelib.app.module.teachBook;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StrUtil;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.teach.student.StudentService;
import kr.go.gbelib.app.cms.module.teachBook.TeachBook;
import kr.go.gbelib.app.cms.module.teachBook.TeachBookSearchView;
import kr.go.gbelib.app.cms.module.teachBook.TeachBookService;

@Controller(value = "userTeachBook")
@RequestMapping(value = { "/{homepagePath}/module/teachBook" })
public class TeachBookController extends BaseController {

	private String basePath = "/homepage/%s/module/teachBook/";
	
	@Autowired
	private TeachService teachService;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private TeachBookService teachBookService;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private CalendarManageService calendarManageService;
	
	@Autowired
	private CodeService codeService;
	
	
	@ModelAttribute("siteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
	}
	
	@RequestMapping(value = {"/index.*"}) 
	public String index(Model model, TeachBook teachBook, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		teachBook.setHomepage_id(homepage.getHomepage_id());	
		
		model.addAttribute("teachBook", teachBook);
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = {"/teachBook.*"}) 
	public String teachBook(Model model, TeachBook teachBook, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		teachBook.setHomepage_id(homepage.getHomepage_id());	
		
		Teach teachOne = teachService.getTeachOne(new Teach(teachBook.getHomepage_id(), teachBook.getGroup_idx(), teachBook.getCategory_idx(), teachBook.getTeach_idx()));
		
		if (teachBook.getSel_date() == null || teachBook.getSel_date().equals("")) {
			if (teachOne == null) {
				teachBook.setSel_date(StrUtil.Todate("now").substring(0, 7));
			} else {
				teachBook.setSel_date(teachOne.getStart_date().substring(0, 7));
			}
		}
		List<Student> studentList = studentService.getStudentListAll(new Student(teachBook.getHomepage_id(), teachBook.getGroup_idx(), teachBook.getCategory_idx(), teachBook.getTeach_idx(), "1"));
		List<TeachBook> teachBookList = teachBookService.getTeachBookList(teachBook);
		model.addAttribute("studentList", studentList);
		model.addAttribute("codeList", codeService.getCode("CMS", "C0008"));
		model.addAttribute("teach", teachOne);
		model.addAttribute("calendar", calendarManageService.getCalendar(new CalendarManage(teachBook.getSel_date())));
		model.addAttribute("teachBook", teachBook);
		model.addAttribute("teachBookRepo", makeTeachBook(studentList, teachBookList));
		
		return String.format(basePath, homepage.getFolder()) + "teachBook_ajax";
	}
	
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(TeachBook teachBook, BindingResult result, HttpServletRequest request) throws ParseException {

		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */
		String[] patternDate = {"yyyy-MM-dd"};
		Date now = new Date();
		
		if (!result.hasErrors()) {
			teachBook.setAdd_id(getSessionMemberId(request));
			teachBook.setMod_id(getSessionMemberId(request));
			if ( teachBook.getEditMode().equals("ONESAVE") ) {
				if ( now.before(DateUtils.parseDate(teachBook.getTeach_date(), patternDate)) ) {
					res.setValid(false);
					res.setMessage(String.format("해당 일자는 %s일 이후 출석체크 불가능 합니다.", teachBook.getTeach_date()));
					return res;
				}
				if ( teachBookService.checkTeachBookStudentByDate(teachBook) > 0 ) {
					if ( teachBook.getStatus().equals("0") ) {
						teachBookService.deleteTeachBook(teachBook); 
					}
					else {
						teachBookService.modifyTeachBook(teachBook);	
					}
				}
				else {
					if ( !teachBook.getStatus().equals("0") ) {
						teachBookService.addTeachBook(teachBook);	
					}
				}
			}
			else if ( teachBook.getEditMode().equals("TOPSAVE") ) {
				if ( now.before(DateUtils.parseDate(teachBook.getTeach_date(), patternDate)) ) {
					res.setValid(false);
					res.setMessage(String.format("해당 일자는 %s일 이후 출석체크 불가능 합니다.", teachBook.getTeach_date()));
					return res;
				}
				
				List<Student> studentList = studentService.getStudentListAll(new Student(teachBook.getHomepage_id(), teachBook.getGroup_idx(), teachBook.getCategory_idx(), teachBook.getTeach_idx(), "1"));
				
				for ( Student oneStudent : studentList ) {
					teachBook.setStudent_idx(oneStudent.getStudent_idx());
					teachBook.setStatus("1");
					teachBookService.mergeTeachBook(teachBook);
				}
			}
			else if (teachBook.getEditMode().equals("LEFTSAVE") ) {
				String[] pattern = {"yyyy-MM"};
				Calendar cal = Calendar.getInstance();
				cal.setTime(DateUtils.parseDate(teachBook.getSel_date(), pattern));
				int lastDay = cal.getActualMaximum(Calendar.DATE);
				
				for ( int i = 1; i <= lastDay; i ++ ) { 
					String teachDate = i < 10 ? teachBook.getSel_date() + "-0" + i : teachBook.getSel_date() + "-" + i;
					if ( DateUtils.parseDate(teachDate, patternDate).before(now) ) {
						teachBook.setTeach_date(teachDate);
						teachBook.setStatus("1");
						teachBookService.mergeTeachBook(teachBook);	
					}
				}
			}
			else if ( teachBook.getEditMode().equals("PAYSAVE") ) {
				teachBookService.modifyStudentPay(teachBook);
			}
			
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = { "/view.*" }, method = RequestMethod.GET)
	public String view(Model model, TeachBook teachBook, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		model.addAttribute("teachBook", teachBook);
		model.addAttribute("teachBookInfo", teachBookService.getTeachBookViewInfo(teachBook));
		
		return String.format(basePath, homepage.getFolder()) + "view_ajax";
	}
	
	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.GET)
	public TeachBookSearchView excel(Model model, TeachBook teachBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("teachBook", teachBook);
		return new TeachBookSearchView();
	}
	
	private Map<Integer, Map<String, String>> makeTeachBook(List<Student> studentList, List<TeachBook> teachBookList) {
		Map<Integer, Map<String, String>> teachBookStatusRepo = new HashMap<Integer, Map<String, String>>();
		
		// 학생별 Map<String,String> 만든다.
		for ( TeachBook oneTeachBook : teachBookList ) {
			int studentIdx = oneTeachBook.getStudent_idx();
			String teachDate = oneTeachBook.getTeach_date();
			Map<String, String> teachBookByStudent = null;
			
			if ( teachBookStatusRepo.containsKey(studentIdx) ) {
				teachBookByStudent = teachBookStatusRepo.get(studentIdx);
			}
			else {
				teachBookByStudent = new HashMap<String, String>();
			}
			
			teachBookByStudent.put(teachDate, oneTeachBook.getStatus());
			teachBookStatusRepo.put(studentIdx, teachBookByStudent);
		}
		
		return teachBookStatusRepo;
	}
}
