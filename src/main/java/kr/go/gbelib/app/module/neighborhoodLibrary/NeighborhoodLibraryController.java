package kr.go.gbelib.app.module.neighborhoodLibrary;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
/**
 * @author ttkaz
 * 2022. 11. 21.
 *
 */
@Controller(value="userNeighborhoodLibrary")
@RequestMapping(value = {"/{homepagePath}/module/nearLib"})
public class NeighborhoodLibraryController extends BaseController {
	private String basePath = "/homepage/%s/module/neighborhoodLibrary/";
	
	@RequestMapping(value = {"/bacode.*"})
	public String bacode(Model model,@RequestParam(required = false) String pass, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		model.addAttribute("param", pass);
		return String.format(basePath, homepage.getFolder()) + "bacode";
		
	}

}
