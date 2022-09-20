package kr.go.gbelib.app.module.librarianPickBook;

import java.util.ArrayList;
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
import kr.go.gbelib.app.intro.search.LibrarySearchService;

@Controller
@RequestMapping(value = { "/{homepagePath}/module/librarianPickBook" })
public class LibrarianPickBookController extends BaseController{
	
	private final String basePath = "/homepage/%s/module/librarianPickBook/";
	
	@Autowired
	private LibrarianPickBookService service;
	
	@Autowired
	private LibrarySearchService librarySearchService;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, LibrarianPickBook librarianPickBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			String before_url = String.format("/%s/module/librarianPickBook/index.do?menu_idx=%s", homepage.getContext_path(),librarianPickBook.getMenu_idx());
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
			return null;
		}
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		LibrarySearch librarySearch = new LibrarySearch();
		
		librarySearch.setUserkey(sessionMemberInfo.getRec_key());
		if (StringUtils.isNoneEmpty(sessionMemberInfo.getBirth_day())) {
			String[] age_split = sessionMemberInfo.getBirth_day().split("-");
			
			librarySearch.setBirth_year(age_split[0]);
		}
		librarySearch.setSex(sessionMemberInfo.getSex());
			
		Map<String, Object> result = LibSearchAPI.getUserreCommBooks(librarySearch);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if(result != null) {
			list = (List<Map<String, Object>>)result.get("LIST_DATA");
		}
		
		
		for (Map<String, Object> map : list) {
			
			String isbn = map.get("ISBN").toString(); 
			
			if (StringUtils.isNotEmpty(isbn)) {
				
				String[] isbnArr = isbn.split("\\s+");
				
				for(int i=0; i < isbnArr.length; i++) {
					if (i == (isbnArr.length -1)) {
						isbnArr[i].replaceAll("세트", "");
						isbnArr[i].replaceAll("셋트", "");
						isbnArr[i].replaceAll("SET", "");
						isbnArr[i].replaceAll("set", "");
						map.put("ISBN",isbnArr[i]);
					}
				}
				
				map.put("imageUrl", librarySearchService.getImageUrl(map));
			}
			
			map.put("ISBN", isbn);
			
		}
		
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
		model.addAttribute("list", list);
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
}
