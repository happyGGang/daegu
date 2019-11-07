package kr.co.whalesoft.app.cms.loginLog;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import is.tagomor.woothee.Classifier;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.module.loginLog.LoginLog;
import kr.go.gbelib.app.module.loginLog.LoginLogService;

@Controller(value = "cmsLoginLogController")
@RequestMapping(value = {"/cms/loginLog", "/wbuilder/loginLog"})
public class LoginLogController extends BaseController {

	private final String basePath = "/wbuilder/loginLog/";

	@Autowired
	private LoginLogService service;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, LoginLog loginLog, HttpServletRequest request, HttpServletResponse response) throws AuthException {
		checkAuth("R", model, request);
		loginLog.setHomepage_id(getAsideHomepageId(request));
		loginLog.setAuth_id(getSessionMemberInfo(request).getAuth_id());

		if(!getSessionIsAdmin(request)) {
			throw new AuthException("권한이 없습니다.");
	    }
		
		int count = service.getLoginLogCntCms(loginLog);
		service.setPaging(model, count, loginLog);
		
		List<LoginLog> loginLogList = service.getLoginLogListCms(loginLog);
		for(LoginLog one: loginLogList) {
			Map<String, String> r = Classifier.parse(one.getUser_agent());
			String name = StringUtils.defaultString(r.get("name"));
			String version = StringUtils.defaultString(r.get("version"));
			String category = StringUtils.upperCase(StringUtils.defaultString(r.get("category")));
			String os = StringUtils.defaultString(r.get("os"));
			String os_version = StringUtils.defaultString(r.get("os_version"));
			
			one.setBrowser(name + " " + version);
			one.setOs(os + " " + os_version);
			one.setCategory(category);
			
		}
		model.addAttribute("loginLogCnt", count);
		model.addAttribute("loginLogList", loginLogList);
		model.addAttribute("loginLog", loginLog);

		return basePath + "index";
	}

}
