/**
 *
 */
package kr.go.gbelib.app.module.bookOfYear;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.bookOfYear.BookOfYear;
import kr.go.gbelib.app.cms.module.bookOfYear.BookOfYearService;

/**
 * @author whaleesoft YONGJU 2020. 2. 12.
 *
 */
@Controller(value="bookOfYearUser")
@RequestMapping(value = {"/{homepagePath}/module/bookOfYear"})
public class BookOfYearController extends BaseController {

	private String basePath = "/homepage/%s/module/bookOfYear/";

	@Autowired
	private BookOfYearService service;

	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, BookOfYear boy, HttpServletRequest request, @PathVariable ("url") String url) {
		Homepage homepage = getSessionHomepage(request);

		boy.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("boyList", service.getBookOfYearList(boy.getMap()));

		return String.format(basePath, homepage.getFolder()) + "index";
	}
}
