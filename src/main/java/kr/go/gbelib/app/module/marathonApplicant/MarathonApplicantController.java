package kr.go.gbelib.app.module.marathonApplicant;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.framework.utils.ValidationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.marathon.Marathon;
import kr.go.gbelib.app.cms.module.marathon.MarathonService;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicant;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicantService;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecord;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecordService;
import kr.go.gbelib.app.cms.module.marathonType.MarathonType;
import kr.go.gbelib.app.cms.module.marathonType.MarathonTypeService;

@Controller(value = "userMarathonApplicant")
@RequestMapping(value = "/{homepagePath}/module/marathonApplicant")
public class MarathonApplicantController extends BaseController {

	private final String basePath = "/homepage/%s/module/marathonApplicant/";
	
	@Autowired
	private MarathonApplicantService service;

	@Autowired
	private MarathonService marathonService;
	
	@Autowired
	private MarathonTypeService marathonTypeService;

	@Autowired
	private MarathonRecordService recordService;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			if(homepage == null) {
				service.alertMessage("잘못된 경로입니다.", request, response);
				return null;
			}else {
				marathonApplicant.setBefore_url(String.format("/%s/module/marathonApplicant/index.do?menu_idx=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx()));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx(), marathonApplicant.getBefore_url()), request, response);
				return null;
			}
		}else {
			Marathon marathonUseOne = new Marathon();
			marathonUseOne.setHomepage_id(homepage.getHomepage_id());
			marathonUseOne = marathonService.getMarathonUseOne(marathonUseOne);
			model.addAttribute("ing", marathonUseOne != null);
			if(marathonUseOne != null) {
				marathonApplicant.setHomepage_id(homepage.getHomepage_id());
				marathonApplicant.setContest_idx(marathonUseOne.getContest_idx());

				service.setPaging(model, service.getMarathonApplicantCount(marathonApplicant), marathonApplicant);
				model.addAttribute("marathonApplicant", marathonApplicant);
				model.addAttribute("marathonTypeList", service.getMarathonTypeList(marathonApplicant));
				model.addAttribute("marathonApplicantList", service.getMarathonApplicantList(marathonApplicant));
			}
			return String.format(basePath, homepage.getFolder()) + "index";
		}
		
	}
	
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			marathonApplicant.setBefore_url(String.format("/%s/module/marathonApplicant/edit.do?menu_idx=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx(), marathonApplicant.getBefore_url()), request, response);
		}else {
			Marathon marathonUseOne = new Marathon();
			marathonUseOne.setHomepage_id(homepage.getHomepage_id());
			marathonUseOne = marathonService.getMarathonUseOne(marathonUseOne);
			model.addAttribute("ing", marathonUseOne != null);
			if(marathonUseOne != null) {
				String application_start_day = marathonUseOne.getApplication_start_day();
				String application_end_day = marathonUseOne.getApplication_end_day();
				Calendar cal = Calendar.getInstance();
				Date date = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date application_start_date = dateFormat.parse(application_start_day);
				Date application_end_date = dateFormat.parse(application_end_day);
				cal.setTime(application_end_date);
				cal.add(Calendar.DATE, 1);
				if(marathonApplicant.getEditMode().equals("view")) {
					marathonApplicant.setHomepage_id(homepage.getHomepage_id());
					marathonApplicant.setContest_idx(marathonUseOne.getContest_idx());
					marathonApplicant.setMember_id(getSessionMemberId(request));
					marathonApplicant.setAdd_date(new Date());
					if(service.getMarathonApplicantOneById(marathonApplicant) != null) {
						model.addAttribute("marathonApplicant", service.copyObjectPaging(marathonApplicant, service.getMarathonApplicantOneById(marathonApplicant)));
						return String.format(basePath, homepage.getFolder()) + "myInfo";
					}else {
						marathonApplicant.setEditMode("");
						service.alertMessageAndUrl("독서마라톤대회에 참가 신청하지 않았습니다. 참가 신청 페이지로 이동합니다.", String.format("/%s/module/marathonApplicant/edit.do?menu_idx=105", homepage.getContext_path()), request, response);
						return null;
					}
				}
				
				if(application_start_date.compareTo(date) > 0 || date.compareTo(cal.getTime()) > 0) {
					service.alertMessageAndUrl("독서마라톤 대회 접수기간이 아닙니다. 참가 신청 현황 페이지로 이동합니다.", String.format("/%s/module/marathonApplicant/index.do?menu_idx=106", homepage.getContext_path()), request, response);
					return null;
				}else {
					marathonApplicant.setHomepage_id(homepage.getHomepage_id());
					marathonApplicant.setContest_idx(marathonUseOne.getContest_idx());
					marathonApplicant.setMember_id(getSessionMemberId(request));
					marathonApplicant.setAdd_date(new Date());
					if(service.checkApplicantId(marathonApplicant) < 1) {
						List<MarathonType> marathonTypeList = service.getMarathonTypeList(marathonApplicant);
						model.addAttribute("marathonApplicant", marathonApplicant);
						model.addAttribute("marathonTypeList", marathonTypeList);
						model.addAttribute("dongList", codeService.getCode(homepage.getHomepage_id(), "H0020"));
						return String.format(basePath, homepage.getFolder()) + "edit";
					}else {
						service.alertMessageAndUrl("이미 참가 신청을 완료하셨습니다. 참가 신청 현황 페이지로 이동합니다.", String.format("/%s/module/marathonApplicant/index.do?menu_idx=106", homepage.getContext_path()), request, response);
					}
				}
			}else {
				model.addAttribute("marathonApplicant", marathonApplicant);
				return String.format(basePath, homepage.getFolder()) + "edit";
			}
		}
		return null;
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(MarathonApplicant marathonApplicant, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res= new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		/* 유효성 검증 >>>>> */
		ValidationUtils.rejectIfEmpty(result, "member_name", "이름을 입력해 주세요");
		ValidationUtils.rejectIfEmpty(result, "age_type", "분류를 선택해 주세요.");
		if(!marathonApplicant.getAge_type().equals("adult")) {
			ValidationUtils.rejectIfEmpty(result, "school_name", "학교를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "school_class_one", "학년을 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "school_class_two", "반을 입력해 주세요.");
		}
		ValidationUtils.rejectIfEmpty(result, "zipcode", "우편번호를 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "address_dong", "동(행정동)을 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "address_one", "주소를 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "address_two", "주소를 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "telephone_one", "전화번호 앞자리를 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "telephone_two", "전화번호 중간자리를 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "telephone_three", "전화번호 끝자리를 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "cellphone_one", "휴대전화번호 앞자리를 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "cellphone_two", "휴대전화번호 중간자리를 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "cellphone_three", "휴대전화번호 끝자리르 입력해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "gender", "성별을 선택해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "birthday_year", "생년월일 연도를 선택해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "birthday_month", "생년월일 월을 선택해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "birthday_date", "생년월일 일을 선택해 주세요.");
		ValidationUtils.rejectIfZero(result, "contest_type_idx", "참가종목을 선택해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "finish_memorial", "완주기념풍을 선택해 주세요.");
		ValidationUtils.rejectIfEmpty(result, "agree", "달서독서마라톤 대회 참가자 완주기준을 동의하셔야 서비스 이용이 가능합니다.");
		ValidationUtils.rejectIfEmpty(result, "agree1", "개인정보 수집 및 이용에 동의하셔야 서비스 이용이 가능합니다.");
		ValidationUtils.rejectIfEmpty(result, "agree2", "만 14세 미만 아동의 참가 신청에 동의하셔야 서비스 이용이 가능합니다.");
		
//		marathonApplicant.setContest_type_idx(service.getContestTypeIdx(marathonApplicant)); //종목으로 종목 번호를 가져온다.

		marathonApplicant.setContest_type(service.getContestType(marathonApplicant));

		marathonApplicant.setMember_id(getSessionMemberId(request)); //아이디를 가져온다.
		
		int checkApplicantCount = service.checkApplicantId(marathonApplicant); //신청 대상을 가져온다.
		if(checkApplicantCount > 0) {
			result.reject("독서마라톤대회에 이미 신청하였습니다.");
		}
		
		String application_subject = service.getContestApplicationSubject(marathonApplicant); //신청 대상을 가져온다.
		if(!application_subject.equals("all")) {
			if(!application_subject.contains(marathonApplicant.getAge_type())) {
				result.reject("선택한 분류는 해당 참가종목에 참여할 수 없습니다.");
			}
		}
		Marathon marathon = new Marathon(homepage.getHomepage_id(), marathonApplicant.getContest_idx());
		marathon = marathonService.getMarathonContestOne(marathon);
		String application_start_day = marathon.getApplication_start_day();
		String application_end_day = marathon.getApplication_end_day();
		
		Calendar cal = Calendar.getInstance();
		
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date application_start_date = dateFormat.parse(application_start_day);
		Date application_end_date = dateFormat.parse(application_end_day);
		cal.setTime(application_end_date);
		cal.add(Calendar.DATE, 1);
		
		if(application_start_date.compareTo(date) > 0) {
			result.reject("해당 대회 접수 기간이 아닙니다.");
		}else if(date.compareTo(application_end_date) > 0) {
			result.reject("해당 대회 접수 기간이 아닙니다.");
		}
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			service.addMarathonApplicant(marathonApplicant);
			res.setUrl(String.format("/%s/module/marathonApplicant/index.do?menu_idx=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx()));
			res.setValid(true);
			res.setMessage("등록되었습니다.");
		}else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/myLocation.*"}, method = RequestMethod.GET)
	public String myLocation(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			if(homepage == null) {
				service.alertMessage("잘못된 경로입니다.", request, response);
				return null;
			}else {
				marathonApplicant.setBefore_url(String.format("/%s/module/marathonApplicant/myLocation.do?menu_idx=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx()));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx(), marathonApplicant.getBefore_url()), request, response);
				return null;
			}
		}else {
			Marathon marathonUseOne = new Marathon();
			marathonUseOne.setHomepage_id(homepage.getHomepage_id());
			marathonUseOne = marathonService.getMarathonUseOne(marathonUseOne);
			model.addAttribute("ing", marathonUseOne != null);
			if(marathonUseOne != null) {
				marathonApplicant.setHomepage_id(homepage.getHomepage_id());
				marathonApplicant.setContest_idx(marathonUseOne.getContest_idx());
				marathonApplicant.setMember_id(getSessionMemberId(request));
				marathonApplicant.setAdd_date(new Date());
				model.addAttribute("marathonApplicant", service.copyObjectPaging(marathonApplicant, service.getMarathonApplicantOneById(marathonApplicant)));
			}
			return String.format(basePath, homepage.getFolder()) + "myLocation";
		}
	}
	
	@RequestMapping(value = {"/myRecord.*"}, method = RequestMethod.GET)
	public String myRecord(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if(!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			if(homepage == null) {
				service.alertMessage("잘못된 경로입니다.", request, response);
				return null;
			}else {
				marathonApplicant.setBefore_url(String.format("/%s/module/marathonApplicant/myLocation.do?menu_idx=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx()));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), marathonApplicant.getMenu_idx(), marathonApplicant.getBefore_url()), request, response);
				return null;
			}
		}else {
			marathonApplicant = setMarathonListAndApplicant(model, marathonApplicant);
			
			MarathonRecord marathonRecord = new MarathonRecord(homepage.getHomepage_id(), marathonApplicant.getContest_idx(), marathonApplicant.getContest_type_idx(), marathonApplicant.getApplicant_idx());
			marathonRecord.setMember_id(service.getMarathonApplicantId(marathonApplicant));
			int read_page_count_total = 0;
			List<MarathonRecord> recordList = recordService.getMarathonRecordList(marathonRecord);
			if(recordList.size() != 0) {
				read_page_count_total = recordService.getTotalPageCount(marathonRecord);
			}
			model.addAttribute("marathonRecordList", recordService.getMarathonRecordList(marathonRecord));
			model.addAttribute("read_page_count_total", read_page_count_total);
			return String.format(basePath, homepage.getFolder()) + "myRecord_ajax";
		}
	}

	@RequestMapping(value = {"/viewContestTypeApplicant.*"}, method = RequestMethod.GET)
	public String viewContestTypeApplicant(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Marathon marathonUseOne = new Marathon();
		marathonUseOne.setHomepage_id(homepage.getHomepage_id());
		marathonUseOne = marathonService.getMarathonUseOne(marathonUseOne);
		model.addAttribute("ing", marathonUseOne != null);
		if(marathonUseOne != null) {
			MarathonType marathonType = new MarathonType();
			marathonType.setHomepage_id(homepage.getHomepage_id());
			marathonType.setContest_idx(marathonUseOne.getContest_idx());
			List<MarathonType> marathonTypeList = marathonTypeService.getMarathonTypeList(marathonType);

			marathonApplicant.setHomepage_id(homepage.getHomepage_id());
			marathonApplicant.setContest_idx(marathonType.getContest_idx());

			int applicant_total_count = service.getMarathonApplicantCount(marathonApplicant);
			List<Integer> applicant_count = new ArrayList<Integer>();
			for(int i = 0; i < marathonTypeList.size(); i++) {
				String contest_type = marathonTypeList.get(i).getContest_type();
				marathonApplicant.setContest_type(contest_type);
//				int contest_type_idx = service.getContestTypeIdx(marathonApplicant);
				marathonApplicant.setContest_type_idx(marathonTypeList.get(i).getContest_type_idx());
				applicant_count.add(service.getMarathonApplicantCount(marathonApplicant));
			}
			model.addAttribute("marathonTypeList", marathonTypeList);
			model.addAttribute("applicant_total_count", applicant_total_count);
			model.addAttribute("applicant_count", applicant_count);
		}
		return String.format(basePath, homepage.getFolder()) + "viewContestTypeApplicant";
	}

	private MarathonApplicant setMarathonListAndApplicant(Model model, MarathonApplicant marathonApplicant) {
		marathonApplicant = getApplicantOne(marathonApplicant);
		model.addAttribute("marathonApplicant", marathonApplicant);
		return marathonApplicant;
	}

	private MarathonApplicant getApplicantOne(MarathonApplicant marathonApplicant) {
		marathonApplicant = (MarathonApplicant) service.copyObjectPaging(marathonApplicant, service.getMarathonApplicantOne(marathonApplicant));
		if(marathonApplicant.getSchool_class().equals(",")) {
			marathonApplicant.setSchool_class_one("");
			marathonApplicant.setSchool_class_two("");
		}else {
			String[] school_class = marathonApplicant.getSchool_class().split(",");
			marathonApplicant.setSchool_class_one(school_class[0]);
			marathonApplicant.setSchool_class_two(school_class[1]);
		}
		//전화번호
		if(marathonApplicant.getTelephone().length() == 12) {
			marathonApplicant.setTelephone_one(marathonApplicant.getTelephone().substring(0,3));
			marathonApplicant.setTelephone_two(marathonApplicant.getTelephone().substring(4,7));
			marathonApplicant.setTelephone_three(marathonApplicant.getTelephone().substring(8));
		}else if(marathonApplicant.getTelephone().length() == 13) {
			marathonApplicant.setTelephone_one(marathonApplicant.getTelephone().substring(0,3));
			marathonApplicant.setTelephone_two(marathonApplicant.getTelephone().substring(4,8));
			marathonApplicant.setTelephone_three(marathonApplicant.getTelephone().substring(9));
		}
		//휴대전화번호
		if(marathonApplicant.getCellphone().length() == 12) {
			marathonApplicant.setCellphone_one(marathonApplicant.getCellphone().substring(0,3));
			marathonApplicant.setCellphone_two(marathonApplicant.getCellphone().substring(4,7));
			marathonApplicant.setCellphone_three(marathonApplicant.getCellphone().substring(8));
		}else if(marathonApplicant.getCellphone().length() == 13) {
			marathonApplicant.setCellphone_one(marathonApplicant.getCellphone().substring(0,3));
			marathonApplicant.setCellphone_two(marathonApplicant.getCellphone().substring(4,8));
			marathonApplicant.setCellphone_three(marathonApplicant.getCellphone().substring(9));
		}
		//생년월일
		String[] birthday = marathonApplicant.getBirthday().split("-");
		

		marathonApplicant.setBirthday_year(birthday[0]);
		marathonApplicant.setBirthday_month(birthday[1]);
		marathonApplicant.setBirthday_date(birthday[2]);
		return marathonApplicant;
	}
}
