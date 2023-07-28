package kr.co.whalesoft.app.homepage.index;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.banner.Banner;
import kr.co.whalesoft.app.cms.banner.BannerService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.mainImg.MainImg;
import kr.co.whalesoft.app.cms.mainImg.MainImgService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import kr.co.whalesoft.app.cms.module.excursions.apply.ApplyService;
import kr.co.whalesoft.app.cms.news.News;
import kr.co.whalesoft.app.cms.news.NewsService;
import kr.co.whalesoft.app.cms.popup.Popup;
import kr.co.whalesoft.app.cms.popup.PopupService;
import kr.co.whalesoft.app.cms.popupZone.PopupZone;
import kr.co.whalesoft.app.cms.popupZone.PopupZoneService;
import kr.co.whalesoft.app.cms.popupZoneTop.PopupZoneTop;
import kr.co.whalesoft.app.cms.popupZoneTop.PopupZoneTopService;
import kr.co.whalesoft.app.cms.quickMenu.QuickMenu;
import kr.co.whalesoft.app.cms.quickMenu.QuickMenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.cms.module.blackList.BlackList;
import kr.go.gbelib.app.cms.module.blackList.BlackListService;
import kr.go.gbelib.app.cms.module.culture.Culture;
import kr.go.gbelib.app.cms.module.culture.CultureService;
import kr.go.gbelib.app.cms.module.drone.loanRequest.LoanRequest;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.book.BookService;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReq;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReqService;
import kr.go.gbelib.app.cms.module.specializedServices.SpecializedServices;
import kr.go.gbelib.app.cms.module.specializedServices.SpecializedServicesService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.cms.module.teach.hashtag.Hashtag;
import kr.go.gbelib.app.cms.module.teach.hashtag.HashtagService;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.teach.student.StudentService;
import kr.go.gbelib.app.common.api.CultureAPI;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.PrivateLibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.intro.search.LibrarySearchService;
import kr.go.gbelib.app.module.bookKeyword.BookKeyword;
import kr.go.gbelib.app.module.bookKeyword.BookKeywordService;
import kr.go.gbelib.app.module.librarianPickBook.LibrarianPickBook;
import kr.go.gbelib.app.module.myLibrary.MyLibrary;
import kr.go.gbelib.app.module.myLibrary.MyLibraryService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller(value = "userIndexController")
public class IndexController extends BaseController {

	private final String basePath = "/homepage/";

	@Autowired
	private LibrarySearchService service;

	@Autowired
	private LibrarySearchService librarySearchService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private QuickMenuService quickMenuService;

	@Autowired
	private PopupZoneService popupZoneService;

	@Autowired
	private PopupZoneTopService popupZoneTopService;

	@Autowired
	private PopupService popupService;

	@Autowired
	private MainImgService mainImgService;

	@Autowired
	private BannerService bannerService;

	@Autowired
	private NewsService newsService;

	@Autowired
	private CalendarManageService calendarManageService;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private TeachService teachService;

	@Autowired
	private FacilityReqService facilityReqService;

	@Autowired
	private BoardManageService boardManageService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private BookKeywordService bookKeywordService;

	@Autowired
	private BookService bookService;

	@Autowired
	private SpecializedServicesService specializedServicesService;

	@Autowired
	private HashtagService hashtagService;

	@Autowired
	private CultureService cultureService;

	@Autowired
	private MyLibraryService myLibraryService;
	
	@Autowired
	private StudentService studentService;
	
	@Autowired
	private BlackListService blackListService;

	@RequestMapping(value = { "index.*" })
	public String index(Model model, HttpServletRequest request) {
		// return doIndexProc(model, request); //대표 홈페이지 이동
		return "redirect:/dgportal/index.do";
	}

	@RequestMapping(value = { "/{contextPath}/index.*" })
	public String index(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		return doIndexProc(model, request, null);
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/info.*" })
	public String info(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/info";
		}
		
		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/info01.*" })
	public String info01(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/info01";
		}
		
		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/info02.*" })
	public String info02(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/info02";
		}
		
		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/info03.*" })
	public String info03(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/info03";
		}
		
		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/index.*" })
	public String kioskIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		return doKioskIndexProc(model, request, null);
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/bookIndex.*" })
	public String kioskBookIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		return doKioskBookIndexProc(model, request, null);
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/teachIndex.*" })
	public String teachIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/teachIndex";
		}
		
		Teach t = new Teach();
		t.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("teachList", teachService.getKioskTeachListForUser(t));

		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/teachDetail.*" })
	public String kioskDetail(Model model, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		if (StringUtils.isEmpty(teach.getHomepage_id())) {
			teach.setHomepage_id(homepage.getHomepage_id());
		}

		int menu_idx = teach.getMenu_idx();
		String searchCate1 = teach.getSearchCate1();
		String homepage_id = teach.getHomepage_id();

		teach = teachService.getTeachDetailForUser(teach);
		if ( teach == null ) {
			teachService.alertMessage("해당 강좌 정보가 없습니다.", request, response);
			return null;
		}
		teach.setMenu_idx(menu_idx);
		teach.setSearchCate1(searchCate1);
		teach.setHomepage_id(homepage_id);

		model.addAttribute("teach", teach);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/teachDetail";
		}

		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/studentEdit.*" })
	public String studentEdit(Model model, Student student, Teach teach, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		Teach teachOne = teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

		if (teachOne == null) {
			service.alertMessage("잘못된 경로로 접근하였습니다", request, response);
			return null;
		}

		if (StringUtils.equals(teachOne.getMember_yn(), "N") && !isLogin(request)) {
			String before_url = String.format("/%s/kiosk/teachIndex.do", homepage.getContext_path());
			homepage.setBefore_url(before_url);
			service.redirectUrl(String.format("/%s/kiosk/login.do?before_url=%s", homepage.getContext_path(), before_url), request, response);
			return null;
		}

		if (StringUtils.equals(teachOne.getMember_yn(), "Y")) {
			student.setMember_id("ANONYMOUS");
		} else {
			student.setMember_id(getSessionMemberId(request));
			student.setMember_key(getSessionMemberId(request));
		}

		// 그룹당 강의 제한 개수 . ->
//		String checkResult = studentService.checkStudent(student);
//		if ( checkResult != null ) {
//			service.alertMessageAndUrl(checkResult, String.format("/%s/kiosk/teachIndex.do", homepage.getContext_path()) , request, response);
//			return null;
//		}
//
//		//블랙리스트 체크
//		if ( blackListService.checkBlackList(new BlackList(student.getHomepage_id(), getSessionMemberId(request)), "10")) {
//			service.alertMessageAndUrl("신청이 불가능합니다.\\n도서관에 문의해주세요.", String.format("/%s/kiosk/teachIndex.do", homepage.getContext_path()) , request, response);
//			return null;
//		}

		model.addAttribute("hakList", codeService.getCode("CMS", "C0020"));
		model.addAttribute("teach", teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx())));
		model.addAttribute("memberInfo", getSessionMemberInfo(request));
		model.addAttribute("student", student);
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0003"));
		model.addAttribute("traingLocationList", codeService.getCode("CMS", "C0022"));
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/studentEdit";
		}

		return basePath + filePath;
	}
	
	@RequestMapping(value = {"/{contextPath}/kiosk/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Student student, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Teach teachOne = teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

		if (teachOne == null) {
			res.setValid(false);
			result.reject("잘못된 경로로 접근하였습니다.");
			return res;
		} else {
			if (StringUtils.equals(teachOne.getMember_yn(), "N") && !isLogin(request)) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		}

		if(student.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "applicant_name", "신청자명을 입력하세요.");
			ValidationUtils.rejectNumbers(result, "applicant_name", "신청자명에는 숫자를 입력할 수 없습니다.");

			if (StringUtils.equals(teachOne.getBirth_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "applicant_birth", "신청자 생년월일을 입력하세요.");
			}
			if (StringUtils.equals(teachOne.getSex_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "applicant_sex", "신청자 성별을 선택하세요.");
			}
			ValidationUtils.rejectIfEmpty(result, "applicant_cell_phone", "신청자 휴대전화번호를 입력하세요.");
			ValidationUtils.rejectPhone(result, "applicant_cell_phone", "신청자 휴대전화번호 형식이 잘못되었습니다.");

			if (StringUtils.equals(teachOne.getTeach_age_type(), "child") && StringUtils.equals(teachOne.getFamily_yn(), "Y")) {
				ValidationUtils.rejectPhone(result, "family_cell_phone", "보호자 휴대전화번호 형식이 잘못되었습니다.");
			}

			if(StringUtils.equals(teachOne.getVaccines_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "vaccines_counter", "백신접종 여부를 선택하세요.");
			}


			teachOne = teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

			if (StringUtils.equals(teachOne.getAddress_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "applicant_address", "신청자 주소를 입력하세요.");
			}

			if (StringUtils.equals(teachOne.getAgent_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "student_name", "수강생명을 입력하세요.");
				ValidationUtils.rejectNumbers(result, "student_name", "수강생명에는 숫자를 입력할 수 없습니다.");
				if (StringUtils.equals(teachOne.getBirth_yn(), "Y")) {
    				ValidationUtils.rejectIfEmpty(result, "student_birth", "수강생 생년월일을 입력하세요.");
				}
				if (StringUtils.equals(teachOne.getSex_yn(), "Y")) {
					ValidationUtils.rejectIfEmpty(result, "student_sex", "수강생 성별을 선택하세요.");
				}
				if (StringUtils.equals(teachOne.getAddress_yn(), "Y")) {
    				ValidationUtils.rejectIfEmpty(result, "student_address", "수강생 주소를 입력하세요.");
				}
			}
			if (StringUtils.equals(teachOne.getFamily_member_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "family_member", "가족 참여 구성원을 모두 기입해주세요.");
			}

			if (StringUtils.equals(teachOne.getFamily_count_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "student_family_count", "가족인원수를 입력하세요");
			}

			if (StringUtils.equals(teachOne.getNeis_location_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "student_location_code", "나이스 지역코드를 입력하세요");
			}

			if (StringUtils.equals(teachOne.getNeis_cd_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "student_neis_cd", "나이스 개인번호를 입력하세요");
			}

			if (StringUtils.equals(teachOne.getNeis_training_num_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "student_training_num", "나이스 연수지명번호를 입력하세요.");
				ValidationUtils.rejectIfStringLength(result, "student_training_num", 60, "나이스 연수지명번호");
			}
			if (StringUtils.equals(teachOne.getOrganization_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "student_organization", "기관을 입력하세요.");
				ValidationUtils.rejectIfStringLength(result, "student_organization", 120, "기관");
			}
			if (StringUtils.equals(teachOne.getRank_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "student_rank", "직급을 입력하세요.");
				ValidationUtils.rejectIfStringLength(result, "student_rank", 60, "직급");
			}
			if (StringUtils.equals(teachOne.getCourse_taken_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "student_course_taken_yn", "연수수강여부를 입력하세요.");
			}
			if (StringUtils.equals(teachOne.getMember_yn(), "Y") && !isLogin(request)) {
				ValidationUtils.rejectIfEmpty(result, "student_password", "비밀번호를 입력하세요.");
			}

			if (StringUtils.equals(teachOne.getSms_service_yn(), "Y")) {
				ValidationUtils.rejectIfEmpty(result, "sms_service_yn", "SMS 수신동의여부를 입력하세요.");
			}

			if ( !student.getSelf_info_yn().equals("Y") ) {
				res.setValid(false);
				res.setMessage("개인정보 미동의 시 참여 하실수 없습니다.");
				return res;
			}

			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String now = sdf.format(date);

			String req_start_date = teachOne.getStart_join_date() + " " + teachOne.getStart_join_time();
			String req_end_date = teachOne.getEnd_join_date() + " " + teachOne.getEnd_join_time();

			if ( req_start_date.compareTo(now) > 0 || req_end_date.compareTo(now) < 0) {
				result.reject("해당 강좌 접수기간이 아닙니다.");
			}
			student.setStudent_age(student.getApplicant_birth().substring(0,4));
			student.setStudent_old(Integer.parseInt(student.getApplicant_birth().substring(0,4)));

		}

		if(!result.hasErrors()) {
			ObjectMapper mapper = new ObjectMapper();
			mapper.setVisibilityChecker(mapper.getSerializationConfig().getDefaultVisibilityChecker()
	                .withFieldVisibility(JsonAutoDetect.Visibility.ANY)
	                .withGetterVisibility(JsonAutoDetect.Visibility.NONE)
	                .withSetterVisibility(JsonAutoDetect.Visibility.NONE)
	                .withCreatorVisibility(JsonAutoDetect.Visibility.NONE));
			String body = "";
			try {
				body = mapper.writeValueAsString(student);
			} catch(Exception e) {
				e.printStackTrace();
			}

			String filterResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", body);
			if (filterResult != null) {
				res.setValid(false);
				res.setUrl(filterResult);
				res.setTargetOpener(true);
				return res;
			}

			if(student.getEditMode().equals("ADD")) {
				String memberId = getSessionMemberId(request);
				if (StringUtils.equals(teachOne.getMember_yn(), "Y") && !isLogin(request)) {
					memberId = "ANONYMOUS";
					student.setStudent_password(CalculateHashUtils.calculateHash(student.getStudent_password()));
					student.setApplicant_name(student.getApplicant_name().trim());
				}

				if (StringUtils.isNotEmpty(memberId)) {
					student.setAdd_id(getSessionMemberId(request));
					if (StringUtils.equals(teachOne.getMember_yn(), "Y") && !isLogin(request)) {
						student.setAdd_id(memberId);
					}
				} else {
					student.setAdd_id(getSessionMemberId(request));
				}
				student.setWeb_id(student.getMember_id());
				if (StringUtils.equals(teachOne.getMember_yn(), "Y") && !isLogin(request)) {
					student.setWeb_id(memberId);
				}
				if (!"ANONYMOUS".equals(memberId)) {
					student.setMember_key(student.getMember_id());
				}
				student.setApi_user_id(student.getMember_id());
				student.setSearch_api_type("USER_ID");

				Object[] addResult = studentService.addStudent(student, "HOMEPAGE");
				res.setValid((Boolean) addResult[0]);
				if (!((Boolean) addResult[0])) {
					res.setValid(true);
					res.setMessage((String) addResult[1]);
					res.setUrl("applyList.do");
					return res;
				}

				if("Y".equals(teachOne.getCancle_use_yn()) && addResult != null && addResult.length >= 3 && addResult[2] != null && (Boolean) addResult[2]  == true) {
					String strDate = teachOne.getStart_cancle_date() + " " + teachOne.getStart_cancle_time();
					String endDate = teachOne.getEnd_cancle_date() + " " + teachOne.getEnd_cancle_time();
					res.setMessage((String) addResult[1] + "\n" + teachOne.getTeach_name()+" 과정이 신청되었습니다.\n수강 취소 기간은 " + strDate + "~" + endDate + "까지 입니다");
				} else {
					res.setMessage((String) addResult[1]);
				}
			}else if (student.getEditMode().equals("MODIFY")) {
				String memberId = getSessionMemberId(request);

				if (StringUtils.equals(teachOne.getMember_yn(), "Y") && !isLogin(request)) {
					memberId = "ANONYMOUS";
					student.setApplicant_name(student.getApplicant_name().trim());
				}

				if (StringUtils.isNotEmpty(memberId)) {
					student.setModify_id(getSessionMemberId(request));
					if (StringUtils.equals(teachOne.getMember_yn(), "Y") && !isLogin(request)) {
						student.setModify_id(memberId);
					}
				} else {
					student.setModify_id(getSessionMemberId(request));
				}

				if (teachOne.getTeach_age_type().equals("infants") && teachOne.getTeach_age_type().equals("OLD")) {
					String[] limitValue = teachOne.getTeach_join_limit_value().split(",");
					if (Integer.parseInt(limitValue[0]) <= Integer.parseInt(student.getStudent_age()) && Integer.parseInt(limitValue[1]) >= Integer.parseInt(student.getStudent_age())) {

					}
					else  {
					res.setValid(false);
					res.setMessage(String.format("해당강좌는 %s 개월 이상 %s 개월 이하 만 신청 가능합니다.", limitValue[0], limitValue[1]));
					return res;
					}
				}

				studentService.updateStudent(student);
				Homepage homepage = getSessionHomepage(request);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");

				if (StringUtils.equals(teachOne.getMember_yn(), "Y") && !isLogin(request)) {
					Teach teach = (Teach) request.getSession().getAttribute("studentAnonyCert");
					student.setApplicant_name(teach.getApply_name());
					student.setStudent_password(teach.getApply_password());
					res.setUrl(String.format("/%s/module/teach/anonyApplyList.do", homepage.getContext_path()));
					res.setData("group_idx=" + student.getGroup_idx() + "&category_idx=" + student.getCategory_idx() + "&menu_idx=" + student.getMenu_idx() + "&homepage_id=" + student.getHomepage_id());
				}else {
					res.setUrl(String.format("/%s/module/teach/applyList.do", homepage.getContext_path()));
					res.setData("group_idx=" + student.getGroup_idx() + "&category_idx=" + student.getCategory_idx() + "&menu_idx=" + student.getMenu_idx() + "&homepage_id=" + student.getHomepage_id());
				}
			} else if (student.getEditMode().equals("CANCEL") || student.getEditMode().equals("CANCEL_ALL")) {
				student.setMember_key(getSessionMemberId(request));
				student.setCancel_id(getSessionMemberId(request));
				studentService.cancelStudent(student);

				res.setValid(true);
				res.setMessage("취소 되었습니다.");
				res.setUrl("applyList.do");
				res.setData("group_idx=" + student.getGroup_idx() + "&category_idx=" + student.getCategory_idx() + "&menu_idx=" + student.getMenu_idx() + (student.getEditMode().equals("CANCEL_ALL") ? "&editMode=ALL" : ""));
			} else if (student.getEditMode().equals("ANONYCANCEL")) {

				if (request.getSession().getAttribute("studentAnonyCert") == null) {
					res.setValid(true);
					res.setMessage("잘못된 접근입니다. (세션 만료)");
					return res;
				}
				Teach teach = (Teach) request.getSession().getAttribute("studentAnonyCert");

				student.setApplicant_name(teach.getApply_name());
				student.setStudent_password(teach.getApply_password());
				studentService.cancelStudent(student);

				res.setValid(true);
				res.setMessage("취소 되었습니다.");
				res.setUrl("anonyApplyList.do");
				res.setData("group_idx=" + student.getGroup_idx() + "&category_idx=" + student.getCategory_idx() + "&menu_idx=" + student.getMenu_idx() + "&homepage_id=" + student.getHomepage_id());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/boardIndex.*" })
	public String boardIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");

		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/boardIndex";
		}
		
		setBoardListToKioskModel(homepage.getHomepage_id(), model);
		
		return basePath + filePath;
	}

	@RequestMapping(value = { "/{contextPath}/kiosk/recommandBoardIndex.*" })
	public String recommandBoardIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/recommandBoardIndex";
		}
		
		Board b = new Board();
		b.setManage_idx(174);
		model.addAttribute("boardList", boardService.getSubBoardByMain(b));//추천도서
		
		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/recommandBoardView.*" })
	public String view(Model model, Board board, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		
		boardService.addViewCount(board);
		
		Board boardOne = boardService.getBoardOne(board);
		
		Map<String, Object> map = null;
		
		if(StringUtils.isNotEmpty(boardOne.getImsi_v_8())) {
			librarySearch.setManageCode(homepage.getManage_code());
			librarySearch.setRegNo(boardOne.getImsi_v_8());
			Map<String, Object> result = LibSearchAPI.getBookInfo(librarySearch);
			
			List<Map<String, Object>> list = null;
			
			try {
				list = LibSearchAPI.getListData(result);
				map = list.get(0);

				//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
					Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
						map.put("aladin", aladinData.get("item"));
					}
					if (map.get("aladin") == null) {
						map.put("imageUrl", service.getImageUrl(map));
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		}
		
		model.addAttribute("detail", map);
		
		try {
			librarySearch.setSearch_text(boardOne.getImsi_v_5());
			Map<String, Object> map2 = LibSearchAPI.getKaKaoList(librarySearch);
			
			List<Map<String, Object>> itemList = (List<Map<String, Object>>) map2.get("list");
			
			String contents = "";
			
			if (itemList != null && itemList.size() > 0) {
				for (Map<String, Object> map3 : itemList) {
					contents = String.valueOf(map3.get("contents"));
				}
				
				model.addAttribute("kakaoResult", contents);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		LibrarySearch ls = new LibrarySearch();
		ls.setManageCode(homepage.getManage_code());
		ls.setBooktype("0");

		Map<String, Object> result = LibSearchAPI.getBestBookList(ls);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		ls.setTotalDataCount(count);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			list = LibSearchAPI.getListData(result);
			for ( Map<String, Object> bestMap : list ) {
				if ( bestMap.containsKey("ISBN") ) {
					//알라딘 API 결과 가져오기
					if (bestMap.get("ISBN") != null && !String.valueOf(bestMap.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(bestMap);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							bestMap.put("aladin", aladinData.get("item"));
						}
						if (bestMap.get("aladin") == null) {
							bestMap.put("imageUrl", service.getImageUrl(bestMap));
						}
					}
				}
			}
		}

		model.addAttribute("bestBookList", list);
		
		model.addAttribute("board", boardOne);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/recommandBoardView";
		}
		
		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/gukboBookKeywordIndex.*"})
	public String gukboBookKeywordIndex(Model model, BookKeyword bookKeyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		model.addAttribute("member", sessionMemberInfo);
		model.addAttribute("bookKeyword", bookKeyword);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/gukboBookKeywordIndex";
		}

		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/gukboBookKeyword.*"})
	public String gukboBookKeyword(Model model, BookKeyword bookKeyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		model.addAttribute("member", sessionMemberInfo);
		model.addAttribute("bookKeyword", bookKeyword);
		model.addAttribute("bookKeywordList", bookKeywordService.getBookKeywordListGukbo(bookKeyword));

		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/gukboBookKeyword_ajax";
		}
		
		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/gukboBookKeywordList.*"})
	public String gukboBookKeywordList(Model model, BookKeyword bookKeyword, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = (Member) request.getSession().getAttribute("member");
		
		librarySearch.setKeyword(bookKeyword.getKeyword_name());
		
		if(!isLogin(request) || StringUtils.isEmpty(member.getBirth_day())) {
			librarySearch.setSex(bookKeyword.getSex());
			librarySearch.setBook_keyword_age(bookKeyword.getAge());
		} else {
			librarySearch.setSex(member.getSex());
			librarySearch.setBirth_year(member.getBirth_day().split("-")[0]);
		}
		
		List<Map<String, Object>> list = LibSearchAPI.getBookKeywordGukboSearchList(librarySearch);
		
//		List<Map<String, Object>> dataList = null;
//		
//		for(int i = 0; i < list.size(); i++) {
//			LibrarySearch ls = new LibrarySearch();
//			ls.setManageCode(homepage.getManage_code());
//			ls.setIsbn(String.valueOf(list.get(i).get("isbn")));
//			ls.setBooktype("BOOKANDNONBOOK");
//			Map<String, Object> result = LibSearchAPI.getBookAndNonbookDetail(ls);
//			
//			try {
//				dataList.add(result);
//			} catch (Exception e) {
//				System.out.println(e);
//			}
//		}
		
		int searchMenuIdx = 0;
		
		searchMenuIdx = menuService.getMenuIdxByProgramIdx2(new Menu(homepage.getHomepage_id(), "", "INTEGRATED"));
		 
		model.addAttribute("searchMenuIdx", searchMenuIdx);
		
		model.addAttribute("bookKeyword", bookKeyword);
		model.addAttribute("list", list);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/gukboBookKeywordList";
		}

		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/gukboBookKeywordView.*"})
	public String gukboView(Model model, BookKeyword bookKeyword, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> map = null;
		
		if(StringUtils.isNotEmpty(bookKeyword.getBook_name())) {
			LibrarySearch ls = new LibrarySearch();
			
			ls.setManageCode(homepage.getManage_code());
			ls.setIsbn(bookKeyword.getIsbn());
			ls.setBooktype("BOOKANDNONBOOK");
			Map<String, Object> result = LibSearchAPI.getBookAndNonbookDetail(ls);
			
			List<Map<String, Object>> list = null;
			
			try {
				list = LibSearchAPI.getListData(result);
				map = list.get(0);

				//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
					Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
						map.put("aladin", aladinData.get("item"));
					}
					if (map.get("aladin") == null) {
						map.put("imageUrl", service.getImageUrl(map));
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		}
		
		try {
			librarySearch.setSearch_text(bookKeyword.getIsbn());
			Map<String, Object> map2 = LibSearchAPI.getKaKaoList(librarySearch);
			
			List<Map<String, Object>> itemList = (List<Map<String, Object>>) map2.get("list");
			
			String contents = "";
			
			if (itemList != null && itemList.size() > 0) {
				for (Map<String, Object> map3 : itemList) {
					contents = String.valueOf(map3.get("contents"));
				}
				
				model.addAttribute("kakaoResult", contents);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		model.addAttribute("detail", map);

		model.addAttribute("bookKeyword", bookKeyword);
		
		LibrarySearch ls = new LibrarySearch();
		ls.setManageCode(homepage.getManage_code());
		ls.setBooktype("0");

		Map<String, Object> result = LibSearchAPI.getBestBookList(ls);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		ls.setTotalDataCount(count);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			list = LibSearchAPI.getListData(result);
			for ( Map<String, Object> bestMap : list ) {
				if ( bestMap.containsKey("ISBN") ) {
					//알라딘 API 결과 가져오기
					if (bestMap.get("ISBN") != null && !String.valueOf(bestMap.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(bestMap);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							bestMap.put("aladin", aladinData.get("item"));
						}
						if (bestMap.get("aladin") == null) {
							bestMap.put("imageUrl", service.getImageUrl(bestMap));
						}
					}
				}
			}
		}

		model.addAttribute("bestBookList", list);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/gukboBookKeywordView";
		}

		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/bookKeywordIndex.*"})
	public String bookKeywordIndex(Model model, BookKeyword bookKeyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		model.addAttribute("member", sessionMemberInfo);
		model.addAttribute("bookKeyword", bookKeyword);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/bookKeywordIndex";
		}

		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/bookKeyword.*"})
	public String bookKeyword(Model model, BookKeyword bookKeyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		model.addAttribute("member", sessionMemberInfo);
		model.addAttribute("bookKeyword", bookKeyword);
		model.addAttribute("bookKeywordList", bookKeywordService.getBookKeywordList(bookKeyword));

		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/bookKeyword_ajax";
		}
		
		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/bookKeywordList.*"})
	public String bookKeywordList(Model model, BookKeyword bookKeyword, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = (Member) request.getSession().getAttribute("member");
		
		librarySearch.setKeyword(bookKeyword.getKeyword_name());
		
		if(!isLogin(request) || StringUtils.isEmpty(member.getBirth_day())) {
			librarySearch.setSex(bookKeyword.getSex());
			librarySearch.setBook_keyword_age(bookKeyword.getAge());
		} else {
			librarySearch.setSex(member.getSex());
			librarySearch.setBirth_year(member.getBirth_day().split("-")[0]);
		}
		
		List<Map<String, Object>> list = LibSearchAPI.getBookKeywordSearchList(librarySearch);
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		for(int i = 0; i < list.size(); i++) {
			List<Map<String, Object>> dataList = null;
			
			LibrarySearch ls = new LibrarySearch();
			ls.setManageCode(homepage.getManage_code());
			ls.setIsbn(String.valueOf(list.get(i).get("isbn")));
			ls.setBooktype("BOOKANDNONBOOK");
			Map<String, Object> result = LibSearchAPI.getBookDetail(ls);
			
			dataList = LibSearchAPI.getListData(result);
			
			if(dataList.size() > 0) {
				for (Map<String, Object> map : dataList) {
					if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = PrivateLibSearchAPI.getAladinDetail(map);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							map.put("aladin", aladinData.get("item"));
						}
						if (map.get("aladin") == null) {
							map.put("imageUrl", service.getImageUrl(map));
						}
					}
				}
				
				resultList.add(i, result);
			}
		}
		
		int searchMenuIdx = 0;
		
		searchMenuIdx = menuService.getMenuIdxByProgramIdx2(new Menu(homepage.getHomepage_id(), "", "INTEGRATED"));
		 
		model.addAttribute("searchMenuIdx", searchMenuIdx);
		
		model.addAttribute("bookKeyword", bookKeyword);
		model.addAttribute("list", resultList);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/bookKeywordList";
		}

		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/bookKeywordView.*"})
	public String view(Model model, BookKeyword bookKeyword, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> map = null;
		
		if(StringUtils.isNotEmpty(bookKeyword.getBook_name())) {
			LibrarySearch ls = new LibrarySearch();
			
			ls.setManageCode(homepage.getManage_code());
			ls.setIsbn(bookKeyword.getIsbn());
			ls.setBooktype("BOOKANDNONBOOK");
			Map<String, Object> result = LibSearchAPI.getBookDetail(ls);
			
			List<Map<String, Object>> list = null;
			
			try {
				list = LibSearchAPI.getListData(result);
				map = list.get(0);

				//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
					Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
						map.put("aladin", aladinData.get("item"));
					}
					if (map.get("aladin") == null) {
						map.put("imageUrl", service.getImageUrl(map));
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		}
		
		try {
			librarySearch.setSearch_text(bookKeyword.getIsbn());
			Map<String, Object> map2 = LibSearchAPI.getKaKaoList(librarySearch);
			
			List<Map<String, Object>> itemList = (List<Map<String, Object>>) map2.get("list");
			
			String contents = "";
			
			if (itemList != null && itemList.size() > 0) {
				for (Map<String, Object> map3 : itemList) {
					contents = String.valueOf(map3.get("contents"));
				}
				
				model.addAttribute("kakaoResult", contents);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		model.addAttribute("detail", map);

		model.addAttribute("bookKeyword", bookKeyword);
		
		LibrarySearch ls = new LibrarySearch();
		ls.setManageCode(homepage.getManage_code());
		ls.setBooktype("0");

		Map<String, Object> result = LibSearchAPI.getBestBookList(ls);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		ls.setTotalDataCount(count);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			list = LibSearchAPI.getListData(result);
			for ( Map<String, Object> bestMap : list ) {
				if ( bestMap.containsKey("ISBN") ) {
					//알라딘 API 결과 가져오기
					if (bestMap.get("ISBN") != null && !String.valueOf(bestMap.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(bestMap);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							bestMap.put("aladin", aladinData.get("item"));
						}
						if (bestMap.get("aladin") == null) {
							bestMap.put("imageUrl", service.getImageUrl(bestMap));
						}
					}
				}
			}
		}

		model.addAttribute("bestBookList", list);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/bookKeywordView";
		}

		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/librarianPickBookIndex.*"})
	public String index(Model model, LibrarianPickBook librarianPickBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		String uri = request.getRequestURI().substring(request.getContextPath().length());
		if((!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) && uri.contains("kiosk")) {
			String before_url = String.format("/%s/kiosk/librarianPickBookIndex.do", homepage.getContext_path());
			homepage.setBefore_url(before_url);
			service.redirectUrl(String.format("/%s/kiosk/login.do?before_url=%s", homepage.getContext_path(), before_url), request, response);
			return null;
		}
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		LibrarySearch librarySearch = new LibrarySearch();
		
		librarySearch.setManageCode(homepage.getManage_code());
		librarySearch.setUserkey(sessionMemberInfo.getRec_key());
		if (StringUtils.isNotEmpty(sessionMemberInfo.getBirth_day())) {
			String[] age_split = sessionMemberInfo.getBirth_day().split("-");
			
			librarySearch.setBirth_year(age_split[0]);
		}
		librarySearch.setSex(sessionMemberInfo.getSex());
			
		try {
			Map<String, Object> result = LibSearchAPI.getUserreCommBooks(librarySearch);
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			if(result != null) {
				list = (List<Map<String, Object>>)result.get("LIST_DATA");
				
				for (Map<String, Object> map : list) {
					
					String isbn = map.get("ISBN").toString(); 
					
					if (StringUtils.isNotEmpty(isbn)) {
						
						String[] isbnArr = isbn.split("\\s+");
						
						for(int i=0; i < isbnArr.length; i++) {
							if (i == (isbnArr.length -1)) {
								isbnArr[i].replaceAll("세트", "");
								isbnArr[i].replaceAll("셋트", "");
								isbnArr[i].replaceAll("SET", "");
								isbnArr[i].replaceAll("set", "");
								map.put("ISBN",isbnArr[i]);
							}
						}
						
						map.put("imageUrl", librarySearchService.getImageUrl(map));
					}
					
					map.put("ISBN", isbn);
					
				}
			}
			
			model.addAttribute("list", list);
		} catch (Exception e) {
			System.out.println(e);
		}
		
		int searchMenuIdx = 0;
		
		searchMenuIdx = menuService.getMenuIdxByProgramIdx2(new Menu(homepage.getHomepage_id(), "", "INTEGRATED"));
		 
		model.addAttribute("searchMenuIdx", searchMenuIdx);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/librarianPickBookIndex";
		}

		return basePath + filePath;
	}
	
	@RequestMapping (value = {"/{contextPath}/kiosk/librarianPickBookView.*"})
	public String librarianPickBookView(Model model, LibrarianPickBook librarianPickBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		LibrarySearch librarySearch = new LibrarySearch();
		
		Map<String, Object> map = null;
		
		if(StringUtils.isNotEmpty(librarianPickBook.getRegNo())) {
			librarySearch.setManageCode(homepage.getManage_code());
			librarySearch.setRegNo(librarianPickBook.getRegNo());
			Map<String, Object> result = LibSearchAPI.getBookInfo(librarySearch);
			
			List<Map<String, Object>> list = null;
			
			try {
				list = LibSearchAPI.getListData(result);
				map = list.get(0);

				//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
					Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
						map.put("aladin", aladinData.get("item"));
					}
					if (map.get("aladin") == null) {
						map.put("imageUrl", service.getImageUrl(map));
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		}
		
		try {
			librarySearch.setSearch_text(librarianPickBook.getIsbn());
			Map<String, Object> map2 = LibSearchAPI.getKaKaoList(librarySearch);
			
			List<Map<String, Object>> itemList = (List<Map<String, Object>>) map2.get("list");
			
			String contents = "";
			
			if (itemList != null && itemList.size() > 0) {
				for (Map<String, Object> map3 : itemList) {
					contents = String.valueOf(map3.get("contents"));
				}
				
				model.addAttribute("kakaoResult", contents);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		model.addAttribute("detail", map);

		model.addAttribute("librarianPickBook", librarianPickBook);
		
		LibrarySearch ls = new LibrarySearch();
		ls.setManageCode(homepage.getManage_code());
		ls.setBooktype("0");

		Map<String, Object> result = LibSearchAPI.getBestBookList(ls);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		ls.setTotalDataCount(count);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			list = LibSearchAPI.getListData(result);
			for ( Map<String, Object> bestMap : list ) {
				if ( bestMap.containsKey("ISBN") ) {
					//알라딘 API 결과 가져오기
					if (bestMap.get("ISBN") != null && !String.valueOf(bestMap.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(bestMap);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							bestMap.put("aladin", aladinData.get("item"));
						}
						if (bestMap.get("aladin") == null) {
							bestMap.put("imageUrl", service.getImageUrl(bestMap));
						}
					}
				}
			}
		}

		model.addAttribute("bestBookList", list);
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/librarianPickBookView";
		}

		return basePath + filePath;
	}

	@RequestMapping(value = {"/{contextPath}/kiosk/login.*"})
	public String login(Model model, Member member, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Member sessionMemberInfo = getSessionMemberInfo(request);

		String queryString = request.getQueryString();
		if (queryString != null && queryString.contains("before_url")) {
			queryString = queryString.replace("before_url=", "");
			sessionMemberInfo.setBefore_url(queryString);
		}

		model.addAttribute("member", sessionMemberInfo);

		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/login";
		}

		return basePath + filePath;
	}
	
	@RequestMapping(value = {"/{contextPath}/kiosk/rfidLogin.*"})
	public String rfidLogin(Model model, Member member, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Member sessionMemberInfo = getSessionMemberInfo(request);

		String queryString = request.getQueryString();
		if (queryString != null && queryString.contains("before_url")) {
			queryString = queryString.replace("before_url=", "");
			sessionMemberInfo.setBefore_url(queryString);
		}
		
		model.addAttribute("member", sessionMemberInfo);

		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/rfidLogin";
		}

		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/menuNavigation.*" })
	public String menuNavigation(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		return basePath + homepage.getFolder() + "/kiosk/menuNavigation_ajax";
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/bookNavigation.*" })
 	public String bookNavigation(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		return basePath + homepage.getFolder() + "/kiosk/bookNavigation_ajax";
	}
	
	@RequestMapping(value = { "/{contextPath}/kiosk/print.*" })
	public String print(Model model, HttpServletRequest request, LibrarySearch librarySearch, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("detail", librarySearch);
		
		return basePath + homepage.getFolder() + "/kiosk/print_ajax";
	}
	
	@RequestMapping(value = { "/{contextPath}/mediawall/index.*" })
	public String medialwallIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");

		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/mediawall/index";
		}
		
		setBoardListToModel(homepage.getHomepage_id(), model);
		
		return basePath + filePath;
	}

	@RequestMapping(value = { "/{contextPath}/mediawall/mediaIndex.*" })
	public String mediaIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/mediawall/mediaIndex";
		}
		
		Board b = new Board();
		b.setManage_idx(174);
		model.addAttribute("boardList", boardService.getSubBoardByMain(b));//추천도서
		
		return basePath + filePath;
	}
	
	@RequestMapping(value = { "/{contextPath}/mediawall/bookIndex.*" })
	public String bookIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		return doMediawallIndexProc(model, request, null);
	}

	@RequestMapping(value = { "/{contextPath}/mediawall/boardIndex.*" })
	public String medialwallBoardIndex(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		
		String filePath = "";
		if (homepage != null) {
			filePath = homepage.getFolder() + "/mediawall/boardIndex";
		}
		
		setBoardListToKioskModel(homepage.getHomepage_id(), model);
		
		return basePath + filePath;
	}

	@RequestMapping(value = { "/{contextPath}/calendar.*" })
	public String calendar(Model model, CalendarManage calendarManage, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");

		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage = new CalendarManage(sf.format(Calendar.getInstance().getTime()));
		}
		calendarManage.setHomepage_id(homepage.getHomepage_id());

		List<CalendarManage> calendarList = calendarManageService.getCalendar(calendarManage);

		CalendarManage closedDay = calendarManageService.getClosedDate2(calendarManage);

		model.addAttribute("calendar", calendarManage);
		model.addAttribute("calendarResult", getCalendarMarkCloseDay(closedDay, calendarList));
		model.addAttribute("closeDayList", calendarManageService.getClosedDate2(calendarManage));
		return "/homepage/calendar_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar2.*" }) // 휴관일만 가져오기
	public String calendar2(Model model, CalendarManage calendarManage, HttpServletRequest request,
			@PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = homepage.getFolder() + "/closedCalendar";

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");

		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage = new CalendarManage(sf.format(Calendar.getInstance().getTime()));
		}
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("calendar", calendarManage);
		model.addAttribute("closeDayList", calendarManageService.getClosedDate2(calendarManage));
		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar3.*" }) // 1개월 가져오기
	public String calendar3(Model model, CalendarManage calendarManage, Board board, HttpServletRequest request,
			@PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/calendar";
		}

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage.setPlan_date(sf.format(Calendar.getInstance().getTime()));
		}

		SimpleDateFormat sf2 = new SimpleDateFormat ("yyyy.MM.dd");
		Date currentDay = new Date ();
		String currDate = sf2.format ( currentDay );

		if (StringUtils.isEmpty(calendarManage.getHomepage_id())) {
			calendarManage.setHomepage_id(homepage.getHomepage_id());
			board.setHomepage_id(homepage.getHomepage_id());
		} else {
			if (calendarManage.getHomepage_id().equals("h73")) {
				board.setHomepage_id("h45");
				board.setCategory1("0001");
			} else if (calendarManage.getHomepage_id().equals("h59")) {
				board.setHomepage_id("h45");
				board.setCategory1("0002");
			} else if (calendarManage.getHomepage_id().equals("h60")) {
				board.setHomepage_id("h45");
				board.setCategory1("0003");
			} else {
				board.setHomepage_id(calendarManage.getHomepage_id());
			}
		}
		board.setImsi_v_1(calendarManage.getPlan_date());

		CalendarManage closedDay = calendarManageService.getClosedDate2(calendarManage);

		calendarManage.setDate_type("2");
		List<CalendarManage> eventDay = calendarManageService.getCalendarManageDetail(calendarManage);
		calendarManage.setDate_type(null);
		List<Board> movieDay = boardService.getBoardMovie(board);
		List<Apply> applyDay = applyService.getOkApply(calendarManage);
		List<Teach> teachDay = teachService.getTeachListForCalendar(calendarManage);
		List<FacilityReq> facilityDay = facilityReqService.getFacilityReqCalendar(calendarManage);
		List<CalendarManage> calendarList = calendarManageService.getCalendar(calendarManage);
		model.addAttribute("currDate", currDate);
		model.addAttribute("calendar", calendarManage);
		model.addAttribute("calendarList", calendarList);
		model.addAttribute("calendarResult", getCalendarMarkGumi(calendarManage.getPlan_date(), closedDay, eventDay, movieDay, applyDay, teachDay, facilityDay));
		if("h80".equals(homepage.getHomepage_id()) || "h82".equals(homepage.getHomepage_id())) {
			model.addAttribute("calendarResult2", getCalendarMarkPrivate(calendarManage.getPlan_date(), closedDay, eventDay, movieDay, applyDay, teachDay, facilityDay));
		}
		model.addAttribute("closeDayList", closedDay);
		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar4.*" }) // 1일 가져오기
	public String calendar4(Model model, CalendarManage calendarManage, Board board, HttpServletRequest request,
			@PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/dailyCalendar";
		}

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.isEmpty(calendarManage.getPlan_day())) {
			calendarManage = new CalendarManage();
			calendarManage.setPlan_day(sf.format(Calendar.getInstance().getTime()));
		}

		SimpleDateFormat sf2 = new SimpleDateFormat ("yyyy.MM.dd");
		Date currentDay = new Date ();
		String currDate = sf2.format ( currentDay );

		calendarManage.setHomepage_id(homepage.getHomepage_id());
		board.setHomepage_id(homepage.getHomepage_id());
		board.setImsi_v_1(calendarManage.getPlan_day().substring(0,7));
		board.setImsi_v_2(calendarManage.getPlan_day().substring(8));

		CalendarManage closedDay = null;
		closedDay = calendarManageService.getClosedDate3(calendarManage);
		List<CalendarManage> eventDay = calendarManageService.getCalendarManageDetail(calendarManage);
		List<Board> movieDay = boardService.getBoardMovie(board);
		List<Apply> applyDay = applyService.getOkApply(calendarManage);
		List<Teach> teachDay = teachService.getTeachListForCalendar(calendarManage);
		List<FacilityReq> facilityDay = facilityReqService.getFacilityReqCalendar(calendarManage);
//		List<CalendarManage> calendarList = calendarManageService.getCalendar(calendarManage);
		model.addAttribute("currDate", currDate);
		model.addAttribute("calendar", calendarManage);
//		model.addAttribute("calendarList", calendarList);
		Map<String, List<String>> calendarMarkGumi = getCalendarMarkGumi(calendarManage.getPlan_day(), closedDay, eventDay, movieDay, applyDay, teachDay, facilityDay);
		String day = calendarManage.getPlan_day().split("-")[2];
		if (day.startsWith("0")) {
			day = day.replace("0", "");
		}
		List<String> calendarResult = calendarMarkGumi.get(day);
		model.addAttribute("calendarResult", calendarResult);
		model.addAttribute("closeDayList", closedDay);
		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar5.*" }) // homepage_id로 휴관일만 가져오기
	public String calendar5(Model model, CalendarManage calendarManage, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage h = (Homepage) request.getAttribute("homepage");
		Homepage homepage = homepageService.getHomepageOne(new Homepage(calendarManage.getHomepage_id()));

		String filePath = h.getFolder() + "/closedCalendar";

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");

		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage = new CalendarManage(sf.format(Calendar.getInstance().getTime()));
		}
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("calendar", calendarManage);
		model.addAttribute("closeDayList", calendarManageService.getClosedDate2(calendarManage));
		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar10.*" }) // 서구
	public String calendar10(Model model, CalendarManage calendarManage, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage h = (Homepage) request.getAttribute("homepage");
		Homepage homepage = homepageService.getHomepageOne(new Homepage(calendarManage.getHomepage_id()));

		String filePath = h.getFolder() + "/calendar10";

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDay = new Date ();
		String currDate = sf.format ( currentDay );


		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage = new CalendarManage(sf.format(Calendar.getInstance().getTime()));
		}

		model.addAttribute("eventList", calendarManageService.getEventSeogu(calendarManage));
		model.addAttribute("movieList", calendarManageService.getMovieSeogu(calendarManage));
		model.addAttribute("closeList", calendarManageService.getCloseSeogu(calendarManage));
		model.addAttribute("calendarManage", calendarManage);

		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar9.*" }) // 분관 휴관일
	@ResponseBody
	public List<String> calendar9(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable String contextPath) {

		List<String> holidayList = new ArrayList<String>();

		Calendar cal = Calendar.getInstance();
		int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");

		for(int i = 1; i <= endDay; i++) {
			String search_day = "0";
			if(i < 10) {
				search_day += i;
			} else {
				search_day = String.valueOf(i);
			}
			librarySearch.setSearch_start_date(sdf.format(cal.getTime()) + search_day);
			Map<String, Object> holiDays = LibSearchAPI.getCheckHoliday(librarySearch);

			if(holiDays.get("RESULT_CODE").equals("1")) {
				holidayList.add(search_day);
			}
		}

		return holidayList;
	}

	@RequestMapping(value = { "/{contextPath}/newBook.*" })
	public String newBook(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		LibrarySearch ls = new LibrarySearch();
		ls.setManageCode(homepage.getManage_code());

		//기본값 '1달 전'
		//검색기간 설정
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		int beforeDays = -30;
		ls.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), beforeDays)));
		ls.setSearch_end_date(sf.format(new Date()));

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		ls.setBooktype("0");

		Map<String, Object> result = LibSearchAPI.getNewBookList(ls);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);
		ls.setTotalDataCount(count);

		if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

			list = LibSearchAPI.getListData(result);
			for (Map<String, Object> map : list) {
				if (map.containsKey("ISBN")) {
					//알라딘 API 결과 가져오기
					if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							map.put("aladin", aladinData.get("item"));
						}
						if (map.get("aladin") == null) {
							map.put("imageUrl", librarySearchService.getImageUrl(map));
						}
					}
				}
			}
		}

		model.addAttribute("newBookList", list);
		return basePath + homepage.getFolder() + "/newBook_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/newBookSeogu.*" })
	public String newBookSeogu(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		LibrarySearch ls = new LibrarySearch();
		ls.setManageCode(homepage.getManage_code());

		//기본값 '1달 전'
		//검색기간 설정
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		int beforeDays = -30;
		ls.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), beforeDays)));
		ls.setSearch_end_date(sf.format(new Date()));

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		ls.setBooktype("0");

		Homepage h = new Homepage();
		h.setHomepage_id(homepage.getHomepage_id());
		h.setHomepage_group(homepage.getHomepage_id());
		h.setTemp_use_yn("Y");
		List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
		for (Homepage subHome : subHomepageList) {
			ls.setManageCode(subHome.getManage_code());

			Map<String, Object> result = LibSearchAPI.getNewBookList(ls);
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);
			ls.setTotalDataCount(count);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

				list = LibSearchAPI.getListData(result);
				for (Map<String, Object> map : list) {
					if (map.containsKey("ISBN")) {
						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
						}
					}
				}
			}

			model.addAttribute("newBookList" + subHome.getHomepage_id(), list);
		}

		return basePath + homepage.getFolder() + "/newBook_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/bestBook.*" })
	public String bestBook(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		
		if (homepage.getHomepage_id().equals("h94")) {
			Board b = new Board();
			b.setManage_idx(1183);
			model.addAttribute("bookList", boardService.getSubBoardByMain(b));//추천도서
		} else {
			LibrarySearch ls = new LibrarySearch();
			ls.setManageCode(homepage.getManage_code());

			//서지형태 분류코드 설정.
			//기본값 도서 "0"
			//0 : 단행, 1: 연속간행물, 2:비도서
			ls.setBooktype("0");

			Map<String, Object> result = LibSearchAPI.getBestBookList(ls);
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			ls.setTotalDataCount(count);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

				list = LibSearchAPI.getListData(result);
				for ( Map<String, Object> map : list ) {
					if ( map.containsKey("ISBN") ) {
						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", service.getImageUrl(map));
							}
						}
					}
				}
			}


			model.addAttribute("bestBookList", list);
		}
		
		return basePath + homepage.getFolder() + "/bestBook_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/recommendBook.*" })
	public String recommendBook(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");

		String category2 = request.getParameter("category2");
		int manage_idx = 299;

		model.addAttribute("recommendBookMenuIdx", 67);
		model.addAttribute("recommendBookContextPath", homepage.getContext_path());

		Board board = new Board();
		board.setManage_idx(manage_idx);
		board.setRowCount(2);
		board.setTotalDataCount(2);
		board.setDept_cd("PORTAL");
		board.setCategory2(category2);
		model.addAttribute("recommendBookList", boardService.getBoardByMain(board));

		return basePath + homepage.getFolder() + "/recommendBook_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/subNotice.*" }) // homepage_id로 만 가져오기
	public String subNotice(Model model, Board board, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = homepage.getFolder() + "/subNotice";

//		if (StringUtils.isEmpty(board.getHomepage_id())) {
//			Homepage h = new Homepage();
//			h.setHomepage_id(h.getHomepage_id());
//			h.setHomepage_group(homepage.getHomepage_id());
//			h.setTemp_use_yn("Y");
//			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
//			if (subHomepageList != null && subHomepageList.size() > 0) {
//				board.setCategory5(subHomepageList.get(0).getHomepage_id());
//			}
//		}
		board.setCategory5(board.getHomepage_id());

		model.addAttribute("subNoticeList", boardService.getSubBoardByMainDalseo(board));


		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/subCalendar.*" }) // homepage_id로 휴관일만 가져오기
	public String subCalendar(Model model, CalendarManage calendarManage, Board board, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = homepage.getFolder() + "/subCalendar";

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage.setPlan_date(sf.format(Calendar.getInstance().getTime()));
//			calendarManage = new CalendarManage(sf.format(Calendar.getInstance().getTime()));
		}

		if (homepage.getHomepage_id().equals("h37")) {
			if (StringUtils.isEmpty(calendarManage.getHomepage_id())) {
				Homepage h = new Homepage();
				h.setHomepage_id(homepage.getHomepage_id());
				h.setHomepage_group(homepage.getHomepage_id());
				h.setTemp_use_yn("Y");
				List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
				if (subHomepageList != null && subHomepageList.size() > 0) {
					calendarManage.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				}
			}
		} else {
			calendarManage.setHomepage_id(homepage.getHomepage_id());
		}


		SimpleDateFormat sf2 = new SimpleDateFormat ("yyyy.MM.dd");
		Date currentDay = new Date ();
		String currDate = sf2.format ( currentDay );

//		calendarManage.setHomepage_id(homepage.getHomepage_id());
		board.setHomepage_id(homepage.getHomepage_id());
		board.setImsi_v_1(calendarManage.getPlan_date());
		if (!StringUtils.equals(homepage.getHomepage_id(), calendarManage.getHomepage_id())) {
			board.setCategory5(calendarManage.getHomepage_id());
		}
		CalendarManage closedDay = calendarManageService.getClosedDate2(calendarManage);

		calendarManage.setDate_type("2");
		List<CalendarManage> eventDay = calendarManageService.getCalendarManageDetail(calendarManage);
		calendarManage.setDate_type(null);
		List<Board> movieDay = boardService.getBoardMovie(board);
		List<Apply> applyDay = applyService.getOkApply(calendarManage);
		List<Teach> teachDay = teachService.getTeachListForCalendar(calendarManage);
		List<FacilityReq> facilityDay = facilityReqService.getFacilityReqCalendar(calendarManage);
		List<CalendarManage> calendarList = calendarManageService.getCalendar(calendarManage);
		model.addAttribute("currDate", currDate);
		model.addAttribute("calendar", calendarManage);
		model.addAttribute("calendarList", calendarList);
//		model.addAttribute("calendarResult", getCalendarMarkGumi(calendarManage.getPlan_date(), closedDay, eventDay, movieDay, applyDay, teachDay, facilityDay));
		model.addAttribute("calendarResult", getCalendarMarkGumiDate(calendarManage.getPlan_date(), closedDay, eventDay, movieDay, applyDay, teachDay, facilityDay));
		model.addAttribute("closeDayList", closedDay);


		return basePath + filePath + "_ajax";
	}

	private String doIndexProc(Model model, HttpServletRequest request, Board board) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Teach indexteach = new Teach();
		String sortField = indexteach.getSortField();
		if (StringUtils.equals(sortField, "TITLE")) {
			indexteach.setSortField("");
			indexteach.setSortType("");
		}
		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/index";
		}


		// model.addAttribute("lnkBookList", LibSearchAPI.getLnkBookList(new
		// LibrarySearch(homepage.getHomepage_code(), 0, 10), "Y"));
		model.addAttribute("newsList", newsService.getNewsListAll(new News(homepage.getHomepage_id())));
		model.addAttribute("bannerList", bannerService.getBannerAll(new Banner(homepage.getHomepage_id())));
		model.addAttribute("mainImgList", mainImgService.getMainImgListAll(new MainImg(homepage.getHomepage_id())));
		model.addAttribute("popupList", popupService.getPopupAll(new Popup(homepage.getHomepage_id())));
		model.addAttribute("popupZoneList", popupZoneService.getPopupZoneAll(new PopupZone(homepage.getHomepage_id())));
		model.addAttribute("quickMenuList", quickMenuService.getQuickMenuListAll(new QuickMenu(homepage.getHomepage_id())));
		model.addAttribute("popupZoneTopList", popupZoneTopService.getPopupZoneTopAll(new PopupZoneTop(homepage.getHomepage_id())));

		//인기검색어
		//h44 달성군립도서관
		String[] trendHomepage = {"h44"};
		for (String th: trendHomepage ) {
			if (homepage.getHomepage_id().equals(th)) {
				Map<String, Object> hotTrendWordList = LibSearchAPI.getHotTrendWordList(homepage.getManage_code());

				int count = LibSearchAPI.getSearchCount(hotTrendWordList);

				if ( count > 0 ) {
					model.addAttribute("hotTrendList", LibSearchAPI.getListData(hotTrendWordList));
				}

			}
		}


		//강좌목록
		//h7 북부도서관
		//h35 남구 대명
		//h36 남구 이천
		//h45 동구
		//h46 북구 구수산
		//h47 북구 대현
		//h48 북구 태전
		//h50 수성 범어
		//h51 수성 용학
		//h52 수성 고산
		String[] teachHomepage = {"h7", "h45", "h35", "h36", "h46", "h47", "h48", "h50", "h51", "h52"};
		for (String th: teachHomepage ) {
			if (homepage.getHomepage_id().equals(th)) {
				Teach t = new Teach();

				Homepage h = new Homepage();
				h.setHomepage_id(homepage.getHomepage_id());
				h.setHomepage_group(homepage.getHomepage_id());
				h.setTemp_use_yn("Y");
				List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
				if (subHomepageList != null && subHomepageList.size() > 0) {
					List<String> homepage_ids = new ArrayList<String>();
					for (Homepage subHome : subHomepageList) {
						homepage_ids.add(subHome.getHomepage_id());
						homepage_ids.add(homepage.getHomepage_id());
					}
					t.setHomepage_ids(homepage_ids);
				} else {
					t.setHomepage_id(homepage.getHomepage_id());

				}

				// 고산 문화행사만 조회
				if(th.equals("h52")) t.setSearchCate1("16");

				model.addAttribute("teachList", teachService.getTeachListForUser(t));

				// 고산 특성화프로그램
				if(th.equals("h52")) {
					Board b = new Board();
					b.setManage_idx(733);
					b.setHomepage_id(homepage.getHomepage_id());
					model.addAttribute("boardList", boardService.getSubBoardByMain(b));//영화도서전체
				}
			}
		}

		//강좌목록2
		//h44 달성군립도서관
		String[] teachHomepage2 = {"h44"};
		for (String th: teachHomepage2 ) {
			if (homepage.getHomepage_id().equals(th)) {
				Teach t = new Teach();
				t.setHomepage_id(homepage.getHomepage_id());
				t.setSearchCate1("16");
				model.addAttribute("teachList1", teachService.getTeachListForUser(t));
				t.setSearchCate1("17");
				model.addAttribute("teachList2", teachService.getTeachListForUser(t));
			}
		}

		//강좌목록3
		//h82 비전공공도서관
		String[] teachHomepage3 = {"h82"};
		for (String th: teachHomepage3 ) {
			if (homepage.getHomepage_id().equals(th)) {
				Teach t = new Teach();
				t.setHomepage_id(homepage.getHomepage_id());
				t.setSearchCate1("16");
				model.addAttribute("teachList1", teachService.getTeachListForUser(t));
				t.setSearchCate1("17");
				model.addAttribute("teachList2", teachService.getTeachListForUser(t));
			}
		}
		
		//대표도서관
		if (homepage.getHomepage_id().equals("h32")) {
			Teach t = new Teach();
			t.setRowCount(5);
			t.setTotalDataCount(5);
			List<String> statusArr = new ArrayList<String>();
			statusArr.add("0");//신청
			statusArr.add("1");//대기자신청
			statusArr.add("6");//신청대기
			t.setSearchStatusArr(statusArr);
			List<Teach> teachListForAllHomepage = teachService.getTeachListForAllHomepage(t);
			for (Teach teach : teachListForAllHomepage) {
				Homepage h = new Homepage(teach.getHomepage_id());
				h = homepageService.getHomepageOne(h);
				teach.setHomepage_name(h.getHomepage_name());
				teach.setHomepage_id(h.getHomepage_id());

				if (!h.getHomepage_group().equals("ALL")) {
					h = homepageService.getHomepageOne(new Homepage(h.getHomepage_group()));
				}

				teach.setContext_path(h.getContext_path());
				if (teach.getHomepage_id().equals("h7")) {
					teach.setMenu_idx(30);
				} else {
					Menu m = new Menu();
					m.setHomepage_id(h.getHomepage_id());
					m.setMenu_idx(97);
					teach.setMenu_idx(menuService.getMenuIdxByProgramIdx(m));
				}
			}
			model.addAttribute("teachList", teachListForAllHomepage);

			Board b = new Board();
			b.setRowCount(5);
			b.setTotalDataCount(5);
			List<Board> allHomepageBoardListByMain = boardService.getAllHomepageBoardListByMain(b);
			model.addAttribute("noticeBoardList", allHomepageBoardListByMain);

			//홈페이지 상단부분 도서관알리미 랜덤표출
			Board b2 = new Board();
			b2.setRowCount(20);
			b2.setTotalDataCount(20);
			List<Board> boardListByMainForRandom = boardService.getAllHomepageBoardListByMain2(b2);
			Collections.shuffle(boardListByMainForRandom);

			model.addAttribute("noticeBoardListRandom", boardListByMainForRandom);

			String boardCategory2 = boardManageService.getBoardManageOne(new BoardManage(homepage.getHomepage_id(), 299)).getCategory2();
			List<Code> category2List = codeService.getCode(homepage.getHomepage_id(), boardCategory2);
			model.addAttribute("category2List", category2List);

			// 도서서비스 사서추천
			Board bookBoard = new Board();
			bookBoard.setManage_idx(299);
			bookBoard.setDept_cd("PORTAL");
			bookBoard.setCategory2Manage("B0010");
			bookBoard.setHomepage_id("h32");
			List<Board> mainBookList = boardService.getBoardByMain(bookBoard);


			int ran = (int)(Math.random() * mainBookList.size());
			if (CollectionUtils.isNotEmpty(mainBookList)) {
				model.addAttribute("recommendOne", mainBookList.get(ran));

			}

		}

		setBoardListToModel(homepage.getHomepage_id(), model);
		
		//국보도서관 강좌
		if (homepage.getHomepage_id().equals("h10")) {
			Teach t = new Teach();
			t.setHomepage_id(homepage.getHomepage_id());
			t.setSearchCate1("16");
			model.addAttribute("teachList", teachService.getTeachListForUser(t));
			
			//국보도서관 신착도서
			LibrarySearch newBook = new LibrarySearch();
			newBook.setManageCode(homepage.getManage_code());

			//기본값 '1달 전'
			//검색기간 설정
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			int beforeDays = -30;
			newBook.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), beforeDays)));
			newBook.setSearch_end_date(sf.format(new Date()));

			//서지형태 분류코드 설정.
			//기본값 도서 "0"
			//0 : 단행, 1: 연속간행물, 2:비도서
			newBook.setBooktype("0");

			Map<String, Object> result = LibSearchAPI.getNewBookList(newBook);
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);
			newBook.setTotalDataCount(count);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

				list = LibSearchAPI.getListData(result);
				for (Map<String, Object> map : list) {
					if (map.containsKey("ISBN")) {
						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", librarySearchService.getImageUrl(map));
							}
						}
					}
				}
			}
			
			model.addAttribute("newBookList", list);
			
			//국보도서관 대출베스트
			LibrarySearch bestBook = new LibrarySearch();
			bestBook.setManageCode(homepage.getManage_code());
			bestBook.setBooktype("0");

			Map<String, Object> bestResult = LibSearchAPI.getBestBookList(bestBook);
			List<Map<String, Object>> bestBookList = null;

			int bestBookCount = LibSearchAPI.getSearchCount(result);

			bestBook.setTotalDataCount(bestBookCount);
			service.setPaging(model, count, bestBook);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

				bestBookList = LibSearchAPI.getListData(bestResult);
				for ( Map<String, Object> map : bestBookList ) {
					if ( map.containsKey("ISBN") ) {
						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", service.getImageUrl(map));
							}
						}
					}
				}
			}
			
			model.addAttribute("bestBookList", bestBookList);
		}

		//junggu
		if (homepage.getHomepage_id().equals("h53")) {
			model.addAttribute("bookList1", boardService.getBoardBookJungu());
		}

		//달성군립
		if (homepage.getHomepage_id().equals("h44")) {
			Board b = new Board();
			b.setManage_idx(685);
			b.setHomepage_id(homepage.getHomepage_id());
			model.addAttribute("movieList", boardService.getSubBoardByMain(b));//영화도서전체
		}

		//북부도서관
		if (homepage.getHomepage_id().equals("h7")) {
			Board b = new Board();
			b.setManage_idx(157);
			b.setHomepage_id(homepage.getHomepage_id());
			model.addAttribute("movieList", boardService.getSubBoardByMain(b));//영화도서전체
			
			Board b2 = new Board();
			b2.setManage_idx(145);
			b2.setHomepage_id(homepage.getHomepage_id());
			model.addAttribute("exhibitionList", boardService.getSubBoardByMain(b2));//전시회전체
			
			Board b3 = new Board();
			b3.setManage_idx(146);
			b3.setHomepage_id(homepage.getHomepage_id());
			model.addAttribute("teachGuideList", boardService.getSubBoardByMain(b3));//강좌행사안내
			
			model.addAttribute("teachGuideListTopNotice", boardService.getTeachGuideListTopNotice(b3));
		}

		//서구도서관
		if (homepage.getHomepage_id().equals("h49")) {
			Board b = new Board();
			b.setManage_idx(628);
			model.addAttribute("noticeList", boardService.getSubBoardByMain(b));//공지사항전체
			b.setManage_idx(632);
			model.addAttribute("galleryList", boardService.getSubBoardByMain(b));//갤러리전체
			b.setManage_idx(625);
			model.addAttribute("bookList", boardService.getSubBoardByMain(b));//추천도서전체
			b.setManage_idx(627);
			model.addAttribute("movieList", boardService.getSubBoardByMain(b));//영화도서전체

			Teach t = new Teach();
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			List<String> homepage_ids = new ArrayList<String>();

			for (Homepage h2:subHomepageList) {
				if (h2.getHomepage_id().equals("h77")) {
					b.setCategory1("0001");
				} else if (h2.getHomepage_id().equals("h61")) {
					b.setCategory1("0002");
				} else if (h2.getHomepage_id().equals("h62")) {
					b.setCategory1("0003");
				} else if (h2.getHomepage_id().equals("h63")) {
					b.setCategory1("0004");
				} else if (h2.getHomepage_id().equals("h64")) {
					b.setCategory1("0005");
				}

				final List<Board> subBoardByMainSeogu = boardService.getSubBoardByMainSeogu(b);
				final Map<String, List<Board>> boardGroup = subBoardByMainSeogu.stream()
					.collect(Collectors.groupingBy(Board::getCategory4_name));

				for (String gorupName : boardGroup.keySet()) {
					model.addAttribute(gorupName + h2.getHomepage_id(), boardGroup.get(gorupName));
				}
//
				homepage_ids.add(h2.getHomepage_id());
				t.setHomepage_id(h2.getHomepage_id());
				model.addAttribute("teachList"+h2.getHomepage_id(), teachService.getTeachListForUser(t));
			}

			t.setHomepage_id(null);
			t.setHomepage_ids(homepage_ids);
			//sw.start("getTeachListForUser");
			List<Teach> teachListForUser = teachService.getTeachListForUser(t);
			//sw.stop();
			model.addAttribute("teachList", teachListForUser);
			//System.out.println(sw.prettyPrint());
		}

		//전자도서관 메인페이지 북큐레이션
		if (homepage.getHomepage_id().equals("h30")) {
			board = new Board();
			board.setManage_idx(944);
			if(board.getPlan_date() == null || board.getPlan_date().equals("")) {
				board.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
			}

			BoardManage boardManage = new BoardManage();
			boardManage.setBoard_type("BOOK");

			model.addAttribute("bookList", boardService.getBoard(boardManage, board));
			//신착도서
			Book book = new Book();
			book.setType("EBK");
			book.setSortField("ADD_DATE");
			book.setSortType("DESC");

			model.addAttribute("newBookList", bookService.getBookList(book));
		}

		//도토리도서관 북큐레이션
		if (homepage.getHomepage_id().equals("h80")) {
			Board b = new Board();
			b.setManage_idx(1058);
			b.setCategory1("0001");
			model.addAttribute("recommendedBookKids", boardService.getSubBoardByMainDotory(b));
			b.setCategory1("0002");
			model.addAttribute("recommendedBookTeenager", boardService.getSubBoardByMainDotory(b));
			b.setCategory1("0003");
			model.addAttribute("recommendedBookAdult", boardService.getSubBoardByMainDotory(b));
		}

		//새벗도서관
		if (homepage.getHomepage_id().equals("h83")) {
			Board b = new Board();
			b.setManage_idx(1071);
			model.addAttribute("noticeList", boardService.getSubBoardByMain(b));//공지사항전체
		}
		
		//아트도서관
		if (homepage.getHomepage_id().equals("h84")) {
			Board b = new Board();
			b.setManage_idx(1074);
			model.addAttribute("bookList", boardService.getSubBoardByMain(b));//추천도서
		}
		
		//연암도서관
		if (homepage.getHomepage_id().equals("h85")) {
			Board b = new Board();
			b.setManage_idx(1079);
			model.addAttribute("bookList", boardService.getSubBoardByMain(b));//추천도서

			LibrarySearch newBook = new LibrarySearch();
			newBook.setManageCode(homepage.getManage_code());

			//기본값 '1달 전'
			//검색기간 설정
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			int beforeDays = -30;
			newBook.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), beforeDays)));
			newBook.setSearch_end_date(sf.format(new Date()));

			//서지형태 분류코드 설정.
			//기본값 도서 "0"
			//0 : 단행, 1: 연속간행물, 2:비도서
			newBook.setBooktype("0");

			Map<String, Object> result = PrivateLibSearchAPI.getNewBookList(newBook);
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);
			newBook.setTotalDataCount(count);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

				list = PrivateLibSearchAPI.getListData(result);
				for (Map<String, Object> map : list) {
					if (map.containsKey("ISBN")) {
						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = PrivateLibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", librarySearchService.getImageUrl(map));
							}

							LibrarySearch kakaoSearch = new LibrarySearch();
							kakaoSearch.setSearch_text(String.valueOf(map.get("ISBN")));

							Map<String, Object> kakaoData = PrivateLibSearchAPI.getKaKaoList(kakaoSearch);
							List<Map<String, Object>> itemList = (List<Map<String, Object>>) kakaoData.get("list");
							if (itemList != null && itemList.size() > 0) {
								for (Map<String, Object> map3 : itemList) {
									String contents = String.valueOf(map3.get("contents"));

									map.put("contentsDetail", contents);
								}
							}
						}
					}
				}
			}

			model.addAttribute("newBookList", list);
		}


		//연암마을도서관
		String[] teachHomepage4 = {"h85"};
		for (String th: teachHomepage4 ) {
			if (homepage.getHomepage_id().equals(th)) {
				Teach t = new Teach();
				t.setHomepage_id(homepage.getHomepage_id());
				t.setSearchCate1("16");
				model.addAttribute("teachList1", teachService.getTeachListForUser(t));
				t.setSearchCate1("17");
				model.addAttribute("teachList2", teachService.getTeachListForUser(t));
			}
		}

		//한들마을도서관
		String[] teachHomepage5 = {"h88"};
		for (String th: teachHomepage5 ) {
			if (homepage.getHomepage_id().equals(th)) {
				Teach t = new Teach();
				t.setHomepage_id(homepage.getHomepage_id());
				t.setSearchCate1("16");
				model.addAttribute("teachList1", teachService.getTeachListForUser(t));
				t.setSearchCate1("17");
				model.addAttribute("teachList2", teachService.getTeachListForUser(t));
			}
		}
		
		//군위도서관
		if (homepage.getHomepage_id().equals("h94")) {
			Board b = new Board();
			b.setManage_idx(1183);
			model.addAttribute("bookList", boardService.getSubBoardByMain(b));//추천도서
			
			Teach t = new Teach();
			t.setHomepage_id(homepage.getHomepage_id());
			model.addAttribute("teachList", teachService.getTeachListForUser(t));
		}

		if ("h89".equals(homepage.getHomepage_id())) {
			Code code = new Code();
			code.setGroup_id("A0000");
			model.addAttribute("areaCodeList", codeService.getCodeList(code));

			code.setGroup_id("TC000");
			model.addAttribute("ageCodeList", codeService.getCodeList(code));

			model.addAttribute("hashtagCodeList", hashtagService.getHashtagUsedList(new Hashtag()));

			Member sessionMemberInfo = getSessionMemberInfo(request);

			Teach teach = new Teach();

			if (isLogin(request) && "HOMEPAGE".equals(sessionMemberInfo.getLoginType())) {
				MyLibrary myLibrary = myLibraryService.getMyLibrary(new MyLibrary(sessionMemberInfo.getLoginType(), sessionMemberInfo.getMember_id()));

				if (myLibrary != null) {
					if (StringUtils.isNotEmpty(myLibrary.getManage_codes())) {
						teach.setManage_codes(myLibrary.getManage_codes().split(","));
					}
				}
			}
			model.addAttribute("teachViewList", teachService.getTeachListForAllCulture(teach, "N"));
		}

		log.debug("jsp Page : "+basePath + filePath);

		BookKeyword bookKeyword = new BookKeyword();

		model.addAttribute("bookKeywordList", bookKeywordService.getBookKeywordList(bookKeyword));

		return basePath + filePath;
	}
	
	private String doKioskIndexProc(Model model, HttpServletRequest request, Board board) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Teach indexteach = new Teach();
		String sortField = indexteach.getSortField();
		if (StringUtils.equals(sortField, "TITLE")) {
			indexteach.setSortField("");
			indexteach.setSortType("");
		}
		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/index";
		}

		setBoardListToModel(homepage.getHomepage_id(), model);

		//junggu
		if (homepage.getHomepage_id().equals("h53")) {
			model.addAttribute("bookList1", boardService.getBoardBookJungu());
		}

		//새벗도서관
		if (homepage.getHomepage_id().equals("h83")) {
			Board b = new Board();
			b.setManage_idx(1071);
			model.addAttribute("noticeList", boardService.getSubBoardByMain(b));//공지사항전체
		}
		
		//아트도서관
		if (homepage.getHomepage_id().equals("h84")) {
			Board b = new Board();
			b.setManage_idx(1074);
			model.addAttribute("bookList", boardService.getSubBoardByMain(b));//추천도서
		}

		//연암마을도서관
		String[] teachHomepage4 = {"h85"};
		for (String th: teachHomepage4 ) {
			if (homepage.getHomepage_id().equals(th)) {
				Teach t = new Teach();
				t.setHomepage_id(homepage.getHomepage_id());
				t.setSearchCate1("16");
				model.addAttribute("teachList1", teachService.getTeachListForUser(t));
				t.setSearchCate1("17");
				model.addAttribute("teachList2", teachService.getTeachListForUser(t));
			}
		}

		log.debug("jsp Page : "+basePath + filePath);

		return basePath + filePath;
	}
	
	private String doKioskBookIndexProc(Model model, HttpServletRequest request, Board board) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Teach indexteach = new Teach();
		String sortField = indexteach.getSortField();
		if (StringUtils.equals(sortField, "TITLE")) {
			indexteach.setSortField("");
			indexteach.setSortType("");
		}
		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/kiosk/bookIndex";
		}

		setBoardListToKioskModel(homepage.getHomepage_id(), model);

		//junggu
		if (homepage.getHomepage_id().equals("h53")) {
			model.addAttribute("bookList1", boardService.getBoardBookJungu());
		}

		//새벗도서관
		if (homepage.getHomepage_id().equals("h83")) {
			Board b = new Board();
			b.setManage_idx(1071);
			model.addAttribute("noticeList", boardService.getSubBoardByMain(b));//공지사항전체
		}
		
		//아트도서관
		if (homepage.getHomepage_id().equals("h84")) {
			Board b = new Board();
			b.setManage_idx(1074);
			model.addAttribute("bookList", boardService.getSubBoardByMain(b));//추천도서
		}

		//연암마을도서관
		String[] teachHomepage4 = {"h85"};
		for (String th: teachHomepage4 ) {
			if (homepage.getHomepage_id().equals(th)) {
				Teach t = new Teach();
				t.setHomepage_id(homepage.getHomepage_id());
				t.setSearchCate1("16");
				model.addAttribute("teachList1", teachService.getTeachListForUser(t));
				t.setSearchCate1("17");
				model.addAttribute("teachList2", teachService.getTeachListForUser(t));
			}
		}

		log.debug("jsp Page : "+basePath + filePath);

		return basePath + filePath;
	}
	
	private String doMediawallIndexProc(Model model, HttpServletRequest request, Board board) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Teach indexteach = new Teach();
		String sortField = indexteach.getSortField();
		if (StringUtils.equals(sortField, "TITLE")) {
			indexteach.setSortField("");
			indexteach.setSortType("");
		}
		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/mediawall/bookIndex";
		}

		//국보도서관 권장도서
		if (homepage.getHomepage_id().equals("h10")) {
			Board b = new Board();
			b.setManage_idx(174);
			
			List<Board> bestBookList = boardService.getSubBoardByMain(b);
			
			model.addAttribute("bookList", bestBookList);
		}
		
		//국보도서관 신착도서
		LibrarySearch newBook = new LibrarySearch();
		newBook.setManageCode(homepage.getManage_code());

		//기본값 '1달 전'
		//검색기간 설정
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		int beforeDays = -30;
		newBook.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), beforeDays)));
		newBook.setSearch_end_date(sf.format(new Date()));

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		newBook.setBooktype("0");

		Map<String, Object> result = LibSearchAPI.getNewBookList(newBook);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);
		newBook.setTotalDataCount(count);

		if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

			list = LibSearchAPI.getListData(result);
			for (Map<String, Object> map : list) {
				if (map.containsKey("ISBN")) {
					//알라딘 API 결과 가져오기
					if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							map.put("aladin", aladinData.get("item"));
						}
						if (map.get("aladin") == null) {
							map.put("imageUrl", librarySearchService.getImageUrl(map));
						}
						
						LibrarySearch kakaoSearch = new LibrarySearch();
						kakaoSearch.setSearch_text(String.valueOf(map.get("ISBN")));
						
						Map<String, Object> kakaoData = LibSearchAPI.getKaKaoList(kakaoSearch);
						List<Map<String, Object>> itemList = (List<Map<String, Object>>) kakaoData.get("list");
						if (itemList != null && itemList.size() > 0) {
							for (Map<String, Object> map3 : itemList) {
								String contents = String.valueOf(map3.get("contents"));
								
								map.put("contentsDetail", contents);
							}
						}
					}
				}
			}
		}
		
		model.addAttribute("newBookList", list);
		
		//국보도서관 대출베스트
		LibrarySearch bestBook = new LibrarySearch();
		bestBook.setManageCode(homepage.getManage_code());
		bestBook.setBooktype("0");

		Map<String, Object> bestResult = LibSearchAPI.getBestBookList(bestBook);
		List<Map<String, Object>> bestBookList = null;

		int bestBookCount = LibSearchAPI.getSearchCount(result);

		bestBook.setTotalDataCount(bestBookCount);
		service.setPaging(model, count, bestBook);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			bestBookList = LibSearchAPI.getListData(bestResult);
			for ( Map<String, Object> map : bestBookList ) {
				if ( map.containsKey("ISBN") ) {
					//알라딘 API 결과 가져오기
					if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							map.put("aladin", aladinData.get("item"));
						}
						if (map.get("aladin") == null) {
							map.put("imageUrl", service.getImageUrl(map));
						}
						LibrarySearch kakaoSearch = new LibrarySearch();
						kakaoSearch.setSearch_text(String.valueOf(map.get("ISBN")));
						
						Map<String, Object> kakaoData = LibSearchAPI.getKaKaoList(kakaoSearch);
						List<Map<String, Object>> itemList = (List<Map<String, Object>>) kakaoData.get("list");
						if (itemList != null && itemList.size() > 0) {
							for (Map<String, Object> map3 : itemList) {
								String contents = String.valueOf(map3.get("contents"));
								
								map.put("contentsDetail", contents);
							}
						}
					}
				}
			}
		}
		
		model.addAttribute("bestBookList", bestBookList);

		log.debug("jsp Page : "+basePath + filePath);

		return basePath + filePath;
	}

	private void setBoardListToModel(String homepage_id, Model model) {
		try{
			String[] boardInfoList = ResourceBundle.getBundle("board").getString(homepage_id).split(",");
			for (String oneStr : boardInfoList) {
				if (!StringUtils.isEmpty(oneStr)) {
					String[] boardInfo = oneStr.split("/");
					String key = boardInfo[0];
					int manage_idx = Integer.parseInt(boardInfo[1]);
					int count = Integer.parseInt(boardInfo[2]);
					BoardManage boardManage = boardManageService.getBoardManageOne(new BoardManage(homepage_id, manage_idx));
					model.addAttribute(key, boardService.getBoardByMain(manage_idx, count, boardManage.getBoard_type()));
					model.addAttribute(key+"TopNotice", boardService.getBoardByMainTopNotice(manage_idx, homepage_id.equals("h8") ? 3 : 2, boardManage.getBoard_type()));
				}
			}
		}catch (MissingResourceException ex) {
			log.debug("MissingResourceException : "+ex);
		}
	}
	
	private void setBoardListToKioskModel(String homepage_id, Model model) {
		try{
			String[] boardInfoList = ResourceBundle.getBundle("board").getString(homepage_id).split(",");
			for (String oneStr : boardInfoList) {
				if (!StringUtils.isEmpty(oneStr)) {
					String[] boardInfo = oneStr.split("/");
					String key = boardInfo[0];
					int manage_idx = Integer.parseInt(boardInfo[1]);
					int count = Integer.parseInt(boardInfo[2]);
					BoardManage boardManage = boardManageService.getBoardManageOne(new BoardManage(homepage_id, manage_idx));
					model.addAttribute(key, boardService.getBoardByMainKiosk(manage_idx, count, boardManage.getBoard_type()));
					model.addAttribute(key+"TopNotice", boardService.getBoardByMainTopNotice(manage_idx, homepage_id.equals("h8") ? 3 : 2, boardManage.getBoard_type()));
				}
			}
		}catch (MissingResourceException ex) {
			log.debug("MissingResourceException : "+ex);
		}
	}

	private List<CalendarManage> getCalendarMarkCloseDay(CalendarManage closedDay, List<CalendarManage> calendarList) {

		Map<Integer, Object> closedDayRepo = new HashMap<Integer, Object>();
		String[] closedDayList;

		if (closedDay != null) {
			closedDayList = closedDay.getDd().split(",");
			for (String one : closedDayList) {
				closedDayRepo.put(Integer.parseInt(one.trim()), null);
			}
		}

		for (CalendarManage oneCal : calendarList) {
			if (StringUtils.isNotEmpty(oneCal.getSun())) {
				int sun = Integer.parseInt(oneCal.getSun().trim());
				if (closedDayRepo.containsKey(sun)) {
					oneCal.setSun(String.format("<a class=\"type-e\">%s</a>", sun));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getMon())) {
				int mon = Integer.parseInt(oneCal.getMon().trim());
				if (closedDayRepo.containsKey(mon)) {
					oneCal.setMon(String.format("<a class=\"type-e\">%s</a>", mon));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getTue())) {
				int tue = Integer.parseInt(oneCal.getTue().trim());
				if (closedDayRepo.containsKey(tue)) {
					oneCal.setTue(String.format("<a class=\"type-e\">%s</a>", tue));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getWed())) {
				int wed = Integer.parseInt(oneCal.getWed().trim());
				if (closedDayRepo.containsKey(wed)) {
					oneCal.setWed(String.format("<a class=\"type-e\">%s</a>", wed));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getThu())) {
				int thu = Integer.parseInt(oneCal.getThu().trim());
				if (closedDayRepo.containsKey(thu)) {
					oneCal.setThu(String.format("<a class=\"type-e\">%s</a>", thu));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getFri())) {
				int fri = Integer.parseInt(oneCal.getFri().trim());
				if (closedDayRepo.containsKey(fri)) {
					oneCal.setFri(String.format("<a class=\"type-e\">%s</a>", fri));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getSat())) {
				int sat = Integer.parseInt(oneCal.getSat().trim());
				if (closedDayRepo.containsKey(sat)) {
					oneCal.setSat(String.format("<a class=\"type-e\">%s</a>", sat));
				}
			}
		}

		return calendarList;
	}

	private Map<String, List<String>> getCalendarMarkGumi(String planDate, CalendarManage closedDay, List<CalendarManage> eventDay, List<Board> movieDay, List<Apply> applyDay, List<Teach> teachDay, List<FacilityReq> facilityDayList) throws ParseException {
		Map<String, List<String>> planRepo = new HashMap<String, List<String>>();
		String[] pattern = {"yyyy-MM-dd"};

		if( closedDay != null) {
			String[] closedDayList = closedDay.getDd().split(",");
			for ( String oneClose : closedDayList ) {
				List<String> closedList = null;
				String key = oneClose.trim();
				if ( key.startsWith("0") ) {
					key = key.replace("0", "");
				}
				if ( planRepo.containsKey(key) ) {
					closedList = planRepo.get(key);
				}
				else {
					closedList = new ArrayList<String>();
				}

				closedList.add("[휴관일]");
				planRepo.put(key, closedList);
			}
		}

		for (CalendarManage event : eventDay) {
			List<String> eventList = null;

			String startDateStr 	= event.getStart_date();
			String endDateStr 		= event.getEnd_date();
			String startKey 		= event.getStart_date().substring(8,10);
			String endKey 			= event.getEnd_date().substring(8,10);
			SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}
			    if ( sf.format(startDate).startsWith(planDate) ) {
			      startKey = sf.format(startDate).substring(8, 10);
				    if ( startKey.startsWith("0") ) {
				  	  startKey = startKey.replace("0", "");
				    }
				    if ( planRepo.containsKey(startKey) ) {
				  	  eventList = planRepo.get(startKey);
				    }
				    else {
				  	  eventList = new ArrayList<String>();
				    }
				    if (!eventList.contains("[휴관일]")) {
				    	eventList.add(event.getTitle());
				    	planRepo.put(startKey, eventList);
				    }
			    }

			    startDate = DateUtils.addDays(startDate, 1);
			}
			if ( endKey.startsWith("0") ) {
				endKey = endKey.replace("0", "");
		    }
			if ( planRepo.containsKey(endKey) ) {
				eventList = planRepo.get(endKey);
			}
			else {
				eventList = new ArrayList<String>();
			}
			if (!eventList.contains("[휴관일]")) {
				eventList.add(event.getTitle());
		    	planRepo.put(endKey, eventList);
		    }
			planRepo.put(endKey, eventList);
		}

		for (Board movie : movieDay) {
			String key = movie.getImsi_v_2().trim();
			if ( key.startsWith("0") ) {
				key = key.replace("0", "");
			}
			List<String> planList = null;
			if ( planRepo.containsKey(key) ) {
				planList = planRepo.get(key);
			}
			else {
				planList = new ArrayList<String>();
			}

			if (!planList.contains("[휴관일]")) {
				planList.add("[영화]" + movie.getTitle());
		    	planRepo.put(key, planList);
		    }
		}



		for (Apply excursions : applyDay) {
			List<String> excursionsList = null;

			String startDateStr 	= excursions.getStart_date();
			String endDateStr 		= excursions.getEnd_date();
			String startKey 		= excursions.getStart_date().substring(8,10);
			String endKey 			= excursions.getEnd_date().substring(8,10);
			SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}

				if ( sf.format(startDate).startsWith(planDate) ) {
			      startKey = sf.format(startDate).substring(8, 10);
				    if ( startKey.startsWith("0") ) {
				  	  startKey = startKey.replace("0", "");
				    }
				    if ( planRepo.containsKey(startKey) ) {
				  	  excursionsList = planRepo.get(startKey);
				    }
				    else {
				  	  excursionsList = new ArrayList<String>();
				    }
				    if (!excursionsList.contains("[휴관일]")) {
				    	excursionsList.add("[견학]" + excursions.getAgency_name());
				    	planRepo.put(startKey, excursionsList);
				    }
			    }
			    startDate = DateUtils.addDays(startDate, 1);
			}
			if ( endKey.startsWith("0") ) {
				endKey = endKey.replace("0", "");
		    }
			if ( planRepo.containsKey(endKey) ) {
				excursionsList = planRepo.get(endKey);
			}
			else {
				excursionsList = new ArrayList<String>();
			}
			if (!excursionsList.contains("[휴관일]")) {
				excursionsList.add("[견학]" + excursions.getAgency_name());
		    	planRepo.put(endKey, excursionsList);
		    }
		}

			for (Teach teach : teachDay) {
				List<String> teachList = null;
				String[] teachDays 	= teach.getTeach_day().split(",");
				String startDateStr = teach.getStart_date();
				String endDateStr 	= teach.getEnd_date();
				String startKey 	= teach.getStart_date().substring(8,10);
				String endKey 		= teach.getEnd_date().substring(8,10);
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

				Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
				Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

				while( !DateUtils.isSameDay(startDate, endDate) ) {
					if ( startDate.after(endDate) ) {
						break;
					}

					if ( sf.format(startDate).startsWith(planDate) ) {
				    	 Calendar cal = Calendar.getInstance() ;
					     cal.setTime(startDate);
					     int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
					     for ( String one : teachDays ) {
					    	  if ( dayNum == Integer.parseInt(one) ) {
					    		  startKey = sf.format(startDate).substring(8, 10);
					    		  if ( startKey.startsWith("0") ) {
					    			  startKey = startKey.replace("0", "");
						  		  }
					    		  if ( planRepo.containsKey(startKey) ) {
					    			  teachList = planRepo.get(startKey);
					    		  }
					    		  else {
					    			  teachList = new ArrayList<String>();
					    		  }
						    		  if (!teachList.contains("[휴관일]")) {
						    			  String teachStatus;
						    			  if(!teach.getGroup_name().isEmpty()) {
						    				  teachStatus="[" + teach.getGroup_name() + "]";
						    			  }else {
						    				  teachStatus= "[강좌]";
						    			  }

										  boolean holidayCheck = false;
						    			  if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
						    				  for ( String string : teach.getHolidays() ) {
						    					  if (StringUtils.equals(string, planDate +"-"+ startKey)) {
						    						  teachStatus = "[휴강]";
													  if(teach.getDisable_holi_calendar().equals("Y")){
														  holidayCheck = true;
													  }
						    					  }
						    				  }
						    			  }
										  if (!holidayCheck) {
											  teachList.add(teachStatus + teach.getTeach_name());
											  planRepo.put(startKey, teachList);
										  }
								      }
					    	  }
					     }
				     }

				     startDate = DateUtils.addDays(startDate, 1);
				}
				if ( sf.format(startDate).startsWith(planDate) ) {
					Calendar cal = Calendar.getInstance() ;
				    cal.setTime(endDate);
				    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
				    for ( String one : teachDays ) {
				    	if ( dayNum == Integer.parseInt(one) ) {
				    		if ( endKey.startsWith("0") ) {
				    			endKey = endKey.replace("0", "");
					  		}
				    		if ( planRepo.containsKey(endKey) ) {
								teachList = planRepo.get(endKey);
							}
							else {
								teachList = new ArrayList<String>();
							}
				    		if (!teachList.contains("[휴관일]")) {
				    			 String teachStatus;
				    			  if(!teach.getGroup_name().isEmpty()) {
				    				  teachStatus="[" + teach.getGroup_name() + "]";
				    			  }else {
				    				  teachStatus= "[강좌]";
				    			  }
				    			  if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
				    				  for ( String string : teach.getHolidays() ) {
				    					  if (StringUtils.equals(string, planDate +"-"+ endKey)) {
				    						  teachStatus = "[휴강]";
				    					  }
				    				  }
				    			  }
				    			teachList.add(teachStatus + teach.getTeach_name());
						    	planRepo.put(endKey, teachList);
						    }
				    	}
				    }
			    }

			}

		for (FacilityReq facility : facilityDayList) {
			List<String> facilityList = null;
			String key 	= facility.getUse_date().substring(8, 10);

		    if ( key.startsWith("0") ) {
		    	key = key.replace("0", "");
	  		}
		    if ( planRepo.containsKey(key) ) {
		    	facilityList = planRepo.get(key);
		    }
		    else {
		    	facilityList = new ArrayList<String>();
		    }

		    if (!facilityList.contains("[휴관일]")) {
		    	facilityList.add(String.format("[시설물] %s (%s)", facility.getFacility_name(), facility.getMasking_name()));
		    	planRepo.put(key, facilityList);
		    }

		}
		return planRepo;
	}

	private Map<String, List<String>> getCalendarMarkGumiDate(String planDate, CalendarManage closedDay, List<CalendarManage> eventDay, List<Board> movieDay, List<Apply> applyDay, List<Teach> teachDay, List<FacilityReq> facilityDayList) throws ParseException {
		Map<String, List<String>> planRepo = new HashMap<String, List<String>>();
		String[] pattern = {"yyyy-MM-dd"};

//		if( closedDay != null) {
//			String[] closedDayList = closedDay.getDd().split(",");
//			for ( String oneClose : closedDayList ) {
//				String key = oneClose.trim();
//				if ( key.startsWith("0") ) {
//					key = key.replace("0", "");
//				}
//				List<String> closedList = null;
//				if ( planRepo.containsKey(key) ) {
//					closedList = planRepo.get(key);
//				}
//				else {
//					closedList = new ArrayList<String>();
//				}
//
//				closedList.add("[휴관일]");
//				planRepo.put(key, closedList);
//			}
//		}

		for (CalendarManage event : eventDay) {
			List<String> eventList = null;

			String startDateStr 	= event.getStart_date();
			String endDateStr 		= event.getEnd_date();
			String startKey 		= event.getStart_date().substring(8,10);
			String endKey 			= event.getEnd_date().substring(8,10);
			SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}
			    if ( sf.format(startDate).startsWith(planDate) ) {
			      startKey = sf.format(startDate).substring(8, 10);
				    if ( startKey.startsWith("0") ) {
				  	  startKey = startKey.replace("0", "");
				    }
				    if ( planRepo.containsKey(startKey) ) {
				  	  eventList = planRepo.get(startKey);
				    }
				    else {
				  	  eventList = new ArrayList<String>();
				    }
				    if (!eventList.contains("[휴관일]")) {
				    	eventList.add(event.getTitle() + "^^^" + startDateStr.substring(5) + " ~ " + endDateStr.substring(5));
				    	planRepo.put(startKey, eventList);
				    }
			    }

			    startDate = DateUtils.addDays(startDate, 1);
			}
			if ( endKey.startsWith("0") ) {
				endKey = endKey.replace("0", "");
		    }
			if ( planRepo.containsKey(endKey) ) {
				eventList = planRepo.get(endKey);
			}
			else {
				eventList = new ArrayList<String>();
			}
			if (!eventList.contains("[휴관일]")) {
				eventList.add(event.getTitle() + "^^^" + startDateStr.substring(5) + " ~ " + endDateStr.substring(5));
		    	planRepo.put(endKey, eventList);
		    }
			planRepo.put(endKey, eventList);
		}

		for (Board movie : movieDay) {
			String key = movie.getImsi_v_2().trim();
			if ( key.startsWith("0") ) {
				key = key.replace("0", "");
			}
			List<String> planList = null;
			if ( planRepo.containsKey(key) ) {
				planList = planRepo.get(key);
			}
			else {
				planList = new ArrayList<String>();
			}

			if (!planList.contains("[휴관일]")) {
				planList.add("[영화]" + movie.getTitle()  + "^^^" + movie.getImsi_v_1()+ "-" + movie.getImsi_v_2());
		    	planRepo.put(key, planList);
		    }
		}



		for (Apply excursions : applyDay) {
			List<String> excursionsList = null;

			String startDateStr 	= excursions.getStart_date();
			String endDateStr 		= excursions.getEnd_date();
			String startKey 		= excursions.getStart_date().substring(8,10);
			String endKey 			= excursions.getEnd_date().substring(8,10);
			SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}

				if ( sf.format(startDate).startsWith(planDate) ) {
			      startKey = sf.format(startDate).substring(8, 10);
				    if ( startKey.startsWith("0") ) {
				  	  startKey = startKey.replace("0", "");
				    }
				    if ( planRepo.containsKey(startKey) ) {
				  	  excursionsList = planRepo.get(startKey);
				    }
				    else {
				  	  excursionsList = new ArrayList<String>();
				    }
				    if (!excursionsList.contains("[휴관일]")) {
				    	excursionsList.add("[견학]" + excursions.getAgency_name() + "^^^" + startDateStr.substring(5) + " ~ " + endDateStr.substring(5));
				    	planRepo.put(startKey, excursionsList);
				    }
			    }
			    startDate = DateUtils.addDays(startDate, 1);
			}
			if ( endKey.startsWith("0") ) {
				endKey = endKey.replace("0", "");
		    }
			if ( planRepo.containsKey(endKey) ) {
				excursionsList = planRepo.get(endKey);
			}
			else {
				excursionsList = new ArrayList<String>();
			}
			if (!excursionsList.contains("[휴관일]")) {
				excursionsList.add("[견학]" + excursions.getAgency_name() + "^^^" + startDateStr.substring(5) + " ~ " + endDateStr.substring(5));
		    	planRepo.put(endKey, excursionsList);
		    }
		}

		for (Teach teach : teachDay) {
			List<String> teachList = null;
			String[] teachDays 	= teach.getTeach_day().split(",");
			String startDateStr = teach.getStart_date();
			String endDateStr 	= teach.getEnd_date();
			String startKey 	= teach.getStart_date().substring(8,10);
			String endKey 		= teach.getEnd_date().substring(8,10);
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}

				if ( sf.format(startDate).startsWith(planDate) ) {
			    	 Calendar cal = Calendar.getInstance() ;
				     cal.setTime(startDate);
				     int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
				     for ( String one : teachDays ) {
				    	  if ( dayNum == Integer.parseInt(one) ) {
				    		  startKey = sf.format(startDate).substring(8, 10);
				    		  if ( startKey.startsWith("0") ) {
				    			  startKey = startKey.replace("0", "");
					  		  }
				    		  if ( planRepo.containsKey(startKey) ) {
				    			  teachList = planRepo.get(startKey);
				    		  }
				    		  else {
				    			  teachList = new ArrayList<String>();
				    		  }

				    		  if (!teachList.contains("[휴관일]")) {
								  boolean holidayCheck = false;
				    			  String teachStatus = "[강좌]";
				    			  if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
					    			if(teach.getDisable_holi().equals("N")) {
					    				  for ( String string : teach.getHolidays() ) {
					    					  if (StringUtils.equals(string, planDate +"-"+ startKey)) {
					    						  teachStatus = "[휴강]";
												  if(teach.getDisable_holi_calendar().equals("Y")){
													  holidayCheck = true;
												  }
					    					  }
					    				  }
					    			  }
				    			  }
								  if (!holidayCheck) {
									  teachList.add(teachStatus + teach.getTeach_name() + "^^^" + startDateStr.substring(5) + " ~ " + endDateStr.substring(5));
									  planRepo.put(startKey, teachList);
								  }
						      }
				    	  }
				     }
			     }

			     startDate = DateUtils.addDays(startDate, 1);
			}
			if ( sf.format(startDate).startsWith(planDate) ) {
				Calendar cal = Calendar.getInstance() ;
			    cal.setTime(endDate);
			    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
			    for ( String one : teachDays ) {
			    	if ( dayNum == Integer.parseInt(one) ) {
			    		if ( endKey.startsWith("0") ) {
			    			endKey = endKey.replace("0", "");
				  		}
			    		if ( planRepo.containsKey(endKey) ) {
							teachList = planRepo.get(endKey);
						}
						else {
							teachList = new ArrayList<String>();
						}
			    		if (!teachList.contains("[휴관일]")) {
							boolean holidayCheck = false;
			    			String teachStatus = "[강좌]";
			    			  if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
			    				if(teach.getDisable_holi().equals("N")) {
			    				  for ( String string : teach.getHolidays() ) {
			    					  if (StringUtils.equals(string, planDate +"-"+ endKey)) {
			    						  teachStatus = "[휴강]";
										  if(teach.getDisable_holi_calendar().equals("Y")){
											  holidayCheck = true;
										  }
			    					  }
			    				  }
			    				}
			    			  }
							if (!holidayCheck) {
								teachList.add(teachStatus + teach.getTeach_name() + "^^^" + startDateStr.substring(5) + " ~ " + endDateStr.substring(5));
								planRepo.put(endKey, teachList);
							}
					    }
			    	}
			    }
		    }

		}

		for (FacilityReq facility : facilityDayList) {
			List<String> facilityList = null;
			String key 	= facility.getUse_date().substring(8, 10);

		    if ( key.startsWith("0") ) {
		    	key = key.replace("0", "");
	  		}
		    if ( planRepo.containsKey(key) ) {
		    	facilityList = planRepo.get(key);
		    }
		    else {
		    	facilityList = new ArrayList<String>();
		    }

		    if (!facilityList.contains("[휴관일]")) {
		    	facilityList.add(String.format("[시설물] %s (%s)", facility.getFacility_name(), facility.getMasking_name()));
		    	planRepo.put(key, facilityList);
		    }

		}
		return planRepo;
	}

	private Map<String, List<String>> getCalendarMarkPrivate(String planDate, CalendarManage closedDay, List<CalendarManage> eventDay, List<Board> movieDay, List<Apply> applyDay, List<Teach> teachDay, List<FacilityReq> facilityDayList) throws ParseException {
		Map<String, List<String>> planRepo = new HashMap<String, List<String>>();
		String[] pattern = {"yyyy-MM-dd"};

		if( closedDay != null) {
			String[] closedDayList = closedDay.getDd().split(",");
			for ( String oneClose : closedDayList ) {
				List<String> closedList = null;
				String key = oneClose.trim();
				if ( key.startsWith("0") ) {
					key = key.replace("0", "");
				}
				if ( planRepo.containsKey(key) ) {
					closedList = planRepo.get(key);
				}
				else {
					closedList = new ArrayList<String>();
				}

				closedList.add("[휴관일]");
				planRepo.put(key, closedList);
			}
		}

		for (CalendarManage event : eventDay) {
			List<String> eventList = null;

			String startDateStr 	= event.getStart_date();
			String endDateStr 		= event.getEnd_date();
			String startKey 		= event.getStart_date().substring(8,10);
			String endKey 			= event.getEnd_date().substring(8,10);
			SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}
			    if ( sf.format(startDate).startsWith(planDate) ) {
			      startKey = sf.format(startDate).substring(8, 10);
				    if ( startKey.startsWith("0") ) {
				  	  startKey = startKey.replace("0", "");
				    }
				    if ( planRepo.containsKey(startKey) ) {
				  	  eventList = planRepo.get(startKey);
				    }
				    else {
				  	  eventList = new ArrayList<String>();
				    }
				    if (!eventList.contains("[휴관일]")) {
				    	eventList.add(event.getTitle());
				    	planRepo.put(startKey, eventList);
				    }
			    }

			    startDate = DateUtils.addDays(startDate, 1);
			}
			if ( endKey.startsWith("0") ) {
				endKey = endKey.replace("0", "");
		    }
			if ( planRepo.containsKey(endKey) ) {
				eventList = planRepo.get(endKey);
			}
			else {
				eventList = new ArrayList<String>();
			}
			if (!eventList.contains("[휴관일]")) {
				eventList.add(event.getTitle());
		    	planRepo.put(endKey, eventList);
		    }
			planRepo.put(endKey, eventList);
		}

		for (Teach teach : teachDay) {
			List<String> teachList = null;
			String[] teachDays 	= teach.getTeach_day().split(",");
			String startDateStr = teach.getStart_date();
			String endDateStr 	= teach.getEnd_date();
			String startKey 	= teach.getStart_date().substring(8,10);
			String endKey 		= teach.getEnd_date().substring(8,10);
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}

				if ( sf.format(startDate).startsWith(planDate) ) {
			    	 Calendar cal = Calendar.getInstance() ;
				     cal.setTime(startDate);
				     int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
				     for ( String one : teachDays ) {
				    	  if ( dayNum == Integer.parseInt(one) ) {
				    		  startKey = sf.format(startDate).substring(8, 10);
				    		  if ( startKey.startsWith("0") ) {
				    			  startKey = startKey.replace("0", "");
					  		  }
				    		  if ( planRepo.containsKey(startKey) ) {
				    			  teachList = planRepo.get(startKey);
				    		  }
				    		  else {
				    			  teachList = new ArrayList<String>();
				    		  }
				    		  if (!teachList.contains("[휴관일]")) {
				    			  String teachStatus= "[강좌]";
								  boolean holidayCheck = false;
				    			  if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
				    				  for ( String string : teach.getHolidays() ) {
				    					  if (StringUtils.equals(string, planDate +"-"+ startKey)) {
				    						  teachStatus = "[휴강]";
											  if(teach.getDisable_holi_calendar().equals("Y")){
												  holidayCheck = true;
											  }
				    					  }
				    				  }
				    			  }
								  if (!holidayCheck) {
									  teachList.add(teachStatus + teach.getTeach_name());
									  planRepo.put(startKey, teachList);
								  }
						      }
				    	  }
				     }
			     }

			     startDate = DateUtils.addDays(startDate, 1);
				}

				if ( sf.format(startDate).startsWith(planDate) ) {
					Calendar cal = Calendar.getInstance() ;
				    cal.setTime(endDate);
				    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
				    for ( String one : teachDays ) {
				    	if ( dayNum == Integer.parseInt(one) ) {
				    		if ( endKey.startsWith("0") ) {
				    			endKey = endKey.replace("0", "");
					  		}
				    		if ( planRepo.containsKey(endKey) ) {
								teachList = planRepo.get(endKey);
							}
							else {
								teachList = new ArrayList<String>();
							}
				    		if (!teachList.contains("[휴관일]")) {
				    			 String teachStatus = "[강좌]";
				    			  if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
				    				  for ( String string : teach.getHolidays() ) {
				    					  if (StringUtils.equals(string, planDate +"-"+ endKey)) {
				    						  teachStatus = "[휴강]";
				    					  }
				    				  }
				    			  }
				    			teachList.add(teachStatus + teach.getTeach_name());
						    	planRepo.put(endKey, teachList);
						    }
				    	}
				    }
			    }
			}
		return planRepo;
	}
	/*
	* 다드림
	 */
	@RequestMapping(value = { "/{contextPath}/searchCulture.*" })
	public String searchCulture(Model model, HttpServletRequest request, @PathVariable String contextPath, Teach teach) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(teach.getSearch_yy()), Integer.parseInt(teach.getSearch_mm())-1, 1); //월은 -1해줘야 해당월로 인식

		String yy = teach.getSearch_yy();
		String mm = teach.getSearch_mm();

		teach.setSearch_start_date(yy+mm+String.format("%02d", 1));
		teach.setSearch_end_date(yy+mm+cal.getActualMaximum(Calendar.DAY_OF_MONTH));

		teach.setRowCount(8);
		teachService.setPaging(model, teachService.getTeachListForAllSearchCultureCount(teach), teach);
		model.addAttribute("searchTeachList",teachService.getTeachListForAllSearchCulture(teach));
		model.addAttribute("count", teachService.getTeachListForAllSearchCultureCount(teach));
		return basePath + homepage.getFolder() + "/searchCulture_ajax";
	}

	/*
	 * 문화포털 최상단 강좌(노출여부에따라 표현)
	 */
	@RequestMapping(value = { "/{contextPath}/education.*" })
	public String education(Model model, HttpServletRequest request,
		@PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Member sessionMemberInfo = getSessionMemberInfo(request);

		Teach teach = new Teach();

		if (isLogin(request) && "HOMEPAGE".equals(sessionMemberInfo.getLoginType())) {
			MyLibrary myLibrary =myLibraryService.getMyLibrary(new MyLibrary(sessionMemberInfo.getLoginType(), sessionMemberInfo.getMember_id()));

			if (myLibrary != null) {
				if (StringUtils.isNotEmpty(myLibrary.getManage_codes())) {
					teach.setManage_codes(myLibrary.getManage_codes().split(","));
				}
			}

		}

		model.addAttribute("teachViewList", teachService.getTeachListForAllCulture(teach, "Y"));
		return basePath + homepage.getFolder() + "/education_ajax";
	}

	/*
	 * 특화서비스
	 */
	@RequestMapping(value = { "/{contextPath}/culture.*" })
	public String culture(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		model.addAttribute("serviceViewList", specializedServicesService.getSpecializedServicesMainList(new SpecializedServices()));
		return basePath + homepage.getFolder() + "/culture_ajax";
	}
	/*
	 * 전시
	 */
	@RequestMapping(value = { "/{contextPath}/exhibition.*" })
	public String exhibition(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Board board = new Board();
		board.setEndRowNum(20);
		model.addAttribute("exhibitionViewList", boardService.getBoardExhibitionList(board));
		return basePath + homepage.getFolder() + "/exhibition_ajax";
	}

	/*
	 * 영화
	 */
	@RequestMapping(value = { "/{contextPath}/movie.*" })
	public String movie(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Board board = new Board();
		board.setEndRowNum(20);
		model.addAttribute("movieViewList", boardService.getBoardMovieList(board));
		return basePath + homepage.getFolder() + "/movie_ajax";
	}

	/*
	 * 공연전시
	 */
	@RequestMapping(value = { "/{contextPath}/areaexhibition.*" })
	public String areaexhibition(Model model, @RequestParam("search_area") String search_area, HttpServletRequest request,
		@PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("gugun", search_area);
		//TODO 요청카운트 제한으로 인한 오류로 인해 임시 조치
		try {
			model.addAttribute("list", CultureAPI.areaRequestDetails(new HashMap<String, Object>(), CultureAPI.areaRequest(parameter)));
		} catch (Exception e) {
			log.error("@@@@@@@@@@@@@@@@@@ areaRequestDetails : " + e);
			model.addAttribute("list", "");
		}
		
		return basePath + homepage.getFolder() + "/areaexhibition_ajax";
	}

	/*
	 * 행사축제
	 */
	@RequestMapping(value = { "/{contextPath}/areacarnival.*" })
	public String areacarnival(Model model, @RequestParam("search_area") String search_area, HttpServletRequest request,
		@PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Board board = new Board();
		board.setManage_idx(1101);
		board.setDept_cd("CULTURE");
		board.setImsi_v_2(search_area);

		model.addAttribute("festivalList", boardService.getBoardByMain(board));
		return basePath + homepage.getFolder() + "/areacarnival_ajax";
	}

	/*
	 * 문화공간
	 */
	@RequestMapping(value = { "/{contextPath}/areaculture.*" })
	public String areaculture(Model model, Culture culture, HttpServletRequest request,
		@PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		model.addAttribute("areaCultureList", cultureService.getAreaCultureList(culture));
		return basePath + homepage.getFolder() + "/areaculture_ajax";
	}
	
	@RequestMapping(value = { "/{contextPath}/curation{idx}.*"})
	public String curation(Model model, HttpServletRequest request, @PathVariable String contextPath, @PathVariable String idx) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		return basePath + homepage.getFolder() + "/curation" + idx + "_ajax";
	}
}
