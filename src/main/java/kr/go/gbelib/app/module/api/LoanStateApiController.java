package kr.go.gbelib.app.module.api;

import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.newelib.book.Book;
import kr.go.gbelib.app.cms.module.newelib.book.BookService;
import kr.go.gbelib.app.cms.module.newelib.config.Config;
import kr.go.gbelib.app.cms.module.newelib.config.ConfigService;
import kr.go.gbelib.app.cms.module.newelib.lending.LendingService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = {"/api/"})
public class LoanStateApiController extends BaseController {

	private String basePath = "/app/api/";
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ConfigService configService;

	@RequestMapping(value = {"/LoanState.*"}, method = RequestMethod.GET)
	public String LoanState(Model model, @RequestParam(value="userKey", required=false) String userKey, @RequestParam(value="orderOption", required=false) String orderOption, @RequestParam(value="currentCount", required=false) String currentCount, @RequestParam(value="pageCount", required=false) String pageCount, @RequestParam(value="comCode", required=false) String comCode, HttpServletRequest request) {
		if(StringUtils.isEmpty(userKey)) {
			model.addAttribute("ResultMessage", "ERROR [userKey가 없습니다.]");
			model.addAttribute("ResultCode", "N");
		}
		
		Book book = new Book();
		book.setMember_id(userKey);
		book.setCom_code(comCode);
		book.setOrderOption(orderOption);

		if(!StringUtils.isEmpty(currentCount)) {
			boolean isNumeric = currentCount.matches("[+-]?\\d*(\\.\\d+)?");
			if(isNumeric) {
				book.setStartPageNum(Integer.parseInt(currentCount));
			}else {
				model.addAttribute("ResultMessage", "ERROR [currentCount에는 숫자만 입력하세요.]");
				model.addAttribute("ResultCode", "N");
			}
		}
		
		if(!StringUtils.isEmpty(pageCount)) {
			boolean isNumeric = currentCount.matches("[+-]?\\d*(\\.\\d+)?");
			if(isNumeric) {
				book.setListPageCount(Integer.parseInt(pageCount));
			}else {
				model.addAttribute("ResultMessage", "ERROR [pageCount에는 숫자만 입력하세요.]");
				model.addAttribute("ResultCode", "N");
			}
		}
		
		Config config = configService.getConfig();
		List<Book> lendingBookListState = bookService.getLendingBookListState(book);
		if(lendingBookListState != null && config.getMax_extention() == 0) {
			for(int i = 0; i < lendingBookListState.size(); i++) {
				lendingBookListState.get(i).setLoanExtendsAvailableYn("N");
				lendingBookListState.get(i).setLoanExtendsAbleReason("대출정책상 반납연장 불가합니다.");
			}
		}else {
			for(int i = 0; i < lendingBookListState.size(); i++) {
				lendingBookListState.get(i).setLoanExtendsAvailableYn("Y");
			}
		}
		
		model.addAttribute("lendingBookListState", lendingBookListState);
		model.addAttribute("ResultMessage", "OK");
		model.addAttribute("ResultCode", "Y");
		model.addAttribute("TotalCount", lendingBookListState.size());

		return basePath + "LoanState";
	}

}
