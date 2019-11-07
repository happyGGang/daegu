package kr.go.gbelib.app.cms.module.searchStatistics;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.framework.base.BaseController;

@Controller
@RequestMapping(value = {"/cms/module/searchStatistics"})
public class SearchStatisticsController extends BaseController{

	private final String basePath = "/cms/module/searchStatistics/";
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request) {
			
		return basePath + "index";
	}
}
