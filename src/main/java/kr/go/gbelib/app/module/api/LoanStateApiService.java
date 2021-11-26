package kr.go.gbelib.app.module.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.api.ApiLog;
import kr.go.gbelib.app.cms.module.api.ApiLogService;
import kr.go.gbelib.app.cms.module.newelib.book.Book;
import kr.go.gbelib.app.cms.module.newelib.book.BookService;
import kr.go.gbelib.app.cms.module.newelib.config.Config;
import kr.go.gbelib.app.cms.module.newelib.config.ConfigService;

@Service
public class LoanStateApiService extends BaseService {
	
	@Autowired
	private ApiLogService apiLogService;

	@Autowired
	private BookService BookService;
	
	@Autowired
	private ConfigService configService;
	
	/**
	 * @param book
	 * @param request
	 * @param response
	 * @param userKey
	 * @param orderOption
	 * @param currentCount
	 * @param pageCount
	 * @param comCode
	 * @return
	 */
	public Map<String, Object> getData(Book book, HttpServletRequest request, HttpServletResponse response,String userKey,String orderOption,String currentCount,String pageCount,String comCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		Book book1 = new Book();
		book1.setMember_id(userKey);
		book1.setCom_code(comCode);
		book1.setOrderOption(orderOption);
		
		if(StringUtils.isEmpty(userKey)) {
			map.put("ResultMessage", "ERROR [userKey가 없습니다.]");
			map.put("ResultCode", "N");
		}

		if(!StringUtils.isEmpty(currentCount)) {
			boolean isNumeric = currentCount.matches("[+-]?\\d*(\\.\\d+)?");
			if(isNumeric) {
				book.setStartPageNum(Integer.parseInt(currentCount));
			}else {
				map.put("ResultMessage", "ERROR [currentCount에는 숫자만 입력하세요.]");
				map.put("ResultCode", "N");
			}
		}
		
		if(!StringUtils.isEmpty(pageCount)) {
			boolean isNumeric = currentCount.matches("[+-]?\\d*(\\.\\d+)?");
			if(isNumeric) {
				book.setListPageCount(Integer.parseInt(pageCount));
			}else {
				map.put("ResultMessage", "ERROR [pageCount에는 숫자만 입력하세요.]");
				map.put("ResultCode", "N");
			}
		}
		
		book1.setTotalDataCount(BookService.getBookListCnt(book1));
		List<Book> bookList = BookService.getLendingBookListState(book1);
		List<Map<String, Object>> bookMapList = new ArrayList<Map<String, Object>>();
		
		Config config = configService.getConfig();
		if(bookList != null && config.getMax_extention() == 0) {
			for(int i = 0; i < bookList.size(); i++) {
				bookList.get(i).setLoanExtendsAvailableYn("N");
				bookList.get(i).setLoanExtendsAbleReason("대출정책상 반납연장 불가합니다.");
			}
		}else {
			for(int i = 0; i < bookList.size(); i++) {
				bookList.get(i).setLoanExtendsAvailableYn("Y");
			}
		}
		for(Book obj: bookList) {
			bookMapList.add(toMap(obj));
		}
		
		map.put("ResultCode", "Y");
		map.put("ResultMessage","OK");
		map.put("TotalCount", bookMapList.size());
		map.put("TotalPage", "1");
		map.put("ContentDataList", bookMapList);
		
		apiLogService.addApiLog(new ApiLog("LoanState", "0", "", makeParamUrl(book), request.getRemoteAddr()));
		
		return map;
	}
	
	public Map<String, Object> toMap(Book book) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("ContentKey", defaultString(book.getBook_code()));
		map.put("UserKey", defaultString(book.getMember_id()));
		map.put("ContentTitle", defaultString(book.getBook_name()));
		map.put("LoanKey", book.getLend_idx());
		map.put("LoanDate", defaultString(book.getLend_dt()));
		map.put("ReturnPlanDate", defaultString(book.getReturn_due_dt()));
		map.put("LendingIdx", book.getLend_idx());
		map.put("ContentAuthor", defaultString(book.getAuthor_name()));
		map.put("ContentPublisher", defaultString(book.getBook_pubname()));
		map.put("ContentPubDate", defaultString(book.getBook_pubdt()));
		map.put("OwnerCodeDesc", defaultString(book.getCom_code()));
		map.put("OwnerCode", defaultString(book.getCom_code()));
		map.put("LibraryUserNo", defaultString(book.getMember_id()));
		map.put("LibraryCode", defaultString(book.getLibrary_code()));
		map.put("ContentType", defaultString(book.getType()));
		map.put("ContentInfo", defaultString(book.getBook_info().replaceAll("\\n", "<br/>")));
		map.put("ContentCoverUrl", makeURL(defaultString(book.getBook_image())));
		map.put("ContentCoverUrlM", makeURL(defaultString(book.getBook_image())));
		map.put("ContentCoverUrlS", makeURL(defaultString(book.getBook_image())));
		map.put("LoanExtendsAvailableYn", defaultString(book.getLoanExtendsAvailableYn()));
		map.put("LoanExtendsAbleReason", defaultString(book.getLoanExtendsAbleReason()));
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
