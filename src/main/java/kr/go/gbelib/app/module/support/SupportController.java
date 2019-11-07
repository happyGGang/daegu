package kr.go.gbelib.app.module.support;

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
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.support.Support;
import kr.co.whalesoft.app.cms.module.support.SupportSearchView;
import kr.co.whalesoft.app.cms.module.support.SupportService;
import kr.co.whalesoft.app.cms.module.supportManage.SupportManage;
import kr.co.whalesoft.app.cms.module.supportManage.SupportManageService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.cms.module.dept.Dept;
import kr.go.gbelib.app.cms.module.dept.DeptService;

@Controller(value="userSupport")
@RequestMapping(value = {"/{homepagePath}/module/support"})
public class SupportController extends BaseController {
	
	private String basePath = "/homepage/%s/module/support/";
	
	@Autowired
	private SupportService service;
	
	@Autowired
	private SupportManageService supportManageService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private CalendarManageService calendarManageService;
	
	@ModelAttribute("siteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
	}
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Support support, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		support.setHomepage_id(homepage.getHomepage_id());
		
		if(support.getPlan_date() == null || support.getPlan_date().equals("")) {
			support.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));						
		}
		
		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(support.getPlan_date());
		model.addAttribute("supportManageRepo", supportManageService.getSupportManageRepo(supportManageService.getSupportManage(new SupportManage(support.getHomepage_id(), support.getPlan_date()))));
		model.addAttribute("calendarList", service.getCalendar(support));
		model.addAttribute("support", support);
		model.addAttribute("supportList", service.getSupport(support));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate(calendarManage));
		model.addAttribute("monthList", codeService.getCode(support.getHomepage_id(), "C0004"));
		model.addAttribute("memberId", getSessionMemberId(request));
		
		if ( "ajax".equals(support.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "index_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "index";	
		}
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Support support, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			if ( "ajax".equals(support.getPageType()) ) {
				support.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s&pageType=ajax", homepage.getContext_path(), support.getMenu_idx()));
			}
			else {
				support.setBefore_url(String.format("http://www.gbelib.kr/%s/module/support/edit.do?menu_idx=%s", homepage.getContext_path(), support.getMenu_idx()));
			}
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), support.getMenu_idx(), support.getBefore_url()), request, response);
			return null;
	    }
		
		support.setHomepage_id(homepage.getHomepage_id());
		int menu_idx = support.getMenu_idx();
		
		SupportManage supportManage = supportManageService.getCheckReqCount(new SupportManage(support.getHomepage_id(), support.getPlan_date()));
		if ( supportManage == null ) {
			supportManageService.alertMessage("신청 가능일이 아닙니다.", request, response);
			return null;
		}
		
		if ( supportManage.getLimit_req_count() > supportManage.getReq_count() ) {
			if(support.getEditMode().equals("MODIFY")) {
				if ( "ajax".equals(support.getPageType()) ) {
					support = service.getSupportOne(support);
					support.setPageType("ajax");
				} else {
					support = service.getSupportOne(support);
				}
				support.setMenu_idx(menu_idx);
				support.setEditMode("MODIFY");
				model.addAttribute("support", support);
			} else {
				model.addAttribute("support", support);
			}
			model.addAttribute("cellPhoneCode", codeService.getCode(support.getHomepage_id(), "C0002"));
			if ( "ajax".equals(support.getPageType()) ) {
				return String.format(basePath, homepage.getFolder()) + "edit_ajax";
			}
			else {
				return String.format(basePath, homepage.getFolder()) + "edit";	
			}
		}
		else {
			service.alertMessageAndReload("신청 가능한 횟수가 다 찼습니다.", request, response);
			return null;
		}
		
		
	}
	
	@RequestMapping(value = {"/apply.*"})
	public String apply(Model model, Support support, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		int menu_idx = support.getMenu_idx();
		support.setHomepage_id(homepage.getHomepage_id());
		support = service.getSupportOne(support);
		support.setMenu_idx(menu_idx);
		model.addAttribute("support", support);
		if ( "ajax".equals(support.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "result_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "result";	
		}
	}
	
	@RequestMapping(value = {"/indexApply.*"})
	public String indexApply(Model model, Support support, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			if ( "ajax".equals(support.getPageType()) ) {
				support.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s&pageType=ajax", homepage.getContext_path(), support.getMenu_idx()));
			}
			else {
				support.setBefore_url(String.format("http://www.gbelib.kr/%s/module/support/indexApply.do?menu_idx=%s", homepage.getContext_path(), support.getMenu_idx()));
			}
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), support.getMenu_idx(), support.getBefore_url()), request, response);
			return null;
	    }
		
		support.setHomepage_id(homepage.getHomepage_id());
		support.setReq_id(getSessionMemberId(request));		
		model.addAttribute("support", support);
		model.addAttribute("supportList", service.getUserSupport(support));
		if ( "ajax".equals(support.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "indexApply_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "indexApply";	
		}
	}	
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public SupportSearchView excel(Model model, Support support, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		model.addAttribute("support", support); 		
		model.addAttribute("supportResult", service.getSupport(support));
		return new SupportSearchView();
	}
	
	@RequestMapping(value = { "/searchDept.*" })
	public String searchDept(Model model, Dept dept, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		if ( StringUtils.isNotEmpty(dept.getCode_name()) ) {
			dept.setSearch_type("CODE_NAME");
			dept.setSearch_text(dept.getCode_name());
		}
		
		int count = deptService.getDeptCount(dept);
		deptService.setPaging(model, count, dept);
		model.addAttribute("dept", dept);
		model.addAttribute("deptList", deptService.getDept(dept));
		model.addAttribute("deptListCount", count);
		
		return String.format(basePath, homepage.getFolder()) + "/search_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Support support, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		if(!support.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "req_organ_code", "신청기관명을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "requer_name", "신청자성명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "requer_tel1", "신청자 휴대폰번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "requer_tel2", "신청자 휴대폰번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "requer_tel3", "신청자 휴대폰번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "hope_req_dt", "지원희망일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "req_title", "제목을 입력하세요.");
		}
						
		support.setReq_id(getSessionMemberId(request));
		support.setMember_key(getSessionMemberInfo(request).getSeq_no());		
		
		if(!result.hasErrors()) {
			StringBuilder sb = new StringBuilder();
			sb.append(support.getEditMode() + "\n");
			sb.append(support.getPlan_date() + "\n");
			sb.append(support.getHomepage_id() + "\n");
			sb.append(support.getSeq() + "\n");
			sb.append(support.getPageType() + "\n");
			sb.append(support.getReq_organ_code() + "\n");
			sb.append(support.getReq_name() + "\n");
			sb.append(support.getRequer_name() + "\n");
			sb.append(support.getRequer_tel() + "\n");
			sb.append(support.getRequer_tel1() + "\n");
			sb.append(support.getRequer_tel2() + "\n");
			sb.append(support.getRequer_tel3() + "\n");
			sb.append(support.getHope_req_dt() + "\n");
			sb.append(support.getReq_title() + "\n");
			sb.append(support.getReq_content() + "\n");
			String addResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", sb.toString());
			if (addResult != null) {
				res.setValid(false);
				res.setUrl(addResult);
				res.setTargetOpener(true);
				return res;
			}
			
			if(support.getEditMode().equals("ADD")) {
				service.addSupport(support);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
				
			} else if(support.getEditMode().equals("MODIFY")) {
				service.modifySupport(support);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(support.getEditMode().equals("DELETE")) {
				service.deleteSupport(support);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Support support, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
			
		Member member = (Member) getSessionMemberInfo(request);		

		if(!result.hasErrors()) {
			support.setReq_id(member.getMember_id());
			service.deleteSupport(support);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/result.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse result(Support support, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		if(!support.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "support_div", "지원구분을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "supporter", "지원자를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "support_content", "지원내용을 입력하세요.");
		}
			
		Member member = (Member) getSessionMemberInfo(request);		

		if(!result.hasErrors()) {
			support.setReq_id(member.getMember_id());
			if(!support.getEditMode().equals("DELETE")) {
				service.modifySupportResult(support);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
				
			} else if(support.getEditMode().equals("DELETE")) {
				service.deleteSupport(support);				
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

}
