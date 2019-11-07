package kr.go.gbelib.app.cms.module.bestStr;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.framework.base.BaseController;

@Controller
@RequestMapping(value = {"/cms/module/bestStr"})
public class BestStrController extends BaseController{

	private final String basePath = "/cms/module/bestStr/";
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request) {
			
		return basePath + "index_ajax";
	}
}
