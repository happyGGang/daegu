package kr.go.gbelib.app.module.bookReview;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
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
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.bookReview.BookReview;
import kr.go.gbelib.app.cms.module.bookReview.BookReviewService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller(value = "userBookReview")
@RequestMapping(value = {"/{homepagePath}/module/bookReview"})
public class BookReviewController extends BaseController {

	private String basePath = "/homepage/%s/module/bookReview/";

	@Autowired
	private BookReviewService service;

	@Autowired
	private MenuService menuService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BookReview bookReview, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

//		Map<String, Object> loanList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "LOAN", null);
		
		String bookReviewFlag = "F"; // FAIL
//		if(loanList != null) {
//			@SuppressWarnings("unchecked")
//			List<Map<String, Object>> dsMyLibraryList = (ArrayList<Map<String,Object>>)loanList.get("dsMyLibraryList");

//			if(dsMyLibraryList != null) {
//				for(Map<String, Object> map : dsMyLibraryList) {
//					String ctrlno = (String)map.get("CTRLNO");
//					if(StringUtils.equals(bookReview.getBook_review_ctrlno(), ctrlno)) {
//						bookReview.setBook_review_loan_id(getSessionUserId(request));
						bookReview.setBook_review_loan_id(getSessionMemberInfo(request).getRec_key());
						int brDuplCnt = service.duplBookReviewUserCnt(bookReview);
						if(brDuplCnt > 0) {
							bookReviewFlag = "D"; // DUPLICATE : 서평이력이 있을 때
						} else {
							bookReviewFlag = "P"; // PASS : 작성가능
						}
//						break;
//					} else {
//						bookReviewFlag = "H"; // HISTORY : 대출이력이 없을 때
//					}
//				}
//			} else {
//				bookReviewFlag = "H"; // 대출이력이 없을 때
//			}
//		}

		model.addAttribute("bookReview", bookReview);
		model.addAttribute("bookReviewList", service.getBookReviewList(bookReview));
		model.addAttribute("bookReviewFlag", bookReviewFlag);

		return String.format(basePath, homepage.getFolder()) + "index_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse bookReviewSave(BookReview bookReview, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		Homepage homepage = (Homepage)request.getAttribute("homepage");
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			try {
				bookReview.setBefore_url(URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				bookReview.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/index.do?menu_idx=%s", homepage.getContext_path(), bookReview.getMenu_idx()));
			}
			result.reject("로그인 후 이용가능합니다.");
			res.setUrl(String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookReview.getMenu_idx(), bookReview.getBefore_url()));
		}

		ValidationUtils.rejectIfEmpty(result, "book_review_content", "서평 내용을 입력하세요");
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
//			bookReview.setBook_review_loan_id(member.getUser_id());
//			bookReview.setBook_review_web_id(member.getWeb_id());
			bookReview.setBook_review_loan_id(member.getRec_key());
			bookReview.setBook_review_web_id(member.getMember_id());
			bookReview.setBook_review_name(member.getMember_name());

			if(bookReview.getEditMode().equals("ADD")) {
//				Map<String, Object> loanList = LibSearchAPI.getMyLibraryList("WEB", bookReview.getBook_review_loan_id(), "LOAN", null);
//				@SuppressWarnings("unchecked")
//				List<Map<String, Object>> dsMyLibraryList = (ArrayList<Map<String,Object>>)loanList.get("dsMyLibraryList");
//
//				boolean libList = false;
//				if(dsMyLibraryList != null) {
//					for(Map<String, Object> map : dsMyLibraryList) {
//						String ctrlno = (String)map.get("CTRLNO");
//						if(StringUtils.equals(bookReview.getBook_review_ctrlno(), ctrlno)) {
//							libList = true;
//							break;
//						}
//					}
//				}

//				if(!libList) {
//					res.setValid(false);
//					res.setMessage("대출 이력이 없습니다.");
//					return res;
//				}
//
				int brDuplCnt = service.duplBookReviewUserCnt(bookReview);
				if(brDuplCnt > 0) {
					res.setValid(false);
					res.setMessage("서평을 이미 등록하였습니다.");
					return res;
				}

				bookReview.setAdd_id(getSessionMemberId(request));
				String addResult = service.addBookReview(bookReview);
				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}
				res.setValid(true);
				res.setMessage("서평 등록되었습니다.");
			} else if(bookReview.getEditMode().equals("MODIFY")) {
				bookReview.setModify_id(getSessionMemberId(request));
				String modifyResult = service.modBookReview(bookReview);
				if (modifyResult != null) {
					res.setValid(true);
					res.setUrl(modifyResult);
					res.setTargetOpener(true);
					return res;
				}
				res.setValid(true);
				res.setMessage("서평 수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(BookReview bookReview, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			if(bookReview.getEditMode().equals("DELETE")) {
				service.delBookReview(bookReview);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/history.*"}, method = RequestMethod.GET)
	public String history(Model model, BookReview bookReview, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookReview.setBook_review_loan_id(getSessionUserId(request));

		int bookReviewAllCnt = service.getbookReviewAllCnt(bookReview);
		service.setPaging(model, bookReviewAllCnt, bookReview);

		List<BookReview> bookReviewAll = service.getBookReviewAll(bookReview);

		for(BookReview one : bookReviewAll) {
			LibrarySearch librarySearch = new LibrarySearch();
			librarySearch.setvCtrl(one.getBook_key());

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
		model.addAttribute("bookReviewAll", bookReviewAll);
		model.addAttribute("homepageList", homepageService.getNormalHomepage());

		return String.format(basePath, homepage.getFolder()) + "history";
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public BookReviewView excel(Model model, BookReview bookReview, HttpServletRequest request, HttpServletResponse response) throws Exception {
		bookReview.setBook_review_loan_id(getSessionUserId(request));
		List<BookReview> bookReviewAll = service.getBookReviewXlsAndCsv(bookReview);

		for(BookReview one : bookReviewAll) {
			LibrarySearch librarySearch = new LibrarySearch();
			librarySearch.setvCtrl(one.getBook_key());

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

		model.addAttribute("bookReviewAll", bookReviewAll);

		return new BookReviewView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(BookReview bookReview, HttpServletRequest request, HttpServletResponse response) throws Exception{
		bookReview.setBook_review_loan_id(getSessionUserId(request));
		List<BookReview> bookReviewAll = service.getBookReviewXlsAndCsv(bookReview);

		for(BookReview one : bookReviewAll) {
			LibrarySearch librarySearch = new LibrarySearch();
			librarySearch.setvCtrl(one.getBook_key());

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

		new BookReviewXlsToCsv(bookReviewAll, request, response);
	}

}