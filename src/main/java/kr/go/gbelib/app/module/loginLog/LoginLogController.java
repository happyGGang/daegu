package kr.go.gbelib.app.module.loginLog;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import is.tagomor.woothee.Classifier;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/loginLog"})
public class LoginLogController extends BaseController {

	private String basePath = "/homepage/%s/module/loginLog/";

	@Autowired
	private LoginLogService service;

	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, LoginLog loginLog, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			loginLog.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s", homepage.getContext_path(), loginLog.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), loginLog.getMenu_idx(), loginLog.getBefore_url()), request, response);
			return null;
	    }
//		setDefaultSearchYear(loginLog);
//		loginLog.setMember_seq_no(getSessionUserSeqNo(request));
		loginLog.setLogin_type("HOMEPAGE");
		loginLog.setMember_id(getSessionMemberId(request));
		
		
		service.setPaging(model, service.getLoginLogCnt(loginLog), loginLog);
		
		List<LoginLog> loginLogList = service.getLoginLogList(loginLog);
		for(LoginLog one: loginLogList) {
			Map<String, String> r = Classifier.parse(one.getUser_agent());
			String name = r.get("name");
			String version = r.get("version");
			String category = StringUtils.upperCase(r.get("category"));
			String os = r.get("os");
			String os_version = r.get("os_version");
			
			one.setBrowser(name + " " + version);
			one.setOs(os + " " + os_version);
			one.setCategory(category);
			
		}
		model.addAttribute("loginLogList", loginLogList);
		model.addAttribute("loginLog", loginLog);

		return String.format(basePath, homepage.getFolder()) + "index";
	}

//	private void setDefaultSearchYear(AccessHistory accessHistory) {
//		if (StringUtils.isEmpty(accessHistory.getSearch_year())) {
//			SimpleDateFormat sf = new SimpleDateFormat("yyyy");
//			Calendar c = Calendar.getInstance();
//			String today = sf.format(c.getTime());
//			accessHistory.setSearch_year(today);
//		}
//	}
}
