package kr.go.gbelib.app.cms.module.elib.best;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.book.BookService;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.elib.code.ElibCode;
import kr.go.gbelib.app.cms.module.elib.code.ElibCodeService;
import kr.go.gbelib.app.cms.module.elib.config.ConfigService;

@Controller
@RequestMapping(value = {"/cms/module/elib/best"})
public class BestController extends BaseController {
	
	private final String basePath = "/cms/module/elib/best/";

	@Autowired
	private BestService service;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ElibCategoryService elibCategoryService;
	
	@Autowired
	private ElibCodeService elibCodeService;
	
	@Autowired
	private ConfigService configService;
	
	@RequestMapping(value = {"/main_index.*"})
	public String main_index(Model model, BestBook bestBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		bestBook.setHomepage_id(getAsideHomepageId(request));
		
		String sortField = bestBook.getSortField();
		if(StringUtils.equals(sortField, "book_pubdt")) {
			bestBook.setSortField("");
			bestBook.setSortType("");
		} else if(StringUtils.equals(sortField, "book_pubdt")) {
			bestBook.setSortType("");
		} else if(StringUtils.equals(sortField, "book_name")) {
			bestBook.setSortType("ASC");
		} else if(StringUtils.equals(sortField, "book_author")) {
			bestBook.setSortType("ASC");
		}
		
		bestBook.setOption("BESTBOOK");
		
		bestBook.setAuto_update_yn(configService.getConfigPair("auto_update_yn"));
		bestBook.setTypes(configService.getConfigPair("types"));
		bestBook.setDate_range(Integer.parseInt(configService.getConfigPair("date_range")));
		bestBook.setLend_weight(Float.parseFloat(configService.getConfigPair("lend_weight")));
		bestBook.setReserve_weight(Float.parseFloat(configService.getConfigPair("reserve_weight")));
		bestBook.setComment_weight(Float.parseFloat(configService.getConfigPair("comment_weight")));
		bestBook.setRecommend_weight(Float.parseFloat(configService.getConfigPair("recommend_weight")));
		bestBook.setAudiobook_weight(Float.parseFloat(configService.getConfigPair("audiobook_weight")));
		bestBook.setElearning_weight(Float.parseFloat(configService.getConfigPair("elearning_weight")));
		
		int count = service.getBookListCnt(bestBook);
		service.setPaging(model, count, bestBook);
		List<BestBook> bookList = service.getBookList(bestBook);
		
		model.addAttribute("bestBook", bestBook);
		model.addAttribute("obj", bestBook);
		model.addAttribute("bookListCnt", count);
		model.addAttribute("bookList", bookList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(bestBook.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(bestBook.getType())));
		model.addAttribute("bestBookList", service.getBestBookListCms(bestBook));
		
		return basePath + "main_index";
	}
	
	@RequestMapping(value = {"/category_index.*"})
	public String category_index(Model model, BestBook book, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		book.setHomepage_id(getAsideHomepageId(request));
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE")) {
			book.setSortField("lend_total");
			book.setSortType("DESC");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		if(book.getParent_id() == 0) {
			book.setParent_id(1);
		}
		
		book.setOption("CATEGORYBESTBOOK");
		
		int count = bookService.getBookListCntCms(book);
		service.setPaging(model, count, book);
		List<Book> bookList = bookService.getBookListCms(book);
		
		model.addAttribute("book", book);
		model.addAttribute("obj", book);
		model.addAttribute("bookListCnt", count);
		model.addAttribute("bookList", bookList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(book.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(book.getType())));
		model.addAttribute("bestBookList", service.getCategoryBestBookList(book));
		
		
		return basePath + "category_index";
	}
	
	@RequestMapping(value = {"/save.*"})
	public @ResponseBody JsonResponse save(Model model, BestBook book, BindingResult result, HttpServletRequest request) {
		book.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);
		String editMode = book.getEditMode();
		int ret = 0;
		
		if(!book.getEditMode().equals("DELETE")) {
			
		}
		
		if(!result.hasErrors()) {
			book.setMember_id(getSessionMemberId(request));
			
			if(editMode.equals("ADDBESTBOOK")) {
				book.setAdd_id(getSessionMemberId(request));
				service.addBestBook(book);
				res.setValid(true);
			}
			else if(editMode.equals("DELETEBESTBOOK")) {
				service.deleteBestBook(book);
				res.setValid(true);
			}
			else if(editMode.equals("ADDCATBESTBOOK")) {
				book.setAdd_id(getSessionMemberId(request));
				ret = service.addCategoryBestBook(book);
				if(ret == -1) {
					res.setValid(false);
					res.setMessage("이미 등록되어 있습니다");
				} else {
					res.setValid(true);
					res.setMessage("등록되었습니다.");
				}
			}
			else if(editMode.equals("DELETECATBESTBOOK")) {
				service.deleteCategoryBestBook(book);
				res.setValid(true);
				res.setMessage("제외되었습니다.");
			}
			else if(editMode.equals("RAISEBESTBOOK")) {
				service.raiseBestBook(book);
				res.setValid(true);
			}
			else if(editMode.equals("LOWERBESTBOOK")) {
				service.lowerBestBook(book);
				res.setValid(true);
			}
			else if(editMode.equals("RAISECATBESTBOOK")) {
				service.raiseCategoryBestBook(book);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
			else if(editMode.equals("LOWERCATBESTBOOK")) {
				service.lowerCategoryBestBook(book);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
			else if(editMode.equals("MODIFYCONFIG")) {
				book.setMod_id(getSessionMemberId(request));
				book.setAdd_id(request.getRemoteAddr());
				service.modifyConfig(book);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
}
