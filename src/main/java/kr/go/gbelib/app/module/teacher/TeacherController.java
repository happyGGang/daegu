package kr.go.gbelib.app.module.teacher;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.teacher.Teacher;
import kr.go.gbelib.app.cms.module.teacher.TeacherService;

@Controller(value = "userTeacher")
@RequestMapping(value = { "/{homepagePath}/module/teacher" })
public class TeacherController extends BaseController {

	private String basePath = "/homepage/%s/module/teacher/";

	@Autowired
	private TeacherService service;

	@Autowired
	private CodeService codeService;

	@Autowired
	private HomepageService homepageService;


	@Autowired
	private RecommendSiteService recommendSiteService;

	@ModelAttribute("siteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, Teacher teacher, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		teacher.setHomepage_id(homepage.getHomepage_id());
		teacher.setConfirm_yn("Y");
		int count = service.getTeacherListCount(teacher);
		service.setPaging(model, count, teacher);
		model.addAttribute("teacherList", service.getTeacherList(teacher));
		model.addAttribute("teacherListCount", count);

		model.addAttribute("teacher", teacher);
		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value = { "/edit.*" }, method = RequestMethod.GET)
	public String edit(Model model, Teacher teacher, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		//로그인 체크
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			teacher.setBefore_url(String.format("http://www.gbelib.kr/%s/module/teacher/edit.do?menu_idx=%s", homepage.getContext_path(), teacher.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), teacher.getMenu_idx(), teacher.getBefore_url()), request, response);
			return null;
		}

		teacher.setHomepage_id(homepage.getHomepage_id());

		if ( teacher.getEditMode().equals("MODIFY") ) {
			Teacher getTeacher =  service.getTeacherOne(teacher);
			if ( getSessionUserSeqNo(request).equals(getTeacher.getMember_key()) ) {
				model.addAttribute("teacher", service.copyObjectPaging(teacher, getTeacher));
			}
			else {
				service.alertMessage("수정 권한이 없습니다.", request, response);
				return null;
			}
		}

		model.addAttribute("memberInfo", getSessionMemberInfo(request));
		model.addAttribute("cellPhoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0003"));

		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Teacher teacher, HttpServletRequest request, BindingResult result) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		JsonResponse res = new JsonResponse(request);
		teacher.setHomepage_id(homepage.getHomepage_id());

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

		if (!result.hasErrors()) {
			if ( service.checkTeacher(teacher) == null ) {
				if(teacher.getEditMode().equals("ADD")) {
					teacher.setAdd_id(getSessionMemberId(request));
					service.addTeacher(teacher);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}
				else if(teacher.getEditMode().equals("MODIFY")) {
					teacher.setMod_id(getSessionMemberId(request));
					service.modifyTeacher(teacher);
					res.setValid(true);
					res.setMessage("수정 되었습니다.");
				}
			}
			else {
				res.setValid(false);
				res.setMessage("이미 등록된 강사 입니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
