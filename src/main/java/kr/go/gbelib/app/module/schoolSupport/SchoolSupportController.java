package kr.go.gbelib.app.module.schoolSupport;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
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
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.schoolSupport.SchoolSupport;
import kr.go.gbelib.app.cms.module.schoolSupport.SchoolSupportService;

@Controller(value="userSchoolSupport")
@RequestMapping(value = {"/{homepagePath}/module/schoolSupport"})
public class SchoolSupportController extends BaseController {
	
	private String basePath = "/homepage/%s/module/schoolSupport/";
	
	@Autowired
	private SchoolSupportService service;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private CalendarManageService calendarManageService;
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private TermsService termsService;
	
	@ModelAttribute("siteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
	}
	
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, SchoolSupport schoolSupport, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		schoolSupport.setHomepage_id(homepage.getHomepage_id());				
		
		if ( StringUtils.isEmpty(schoolSupport.getPlan_date()) ) {
			schoolSupport.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(schoolSupport.getPlan_date());
		
		model.addAttribute("calendarList", service.getCalendar(schoolSupport));
		model.addAttribute("schoolSupport", schoolSupport);
		model.addAttribute("schoolSupportRepo", service.makeRepo(service.getSupportList(schoolSupport), schoolSupport.getPlan_date()));
		model.addAttribute("areaList", codeService.getCode(schoolSupport.getHomepage_id(), "C0019"));
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, SchoolSupport schoolSupport, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");		

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			schoolSupport.setBefore_url(String.format("http://www.gbelib.kr/%s/module/schoolSupport/index.do?menu_idx=%s", homepage.getContext_path(), schoolSupport.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), schoolSupport.getMenu_idx(), schoolSupport.getBefore_url()), request, response);
			return null;
	    }
		
		model.addAttribute("managerTypeList", codeService.getCode(schoolSupport.getHomepage_id(), "C0018"));
		model.addAttribute("areaList", codeService.getCode(schoolSupport.getHomepage_id(), "C0019"));
		
		//약관 연동부 
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(menuOne.getManage_idx())));
		
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("schoolSupport", schoolSupport);
		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, SchoolSupport schoolSupport, BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			if ( schoolSupport.getEditMode().equals("ADD") ) {
				schoolSupport.setSupport_status("0");
				service.addSupport(schoolSupport);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	/*
	
	@RequestMapping(value = {"/apply.*"})
	public String apply(Model model, FacilityReq facilityReq, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");			
		
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			 
			facilityReq.setBefore_url(String.format("http://www.gbelib.kr/%s/module/facility/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), facilityReq.getMenu_idx()));
			
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), facilityReq.getMenu_idx(), facilityReq.getBefore_url()), request, response);
			return null;
	    }
				
		facilityReq.setHomepage_id(homepage.getHomepage_id());
		facilityReq.setMember_key(getSessionUserSeqNo(request));
		
		model.addAttribute("facilityReq", facilityReq);
		model.addAttribute("applyList", facilityReqService.getApplyList(facilityReq));
		
		return String.format(basePath, homepage.getFolder()) + "apply";
	}
	
	*/
}
