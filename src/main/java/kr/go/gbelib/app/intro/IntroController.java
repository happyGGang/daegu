package kr.go.gbelib.app.intro;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	public String index(@PathVariable String context_path, Model model, HttpServletRequest request, HttpServletResponse response) {
		response.setHeader("X-Frame-Options", "DENY");
		response.setHeader("X-Content-Type-Options", "nosniff");
		response.setHeader("X-XSS-Protection", "1");
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		if (request.getProtocol().equals("HTTP/1.1")) {
			response.setHeader("Cache-Control", "no-cache");
		}
		model.addAttribute("homepage", request.getAttribute("homepage"));
		return basePath + "index";
	}

}