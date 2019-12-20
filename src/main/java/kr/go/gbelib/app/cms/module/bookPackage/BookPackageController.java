package kr.go.gbelib.app.cms.module.bookPackage;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller
@RequestMapping(value = {"/cms/module/bookPackage"})
public class BookPackageController extends BaseController {
	
	private final String basePath = "/cms/module/bookPackage/";

	@Autowired
	private BookPackageService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BookPackage bookPackage, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		model.addAttribute("bookPackage", bookPackage);
		model.addAttribute("bookPackageList", service.getBookPackageList(bookPackage));

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, BookPackage bookPackage, HttpServletRequest request) throws AuthException {
		if(bookPackage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("bookPackage", service.copyObjectPaging(bookPackage, service.getBookPackageOne(bookPackage)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("bookPackage", bookPackage);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/search.*"}, method = RequestMethod.GET)
	public String search(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> map = null;
		if (StringUtils.isNotEmpty(librarySearch.getSearch_text())) {
			map = LibSearchAPI.getNaverList(librarySearch);
			int totalCount = (Integer) map.get("totalCount");
			@SuppressWarnings ("unchecked")
			List<Map<String, Object>> itemList = (List<Map<String, Object>>) map.get("list");
			if (itemList != null && itemList.size() > 0) {
				for (Map<String, Object> map2 : itemList) {
					String[] isbnArr = String.valueOf(map2.get("isbn")).split(" ");
					for (int i = 0; i < isbnArr.length; i++) {
						String isbn = String.valueOf(map2.get("isbn")).split(" ")[i];
						map2.put("isbn"+isbn.length(), isbn);

						LibrarySearch bookSerach = new LibrarySearch();
//						bookSerach.setManageCode(homepage.getManage_code());
						bookSerach.setIsbn(isbn);
						Map<String, Object> sameBook = (Map<String, Object>) LibSearchAPI.getBookDetail(bookSerach);

						int sameBookCount = LibSearchAPI.getSearchCount(sameBook);

						if (sameBookCount > 0) {
							map2.put("already"+isbn.length(), true);
						}

					}

				}
				service.setPaging(model, totalCount, librarySearch);
				model.addAttribute("naverResult", map);
			}
		}
		
		model.addAttribute("librarySearch", librarySearch);
		
		return basePath + "search_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookPackage bookPackage, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(!bookPackage.getEditMode().equals("DELETE")) {
    		ValidationUtils.rejectIfEmpty(result, "book_package_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_package_subject", "책꾸러미명을 입력하세요.");
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (bookPackage.getEditMode().equals("ADD")) {
				bookPackage.setAdd_id(getSessionMemberId(request));
				service.addBookPackage(bookPackage);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (bookPackage.getEditMode().equals("MODIFY")) {
				bookPackage.setModify_id(getSessionMemberId(request));
				service.modifyBookPackage(bookPackage);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (bookPackage.getEditMode().equals("DELETE")) {
				service.deleteBookPackage(bookPackage);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
