/**
 *
 */
package kr.co.whalesoft.app.cms.menu.menuLog;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

/**
 * @author whaleesoft YONGJU 2020. 1. 14.
 *
 */
@Controller
@RequestMapping(value = {"/cms/menuLog"})
public class MenuLogController  extends BaseController {

	private final String basePath = "/cms/menuLog/";

	@Autowired
	private MenuLogService service;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, MenuLog menuLog, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Member member = getSessionMemberInfo(request);
//		if ( !getSessionIsAdmin(request) ) {
			menuLog.setHomepage_id(getAsideHomepageId(request));
//		}

		int count = service.getMenuLogCount(menuLog);
		service.setPaging(model, count, menuLog);

		model.addAttribute("menuLog", menuLog);
		model.addAttribute("menuLogList", service.getMenuLogList(menuLog));

		return basePath + "index";
	}

	@RequestMapping (value = {"/recovery.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse recovery(MenuLog menuLog, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			service.recovery(menuLog);
			res.setValid(true);
			res.setMessage("복원되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
