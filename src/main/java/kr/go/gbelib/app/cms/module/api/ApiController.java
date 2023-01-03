package kr.go.gbelib.app.cms.module.api;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLib;
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLibService;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibrary;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibraryService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.student.Student;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
	private TeachApiService teachApiService;
	
	@Autowired
	private ElibLoginApiService elibLoginApiService;

	@Autowired
	private UntackBookApiService untackBookApiService;
	
	@Autowired
	private NearbyLibService neigborhoodLibraryService;
	
//	@Autowired
//	private NearbyLibService neabyLibService;

	private static final String LOGIN_PAGE = "/elib/intro/login/index.do?menu_idx=43";
	
	@RequestMapping(value = {"/board.*"})
	public @ResponseBody Map<String, Object> index(Board board, HttpServletRequest request, HttpServletResponse response) {
		return boardApiService.getData(board, request, response);
	}
	
	@RequestMapping(value = {"/elib.*"})
	public @ResponseBody Map<String, Object> index(Book book, HttpServletRequest request, HttpServletResponse response) {
		return elibApiService.getData(book, request, response);
	}
	
	@RequestMapping(value = {"/teach.*"})
	public @ResponseBody Map<String, Object> index(Teach teach,HttpServletRequest request, HttpServletResponse response) {
		return teachApiService.getData(teach, request, response);
	}
	
	@RequestMapping(value = {"/student.*"})
	public @ResponseBody Map<String, Object> student(Student student,HttpServletRequest request, HttpServletResponse response) {
		return teachApiService.getData2(student, request, response);
	}

	@RequestMapping(value = {"/lockerPasswordCheck.*"})
	public @ResponseBody Map<String, Object> lockerPasswordCheck(UntactBookReservation untactBookReservation, HttpServletRequest request, HttpServletResponse response) {
		return untackBookApiService.getData(untactBookReservation, request, response);
	}

	@RequestMapping(value = {"/changeUntactBookLoanStatus.*"})
	public @ResponseBody Map<String, Object> changeUntactBookLoanStatus(UntactBookReservation untactBookReservation, HttpServletRequest request, HttpServletResponse response) {
		return untackBookApiService.getData2(untactBookReservation, request, response);
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
	
	@RequestMapping(value = {"bookImage.*"})
	public @ResponseBody Map<String, Object> bookImage(Book book, HttpServletRequest request, HttpServletResponse response) {
		return untackBookApiService.getImage(book , request, response);
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
	
	@RequestMapping(value = {"nearLib/edit.*"})
	public @ResponseBody Map<String, Object> neighborhoodLibraryEdit(NearbyLib neighborhoodLibrary, HttpServletRequest request, HttpServletResponse response) {
		return neigborhoodLibraryService.updateNearbyLibApi(neighborhoodLibrary);
	}
	
	@RequestMapping(value = {"nearLibCheck/edit.*"})
	public @ResponseBody Map<String, Object> neighborhoodLibraryCheckLocker(@RequestParam(required = false)String pass, HttpServletRequest request, HttpServletResponse response) {
		NearbyLib neighborhoodLibrary = new NearbyLib();
		neighborhoodLibrary.setDevice_password(Integer.parseInt(String.valueOf(pass).substring(0, 4)));
		neighborhoodLibrary.setLocker_idx(Integer.parseInt(String.valueOf(pass).substring(4, 7)));
		neighborhoodLibrary.setDevice_idx(Integer.parseInt(String.valueOf(pass).substring(7)));
		
		return neigborhoodLibraryService.checkReserveLocker(neighborhoodLibrary);
	}
	
	@RequestMapping(value = {"nearLib/return.*"})
	public @ResponseBody Map<String, Object> neighborhoodLibraryReturn(NearbyLib neighborhoodLibrary, HttpServletRequest request, HttpServletResponse response) {
	
		return neigborhoodLibraryService.returnReserveBook(neighborhoodLibrary);
	}
	
	@RequestMapping(value = {"nearLib/expire.*"})
	public @ResponseBody Map<String, Object> neighborhoodLibraryexpire(NearbyLib nearbyLib, HttpServletRequest request, HttpServletResponse response) {
	
		return neigborhoodLibraryService.expireReserveBook(nearbyLib);
	}
	
	@RequestMapping(value = {"nearLib/returnYn.*"})
	public @ResponseBody Map<String, Object> neighborhoodLibraryReturnYn(NearbyLib nearbyLib, HttpServletRequest request, HttpServletResponse response) {
	
		return neigborhoodLibraryService.returnYnReserveBook(nearbyLib);
	}
	
//	@RequestMapping(value = {"nearbyLib/edit.*"})
//	public @ResponseBody Map<String, Object> nearbyLibEdit(NearbyLib neighborhoodLibrary, HttpServletRequest request, HttpServletResponse response) {
//		return neabyLibService.updateNearbyLibApi(neighborhoodLibrary);
//	}
	
//	@RequestMapping(value = {"nearbyLibCheck/edit.*"})
//	public @ResponseBody Map<String, Object> nearbyLibCheckLocker(@RequestParam(required = false)String pass, HttpServletRequest request, HttpServletResponse response) {
//		NearbyLib neighborhoodLibrary = new NearbyLib();
//		neighborhoodLibrary.setDevice_password(Integer.parseInt(String.valueOf(pass).substring(0, 4)));
//		neighborhoodLibrary.setLocker_idx(Integer.parseInt(String.valueOf(pass).substring(4, 7)));
//		neighborhoodLibrary.setDevice_idx(Integer.parseInt(String.valueOf(pass).substring(7)));
//		
//		return neabyLibService.checkReserveLocker(neighborhoodLibrary);
//	}
	
}
