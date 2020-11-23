package kr.go.gbelib.app.module.marathon;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.marathon.Marathon;
import kr.go.gbelib.app.cms.module.marathon.MarathonService;
import kr.go.gbelib.app.cms.module.marathonType.MarathonType;
import kr.go.gbelib.app.cms.module.marathonType.MarathonTypeService;

@Controller(value="userMarathon")
@RequestMapping(value = {"/{homepagePath}/module/marathon"})
public class MarathonController extends BaseController {

	private String basePath = "/homepage/%s/module/marathon/";
	
	@Autowired
	private MarathonService service;
	
	@Autowired
	private MarathonTypeService marathonTypeService;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Marathon marathon, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Marathon marathonUseOne = new Marathon();
		marathonUseOne.setHomepage_id(homepage.getHomepage_id());
		marathonUseOne = service.getMarathonUseOne(marathonUseOne);
		model.addAttribute("ing", marathonUseOne != null);
		if(marathonUseOne != null) {
			MarathonType marathonType = new MarathonType();
			marathonType.setHomepage_id(homepage.getHomepage_id());
			marathonType.setContest_idx(marathonUseOne.getContest_idx());
			List<MarathonType> marathonTypeList = marathonTypeService.getMarathonTypeList(marathonType);
			model.addAttribute("marathonUseOne", marathonUseOne);
			model.addAttribute("marathonTypeList", marathonTypeList);
		}
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
}
