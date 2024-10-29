package kr.co.whalesoft.app.cms.workingLog;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.framework.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

		WorkingLog workingLogOne = service.getWorkingLogOne(workingLog);

		boolean isResult = false;

		List<String> result = Optional.ofNullable(workingLogOne)
									  .map(WorkingLog::getWork_result)
									  .filter(resultStr -> resultStr.contains("before") && resultStr.contains("after"))
									  .map(this::parseResultStr)
									  .orElseGet(() -> Arrays.asList(workingLogOne.getWork_result()));

		if (result.size() > 1) {
			isResult = true;
			model.addAttribute("beforeData", result.get(0));
			model.addAttribute("afterData", result.get(1));
		}

		model.addAttribute("isResult", isResult);
		model.addAttribute("workingLog", service.copyObjectPaging(workingLog, workingLogOne));

		return returnUrl("view_ajax", request);
	}

	private List<String> parseResultStr(String resultStr) {
		Pattern pattern = Pattern.compile("before=\\{(.*?)\\}, after=\\{(.*?)\\}");
		Matcher matcher = pattern.matcher(resultStr);
		if (matcher.find()) {
			String beforeData = matcher.group(1).replace(", ", "\n");
			String afterData = matcher.group(2).replace(", ", "\n");

			return Arrays.asList(beforeData, afterData);
		}
		return Collections.singletonList("");
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
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public WorkingLogSearchView excel(Model model, WorkingLog workingLog, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("workingLog", workingLog);
		model.addAttribute("workingLogResult", service.getWorkingLogExcelList(workingLog));
		
		return new WorkingLogSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, WorkingLog workingLog, HttpServletRequest request, HttpServletResponse response) {
		List<WorkingLog> workingLogList = service.getWorkingLogExcelList(workingLog);
		
		new WorkingLogXlsToCsv(workingLogList, "작업 이력 리스트.csv", request, response);
	}
	
}
