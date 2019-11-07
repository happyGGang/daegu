package kr.co.whalesoft.app.cms.index;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller(value = "wbuilderIndexController")
@RequestMapping(value = {"/wbuilder"})
public class WbuilderIndexController extends BaseController {
	
	private final String basePath = "/wbuilder/";
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		return basePath + "index";
	}
	
}