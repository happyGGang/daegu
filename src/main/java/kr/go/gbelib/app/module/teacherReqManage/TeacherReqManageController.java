package kr.go.gbelib.app.module.teacherReqManage;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.teacherReqManage.TeacherReqManage;
import kr.go.gbelib.app.cms.module.teacherReqManage.TeacherReqManageService;

@Controller(value = "userTeacherReqManage")
@RequestMapping(value = { "/{homepagePath}/module/teacherReqManage" })
public class TeacherReqManageController extends BaseController {

	private String basePath = "/homepage/%s/module/teacherReqManage/";

	@Autowired
	private TeacherReqManageService service;

	@Autowired
	private TermsService termsService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private RecommendSiteService recommendSiteService;

	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, TeacherReqManage teacher, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		teacher.setHomepage_id(homepage.getHomepage_id());
		teacher.setConfirm_yn("Y");
		int count = service.getTeacherListCount(teacher);
		service.setPaging(model, count, teacher);
		model.addAttribute("teacherList", service.getTeacherList(teacher));
		model.addAttribute("teacherListCount", count);
//		model.addAttribute("subjectCodeList", codeService.getCode("CMS", "C0023"));

		List<Code> codeList = codeService.getCode("CMS", "C0023");
		List<Code> largeCodeList = new ArrayList<Code>();
		String tempLargeCodeName = "";
		for ( Code code : codeList ) {

			int dashIndex = code.getCode_name().indexOf("-");
			String largeCodeName = code.getCode_name().substring(0, dashIndex);
			if (!StringUtils.equals(tempLargeCodeName, largeCodeName)) {
				tempLargeCodeName = largeCodeName;
				Code tempCode = new Code();
				tempCode.setCode_id(code.getCode_id().substring(0, 1));
				tempCode.setCode_name(largeCodeName);
				largeCodeList.add(tempCode);
			}
		}
		model.addAttribute("largeCodeList", largeCodeList);

		if (StringUtils.isNotEmpty(teacher.getLargeSubjectCode())) {
			List<Code> smallCodeList = new ArrayList<Code>();
			for ( Code code : codeList ) {
				if (code.getCode_id().startsWith(teacher.getLargeSubjectCode())) {
					int dashIndex = code.getCode_name().indexOf("-");
					String smallCodeName = code.getCode_name().substring(dashIndex+1);
					Code tempCode = new Code();
					tempCode.setCode_id(code.getCode_id());
					tempCode.setCode_name(smallCodeName);
					smallCodeList.add(tempCode);
				}
			}
			model.addAttribute("smallCodeList", smallCodeList);
		}

		model.addAttribute("locationCodeList", codeService.getCode("CMS", "C0021"));

		model.addAttribute("teacher", teacher);
		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, TeacherReqManage teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		//로그인 체크
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			teacher.setBefore_url(String.format("http://www.gbelib.kr/%s/module/teacherReqManage/index.do?menu_idx=%s", homepage.getContext_path(), teacher.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), teacher.getMenu_idx(), teacher.getBefore_url()), request, response);
			return null;
		}

		teacher.setHomepage_id(homepage.getHomepage_id());

		if ( teacher.getEditMode().equals("MODIFY") ) {
			teacher.setTeacher_id(getSessionMemberId(request));
			TeacherReqManage getTeacher =  service.getTeacherApplyOne(teacher);
			model.addAttribute("teacher", service.copyObjectPaging(teacher, getTeacher));
		}
		else {
			Member tempMember = getSessionMemberInfo(request);
			teacher.setTeacher_sex(StringUtils.equals(tempMember.getSex(), "0001") ? "남" : "여");
			teacher.setTeacher_zipcode(tempMember.getZipcode());
			teacher.setTeacher_address(tempMember.getAddress1());
			teacher.setTeacher_email(tempMember.getEmail());
			model.addAttribute("teacher", teacher);
		}

		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(menuOne.getManage_idx())));
//		model.addAttribute("prtcNotice",MemberAPI.getPrtcNoticeList("WEB"));
		model.addAttribute("memberInfo", getSessionMemberInfo(request));

		model.addAttribute("locationCodeList", codeService.getCode("CMS", "C0021"));
		model.addAttribute("subjectCodeList", codeService.getCode("CMS", "C0023"));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0003"));

		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping(value = { "/detail.*" }, method = RequestMethod.GET)
	public String detail(Model model, TeacherReqManage teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		teacher.setHomepage_id(homepage.getHomepage_id());

		TeacherReqManage getTeacher =  service.getTeacherOne(teacher);
		model.addAttribute("teacher", service.copyObjectPaging(teacher, getTeacher));

		return String.format(basePath, homepage.getFolder()) + "detail";
	}

	@RequestMapping(value = { "/view.*" }, method = RequestMethod.GET)
	public String view(Model model, TeacherReqManage teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		//로그인 체크
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			teacher.setBefore_url(String.format("http://www.gbelib.kr/%s/module/teacherReqManage/index.do?menu_idx=%s", homepage.getContext_path(), teacher.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), teacher.getMenu_idx(), teacher.getBefore_url()), request, response);
			return null;
		}

		teacher.setHomepage_id(homepage.getHomepage_id());
		teacher.setTeacher_id(getSessionMemberId(request));

		TeacherReqManage getTeacher =  service.getTeacherApplyOne(teacher);
		model.addAttribute("teacher", service.copyObjectPaging(teacher, getTeacher));

		return String.format(basePath, homepage.getFolder()) + "view";
	}

	@RequestMapping(value = { "/apply.*" })
	public String apply(Model model, TeacherReqManage teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		//로그인 체크
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			teacher.setBefore_url(String.format("http://www.gbelib.kr/%s/module/teacherReqManage/index.do?menu_idx=%s", homepage.getContext_path(), teacher.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), teacher.getMenu_idx(), teacher.getBefore_url()), request, response);
			return null;
		}

		teacher.setTeacher_id(getSessionMemberId(request));

		int count = service.getTeacherApplyListCount(teacher);
		service.setPaging(model, count, teacher);
		model.addAttribute("teacherList", service.getTeacherApplyList(teacher));
		model.addAttribute("teacherListCount", count);
//		model.addAttribute("subjectCodeList", codeService.getCode("CMS", "C0023"));

		List<Code> codeList = codeService.getCode("CMS", "C0023");
		List<Code> largeCodeList = new ArrayList<Code>();
		String tempLargeCodeName = "";
		for ( Code code : codeList ) {

			int dashIndex = code.getCode_name().indexOf("-");
			String largeCodeName = code.getCode_name().substring(0, dashIndex);
			if (!StringUtils.equals(tempLargeCodeName, largeCodeName)) {
				tempLargeCodeName = largeCodeName;
				Code tempCode = new Code();
				tempCode.setCode_id(code.getCode_id().substring(0, 1));
				tempCode.setCode_name(largeCodeName);
				largeCodeList.add(tempCode);
			}
		}
		model.addAttribute("largeCodeList", largeCodeList);

		if (StringUtils.isNotEmpty(teacher.getLargeSubjectCode())) {
			List<Code> smallCodeList = new ArrayList<Code>();
			for ( Code code : codeList ) {
				if (code.getCode_id().startsWith(teacher.getLargeSubjectCode())) {
					int dashIndex = code.getCode_name().indexOf("-");
					String smallCodeName = code.getCode_name().substring(dashIndex+1);
					Code tempCode = new Code();
					tempCode.setCode_id(code.getCode_id());
					tempCode.setCode_name(smallCodeName);
					smallCodeList.add(tempCode);
				}
			}
			model.addAttribute("smallCodeList", smallCodeList);
		}

		model.addAttribute("teacher", teacher);
		return String.format(basePath, homepage.getFolder()) + "apply";
	}

	@RequestMapping(value = { "/save.*" },  method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, TeacherReqManage teacher, HttpServletRequest request, HttpServletResponse response, BindingResult result) throws Exception {
		JsonResponse res = new JsonResponse(request);

		if ( teacher.getEditMode().equals("ADD") ) {
			ValidationUtils.rejectIfEmpty(result, "teacher_id", "강사ID를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "teacher_name", "이름을 입력하세요.");
			ValidationUtils.rejectIfStringLength(result, "teacher_name", 50, "강사명");

			if (teacher.getOpen_file() == null) {
				result.reject("강의계획서를 등록해주세요.");
			}
		}

		if ( teacher.getEditMode().equals("ADD") || teacher.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "teacher_birth", "생년월일을 입력하세요.");
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

			if ( StringUtils.isNotEmpty(teacher.getTeacher_phone()) ) {
				ValidationUtils.rejectPhone2(result, "teacher_phone", "전화번호 형식이 잘못되었습니다.");
			}

			if (StringUtils.isNotEmpty(teacher.getTeacher_email())) {
				ValidationUtils.rejectNotFullEmailType(result, "teacher_email", "이메일 형식이 잘못되었습니다.");
			}

			ValidationUtils.rejectIfEmpty(result, "subject_cd", "과목구분을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "teacher_subject_name", "과목명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "teacher_location_code", "강의가능지역을 선택하세요.");
			ValidationUtils.rejectIfStringLength(result, "teacher_subject_name", 100, "과목명");
//			ValidationUtils.rejectIfStringLength(result, "stage", 100, "강의실");
//			ValidationUtils.rejectIfStringLength(result, "teacher_nationality", 30, "국적");
//			ValidationUtils.rejectIfStringLength(result, "teacher_zipcode", 20, "우편번호");
			ValidationUtils.rejectIfStringLength(result, "teacher_address", 200, "주소");

			if ( !"Y".equals(teacher.getSelf_info_yn()) ) {
				res.setValid(false);
				res.setMessage("이용약관 및 개인정보의 수집·이용 동의 하여야 신청이 가능합니다.");
				return res;
			}
		}

		if (!result.hasErrors()) {
			if(teacher.getEditMode().equals("ADD")) {
				if ( service.checkTeacher(teacher) != null ) {
					res.setValid(false);
					res.setMessage("이미 등록된 강사 입니다.");
					return res;
				}
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
				res.setUrl("index.do?menu_idx="+teacher.getMenu_idx());
			} else if(teacher.getEditMode().equals("MODIFY")) {
				teacher.setMod_id(getSessionMemberId(request));

				String modifyResult = service.modifyTeacher(teacher, request);
				if (modifyResult != null) {
					res.setValid(true);
					res.setUrl(modifyResult);
					res.setTargetOpener(true);
					return res;
				}

				teacher.setConfirm_yn("N");
				service.confirmTeacher(teacher);

				res.setValid(true);
				res.setMessage("수정 되었습니다.");
				res.setUrl("apply.do?menu_idx="+teacher.getMenu_idx());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
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

	@RequestMapping(value = "/download2/{homepage_id}/{teacher_idx}/{file_hash}.*", method = RequestMethod.GET)
	@ResponseBody
    public void getFile2(@PathVariable("homepage_id") String homepage_id, @PathVariable("teacher_idx") int teacher_idx, @PathVariable("file_hash") String file_hash, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	TeacherReqManage teacherReqManage = new TeacherReqManage(homepage_id, teacher_idx);
    	teacherReqManage = service.getTeacherOne(teacherReqManage);
    	if ( teacherReqManage != null && teacherReqManage.getTeacher_open_files() != null ) {
        	ObjectMapper mapper = new ObjectMapper();
        	Map<String, String>[] open_files = mapper.readValue(teacherReqManage.getTeacher_open_files(), new TypeReference<Map<String, String>[]>() {});
        	String realFileName = null;
        	String fileName = null;
        	String fileType = null;

        	for(Map<String, String> map: open_files) {
        		if(StringUtils.equals(map.get("file_hash"), file_hash)) {
        			realFileName = map.get("real_file_name");
        			fileName = map.get("file_name");
        			fileType = map.get("file_extension");
        			break;
        		}
        	}

        	if(realFileName == null) {
    			response.setHeader("Content-type", "text/html");
    			service.alertMessage("파일이 존재하지 않습니다.", request, response);
    			return;
        	}

        	String fullFilename = fileName+"."+fileType;
    		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + realFileName;
    		File file = new File(filePath);

    		if(file.length() == 0) {
    			response.setHeader("Content-type", "text/html");
    			service.alertMessage("파일이 존재하지 않습니다.", request, response);
    			return;
    		}

    		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fullFilename, request.getHeader("user-agent")));
			response.setHeader("Content-Length", Long.toString(file.length()));
		    response.setHeader("Pragma", "no-cache;");
		    response.setHeader("Expires", "-1;");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.setHeader("Connection", "close");
		    response.setContentType(AttachmentUtils.getContentType(fileType));

    		FileCopyUtils.copy(new FileInputStream(file), response.getOutputStream());
    	} else {
    		response.setHeader("Content-type", "text/html");
    		service.alertMessage("파일이 존재하지 않습니다.", request, response);
    		return;
    	}
    }

}
