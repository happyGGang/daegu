package kr.go.gbelib.app.module.teacher.teacherAgree;

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
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.teacher.Teacher;
import kr.go.gbelib.app.cms.module.teacher.TeacherService;

@Controller(value = "userTeacherAgree")
@RequestMapping(value = { "/{homepagePath}/module/teacherAgree" })
public class TeacherAgreeController extends BaseController {

	private String basePath = "/homepage/%s/module/teacherAgree/";

	@Autowired
	private TeacherService service;

	@Autowired
	private CodeService codeService;

	@Autowired
	private TermsService termsService;

	@Autowired
	private RecommendSiteService recommendSiteService;

	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, Teacher teacher, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(menuOne.getManage_idx())));
		teacher.setMember_key(getSessionUserSeqNo(request));
		teacher.setHomepage_id(homepage.getHomepage_id());
		teacher.setMenu_idx(homepage.getMenu_idx());
		model.addAttribute("teacherAgree", teacher);
		model.addAttribute("teacherAgreeOne", service.getTeacherAgreeOne(teacher));

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

		if (!result.hasErrors()) {
			teacher.setMember_key(getSessionUserSeqNo(request));
			if(teacher.getEditMode().equals("ADD")) {
				service.addTeacherAgree(teacher);
				res.setValid(true);
				res.setReload(true);
				res.setMessage("동의하였습니다.");
			} else if(teacher.getEditMode().equals("DELETE")) {
				service.deleteTeacherAgree(teacher);
				res.setValid(true);
				res.setReload(true);
				res.setMessage("동의 취소하였습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
