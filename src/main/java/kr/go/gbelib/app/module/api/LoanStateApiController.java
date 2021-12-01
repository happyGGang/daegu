package kr.go.gbelib.app.module.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.elib.book.Book;

@Controller
@RequestMapping(value = {"/api/"})
public class LoanStateApiController extends BaseController {

	
	@Autowired
	private LoanStateApiService loanStateApiService;
	
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
	@RequestMapping(value = {"/LoanState.*"})
	public @ResponseBody Map<String, Object> index(Book book,HttpServletRequest request, HttpServletResponse response ,@RequestParam(value="userKey", required=true) String userKey, @RequestParam(value="orderOption", required=false) String orderOption, @RequestParam(value="currentCount", required=false) String currentCount, @RequestParam(value="pageCount", required=false) String pageCount, @RequestParam(value="comCode", required=false) String comCode) {
		
		return loanStateApiService.getData(book, request, response,userKey,orderOption,currentCount,pageCount,comCode);
	}
	
	/*
	 * @RequestMapping(value = {"/LoanState.*"}, method = RequestMethod.GET) public
	 * String LoanState(Model model, @RequestParam(value="userKey", required=false)
	 * String userKey, @RequestParam(value="orderOption", required=false) String
	 * orderOption, @RequestParam(value="currentCount", required=false) String
	 * currentCount, @RequestParam(value="pageCount", required=false) String
	 * pageCount, @RequestParam(value="comCode", required=false) String comCode,
	 * HttpServletRequest request) { if(StringUtils.isEmpty(userKey)) {
	 * model.addAttribute("ResultMessage", "ERROR [userKey가 없습니다.]");
	 * model.addAttribute("ResultCode", "N"); }
	 * 
	 * Book book = new Book(); book.setMember_id(userKey);
	 * book.setCom_code(comCode); book.setOrderOption(orderOption);
	 * 
	 * if(!StringUtils.isEmpty(currentCount)) { boolean isNumeric =
	 * currentCount.matches("[+-]?\\d*(\\.\\d+)?"); if(isNumeric) {
	 * book.setStartPageNum(Integer.parseInt(currentCount)); }else {
	 * model.addAttribute("ResultMessage", "ERROR [currentCount에는 숫자만 입력하세요.]");
	 * model.addAttribute("ResultCode", "N"); } }
	 * 
	 * if(!StringUtils.isEmpty(pageCount)) { boolean isNumeric =
	 * currentCount.matches("[+-]?\\d*(\\.\\d+)?"); if(isNumeric) {
	 * book.setListPageCount(Integer.parseInt(pageCount)); }else {
	 * model.addAttribute("ResultMessage", "ERROR [pageCount에는 숫자만 입력하세요.]");
	 * model.addAttribute("ResultCode", "N"); } }
	 * 
	 * Config config = configService.getConfig(); List<Book> lendingBookListState =
	 * bookService.getLendingBookListState(book); if(lendingBookListState != null &&
	 * config.getMax_extention() == 0) { for(int i = 0; i <
	 * lendingBookListState.size(); i++) {
	 * lendingBookListState.get(i).setLoanExtendsAvailableYn("N");
	 * lendingBookListState.get(i).setLoanExtendsAbleReason("대출정책상 반납연장 불가합니다."); }
	 * }else { for(int i = 0; i < lendingBookListState.size(); i++) {
	 * lendingBookListState.get(i).setLoanExtendsAvailableYn("Y"); } }
	 * 
	 * model.addAttribute("lendingBookListState", lendingBookListState);
	 * model.addAttribute("ResultMessage", "OK"); model.addAttribute("ResultCode",
	 * "Y"); model.addAttribute("TotalCount", lendingBookListState.size());
	 * 
	 * return basePath + "LoanState"; }
	 */
	
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
