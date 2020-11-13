package kr.co.whalesoft.app.cms.workingLog;

import kr.co.whalesoft.framework.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * 작업이력
 * @author whalesoft
 * @since 2020.11.13
 */
@Controller
@RequestMapping(value={"/cms/workingLog", "/wbuilder/workingLog"})
public class WorkingLogController extends BaseController {

	@Autowired
	private WorkingLogService service;

	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, WorkingLog workingLog, HttpServletRequest request, @PathVariable ("url") String url) {

		if (!"CMS".equals(getAsideHomepageId(request))) {
			workingLog.setSite_id(getAsideHomepageId(request));
		}
		service.setPaging(model, service.getWorkingLogCount(workingLog), workingLog);
		model.addAttribute("workingLogList", service.getWorkingLogList(workingLog));
		model.addAttribute("workingLog", workingLog);

		return returnUrl("index", request);
	}

	@RequestMapping (value = {"/view.*"}, method = RequestMethod.GET)
	public String view(Model model, WorkingLog workingLog, HttpServletRequest request) {

		model.addAttribute("workingLog", service.copyObjectPaging(workingLog, service.getWorkingLogOne(workingLog)));

		return returnUrl("view_ajax", request);
	}

	private String returnUrl(String url, HttpServletRequest request) {
		if (request.getHeader("referer").contains("wbuilder")) {
			String wbuilderPath = "/wbuilder/workingLog/";
			return wbuilderPath + url;
		} else {
			String basePath = "/cms/workingLog/";
			return basePath + url;
		}
	}
}
