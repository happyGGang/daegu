package kr.go.gbelib.app.cms.module.conversionExample;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value={"/cms/conversionExample"})
public class ConversionExampleController extends BaseController {

	private final String basePath = "/cms/module/conversionExample/";
	
	@Autowired
	private ConversionExampleService service;

	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request) throws AuthException {
		List<Map<String, String>> list = service.getAllList();
		
		model.addAttribute("list", list);
		return basePath + "index";
	}
}
