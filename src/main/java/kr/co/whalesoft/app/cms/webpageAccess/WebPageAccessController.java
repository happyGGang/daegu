package kr.co.whalesoft.app.cms.webpageAccess;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = { "/cms/webpageAccess" })
public class WebPageAccessController extends BaseController {
	private final String basePath = "/cms/webpageAccess/";

	@Autowired
	private WebpageAccessService webpageAccessService;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		WebpageAccess webpageAccess = new WebpageAccess();
		Calendar c = Calendar.getInstance();
		String today = sf.format(c.getTime());
		webpageAccess.setStart_date(today);
		webpageAccess.setEnd_date(today);
		webpageAccess.setSearch_year(today.substring(0, 4));
		model.addAttribute("webpageAccess", webpageAccess);
		return basePath + "index";
	}

	@RequestMapping(value = { "/accessGraph.*" })
	public String getWebpageAccessDataByChart(Model model, WebpageAccess webpageAccess) {
		model.addAttribute("webpageAccess", webpageAccess);
		model.addAttribute("webpageAccessResult", webpageAccessService.getWebpageAccessResult(webpageAccess));
		return basePath + "accessGraph_ajax";
	}

	@RequestMapping(value = { "/accessTable.*" })
	public String getWebpageAccessDataByTable(Model model, WebpageAccess webpageAccess) {
		model.addAttribute("webpageAccess", webpageAccess);
		model.addAttribute("webpageAccessResult", webpageAccessService.getWebpageAccessResult(webpageAccess));
		return basePath + "accessTable_ajax";
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public WebpageAccessSearchView excelDownload(Model model, WebpageAccess webpageAccess, HttpServletRequest request){
		model.addAttribute("webpageAccess", webpageAccess);
		model.addAttribute("webpageAccessList", webpageAccessService.getWebpageAccessResult(webpageAccess));

		return new WebpageAccessSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, WebpageAccess webpageAccess, HttpServletRequest request, HttpServletResponse response){
		List<WebpageAccess> webpageAccessList = webpageAccessService.getWebpageAccessResult(webpageAccess);

		new WebpageAccessXlsToCsv(webpageAccess, webpageAccessList, request, response); 
	}
}
