package kr.go.gbelib.app.module.accessHistory;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;

@Controller(value="accessHistory")
@RequestMapping(value = {"/{homepagePath}/module/accessHistory"})
public class AccessHistoryController extends BaseController {

	private String basePath = "/homepage/%s/module/accessHistory/";

	@Autowired
	private AccessHistoryService service;

	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, AccessHistory accessHistory, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			accessHistory.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s", homepage.getContext_path(), accessHistory.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), accessHistory.getMenu_idx(), accessHistory.getBefore_url()), request, response);
			return null;
	    }
		setDefaultSearchYear(accessHistory);
		accessHistory.setMember_seq_no(getSessionMemberId(request));
		service.setPaging(model, service.getAccessHistoryCount(accessHistory), accessHistory);
		model.addAttribute("accessHistoryList", service.getAccessHistoryList(accessHistory));
		model.addAttribute("accessHistory", accessHistory);

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	private void setDefaultSearchYear(AccessHistory accessHistory) {
		if (StringUtils.isEmpty(accessHistory.getSearch_year())) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy");
			Calendar c = Calendar.getInstance();
			String today = sf.format(c.getTime());
			accessHistory.setSearch_year(today);
		}
	}
}
