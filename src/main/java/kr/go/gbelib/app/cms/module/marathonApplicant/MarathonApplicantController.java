package kr.go.gbelib.app.cms.module.marathonApplicant;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.go.gbelib.app.cms.module.marathon.Marathon;
import kr.go.gbelib.app.cms.module.marathon.MarathonService;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecord;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecordService;
import kr.go.gbelib.app.cms.module.marathonRecord.marathonApplicantRecord.MarathonApplicantRecord;
import kr.go.gbelib.app.cms.module.marathonType.MarathonType;

@Controller
@RequestMapping(value = {"/cms/module/marathonApplicant"})
public class MarathonApplicantController extends BaseController{

	private final String basePath = "/cms/module/marathonApplicant/";

	@Autowired
	MarathonApplicantService service;

	@Autowired
	MarathonService marathonService;

	@Autowired
	MarathonRecordService recordService;
	
	@Autowired
	CodeService codeService;

	@RequestMapping(value= {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);
		marathonApplicant.setHomepage_id(getAsideHomepageId(request));
		
		List<Marathon> marathonList = new ArrayList<Marathon>();
		Marathon marathonUseOne = new Marathon();
		marathonUseOne.setHomepage_id(getAsideHomepageId(request));

		if(marathonApplicant.getContest_idx() != 0) { //선택된 대회
			marathonList = service.getMarathonList(marathonApplicant);
			model.addAttribute("marathonTypeList", service.getMarathonTypeList(marathonApplicant));
		}else { //처음 대회 설정
			marathonList = service.getMarathonList(marathonApplicant); //모든 대회 목록을 가져온다.
			marathonUseOne = marathonService.getMarathonUseOne(marathonUseOne); //사용하는 대회를 가져온다.
			if(marathonUseOne != null) { //사용하는 대회가 있으면
				marathonApplicant.setContest_idx(marathonUseOne.getContest_idx()); //대회 번호를 사용하는 대회 번호로 설정한다.
				model.addAttribute("marathonTypeList", service.getMarathonTypeList(marathonApplicant)); //위의 대회 종목들을 가져온다.
			}else {
				marathonApplicant.setContest_idx(0);
				model.addAttribute("marathonTypeList", service.getMarathonTypeList(marathonApplicant));
			}
		}

		service.setPaging(model, service.getMarathonApplicantCount(marathonApplicant), marathonApplicant); //위의 대회 신청자들의 개수를 가져온다.
		model.addAttribute("marathonList", marathonList);
		model.addAttribute("marathonApplicant", marathonApplicant);
		model.addAttribute("marathonApplicantList", service.getMarathonApplicantList(marathonApplicant)); //위의 대회 신청자들을 가져온다.
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request) throws AuthException{
		marathonApplicant.setHomepage_id(getAsideHomepageId(request));
		
		if(marathonApplicant.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			marathonApplicant = setMarathonListAndApplicant(model, marathonApplicant);
			
		}else {
			checkAuth("C", model, request);
			marathonApplicant.setAdd_date(new Date());
			List<Marathon> marathonList = service.getMarathonList(marathonApplicant);
			List<MarathonType> marathonTypeList = service.getMarathonTypeList(marathonApplicant);
			model.addAttribute("marathonList", marathonList);
			model.addAttribute("marathonTypeList", marathonTypeList);
			model.addAttribute("marathonApplicant", marathonApplicant);
		}
		model.addAttribute("dongList", codeService.getCode(getAsideHomepageId(request), "H0020"));
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/viewRecord.*"}, method = RequestMethod.GET)
	public String viewRecord(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request) throws AuthException{
		checkAuth("U", model, request);
		
		marathonApplicant = setMarathonListAndApplicant(model, marathonApplicant);
		
		MarathonRecord marathonRecord = new MarathonRecord(getAsideHomepageId(request), marathonApplicant.getContest_idx(), marathonApplicant.getContest_type_idx(), marathonApplicant.getApplicant_idx());
		marathonRecord.setMember_id(service.getMarathonApplicantId(marathonApplicant));
		int read_page_count_total = 0;
		List<MarathonRecord> recordList = recordService.getMarathonRecordListAll(marathonRecord);
		if(recordList.size() != 0) {
			read_page_count_total = recordService.getTotalPageCount(marathonRecord);
		}
		model.addAttribute("marathonRecordList", recordList);
		model.addAttribute("read_page_count_total", read_page_count_total);
		return basePath + "viewRecord_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(MarathonApplicant marathonApplicant, BindingResult result, HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);
		marathonApplicant.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		

		/* 유효성 검증 >>>>>>>>> */
		if(marathonApplicant.getEditMode().equals("ADD") || marathonApplicant.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "member_id", "아이디를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "member_name", "이름을 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "age_type", "분류를 입력해 주세요.");
			if(!marathonApplicant.getAge_type().equals("adult")) {
				ValidationUtils.rejectIfEmpty(result, "school_name", "학교를 입력하세요.");
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
			ValidationUtils.rejectIfEmpty(result, "cellphone_three", "휴대전화번호 끝자리를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "gender", "성별을 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "birthday_year", "생년월일 년도를 선택해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "birthday_month", "생년월일 월을 선택해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "birthday_date", "생년월일 일을 선택해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "contest_type_idx_edit", "참가종목을 선택해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "finish_memorial", "완주기념품을 선택해 주세요.");
			
			marathonApplicant.setContest_type_idx(marathonApplicant.getContest_type_idx_edit());
			marathonApplicant.setContest_type(service.getContestType(marathonApplicant));
			
			if(marathonApplicant.getEditMode().equals("ADD")) {
    			int checkApplicantCount = service.checkApplicantId(marathonApplicant);
    			if(checkApplicantCount > 0) {
    				result.reject("해당 아이디는 이미 등록되었습니다.");
    			}

    			String application_subject = service.getContestApplicationSubject(marathonApplicant); //신청 대상을 가져온다.
    			if(application_subject != null) {
    				if(!application_subject.equals("all")) {
        				if(!application_subject.contains(marathonApplicant.getAge_type())) {
        					result.reject("선택한 분류는 해당 참가종목에 참여할 수 없습니다.");
        				}
        			}
    			}else {
    				result.reject("선택한 분류는 해당 참가종목에 참여할 수 없습니다.");
    			}
    			
    			Marathon marathon = new Marathon(getAsideHomepageId(request), marathonApplicant.getContest_idx());
    			marathon = marathonService.getMarathonContestOne(marathon);
    			String application_start_day = marathon.getApplication_start_day();
    			String application_end_day = marathon.getApplication_end_day();

    			Date date = new Date();
    			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    			Date application_start_date = dateFormat.parse(application_start_day);
    			Date application_end_date = dateFormat.parse(application_end_day);

    			Calendar cal = Calendar.getInstance();
    			cal.setTime(application_end_date);
    			cal.add(Calendar.DATE, 1);

    			if(application_start_date.compareTo(date) > 0) {
    				result.reject("해당 대회 접수 기간이 아닙니다.");
    			}else if(date.compareTo(cal.getTime()) > 0) {
    				result.reject("해당 대회 접수 기간이 아닙니다.");
    			}
			}else if(marathonApplicant.getEditMode().equals("MODIFY")) {
				String application_subject = service.getContestApplicationSubjectModify(marathonApplicant);
    			if(!application_subject.equals("all")) {
    				if(!application_subject.contains(marathonApplicant.getAge_type())) {
    					result.reject("선택한 분류는 해당 참가종목에 참여할 수 없습니다.");
    				}
    			}
			}
		}else if(marathonApplicant.getEditMode().equals("MODIFYSTATUS")) {
			if(marathonApplicant.getApplicant_idx_arr().length == 0) {
				result.reject("참가자를 선택해 주세요.");
			}
		}else if(marathonApplicant.getEditMode().equals("DELETE")) {
			if(marathonApplicant.getApplicant_idx_arr().length == 0) {
				result.reject("참가자를 선택해 주세요.");
			}
		}
		/* <<<<<<<<<<<<<<< 유효성 검증 */

		if(!result.hasErrors()) {
    		if(marathonApplicant.getEditMode().equals("ADD")) {
    			service.addMarathonApplicant(marathonApplicant);
    			res.setValid(true);
    			res.setMessage("등록되었습니다.");
    		}else if(marathonApplicant.getEditMode().equals("MODIFY")) {
				marathonApplicant.setModify_id(member.getMember_id()); //신청자를 변경하는 관리자 아이디
				marathonApplicant.setContest_type_idx_before(service.getContestTypeIdx(marathonApplicant)); //변경 전 종목번호를 가져온다.
				if(marathonApplicant.getContest_type_idx() != marathonApplicant.getContest_type_idx_before()) { //종목을 변경을 한다.
					marathonApplicant.setApplicant_idx_modify(service.getMarathonApplicantMaxIdx(marathonApplicant)); //종목을 변경할 경우에 해당 종목번호에 가장 큰 신청자 번호에서 1을 더한 값을 가져온다.
					service.modifyMarathonApplicantWithRecord(marathonApplicant);
					res.setValid(true);
					res.setMessage("수정되었습니다.");
				}else { //종목을 변경하지 않는다.
					service.modifyMarathonApplicant(marathonApplicant);
					res.setValid(true);
					res.setMessage("수정되었습니다.");
				}
    		}else if(marathonApplicant.getEditMode().equals("DELETE")) {
    			service.deleteMarathonApplicant(marathonApplicant);
    			res.setValid(true);
    			res.setMessage("삭제되었습니다.");
    		}else if(marathonApplicant.getEditMode().equals("MODIFYSTATUS")) {
    			service.modifyMarathonApplicantStatus(marathonApplicant);
    			res.setValid(true);
    			res.setMessage("수정되었습니다.");
    		}
		}else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}

	@RequestMapping(value = {"/viewApplicantRecordOneExcelDown.*"}, method = RequestMethod.GET) //1명 참가자 엑셀 다운 ( 참가자 정보, 일지 )
	public String viewApplicantExcelDown(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);

		marathonApplicant = getApplicantOne(marathonApplicant);

		MarathonRecord marathonRecord = new MarathonRecord(getAsideHomepageId(request), marathonApplicant.getContest_idx(), marathonApplicant.getContest_type_idx(), marathonApplicant.getApplicant_idx());
		marathonRecord.setMember_id(service.getMarathonApplicantId(marathonApplicant));
		int read_page_count_total = 0;
		List<MarathonRecord> recordList = recordService.getMarathonRecordListAll(marathonRecord);
		if(recordList.size() != 0) {
			read_page_count_total = recordService.getTotalPageCount(marathonRecord);
		}
		model.addAttribute("marathonRecordList", recordList);
		model.addAttribute("read_page_count_total", read_page_count_total);
		model.addAttribute("marathonApplicant", marathonApplicant);
		request.setAttribute("marathonApplicant", marathonApplicant);
		return basePath + "viewApplicantRecordOneExcelDown_ajax";
	}

	@RequestMapping(value = {"/viewApplicantListExcelDown.*"}, method = RequestMethod.GET) //참가자 엑셀 다운 ( 참가자 정보 )
	public String viewRecordApplicantExcelDown(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);
		
		List<MarathonApplicant> marathonApplicantList = service.getMarathonApplicantExcelList(marathonApplicant);
		if(marathonApplicantList != null) {
			for(int i = 0; i < marathonApplicantList.size(); i++) {
				String school_class[] = marathonApplicantList.get(i).getSchool_class().split(",");
				if(school_class.length == 0 || school_class == null) {
					marathonApplicantList.get(i).setSchool_class_one("");
					marathonApplicantList.get(i).setSchool_class_two("");
				}else {
					marathonApplicantList.get(i).setSchool_class_one(school_class[0]);
					marathonApplicantList.get(i).setSchool_class_two(school_class[1]);
				}
			}
		}
		model.addAttribute("marathonApplicantList", marathonApplicantList);
		return basePath + "viewApplicantListExcelDown_ajax";
	}
	
	@RequestMapping(value = {"/viewApplicantRecordListExcelDown.*"}, method = RequestMethod.GET) //일지 엑셀 다운 ( 참가자 정보, 일지 참가 )
	public String viewRecordExcelDown(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);

		MarathonRecord marathonRecord = new MarathonRecord();
		marathonRecord.setHomepage_id(marathonApplicant.getHomepage_id());
		marathonRecord.setContest_idx(marathonApplicant.getContest_idx());
		marathonRecord.setContest_type_idx(marathonApplicant.getContest_type_idx());
		List<MarathonApplicantRecord> marathonApplicantRecordList = recordService.getMarathonApplicantRecordExcelList(marathonRecord);
		if(marathonApplicantRecordList != null) {
			for(int i = 0; i < marathonApplicantRecordList.size(); i++) {
				String school_class[] = marathonApplicantRecordList.get(i).getSchool_class().split(",");
				if(school_class.length == 0) {
					marathonApplicantRecordList.get(i).setSchool_class_one("");
					marathonApplicantRecordList.get(i).setSchool_class_two("");
				}else {
					marathonApplicantRecordList.get(i).setSchool_class_one(school_class[0]);
					marathonApplicantRecordList.get(i).setSchool_class_two(school_class[1]);
				}
			}
		}

		model.addAttribute("marathonApplicantRecordList", marathonApplicantRecordList);
		return basePath + "viewApplicantRecordListExcelDown_ajax";
	}

	@RequestMapping(value = {"/viewRecordSuccessExcelDown.*"}, method = RequestMethod.GET) //일지 목록 다운(완주자)
	public String viewRecordSuccessExcelDown(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);
		
		List<MarathonApplicantRecord> marathonRecordSuccessList = getMarathonRecordSuccessList(marathonApplicant);

		model.addAttribute("marathonRecordSuccessList", marathonRecordSuccessList);
		return basePath + "viewRecordSuccessExcelDown_ajax";
	}

	@RequestMapping(value = {"/viewRecordSuccessEditExcelDown.*"}, method = RequestMethod.GET) //일지 목록 다운( 완주자 편집용 )
	public String recordExcelSuccessEditDownload(Model model, MarathonApplicant marathonApplicant, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);
		
		List<MarathonApplicantRecord> marathonRecordSuccessEditList = getMarathonRecordSuccessList(marathonApplicant);
		
		model.addAttribute("marathonRecordSuccessEditList", marathonRecordSuccessEditList);
		return basePath + "viewRecordSuccessEditExcelDown_ajax";
	}

	/**
	 * 
	 * @param model
	 * @param marathonApplicant
	 * @return
	 */
	private MarathonApplicant setMarathonListAndApplicant(Model model, MarathonApplicant marathonApplicant) {
		List<Marathon> marathonList = service.getMarathonList(marathonApplicant);
		List<MarathonType> marathonTypeList = service.getMarathonTypeList(marathonApplicant);
		model.addAttribute("marathonList", marathonList);
		model.addAttribute("marathonTypeList", marathonTypeList);
		
		marathonApplicant = getApplicantOne(marathonApplicant);
		model.addAttribute("marathonApplicant", marathonApplicant);
		return marathonApplicant;
	}

	/**
	 * marathonApplicant 데이터 가공
	 * @param marathonApplicant
	 * @return
	 */
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
		marathonApplicant.setContest_type_idx_edit(marathonApplicant.getContest_type_idx());
		return marathonApplicant;
	}

	/**
	 * marathonRecordSuccessList GET
	 * @param marathonRecordSuccessList
	 * @return
	 */
	private List<MarathonApplicantRecord> getMarathonRecordSuccessList(MarathonApplicant marathonApplicant) {
		MarathonRecord marathonRecord = new MarathonRecord();
		marathonRecord.setHomepage_id(marathonApplicant.getHomepage_id());
		marathonRecord.setContest_idx(marathonApplicant.getContest_idx());
		marathonRecord.setContest_type_idx(marathonApplicant.getContest_type_idx());
		List<MarathonApplicantRecord> marathonRecordSuccessList = recordService.getMarathonRecordSuccessExcelList(marathonRecord);
		if(marathonRecordSuccessList != null) {
			for(int i = 0; i < marathonRecordSuccessList.size(); i++) {
				String school_class[] = marathonRecordSuccessList.get(i).getSchool_class().split(",");
				if(school_class.length == 0) {
					marathonRecordSuccessList.get(i).setSchool_class_one("");
					marathonRecordSuccessList.get(i).setSchool_class_two("");
				}else {
					marathonRecordSuccessList.get(i).setSchool_class_one(school_class[0]);
					marathonRecordSuccessList.get(i).setSchool_class_two(school_class[1]);
				}
			}
		}
		return marathonRecordSuccessList;
	}
}
