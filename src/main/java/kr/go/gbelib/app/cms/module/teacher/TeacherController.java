package kr.go.gbelib.app.cms.module.teacher;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import jxl.write.WritableWorkbook;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.file.Download;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping(value = {"/cms/module/teacher"})
public class TeacherController extends BaseController {

	private final String basePath = "/cms/module/teacher/";

	@Autowired
	private TeacherService service;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Teacher teacher, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		teacher.setHomepage_id(getAsideHomepageId(request));	
		int count = service.getTeacherListCount(teacher);
		service.setPaging(model, count, teacher);
		teacher.setTotalDataCount(count);
		model.addAttribute("teacher", teacher);
		model.addAttribute("teacherListCount", count);
		model.addAttribute("teacherList", service.getTeacherList(teacher));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Teacher teacher, HttpServletRequest request) throws AuthException {
		if(teacher.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("teacher", service.copyObjectPaging(teacher, service.getTeacherOne(teacher)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("teacher", teacher);
		}
		
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0003"));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Teacher teacher, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( teacher.getEditMode().equals("ADD") || teacher.getEditMode().equals("MODIFY") ) {
			if ( teacher.getEditMode().equals("ADD") ) {
				ValidationUtils.rejectIfEmpty(result, "teacher_id", "강사ID를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "teacher_name", "강사명을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "teacher_sex", "강사성별을 선택하세요.");
				
			}
			ValidationUtils.rejectExceptNumber(result, "teacher_zipcode", "우편번호는 숫자만 입력 가능합니다.");
			ValidationUtils.rejectIfStringLength(result, "teacher_name", 50, "강사명");
			ValidationUtils.rejectIfStringLength(result, "teacher_subject_name", 100, "과목명");
			ValidationUtils.rejectIfStringLength(result, "stage", 100, "강의실");
			ValidationUtils.rejectIfStringLength(result, "teacher_nationality", 30, "국적");
			ValidationUtils.rejectIfStringLength(result, "teacher_zipcode", 20, "우편번호");
			ValidationUtils.rejectIfStringLength(result, "teacher_address", 200, "주소");
			ValidationUtils.rejectPhone2(result, "teacher_phone", "전화번호 형식이 잘못되었습니다.");
			ValidationUtils.rejectPhone(result, "teacher_cell_phone", "폰번호 형식이 잘못되었습니다.");
		}
		
		if(!result.hasErrors()) {
			if(teacher.getEditMode().equals("ADD")) {
				String checkResult = checkSameTeacher(teacher);
				if ( checkResult == null ) {
					teacher.setAdd_id(getSessionMemberId(request));
					service.addTeacher(teacher);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage(checkResult);
				}
			} else if(teacher.getEditMode().equals("MODIFY")) {
				teacher.setMod_id(getSessionMemberId(request));
				service.modifyTeacher(teacher);
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
	public TeacherSearchView excel(Model model, Teacher teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("teacher", teacher); 
		model.addAttribute("teacherResult", service.getExcelList(teacher));
//		model.addAttribute("csvConvert", "false");
		return new TeacherSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Teacher teacher, HttpServletRequest request, HttpServletResponse response) {
//		model.addAttribute("teacher", teacher);
//		model.addAttribute("teacherResult", service.getExcelList(teacher));
		List<Teacher> teacherList = service.getExcelList(teacher);

		new TeacherXlsToCsv(teacherList, "강사 리스트.csv", request, response);
	}
	
	@RequestMapping(value = {"/certDownload.*"}, method = RequestMethod.POST)
	public void certDownload(Model model, Teacher teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Download down = new Download(request, response, "cert.xls");
		service.writeExcelData(teacher, down.getOutputStream(), request);
		
		down.close();
	}
	
	@RequestMapping(value = {"/history.*"})
	public String history(Model model, Teacher teacher) {
		model.addAttribute("teacher", service.getTeacherOne(teacher));
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
	
	@RequestMapping(value = "/download/{homepage_id}/{teacher_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public byte[] getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("teacher_idx") int teacher_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Teacher teacherReqManage = new Teacher(homepage_id, teacher_idx);
		teacherReqManage = service.getTeacherOne(teacherReqManage);
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
			
//			String fileName = "";
			String fileName = teacherReqManage.getFile_name() + "." + teacherReqManage.getFile_extension();
			
			response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
			response.setHeader("Content-Length", Long.toString(file.length()));
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.setHeader("Content-Type", "application/octet-stream");
		}
		
	    return bytes;
    }
	
	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, Teacher teacher, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member teacherMember = new Member();
		teacherMember.setUser_id(teacher.getTeacher_id());

		Map<String, String> memberInfo = null;
		if ( teacher.getSearch_api_type().equals("WEBID") ) {
			teacherMember.setCheck_certify_type("WEBID");
			teacherMember.setCheck_certify_data(teacher.getTeacher_id());

			memberInfo = MemberAPI.getMemberCertify("WEB", teacherMember);
			
			if ( memberInfo == null ) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
				return result;
			} else {
				Member member = new Member();
				member.setUser_id(memberInfo.get("USER_ID"));
				memberInfo = MemberAPI.getMember("WEB", member);
			}
			
		}
		else {
			
			Member member = new Member();
			member.setUser_id(teacher.getTeacher_id());
			memberInfo = MemberAPI.getMember("WEB", member);
			if ( memberInfo == null ) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
				return result;
			}
		}
		
		result.put("memberInfo", memberInfo);
		return result; 
	}
	
	@RequestMapping(value = {"/searchTeacher.*"})
	public String searchTeacher(Model model, Teacher teacher, HttpServletRequest request) {
		teacher.setConfirm_yn("Y");
		service.setPaging(model, service.getTeacherListCount(teacher), teacher);
		model.addAttribute("teacher", teacher);
		model.addAttribute("teacherList", service.getTeacherList(teacher));
		
		return basePath + "search_ajax";
	}
	
	private String checkSameTeacher(Teacher teacher) {
		if ( service.checkTeacher(teacher) != null ) {
			return "이미 등록된 강사 입니다.";
		}
		
		/*Member teacherMember = new Member();
		teacherMember.setUser_id(teacher.getTeacher_id());
		teacherMember.setCheck_certify_type("WEBID");
		teacherMember.setCheck_certify_data(teacher.getTeacher_id());

		Map<String, String> memberInfo = MemberAPI.getMemberCertify("WEB", teacherMember);
		
		if ( memberInfo != null ) {
			String web_id 	= memberInfo.get("WEB_ID");
			String seq_no 	= memberInfo.get("SEQ_NO");
			
			teacher.setTeacher_id(web_id);
			teacher.setMember_key(seq_no);
			
			
		}
		else {
			return "해당 ID는 유효한 회원이 아닙니다.";
		}*/

		return null;
	}
	
}