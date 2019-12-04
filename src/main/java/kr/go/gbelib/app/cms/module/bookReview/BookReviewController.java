package kr.go.gbelib.app.cms.module.bookReview;

import java.util.ArrayList;
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

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.module.bookReview.BookReviewView;
import kr.go.gbelib.app.module.bookReview.BookReviewXlsToCsv;

@Controller
@RequestMapping(value = {"/cms/module/bookReview"})
public class BookReviewController extends BaseController {

	private final String basePath = "/cms/module/bookReview/";

	@Autowired
	private BookReviewService service;

	@Autowired
	private MenuService menuService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BookReview bookReview, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = null;
		if(StringUtils.isEmpty(bookReview.getHomepage_id())) {
			homepage = getSessionHomepageInfo(request);
			bookReview.setBr_loca(homepage.getLib_code());
			bookReview.setHomepage_id(homepage.getHomepage_id());
		} else {
			bookReview.setBr_loca(getHomepageOne(bookReview.getHomepage_id()).getLib_code());
		}

		int count = service.getBookReviewLocaListCnt(bookReview);
		service.setPaging(model, count, bookReview);

		List<BookReview> bookReviewLocaList = service.getBookReviewLocaList(bookReview);

		for(BookReview one : bookReviewLocaList) {
			LibrarySearch librarySearch = new LibrarySearch();
			librarySearch.setvCtrl(one.getBr_ctrlno());

			@SuppressWarnings("unchecked")
			List<Map<String, Object>> dsItemDetail = (ArrayList<Map<String,Object>>)LibSearchAPI.getBookDetail(librarySearch).get("dsItemDetail");
			one.setDsItemDetail(dsItemDetail.get(0));

			Homepage codeHomepage = new Homepage();
			codeHomepage.setLib_code(one.getDsItemDetail().get("LOCA").toString());
			Homepage newHomepage = homepageService.getHomepageOneByCode(codeHomepage);

			int moduleMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(newHomepage.getHomepage_id(), 2));
			one.setMenu_idx(moduleMenuIdx);
			one.getDsItemDetail().put("context_path", newHomepage.getContext_path());
		}

		model.addAttribute("bookReview", bookReview);
		model.addAttribute("bookReviewLocaList", bookReviewLocaList);

		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, BookReview bookReview, HttpServletRequest request) throws AuthException {

		if(bookReview.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			bookReview = (BookReview) service.copyObjectPaging(bookReview, service.getBookReviewOne(bookReview));
		} else {
			checkAuth("C", model, request);
		}

		model.addAttribute("bookReview", bookReview);
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookReview bookReview, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(!bookReview.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "br_content", "서평 내용을 입력하세요.");
		}
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			if(bookReview.getEditMode().equals("ADD")) {
//				res.setValid(true);
//				res.setMessage("");
			} else if(bookReview.getEditMode().equals("MODIFY")) {
				service.modBookReview(bookReview);
				res.setValid(true);
				res.setReload(true);
				res.setMessage("수정되었습니다.");
			} else if(bookReview.getEditMode().equals("DELETE")) {
				service.delBookReview(bookReview);
				res.setValid(true);
				res.setReload(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BookReviewView excel(Model model, BookReview bookReview, HttpServletRequest request, HttpServletResponse response) throws Exception{
		bookReview.setBr_loca(getHomepageOne(bookReview.getHomepage_id()).getLib_code());

		List<BookReview> bookReviewLocaList = service.getBookReviewLocaList(bookReview);

		for(BookReview one : bookReviewLocaList) {
			LibrarySearch librarySearch = new LibrarySearch();
			librarySearch.setvCtrl(one.getBr_ctrlno());

			@SuppressWarnings("unchecked")
			List<Map<String, Object>> dsItemDetail = (ArrayList<Map<String,Object>>)LibSearchAPI.getBookDetail(librarySearch).get("dsItemDetail");
			one.setDsItemDetail(dsItemDetail.get(0));

			Homepage codeHomepage = new Homepage();
			codeHomepage.setLib_code(one.getDsItemDetail().get("LOCA").toString());
			Homepage newHomepage = homepageService.getHomepageOneByCode(codeHomepage);

			int moduleMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(newHomepage.getHomepage_id(), 2));
			one.setMenu_idx(moduleMenuIdx);
			one.getDsItemDetail().put("context_path", newHomepage.getContext_path());
		}

		model.addAttribute("bookReview", bookReview);
		model.addAttribute("bookReviewAll", bookReviewLocaList);

		return new BookReviewView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, BookReview bookReview, HttpServletRequest request, HttpServletResponse response) throws Exception{
		bookReview.setBr_loca(getHomepageOne(bookReview.getHomepage_id()).getLib_code());

		List<BookReview> bookReviewAll = service.getBookReviewLocaList(bookReview);

		for(BookReview one : bookReviewAll) {
			LibrarySearch librarySearch = new LibrarySearch();
			librarySearch.setvCtrl(one.getBr_ctrlno());

			@SuppressWarnings("unchecked")
			List<Map<String, Object>> dsItemDetail = (ArrayList<Map<String,Object>>)LibSearchAPI.getBookDetail(librarySearch).get("dsItemDetail");
			one.setDsItemDetail(dsItemDetail.get(0));
		}

		new BookReviewXlsToCsv(bookReviewAll, request, response);
	}

}
