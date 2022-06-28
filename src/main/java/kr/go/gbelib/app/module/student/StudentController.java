package kr.go.gbelib.app.module.student;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.map.ObjectMapper;
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
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.cms.module.blackList.BlackList;
import kr.go.gbelib.app.cms.module.blackList.BlackListService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.teach.student.StudentService;

@Controller(value="userStudent")
@RequestMapping(value = {"/{homepagePath}/module/teach/student"})
public class StudentController extends BaseController {

	private String basePath = "/homepage/%s/module/teach/student/";

	@Autowired
	private TeachService teachService;

	@Autowired
	private StudentService service;

	@Autowired
	private CodeService codeService;

	@Autowired
	private TermsService termsService;

	@Autowired
	private RecommendSiteService recommendSiteService;
	
	@Autowired
	private BlackListService blackListService;
	
	@Autowired
	private StudentService studentService;

	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = {"/cert.*"}, method = RequestMethod.GET)
	public String cert(Model model, Student student, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "cert";

	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Student student, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		Teach teachOne = teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx()));

		if (teachOne == null) {
			service.alertMessage("잘못된 경로로 접근하였습니다", request, response);
			return null;
		}

		if (StringUtils.equals(teachOne.getMember_yn(), "N") && !isLogin(request)) {
			student.setBefore_url(String.format("/%s/module/teach/index.do?menu_idx=%s&group_idx=%s&category_idx=%s", homepage.getContext_path(), student.getMenu_idx(), student.getGroup_idx(), student.getCategory_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), student.getMenu_idx(), student.getBefore_url()), request, response);
			return null;
		}

		if (StringUtils.equals(teachOne.getMember_yn(), "Y")) {
			student.setMember_id("ANONYMOUS");
		} else {
			student.setMember_id(getSessionMemberId(request));
			student.setMember_key(getSessionMemberId(request));
		}

		//대표, 달서구, 동구, 서구, 중구, 수성구(범어,용학,고산)는 제외
		if ( !homepage.getHomepage_id().equals("h32") && !homepage.getHomepage_id().equals("h37") && !homepage.getHomepage_id().equals("h49") && !homepage.getHomepage_id().equals("h45") && !homepage.getHomepage_id().equals("h53")
				&& !homepage.getHomepage_id().equals("h50") && !homepage.getHomepage_id().equals("h51") && !homepage.getHomepage_id().equals("h52") ) {
			student.setHomepage_id(homepage.getHomepage_id());
		}

		System.out.println("@@@@@@@@@@@@@@@ homepage.getHomepage_id() = " + homepage.getHomepage_id());
		System.out.println("@@@@@@@@@@@@@@@ student.getHomepage_id() = " + student.getHomepage_id());

		// 그룹당 강의 제한 개수 . ->
		String checkResult = service.checkStudent(student);
		if ( checkResult != null ) {
			service.alertMessage(checkResult, request, response);
			return null;
		}

		//블랙리스트 체크
		if ( blackListService.checkBlackList(new BlackList(student.getHomepage_id(), getSessionMemberId(request)), "10")) {
			service.alertMessage("신청이 불가능합니다.\\n도서관에 문의해주세요.", request, response);
			return null;
		}

		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		Terms t = new Terms(menuOne.getManage_idx());
		t.setHomepage_id(homepage.getHomepage_id());
		// 홈페이지 강좌의 약관 전체 리스트
		List<Terms> termsList = termsService.getTermsListInModule(t);
		List<Terms> termsResult = new ArrayList<Terms>();
		// 강좌 관리에서 선택한 약관
		if(teachOne.getTerms() != null) {
    		String[] termsArr = teachOne.getTerms().split(",");
    		for (Terms termsOne : termsList) {
    			for (String s : termsArr) {
    				if(termsOne.getTerms_idx() == Integer.parseInt(s)) {
    					termsResult.add(termsOne);
    					break;
    				}
    			}
    		}
		}
		
		model.addAttribute("termsList", termsResult);
		model.addAttribute("hakList", codeService.getCode("CMS", "C0020"));
		model.addAttribute("teach", teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx())));
		model.addAttribute("memberInfo", getSessionMemberInfo(request));
		model.addAttribute("student", student);
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0003"));
//		model.addAttribute("prtcNotice",MemberAPI.getPrtcNoticeList("WEB"));
		model.addAttribute("traingLocationList", codeService.getCode("CMS", "C0022"));
		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	
	@RequestMapping(value = {"/edit_mod.*"})
	public String edit_mod(Model model, Student student, HttpServletRequest request, HttpServletResponse response){
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		int menu_idx = student.getMenu_idx();
		student = studentService.getStudentOne(student);
		student.setEditMode("MODIFY");
		student.setMenu_idx(menu_idx);	
		model.addAttribute("student", student);
		model.addAttribute("teach", teachService.getTeachOne(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx())));
		model.addAttribute("statusCode", codeService.getCode("CMS", "C0005"));
		model.addAttribute("hakList", codeService.getCode("CMS", "C0020"));
		model.addAttribute("traingLocationList", codeService.getCode("CMS", "C0022"));
		model.addAttribute("termsList", termsService.getTermsListByTeach(new Teach(student.getHomepage_id(), student.getGroup_idx(), student.getCategory_idx(), student.getTeach_idx())));
		
		return String.format(basePath, homepage.getFolder()) + "edit_mod";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
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
//			ValidationUtils.rejectIfEmpty(result, "member_id", "신청자ID를 입력하세요.");
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
//				ValidationUtils.rejectIfEmpty(result, "applicant_zipcode", "신청자 우편번호를 입력하세요.");
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
//    				ValidationUtils.rejectIfEmpty(result, "student_zipcode", "수강생 우편번호를 입력하세요.");
    				ValidationUtils.rejectIfEmpty(result, "student_address", "수강생 주소를 입력하세요.");
				}
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

//				String writer = quizReq.getName() + "/" + quizReq.getSchool() + "/" + quizReq.getBan();
//				String addResult = WebFilterCheckUtils.webFilterCheck(writer, "강좌 신청", );
//				if (addResult != null) {
//					res.setValid(true);
//					res.setUrl(addResult);
//					res.setTargetOpener(true);
//					return res;
//				}

				Object[] addResult = service.addStudent(student, "HOMEPAGE");
				res.setValid((Boolean) addResult[0]);

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
				
				service.updateStudent(student);
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
	//				res.setUrl(String.format("/%s/module/teach/index.do", homepage.getContext_path()));
	//				res.setData("menu_idx=" + student.getMenu_idx());
				}
			} else if (student.getEditMode().equals("CANCEL") || student.getEditMode().equals("CANCEL_ALL")) {
				student.setMember_key(getSessionMemberId(request));
				student.setCancel_id(getSessionMemberId(request));
				service.cancelStudent(student);

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
				service.cancelStudent(student);

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

	@RequestMapping(value = {"/certificate.*"})
	public String certificate(Model model, Student student, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		model.addAttribute("certificateInfo", service.getCertificateInfo(student));
		return String.format(basePath, homepage.getFolder()) + "certificate_ajax";
	}

}
