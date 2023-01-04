package kr.go.gbelib.app.module.bookOfFamous;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.bookOfFamous.BookOfFamous;
import kr.go.gbelib.app.cms.module.bookOfFamous.BookOfFamousService;

@Controller(value="bookOfFamousUser")
@RequestMapping(value = {"/{homepagePath}/module/bookOfFamous"})
public class BookOfFamousController extends BaseController {

	private String basePath = "/homepage/%s/module/bookOfFamous/";

	@Autowired
	private BookOfFamousService service;

	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, BookOfFamous boy, HttpServletRequest request, @PathVariable ("url") String url) {
		Homepage homepage = getSessionHomepage(request);

		boy.setHomepage_id(homepage.getHomepage_id());
		service.setPaging(model, service.getBookOfFamousCount(boy), boy);
		model.addAttribute("boyList", service.getBookOfFamousList(boy));

		return String.format(basePath, homepage.getFolder()) + "index";
	}
}
