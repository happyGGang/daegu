package kr.go.gbelib.app.module.bookKeyword;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller(value = "bookKeyword")
@RequestMapping(value = {"/{homepagePath}/module/bookKeyword"})
public class BookKeywordController extends BaseController{
	private final String basePath = "/homepage/%s/module/bookKeyword/";

	@Autowired
	private BookKeywordService service;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookKeyword bookKeyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			String before_url = String.format("/%s/module/bookKeyword/index.do?menu_idx=%s", homepage.getContext_path(),bookKeyword.getMenu_idx());
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
			return null;
		}
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		model.addAttribute("member", sessionMemberInfo);
		model.addAttribute("bookKeyword", bookKeyword);
//		model.addAttribute("bookKeywordList", service.getBookKeywordList(bookKeyword));

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/bookKeyword.*"})
	public String bookKeyword(Model model, BookKeyword bookKeyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		model.addAttribute("member", sessionMemberInfo);
		model.addAttribute("bookKeyword", bookKeyword);
		model.addAttribute("bookKeywordList", service.getBookKeywordList(bookKeyword));

		return String.format(basePath, homepage.getFolder()) + "bookKeyword_ajax";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BookKeyword bookKeyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = (Member) request.getSession().getAttribute("member");
		
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			String before_url = String.format("/%s/module/bookKeyword/index.do?menu_idx=%s", homepage.getContext_path(),bookKeyword.getMenu_idx());
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
			return null;
		}

		LibrarySearch librarySearch = new LibrarySearch();
		librarySearch.setKeyword(bookKeyword.getKeyword_name());
		
		librarySearch.setSex(member.getSex());
		if (StringUtils.isNotEmpty(member.getBirth_day())) {
			librarySearch.setBirth_year(member.getBirth_day().split("-")[0]);
		}
		
		List<Map<String, Object>> list = LibSearchAPI.getBookKeywordSearchList(librarySearch);
		
		int searchMenuIdx = 0;
		
		if (StringUtils.isNotEmpty(homepage.getContext_path())) {
			if (homepage.getContext_path().equals("dgportal")) {
				searchMenuIdx = 7 ;
			} else {
				searchMenuIdx = menuService.getMenuIdxByProgramIdx2(new Menu(homepage.getHomepage_id(), "", "INTEGRATED"));
			}
		} else {
			searchMenuIdx = menuService.getMenuIdxByProgramIdx2(new Menu(homepage.getHomepage_id(), "", "INTEGRATED"));
		}
		 
		model.addAttribute("searchMenuIdx", searchMenuIdx);
		
		model.addAttribute("bookKeyword", bookKeyword);
		model.addAttribute("list", list);

		return String.format(basePath, homepage.getFolder()) + "view";
	}
	
	@RequestMapping(value = { "/excelDownload.*" })
	public BookKeywordView excel(Model model, BookKeyword bookKeyword, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member member = (Member) request.getSession().getAttribute("member");
		
		LibrarySearch librarySearch = new LibrarySearch();
		librarySearch.setKeyword(bookKeyword.getKeyword_name());
		librarySearch.setSex(member.getSex());
		if (StringUtils.isNotEmpty(member.getBirth_day())) {
			librarySearch.setBirth_year(member.getBirth_day().split("-")[0]);
		}
		
		model.addAttribute("bookKeywordXls", LibSearchAPI.getBookKeywordSearchList(librarySearch));

		return new BookKeywordView();
	}
}
