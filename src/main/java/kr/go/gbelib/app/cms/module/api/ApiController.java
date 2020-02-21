package kr.go.gbelib.app.cms.module.api;

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

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;

@Controller
@RequestMapping(value = {"/api/"})
public class ApiController extends BaseController {

	@Autowired
	private ElibApiService elibApiService;
	
	@Autowired
	private BoardApiService boardApiService;
	
	@Autowired
	private SSOApiService ssoApiService;
	
	@Autowired
	private ElibApiService2 elibApiService2;
	
	@Autowired
	private ElibLoginApiService elibLoginApiService;
	
	private static final String LOGIN_PAGE = "/elib/intro/login/index.do?menu_idx=43";
	
	@RequestMapping(value = {"/board.*"})
	public @ResponseBody Map<String, Object> index(Board board, HttpServletRequest request, HttpServletResponse response) {
		return boardApiService.getData(board, request, response);
	}
	
	@RequestMapping(value = {"/elib.*"})
	public @ResponseBody Map<String, Object> index(Book book, HttpServletRequest request, HttpServletResponse response) {
		return elibApiService.getData(book, request, response);
	}
	
	/**
	 * 전자도서관 공급사 앱에서 대출, 반납 등 API 호출 시
	 * @param lending
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/elib2.*"})
	public @ResponseBody ElibXmlResult index(Lending lending, HttpServletRequest request, HttpServletResponse response) {
		return elibApiService2.doApi(lending, request, response);
	}
	
	@RequestMapping(value = {"elib_login.*"})
	public @ResponseBody ElibLoginXmlResult index(@RequestParam(required=false, defaultValue="elib_login_api") String login_uid, @RequestParam(required=false, defaultValue="elib_login_api") String login_pwd, HttpServletRequest request, HttpServletResponse response) {
		return elibLoginApiService.doApi(login_uid, login_pwd, request, response);
	}
	
	@RequestMapping(value = {"/sso.*"})
	public String index(SSO sso, HttpServletRequest request, HttpServletResponse response) {
		try {
			return ssoApiService.getData(sso, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:" + LOGIN_PAGE;
		}
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
