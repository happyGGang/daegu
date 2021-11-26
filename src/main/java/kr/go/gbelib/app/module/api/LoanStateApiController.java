package kr.go.gbelib.app.module.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.newelib.book.Book;
import kr.go.gbelib.app.cms.module.newelib.config.ConfigService;
import kr.go.gbelib.app.cms.module.newelib.lending.Lending;
import kr.go.gbelib.app.cms.module.teach.Teach;

@Controller
@RequestMapping(value = {"/api/"})
public class LoanStateApiController extends BaseController {

	
	@Autowired
	private LoanStateApiService loanStateApiService;
	
	@RequestMapping(value = {"/LoanState.*"})
	public @ResponseBody Map<String, Object> index(Book book,HttpServletRequest request, HttpServletResponse response) {
		return loanStateApiService.getData(book, request, response);
	}
	
	public static Map<String, Object> modeError() {
		return error("-1", "잘못된 유형입니다.");
	}
	
	public static Map<String, Object> error(String code, String msg) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("code", code);
		map.put("msg", msg);
		map.put("rowCount", 0);
		map.put("viewPage", 0);
		map.put("totalDataCount", 0);
		map.put("totalPageCount", 0);
		map.put("data", new ArrayList<Map<String, Object>>());
		
		return map;
	}

}
