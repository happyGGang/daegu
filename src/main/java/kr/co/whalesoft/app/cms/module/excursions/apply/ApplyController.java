package kr.co.whalesoft.app.cms.module.excursions.apply;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.excursions.Excursions;
import kr.co.whalesoft.app.cms.module.excursions.ExcursionsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.MemberAPI;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = {"/cms/module/excursions/apply"})
public class ApplyController extends BaseController {

	private final String basePath = "/cms/module/excursions/apply/";

	@Autowired
	private ApplyService service;

	@Autowired
	private ExcursionsService excursionsService;
	
	@Autowired
	@Qualifier("excursionsStorage")
	private FileStorage excursionsStorage;

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Apply apply) {
		if(apply.getEditMode().equals("MODIFY")) {
			model.addAttribute("apply", service.copyObjectPaging(apply, service.getApplyOne(apply)));
		} else {
		model.addAttribute("apply", apply);
		}
		List<String> allowedHomepageIds = Arrays.asList("h77", "h61", "h62", "h63", "h64");
		boolean isSeoguPrivatetour = allowedHomepageIds.contains(apply.getHomepage_id()) && "0011".equals(apply.getDate_type());

		model.addAttribute("isSeoguPrivatetour", isSeoguPrivatetour);
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/applyEdit.*"})
	public String applyEdit(Model model, Apply apply) {
		apply.setPlan_date(apply.getStart_date());

		List<Apply> applyList = service.getApply(apply);

		List<String> allowedHomepageIds = Arrays.asList("h77", "h61", "h62", "h63", "h64");
		boolean isSeoguPrivatetour = allowedHomepageIds.contains(apply.getHomepage_id()) && "0011".equals(apply.getDate_type());

		model.addAttribute("isSeoguPrivatetour", isSeoguPrivatetour);

		if (applyList == null) {
			applyList = new ArrayList<>();
		}
		model.addAttribute("applyList", applyList);

		String viewName = "applyEdit_ajax";

		if (!applyList.isEmpty()) {
			String date_type = applyList.get(0).getDate_type();
			if ("h35".equals(apply.getHomepage_id()) && "0002".equals(date_type)) {
				viewName = "applySrEdit_ajax";
			}
		}

		return basePath + viewName;
	}

	@RequestMapping(value = {"/excelDownloadDate.*"})
	public String excelDownloadDate(Model model, Apply apply) {
		Excursions excursions = new Excursions();
		excursions.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		model.addAttribute("excursions", excursions);
		model.addAttribute("apply", apply);
		return basePath + "excelDownloadDate_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public ApplySearchView excel(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("apply", apply);
		model.addAttribute("applyResult", service.getApply(apply));
		return new ApplySearchView();
	}		

	@RequestMapping(value = {"/excelDownloadMonth.*"})
	public ApplySearchView excelDownloadMonth(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		if("default".equals(apply.getEditMode())){
			apply.setStart_date(apply.getPlan_year1() + "-" +apply.getPlan_month1() + "-01");
			apply.setEnd_date(apply.getPlan_year1() + "-" +apply.getPlan_month1() + "-31");
		}else if ("select".equals(apply.getEditMode())) {
			apply.setStart_date(apply.getPlan_year2() + "-" +apply.getPlan_month2() + "-01");
			apply.setEnd_date(apply.getPlan_year3() + "-" +apply.getPlan_month3() + "-31");
		}
		
		model.addAttribute("apply", apply);
		model.addAttribute("applyResult", service.getApplyMonth(apply));
		return new ApplySearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Apply> applyResult = service.getApply(apply);

		new ApplyXlsToCsv(apply, applyResult, "견학신청현황 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/csvDownloadMonth.*"}, method = RequestMethod.POST)
	public void csvDownloadMonth(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		apply.setStart_date(apply.getPlan_date() + "-01");
		apply.setEnd_date(apply.getPlan_date() + "-31");

		List<Apply> applyResult = service.getApplyMonth(apply);

		new ApplyXlsToCsv(apply, applyResult, "견학신청현황 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/stateEdit.*"})
	public String stateEdit(Model model, Apply apply) {
		model.addAttribute("apply", service.copyObjectPaging(apply, service.getApplyOne(apply)));
		List<String> allowedHomepageIds = Arrays.asList("h77", "h61", "h62", "h63", "h64");
		boolean isSeoguPrivatetour = allowedHomepageIds.contains(apply.getHomepage_id()) && "0011".equals(apply.getDate_type());

		model.addAttribute("isSeoguPrivatetour", isSeoguPrivatetour);
		return basePath + "stateEdit_ajax";
	}

	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, Apply apply, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();

		Member applyMember = new Member();
		applyMember.setUser_id(apply.getApplicant_member_id());

		List<Map<String, Object>> memberInfo = null;
		if ( apply.getSearch_api_type().equals("WEBID") ) {
			applyMember.setCertType(apply.getSearch_api_type());
			applyMember.setMember_id(apply.getApplicant_member_id());
			
			memberInfo = MemberAPI.checkDupUser("0", applyMember);
			
			if ( memberInfo.isEmpty() ) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
				return result;
			}
		}

		result.put("memberInfo", memberInfo);

		return result;
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Apply apply, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if(apply.getEditMode().equals("ADD") || apply.getEditMode().equals("MODIFY")) {
			if ( !"Y".equals(apply.getSelf_info_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}
			if (!apply.getIsSeoguPrivatetour()) {
				ValidationUtils.rejectIfEmpty(result, "applicant_member_id", "신청자 ID를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_2", "신청자 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_3", "신청자 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_1", "기관 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_2", "기관 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_3", "기관 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "age", "연령대를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "personnel", "방문인원을 입력하세요.");
			} else {
				ValidationUtils.rejectIfEmpty(result, "applicant_member_id", "신청자 ID를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_2", "신청자 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_3", "신청자 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "personnel", "방문인원을 입력하세요.");
			}

			if ("h8".equals(apply.getHomepage_id())){
				ValidationUtils.rejectIfEmpty(result, "Desired_start_time", "체험희망 시작시간을 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "Desired_end_time", "체험희망 종료시간을 입력해주세요.");
			}
			if ("h8".equals(apply.getHomepage_id()) && !apply.getDesired_start_time().isEmpty() && !apply.getDesired_end_time().isEmpty()) {
				SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
				sfTime.setLenient(false);
				try {
					sfTime.parse(apply.getDesired_start_time());
					sfTime.parse(apply.getDesired_end_time());
				} catch (Exception e) {
					result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
				}
			}
		}
		if(!result.hasErrors()) {
			if(apply.getEditMode().equals("ADD")) {
				if ( service.checkApply(apply) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}
				Excursions excursions = excursionsService.getExcursionsOne(new Excursions(apply.getHomepage_id(), apply.getExcursions_idx()));

				if ( excursions.getMax_apply() > 0 ) {
					List<String> allowedHomepageIds = Arrays.asList("h77", "h61", "h62", "h63", "h64");
					List<String> allowedDateTypes = Arrays.asList("0010", "0011");
					if (allowedHomepageIds.contains(excursions.getHomepage_id()) &&	allowedDateTypes.contains(excursions.getDate_type())) {
						int applyCount = apply.getPersonnel() + excursions.getPersonnel_count();

						if (excursions.getMax_apply() < applyCount ) {
							res.setValid(false);
							res.setMessage("신청가능팀수가 가득찼습니다.");
							return res;
						}
					} else {
						if (excursions.getMax_apply() <= excursions.getApply_count() ) {
							res.setValid(false);
							res.setMessage("신청가능팀수가 가득찼습니다.");
							return res;
						}
					}
				}

				if ( excursions.getMax_personnel_apply() > 0 ) {
					if (excursions.getMax_personnel_apply() < (apply.getPersonnel() + excursions.getPersonnel_count()) ) {
						int count = excursions.getMax_personnel_apply() - excursions.getPersonnel_count();

						if(count < 0){
							count = 0;
						}

						res.setValid(false);
						res.setMessage("최대 신청 가능 인원이 가득찼습니다.\n현재 신청 가능 인원수는 " + count + "명 입니다.");
						return res;
					}
				}

				apply.setAdd_id(getSessionMemberId(request));
				apply.setStart_date(excursions.getStart_date());
				apply.setStart_time(excursions.getStart_time());
				apply.setEnd_date(excursions.getEnd_date());
				apply.setEnd_time(excursions.getEnd_time());
				if (apply.getApply_file() != null) {
					MultipartFile mFile = apply.getApply_file();
					if ( mFile.getSize() > 0 ) {
						String serverFileName = Long.toString((System.currentTimeMillis()));
						String originFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
						String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
						String filePath = "/" + apply.getHomepage_id();
						
						File f = excursionsStorage.addFile(mFile, serverFileName, filePath);
						apply.setServer_file_name(serverFileName);
						apply.setOrigin_file_name(originFileName);
						apply.setFile_extension(fileExtension);
						apply.setFile_size(f.length());
					}
				}
				String addResult = (String) service.addApply(apply, request);
				
				
				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}

				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (apply.getEditMode().equals("MODIFY")) {
				if (apply.getApply_file() != null) {
					MultipartFile mFile = apply.getApply_file();
					if (mFile.getSize() > 0) {
						String serverFileName = Long.toString((System.currentTimeMillis()));
						String originFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
						String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
						String filePath = "/" + apply.getHomepage_id();

						File f = excursionsStorage.addFile(mFile, serverFileName, filePath);
						apply.setServer_file_name(serverFileName);
						apply.setOrigin_file_name(originFileName);
						apply.setFile_extension(fileExtension);
						apply.setFile_size(f.length());
					}
				}
				apply.setModify_id(getSessionMemberId(request));
				service.modifyApplyFile(apply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(apply.getEditMode().equals("STATEMODIFY")) {
				apply.setModify_id(getSessionMemberId(request));
				service.modifyApplyState(apply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(apply.getEditMode().equals("DELETE")) {
				service.deleteApply(apply);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = "/download/{homepage_id}/{apply_idx}.*", method = RequestMethod.GET)
	@ResponseBody
	public byte[] getFile(@PathVariable("homepage_id") String homepage_id,@PathVariable("apply_idx") int apply_idx, 
			@RequestParam(required=false, value="file_type") String file_type, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Apply apply = new Apply();
		
		apply.setApply_idx(apply_idx);
		apply.setHomepage_id(homepage_id);
		apply = service.getApplyDownOne(apply);
		String serverName = "";
		String orgName = "";
		String extension = "";
		
		serverName = apply.getServer_file_name();
		orgName = apply.getOrigin_file_name();
		extension = apply.getFile_extension();
		String filePath = excursionsStorage.getRootPath()+ "/" + homepage_id + "/" + serverName;
		File file = new File(filePath);

		byte[] bytes = null;
		
		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

//		String fileName = "";
		String fileName = String.format("%s.%s", orgName, extension);

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.setHeader("Content-Type", "application/octet-stream");

	    return bytes;
    }
}
