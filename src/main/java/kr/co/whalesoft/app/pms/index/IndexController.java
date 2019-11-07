package kr.co.whalesoft.app.pms.index;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.whalesoft.framework.base.BaseController;

@Controller(value = "pmsIndexController")
@RequestMapping(value = {"/pms"})
public class IndexController extends BaseController {
	
	private final String basePath = "/pms/";

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, HttpServletRequest request) {
//		String asideHomepageId = getAsideHomepageId(request);
//		if (StringUtils.isEmpty(asideHomepageId)) {
//			return "redirect:/cms/index.do";
//		}
		return basePath + "index";
	}
	
}