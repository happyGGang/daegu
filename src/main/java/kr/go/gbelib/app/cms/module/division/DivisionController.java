package kr.go.gbelib.app.cms.module.division;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value={"/cms/module/division"})
public class DivisionController extends BaseController {

    private final String basePath = "/cms/module/division/";

    @Autowired
	private DivisionService service;

    @RequestMapping (value = {"/index.*"})
	public String index(Model model, Division division, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);

		model.addAttribute("division", division);
		model.addAttribute("divisionList", service.getDivisionList(division));

		return basePath + "index";
	}

	@RequestMapping(value = {"/list.*"})
	@ResponseBody
	public List<Division> getSubDivisions(@RequestParam int depth, @RequestParam int parent_idx) {
		Division division = new Division();
		division.setDepth(depth);
		division.setParent_idx(parent_idx);
		return service.findByDepthAndParent(division);
	}
}
