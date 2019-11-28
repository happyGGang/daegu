package kr.go.gbelib.app.module.deptMng;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.deptMng.DeptMng;
import kr.co.whalesoft.app.cms.deptMng.DeptMngService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.app.cms.statusMng.StatusMngService;
import kr.co.whalesoft.framework.base.BaseController;

@Controller(value="userDeptMng")
@RequestMapping(value = {"/{homepagePath}/module/deptMng"})
public class DeptMngController extends BaseController {

	private String basePath = "/homepage/%s/module/deptMng/";

	@Autowired
	private DeptMngService service;

	@Autowired
	private StatusMngService statusMngService;

	@Autowired
	private RecommendSiteService recommendSiteService;

	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, DeptMng deptMng, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		deptMng.setHomepage_id(homepage.getHomepage_id());

		List<DeptMng> workList = service.getWorkMngAll(deptMng);
		for (DeptMng one : workList) {
			one.setWork_info(one.getWork_info().replaceAll("\n", "<br/>"));
		}

		deptMng.setChart_yn(service.getdeptChartYN(deptMng));

		model.addAttribute("deptMng", deptMng);
		model.addAttribute("deptList", service.getDeptList(deptMng));
		model.addAttribute("workList", workList);
		model.addAttribute("divList", statusMngService.getChartDivList(homepage.getHomepage_id()));
		model.addAttribute("statusList", statusMngService.getStatusList(homepage.getHomepage_id()));
		model.addAttribute("totalCnt", statusMngService.getTotalCant(homepage.getHomepage_id()));

		return String.format(basePath, homepage.getFolder()) + "index";
	}


}
