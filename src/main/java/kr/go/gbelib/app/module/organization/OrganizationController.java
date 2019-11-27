package kr.go.gbelib.app.module.organization;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.organization.Organization;
import kr.co.whalesoft.app.cms.organization.OrganizationService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.framework.base.BaseController;

@Controller(value="userOrganization")
@RequestMapping(value = {"/{homepagePath}/module/organization"})
public class OrganizationController extends BaseController {
	
	private String basePath = "/homepage/%s/module/organization/";
	
	@Autowired
	private OrganizationService service;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Organization organization, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		organization.setHomepage_id(homepage.getHomepage_id());
		
		List<Organization> workList = service.getOrganizationWorkAll(organization);
		for (Organization one : workList) {
			one.setWork_info(one.getWork_info().replaceAll("\n", "<br/>"));
		}
		
		organization.setChart_yn(service.getOrganizationChartYN(organization));
		
		model.addAttribute("organization", organization);
		model.addAttribute("organizationList", service.getOrganizationList(organization));
		model.addAttribute("workList", workList);
		model.addAttribute("divisionList", service.getChartDivisionList(homepage.getHomepage_id()));
		model.addAttribute("statusList", service.getStatusList(homepage.getHomepage_id()));
		model.addAttribute("totalCnt", service.getTotalCnt(homepage.getHomepage_id()));
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}

}
