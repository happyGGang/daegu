package kr.go.gbelib.app.cms.module.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.book.BookService;

@Service
public class ElibApiService extends BaseService {
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ApiLogService apiLogService;
	
	public Map<String, Object> getData(Book book, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String menu = book.getMenu();
		Book book1 = new Book();
		book1.setType(book.getType());
		book1.setRowCount(book.getRowCount());
		book1.setViewPage(book.getViewPage());
		
		if("BEST".equals(menu)) {
			book1.setSortField("BOOK_LEND");
			book1.setSortType("DESC");
		} else if("NEW".equals(menu)) {
			book1.setSortField("BOOK_REGDT");
			book1.setSortType("DESC");
		} else {
			String errmsg = "잘못된 menu 파라미터";
			apiLogService.addApiLog(new ApiLog("ELIB", "-1", errmsg, makeParamUrl(book), request.getRemoteAddr()));
			return ApiController.error("-1", errmsg);
		}
		
		book1.setTotalDataCount(bookService.getBookListCnt(book1));
		List<Book> bookList = bookService.getBookList(book1);
		List<Map<String, Object>> bookMapList = new ArrayList<Map<String, Object>>();
		
		for(Book obj: bookList) {
			bookMapList.add(toMap(obj));
		}
		
		map.put("code", "1");
		map.put("msg", "");
		map.put("menu", menu);
		map.put("type", book1.getType());
		map.put("rowCount", book1.getRowCount());
		map.put("viewPage", book1.getViewPage());
		map.put("totalDataCount", book1.getTotalDataCount());
		map.put("totalPageCount", book1.getTotalPageCount());
		map.put("data", bookMapList);
		
		apiLogService.addApiLog(new ApiLog("ELIB", "0", "", makeParamUrl(book), request.getRemoteAddr()));
		
		return map;
	}
	
	public Map<String, Object> toMap(Book book) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("book_idx", book.getBook_idx());
		map.put("book_code", defaultString(book.getBook_code()));
		map.put("cate_name", defaultString(book.getCate_name()));
		map.put("book_name", defaultString(book.getBook_name()));
		map.put("author_name", defaultString(book.getAuthor_name()));
		map.put("book_pubname", defaultString(book.getBook_pubname()));
		map.put("keyword", "");
		map.put("isbn13", defaultString(book.getIsbn13()));
//		map.put("book_lend", book.getBook_lend());
		map.put("lend_total", book.getLend_total());
		map.put("max_lend", book.getMax_lend());
//		map.put("book_reserve", book.getBook_reserve());
		map.put("book_pubdt", defaultString(book.getBook_pubdt()));
		map.put("smart_use", "Y");
		map.put("tablet_use", "Q");
		map.put("device", defaultString(book.getDevice()));
		map.put("type", defaultString(book.getType()));
		map.put("format", defaultString(book.getFormat()));
		map.put("book_image", makeURL(defaultString(book.getBook_image())));
		map.put("recommend_cnt", book.getRecommend_cnt());
		map.put("library_name", defaultString(book.getLibrary_name()));
		map.put("parent_name", defaultString(book.getParent_name()));
		map.put("url", String.format("https://www.gbelib.kr/elib/module/elib/book/view.do?menu_idx=17&book_idx=%s", book.getBook_idx()));
		
		return map;
	}
	
	private String defaultString(String s) {
		if(s == null) return "";
		else return s;
	}
	
	private String makeURL(String s) {
		if(s.startsWith("http")) {
			return s;
		} else {
			return "https://www.gbelib.kr" + s;
		}
	}
	
	private String makeParamUrl(Book book) {
		StringBuilder sb = new StringBuilder();
		
		sb.append("menu=" + book.getMenu());
		sb.append("&type=" + book.getType());
		sb.append("&rowCount=" + book.getRowCount());
		sb.append("&viewPage=" + book.getViewPage());
		
		return sb.toString();
	}
	
}
