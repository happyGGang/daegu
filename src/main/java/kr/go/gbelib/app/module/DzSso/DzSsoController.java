package kr.go.gbelib.app.module.DzSso;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;

/**
 * 디지털좌석예약시스템 바로가기
 * @author YONGJU
 *
 */
@Controller
@RequestMapping(value = {"/{homepagePath}/module/dzSso"})
public class DzSsoController extends BaseController {
	
	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, @PathVariable("homepagePath") String homepagePath, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String contextPath = "";
		if (StringUtils.equals(homepagePath, "temp")) {
			contextPath = request.getParameter("contextPath");
			
			if(!StringUtils.isAlpha(contextPath)) {
				response.sendError(404);
				return null;
			}
		} else {
			Homepage homepage = (Homepage) request.getAttribute("homepage");
			contextPath = homepage.getContext_path();			
		}
		String returnUrl = "";
		if (getSessionMemberInfo(request).isLogin()) {
			returnUrl = String.format("https://dz.gbelib.kr/wb_booking/sso_login_proc.php?flag=app&ssoId=%s&ssoNo=%s&goPage=http://dz.gbelib.kr/%s", getSessionMemberInfo(request).getUser_no(), getSessionMemberInfo(request).getSeq_no(), contextPath);
		} else {
			returnUrl = String.format("http://dz.gbelib.kr/%s", contextPath);
		}
		return "redirect:" + returnUrl;
	}
}
