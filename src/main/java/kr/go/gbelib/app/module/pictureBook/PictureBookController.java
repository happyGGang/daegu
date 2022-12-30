package kr.go.gbelib.app.module.pictureBook;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.pictureBook.PictureBook;
import kr.go.gbelib.app.cms.module.pictureBook.PictureBookService;
import kr.go.gbelib.app.cms.module.pictureBook.PictureBookView;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;

@Controller(value = "userPictureBook")
@RequestMapping(value = {"/{homepagePath}/module/pictureBook"})
public class PictureBookController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/pictureBook/";
	
	@Autowired
	private PictureBookService service;
	
	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, PictureBook pictureBook, HttpServletRequest request, @PathVariable("url") String url) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		service.setPaging(model, service.getPictureBookCount(pictureBook), pictureBook);
		
		model.addAttribute("pictureBook", pictureBook);
		model.addAttribute("pictureBookList", service.getPictureBookList(pictureBook));

		return String.format(basePath, homepage.getFolder()) + "index" + url;
	}
	
	@RequestMapping (value = {"/view{url}.*"}, method = RequestMethod.GET)
	public String view(Model model, PictureBook pictureBook, HttpServletRequest request,  @PathVariable("url") String url) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		int menu_idx = pictureBook.getMenu_idx();
		String loan_year = pictureBook.getLoan_year();
		
		pictureBook = (PictureBook)service.copyObjectPaging(pictureBook, service.getPictureBookOne(pictureBook));
		pictureBook.setMenu_idx(menu_idx);
		pictureBook.setLoan_year(loan_year);
		pictureBook.setBefore_url(url);
		
		model.addAttribute("pictureBook", pictureBook);
		model.addAttribute("loanableMonth", service.getLoanableMonth(pictureBook));

		return String.format(basePath, homepage.getFolder()) + "view";
	}
	
	@RequestMapping (value = {"/loanList.*"}, method = RequestMethod.GET)
	public String loanList(Model model, PictureBook pictureBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember loginSupport = sessionLoginSupport(request);
		if (loginSupport == null && !getSessionIsAdmin(request)) {
			pictureBook.setBefore_url(String.format("/%s/module/pictureBook/loanList.do?menu_idx=%s", homepage.getContext_path(), pictureBook.getMenu_idx()));
			service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), pictureBook.getMenu_idx(), pictureBook.getBefore_url()), request, response);
			return null;
		}
		
		if(StringUtils.isEmpty(pictureBook.getPay_yn())) {
			pictureBook.setPay_yn("N");
		}
		
		if(!getSessionIsAdmin(request) && !"1".equals(loginSupport.getAuth_group())) {
			pictureBook.setAdd_id(loginSupport.getMember_id());
		}
		
		service.setPaging(model, service.getPictureBookLoanCount(pictureBook), pictureBook);

		model.addAttribute("pictureBook", pictureBook);
		model.addAttribute("pictureBookLoanList", service.getPictureBookLoanList(pictureBook));

		return String.format(basePath, homepage.getFolder()) + "loanList";
	}
	
	@RequestMapping (value = {"/loanView.*"}, method = RequestMethod.GET)
	public String loanView(Model model, PictureBook pictureBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		pictureBook = (PictureBook)service.copyObjectPaging(pictureBook, service.getPictureBookLoanOne(pictureBook));
		model.addAttribute("pictureBook", pictureBook);

		return String.format(basePath, homepage.getFolder()) + "loanView";
	}
	
	@RequestMapping(value = {"/loanEdit.*"})
	public String loanEdit(Model model, PictureBook pictureBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember loginSupport = sessionLoginSupport(request);
		if (loginSupport == null && !getSessionIsAdmin(request)) {
			pictureBook.setBefore_url(String.format("/%s/module/pictureBook/index.do?menu_idx=%s%%26pay_yn=%s", homepage.getContext_path(), pictureBook.getMenu_idx(), pictureBook.getPay_yn()));
			service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), pictureBook.getMenu_idx(), pictureBook.getBefore_url()), request, response);
			return null;
		}
		
		if(pictureBook.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			PictureBook pictureBookOne = (PictureBook)service.copyObjectPaging(pictureBook, service.getPictureBookLoanOne(pictureBook));
			pictureBookOne.setMenu_idx(pictureBook.getMenu_idx());
			model.addAttribute("pictureBook", pictureBookOne);
		} else {
			checkAuth("C", model, request);
			model.addAttribute("pictureBook", pictureBook);
		}
		
		int count = service.getDupLoanCount(pictureBook);
		
		if(count > 0) {
			pictureBook.setDupLoanCount("예약");
		} else {
			pictureBook.setDupLoanCount("신청");
		}
		
		return String.format(basePath, homepage.getFolder()) + "loanEdit";
	}
	
	@RequestMapping (value = {"/loanSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse loanSave(PictureBook pictureBook, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(pictureBook.getEditMode().equals("ADD") || pictureBook.getEditMode().equals("MODIFY")) {
    		ValidationUtils.rejectIfEmpty(result, "request_name", "신청자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_2", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_3", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_2", "학교 연락처를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_3", "학교 연락처를 입력하세요.");
    		
    		String phone = pictureBook.getPhone_1() + "-" + pictureBook.getPhone_2() + "-" + pictureBook.getPhone_3();
			String school_tel = pictureBook.getSchool_tel_1() + "-" + pictureBook.getSchool_tel_2() + "-" + pictureBook.getSchool_tel_3();
			pictureBook.setPhone(phone);
			pictureBook.setSchool_tel(school_tel);
			
			Pattern pattern1 = Pattern.compile("^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher1 = pattern1.matcher(pictureBook.getPhone());
    		if (!matcher1.matches()) {
    			result.rejectValue("phone_2", "휴대폰 형식이 올바르지 않습니다.");
    		}
    		
			Pattern pattern2 = Pattern.compile("^[\\d]{2,3}-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher2 = pattern2.matcher(pictureBook.getSchool_tel());
    		if (!matcher2.matches()) {
    			result.rejectValue("school_tel_2", "학교 연락처 형식이 올바르지 않습니다.");
    		}
    		
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if(pictureBook.getEditMode().equals("ADD") || pictureBook.getEditMode().equals("MODIFY")) {
//				int loan_year = Integer.parseInt(pictureBook.getLoan_year());
//				int loan_month = Integer.parseInt(pictureBook.getLoan_month());
//				
//				Calendar cal = Calendar.getInstance();
//				cal.set(loan_year, loan_month-1, 1);
//				pictureBook.setLoan_start_date(loan_year + "-" + loan_month + "-" + "01");
//				pictureBook.setLoan_end_date(loan_year + "-" + loan_month + "-" + cal.getActualMaximum(Calendar.DAY_OF_MONTH));
				
				pictureBook.setSchool_name(sessionLoginSupport(request) != null ? sessionLoginSupport(request).getSchool_name() : "관리자");
			}
			
			String param = "menu_idx="+pictureBook.getMenu_idx() + "&pay_yn="+pictureBook.getPay_yn() + "&viewPage="+ pictureBook.getViewPage()
				+ "&search_type="+pictureBook.getSearch_type() + "&search_text="+pictureBook.getSearch_text();
			String session_id = getSessionIsAdmin(request) ? getSessionMemberId(request) : sessionLoginSupport(request).getMember_id();
			if (pictureBook.getEditMode().equals("ADD")) {
				
				int duplCnt = service.checkDupLoanDateCount(pictureBook);
				if(duplCnt > 0) {
					res.setValid(false);
					res.setMessage("해당 기간은 이미 신청되어 있습니다.");
					return res;
				}
				
				pictureBook.setAdd_id(session_id);
				service.addPictureBookLoan(pictureBook);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData(param);
				res.setMessage("등록되었습니다.");
			} else if (pictureBook.getEditMode().equals("MODIFY")) {
				pictureBook.setModify_id(session_id);
				service.modifyPictureBookLoan(pictureBook);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
				res.setUrl("index.do");
				res.setData(param);
			} else if (pictureBook.getEditMode().equals("DELETE")) {
				service.deletePictureBookLoan(pictureBook);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if(pictureBook.getEditMode().equals("STATUS")) {
				service.statusChangeAll(pictureBook);
				res.setValid(true);
				res.setMessage("상태가 모두 변경되었습니다.");
				res.setReload(true);
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public PictureBookView excel(Model model, PictureBook pictureBook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		SupportMember sm = sessionLoginSupport(request);
		
		if(sm != null && !"1".equals(sm.getAuth_group())) {
			pictureBook.setAdd_id(sm.getMember_id());
		}
		
		List<PictureBook> pictureBookLoanList = service.getPictureBookLoanExcelList(pictureBook);
		
		model.addAttribute("pictureBook", pictureBook);
		model.addAttribute("pictureBookLoanList", pictureBookLoanList);

		return new PictureBookView();
	}
	
	@RequestMapping(value = {"/mysql_to_tibero.*"}, method = RequestMethod.GET)
	public void mysqlToTibero(Model model, PictureBook pictureBook) {
		
		// TODO: 무료 : 595959, 유료 : 18353408
		// 무료, 유료 두번 해야함, 유료일 떄 무료의 최대 인덱스값 - 유료 최소 인덱스 값을 plus_num에 지정
		String a_num = "18353408";
		int plus_num = 20;
		String table = "";
		
		if(a_num.equals("595959")) {
			table = "board_23";
		} else if(a_num.equals("18353408")) {
			table = "board_32";
		}
		
		List<Map<String, Object>> list = service.getMySqlList(table);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		for (Map<String, Object> map : list) {
			PictureBook pb = new PictureBook();
			
			if(a_num.equals("595959")) {
				pb.setPicture_book_idx(Integer.parseInt(String.valueOf(map.get("b_num"))));
			} else {
				pb.setPicture_book_idx(Integer.parseInt(String.valueOf(map.get("b_num")))+plus_num);
			}
			pb.setPicture_book_name(String.valueOf(map.get("b_name")));
			pb.setPicture_book_subject(String.valueOf(map.get("b_subject")));
			pb.setAuthor(String.valueOf(map.get("b_temp1")));
			pb.setPublisher(String.valueOf(map.get("b_temp2")));
			
			String b3 = String.valueOf(map.get("b_temp3"));
			if(StringUtils.isNotEmpty(b3)) {
				pb.setPublish_year(Integer.parseInt(b3));
			}
			
			pb.setIsbn(String.valueOf(map.get("b_temp4")));
			
			String b5 = String.valueOf(map.get("b_temp5")).replace(",", "");
			if(StringUtils.isNotEmpty(b5)) {
				pb.setPicture_price(Integer.parseInt(b5));
			}
			
			String b6 = String.valueOf(map.get("b_temp6"));
			if(StringUtils.isNotEmpty(b6)) {
				pb.setPicture_count(Integer.parseInt(b6));
			}
			
			pb.setKeyword(String.valueOf(map.get("b_temp7")).replace(" ", ""));
			pb.setCategory(String.valueOf(map.get("b_temp8")));
			pb.setDesc_link(String.valueOf(map.get("b_temp9")));
			pb.setThumb_image(String.valueOf(map.get("b_temp10")));
			pb.setContent(String.valueOf(map.get("b_content")));
			if(a_num.equals("595959")) {
				pb.setPay_yn("N");
			} else {
				pb.setPay_yn("Y");
			}
			
			try {
				pb.setAdd_id(String.valueOf(map.get("b_id")));
				pb.setAdd_date(sdf.parse(String.valueOf(map.get("b_regdate"))));
			} catch(ParseException e) {
				e.printStackTrace();
			}
			
			
			System.out.println("@@@@@@@@@@@@@@@ " + pb.toString());
//			service.addParseTibero(pb);
		}
		
		List<Map<String, Object>> list2 = service.getMySqlList2(a_num);

		for (Map<String, Object> map : list2) {
			PictureBook pb = new PictureBook();
			
			if(a_num.equals("595959")) {
				pb.setPicture_book_idx(Integer.parseInt(String.valueOf(map.get("b_num"))));
			} else {
				pb.setPicture_book_idx(Integer.parseInt(String.valueOf(map.get("b_num")))+plus_num);
			}
			pb.setPicture_book_loan_idx(Integer.parseInt(String.valueOf(map.get("bb_num"))));
			pb.setRequest_name(String.valueOf(map.get("bb_manager")));
			pb.setSchool_name(String.valueOf(map.get("bb_school")));
			pb.setLoan_start_date(String.valueOf(map.get("bb_sdate")));
			pb.setLoan_end_date(String.valueOf(map.get("bb_edate")));
			pb.setPhone(String.valueOf(map.get("bb_phone")));
			String school_tel = String.valueOf(map.get("bb_school_tel"));
			pb.setSchool_tel(StringUtils.isEmpty(school_tel) ? "053-000-0000" : school_tel);
			pb.setRequest_content(String.valueOf(map.get("bb_content")));
			pb.setRequest_status(String.valueOf(map.get("bb_status")));
			
			try {
				pb.setAdd_date(sdf.parse(String.valueOf(map.get("bb_regdate"))));
				pb.setAdd_id(String.valueOf(map.get("m_id")));
			} catch(ParseException e) {
				e.printStackTrace();
			}
			
			System.out.println("@@@@@@@@@@@@@@@ " + pb.toString2());
			service.addParseTibero2(pb);
		}
		
	}
	
	@RequestMapping (value = {"/checkLoanDate.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse checkLoanDate(PictureBook pictureBook, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		JsonResponse res = new JsonResponse(request);
		
		String loan_start_date = pictureBook.getLoan_start_date();
		String loan_end_date = pictureBook.getLoan_end_date();
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Date start_date = sdf.parse(loan_start_date);
			Date end_date = sdf.parse(loan_end_date);
			
		    long calDate = start_date.getTime() - end_date.getTime(); 
		    long calDateDays = calDate / ( 24*60*60*1000); 
		    
		    calDateDays = Math.abs(calDateDays);
			
		    //신청기간 2주에서 한달 제한
			if(calDateDays < 13 || calDateDays > 30) {
				res.setValid(false);
				res.setMessage("신청 가능 기간은 최소 2주에서 최대 한달까지입니다.");
				return res;
			}
		} catch (Exception e) {
			res.setValid(false);
			res.setMessage("신청 날짜 비교에 오류가 생겼습니다. 다시 신청해주세요.");
			return res;
		}
		
		int checkDupLoanDateCount = service.checkDupLoanDateCount(pictureBook);
		
		if(checkDupLoanDateCount > 0) {
			pictureBook = service.dupLoanDate(pictureBook);
			
			res.setValid(false);
			res.setMessage("이미 신청이된 날짜입니다. " + pictureBook.getLoan_end_date() + " 이후로 신청이 가능합니다.");
			
			return res;
		}
		
		res.setValid(true);
		
		return res;
	}

}
