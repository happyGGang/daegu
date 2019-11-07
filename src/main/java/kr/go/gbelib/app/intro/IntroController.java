package kr.go.gbelib.app.intro;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.framework.base.BaseController;

@Controller
@RequestMapping(value = {"/intro"})
public class IntroController extends BaseController {
	
	private final String basePath = "/intro/";
	
	@RequestMapping(value = {"/{context_path}/index.*"})
	public String index(@PathVariable String context_path, Model model, HttpServletRequest request) {
		model.addAttribute("homepage", request.getAttribute("homepage"));
		return basePath + "index";
	}
	
}