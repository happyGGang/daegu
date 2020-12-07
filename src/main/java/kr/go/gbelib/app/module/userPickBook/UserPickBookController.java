package kr.go.gbelib.app.module.userPickBook;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.archive.Archive;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = { "/{homepagePath}/module/userPickBook" })
public class UserPickBookController extends BaseController {

	private String basePath = "/homepage/%s/module/userPickBook/";

	@Autowired
	private UserPickBookService service;

	@Autowired
	private MenuService menuService;


	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		Member member = getSessionMemberInfo(request);
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (!StringUtils.equals(member.getMember_class(), "0")) {
			service.alertMessage("희망도서 신청 가능한 회원이 아닙니다.", request, response);
			return null;
		}

		List<Map<String, Object>> list = service.getUserPickBook(member);

		model.addAttribute("userPickBookList", list);
		int searchMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 8));
		model.addAttribute("searchMenuIdx", searchMenuIdx);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
}
