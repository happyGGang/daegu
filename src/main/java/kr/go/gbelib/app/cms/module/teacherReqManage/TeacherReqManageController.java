package kr.go.gbelib.app.cms.module.teacherReqManage;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.teacher.Teacher;

@Controller
@RequestMapping(value = {"/cms/module/teacherReqManage"})
public class TeacherReqManageController extends BaseController {

	private final String basePath = "/cms/module/teacherReqManage/";

	@Autowired
	private TeacherReqManageService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, TeacherReqManage teacher, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			teacher.setHomepage_id(getAsideHomepageId(request));
//		}
		int count = service.getTeacherListCount(teacher);
		service.setPaging(model, count, teacher);
		teacher.setTotalDataCount(count);
		model.addAttribute("teacher", teacher);
		model.addAttribute("teacherListCount", count);
		model.addAttribute("teacherList", service.getTeacherList(teacher));

		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, TeacherReqManage teacher, HttpServletRequest request) throws AuthException {
		if(teacher.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("teacher", service.copyObjectPaging(teacher, service.getTeacherOne(teacher)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("teacher", teacher);
		}

		model.addAttribute("locationCodeList", codeService.getCode("CMS", "C0021"));
		model.addAttribute("subjectCodeList", codeService.getCode("CMS", "C0023"));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0003"));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, TeacherReqManage teacher, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResponse res = new JsonResponse(request);

		if ( teacher.getEditMode().equals("ADD") ) {
			ValidationUtils.rejectIfEmpty(result, "member_key", "회원 키를 전달 받지 못 했습니다. 강사ID 입력란에서 웹ID 또는 대출번호로 최소 한번은 성공적으로 조회를 해야 회원 키가 전달됩니다.");
			ValidationUtils.rejectIfEmpty(result, "teacher_id", "강사ID를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "teacher_name", "이름을 입력하세요.");
			ValidationUtils.rejectIfStringLength(result, "teacher_name", 50, "강사명");

			if (teacher.getOpen_file() == null) {
				result.reject("강의계획서를 등록해주세요.");
			}
		}

		if ( teacher.getEditMode().equals("ADD") || teacher.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "teacher_sex", "강사성별을 선택하세요.");

			if (StringUtils.isNotEmpty(teacher.getTeacher_cell_phone())) {
				ValidationUtils.rejectPhone(result, "teacher_cell_phone", "휴대전화번호 형식이 잘못되었습니다.");
			}

			ValidationUtils.rejectIfEmpty(result, "full_adder", "주소를 입력해주세요.");

			if (teacher.getFull_adder().length() < 6) {
				result.rejectValue("full_adder", "주소 형식이 잘못되었습니다.");
			} else {
				teacher.setTeacher_zipcode(StringUtils.defaultString(teacher.getFull_adder()).trim().substring(0,5).trim());
				teacher.setTeacher_address(StringUtils.defaultString(teacher.getFull_adder()).trim().substring(5,teacher.getFull_adder().length()).trim());

				if (teacher.getFull_adder().trim().substring(0,5).matches("^[\\d]{5}") != true ) {
					result.rejectValue("full_adder", "우편번호를 입력해주세요.");
				}
			}

			if (StringUtils.isNotEmpty(teacher.getTeacher_phone())) {
				ValidationUtils.rejectPhone2(result, "teacher_phone", "전화번호 형식이 잘못되었습니다.");
			}

			if (StringUtils.isNotEmpty(teacher.getTeacher_email())) {
				ValidationUtils.rejectNotFullEmailType(result, "teacher_email", "이메일 형식이 잘못되었습니다.");
			}

			ValidationUtils.rejectIfEmpty(result, "subject_cd", "과목구분을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "teacher_location_code", "강의가능지역을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "teacher_subject_name", "과목명을 입력하세요.");
			ValidationUtils.rejectIfStringLength(result, "teacher_subject_name", 100, "과목명");
//			ValidationUtils.rejectIfStringLength(result, "stage", 100, "강의실");
//			ValidationUtils.rejectIfStringLength(result, "teacher_nationality", 30, "국적");
//			ValidationUtils.rejectIfStringLength(result, "teacher_zipcode", 20, "우편번호");
			ValidationUtils.rejectIfStringLength(result, "teacher_address", 200, "주소");
		}

		if(!result.hasErrors()) {
			if(teacher.getEditMode().equals("ADD")) {
				String checkResult = checkSameTeacher(teacher);
				if ( checkResult == null ) {
					teacher.setAdd_id(getSessionMemberId(request));
					String addResult = service.addTeacher(teacher, request);

					if (addResult != null) {
						res.setValid(true);
						res.setUrl(addResult);
						res.setTargetOpener(true);
						return res;
					}
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}
				else {
					res.setValid(false);
					res.setMessage(checkResult);
				}
			} else if(teacher.getEditMode().equals("MODIFY")) {
				teacher.setMod_id(getSessionMemberId(request));
				String modifyResult = service.modifyTeacher(teacher, request);

				if (modifyResult != null) {
					res.setValid(true);
					res.setUrl(modifyResult);
					res.setTargetOpener(true);
					return res;
				}
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(teacher.getEditMode().equals("DELETE")) {
				service.deleteTeacher(teacher);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if ( teacher.getEditMode().equals("CONFIRM") ) {
				service.confirmTeacher(teacher);
				res.setValid(true);
				if ( teacher.getConfirm_yn().equals("Y") ) {
					res.setMessage("승인 되었습니다.");
				}
				else {
					res.setMessage("승인 취소 되었습니다.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public TeacherReqManageSearchView excel(Model model, TeacherReqManage teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("teacher", teacher);
		model.addAttribute("teacherResult", service.getTeacherListAll(teacher.getHomepage_id()));
		return new TeacherReqManageSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(TeacherReqManage teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<TeacherReqManage> teacherResult = service.getTeacherListAll(teacher.getHomepage_id());

		new TeacherReqManageXlsToCsv(teacher, teacherResult, "강사 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/history.*"})
	public String history(Model model, TeacherReqManage teacher) {
		model.addAttribute("teacher", teacher);
		model.addAttribute("history", service.getHistoryList(teacher));
		return basePath + "history_ajax";
	}

	@RequestMapping(value = {"/modifyManageHistory.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modifyManageHistory(Model model, Teacher teacher, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(!result.hasErrors()) {
			service.modifyManageHistory(teacher);

			res.setValid(true);
			res.setMessage("수정 되었습니다.");
		}
		return res;
	}

	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, TeacherReqManage teacher, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();

		Member teacherMember = new Member();
		teacherMember.setUser_id(teacher.getTeacher_id());
//		teacherMember.setCheck_certify_type("WEBID");
//		teacherMember.setCheck_certify_data(teacher.getTeacher_id());

		Map<String, String> memberInfo = null;

		if ( teacher.getSearch_api_type().equals("WEBID") ) {
//			teacherMember.setCheck_certify_type("WEBID");
//			teacherMember.setCheck_certify_data(teacher.getTeacher_id());

//			memberInfo = MemberAPI.getMemberCertify("WEB", teacherMember);
//
//			if ( memberInfo == null ) {
//				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
//				return result;
//			}
		}
		else {
//			memberInfo = MemberAPI.getDupUser("WEB", teacherMember, "0002", teacher.getTeacher_id());
//			if ( memberInfo == null ) {
//				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
//				return result;
//			}
		}

		result.put("memberInfo", memberInfo);
		return result;
	}

	@RequestMapping(value = {"/searchTeacher.*"})
	public String searchTeacher(Model model, TeacherReqManage teacher, HttpServletRequest request) {
		teacher.setConfirm_yn("Y");
		service.setPaging(model, service.getTeacherListCount(teacher), teacher);
		model.addAttribute("teacher", teacher);
		model.addAttribute("teacherList", service.getTeacherList(teacher));

		return basePath + "search_ajax";
	}

	@RequestMapping(value = "/download/{homepage_id}/{teacher_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public ResponseEntity<byte[]> getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("teacher_idx") int teacher_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		TeacherReqManage teacherReqManage = new TeacherReqManage(homepage_id, teacher_idx);
		teacherReqManage = service.getTeacherOne(teacherReqManage);
		HttpHeaders responseHeaders = new HttpHeaders();
		byte[] bytes = null;
		if ( teacherReqManage != null ) {
			String filePath = service.getRootPath()+ "/" + homepage_id + "/" + teacherReqManage.getReal_file_name();
			File file = new File(filePath);

			if(file.length() > 0) {
				bytes = FileCopyUtils.copyToByteArray(file);
			} else {
				response.setHeader("Content-type", "text/html");
				service.alertMessage("파일이 존재하지 않습니다.", request, response);
				return null;
			}

			String fileName = teacherReqManage.getFile_name();
			String fileType = teacherReqManage.getFile_extension();
			String fullFilename = fileName+"."+fileType;

			responseHeaders.set("Content-Disposition", AttachmentUtils.getContentDisposition(fullFilename, request.getHeader("user-agent")));
			responseHeaders.setPragma("no-cache;");
			responseHeaders.setExpires(-1);
//			responseHeaders.setContentLength(file.length());
			responseHeaders.setContentType(MediaType.valueOf(AttachmentUtils.getContentType(fileType)));
			responseHeaders.setContentLength(bytes.length);

			return new ResponseEntity<byte[]>(bytes, responseHeaders, HttpStatus.OK);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

    }

	private String checkSameTeacher(TeacherReqManage teacher) {
		//Member teacherMember = new Member();
		//teacherMember.setUser_id(teacher.getTeacher_id());
		//teacherMember.setCheck_certify_type("WEBID");
		//teacherMember.setCheck_certify_data(teacher.getTeacher_id());

		if ( service.checkTeacher(teacher) != null ) {
			return "이미 등록된 강사 입니다.";
		}

		return null;
	}

}