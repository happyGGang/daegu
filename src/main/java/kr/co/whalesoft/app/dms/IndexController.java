package kr.co.whalesoft.app.dms;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.framework.base.BaseController;

@Controller(value = "dmsIndexController")
@RequestMapping(value = {"/dms"})
public class IndexController extends BaseController {

	private final String basePath = "/dms/";

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, HttpServletRequest request) {
//		String asideHomepageId = getAsideHomepageId(request);
//		if (StringUtils.isEmpty(asideHomepageId)) {
//			return "redirect:/cms/index.do";
//		}
		return basePath + "index";
	}

}