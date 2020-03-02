package kr.go.gbelib.app.module.bookExpress;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.bookReview.BookReview;
import kr.go.gbelib.app.cms.module.portalMember.PortalMember;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.module.bookReview.BookReviewView;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/bookExpress"})
public class BookExpressController extends BaseController {
	
	private String basePath = "/homepage/%s/module/bookExpress/";
	
	@Autowired
	private BookExpressService service;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BookExpress bookExpress, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		PortalMember loginPortal = sessionLoginPortal(request);
		
		if (loginPortal == null) {
			bookExpress.setBefore_url(String.format("/%s/module/bookExpress/index.do?menu_idx=%s", homepage.getContext_path(), bookExpress.getMenu_idx()));
    		service.alertMessageAndUrl("대표도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/portalMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookExpress.getMenu_idx(), bookExpress.getBefore_url()), request, response);
    		return null;
        }
		
		bookExpress.setAgency_id(loginPortal.getAgency_id());
		service.setPaging(model, service.getInterestBookCount(bookExpress), bookExpress);

		model.addAttribute("bookExpress", bookExpress);
		model.addAttribute("interestBookList", service.getInterestBookList(bookExpress));

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/list.*"}, method = RequestMethod.GET)
	public String list(Model model, BookExpress bookExpress, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		PortalMember loginPortal = sessionLoginPortal(request);
		
		if (loginPortal == null) {
			bookExpress.setBefore_url(String.format("/%s/module/bookExpress/list.do?menu_idx=%s", homepage.getContext_path(), bookExpress.getMenu_idx()));
    		service.alertMessageAndUrl("대표도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/portalMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookExpress.getMenu_idx(), bookExpress.getBefore_url()), request, response);
    		return null;
        }
		
		
		if (loginPortal.getAuth_group().equals("2")) {
			bookExpress.setLibrary_code(loginPortal.getLibrary_code());
		} else if(loginPortal.getAuth_group().equals("3")) {
			bookExpress.setAgency_id(loginPortal.getAgency_id());
		}
		
		service.setPaging(model, service.getBookExpressCount(bookExpress), bookExpress);
		
		model.addAttribute("bookExpress", bookExpress);
		model.addAttribute("homepageList", homepageService.getNormalHomepage());
		model.addAttribute("bookExpressList", service.getBookExpressList(bookExpress));
		model.addAttribute("statusCount", service.getStatusCount(bookExpress));

		return String.format(basePath, homepage.getFolder()) + "list";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookExpress bookExpress, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */
		
		PortalMember loginPortal = sessionLoginPortal(request);
		bookExpress.setAgency_name(loginPortal.getAgency_name());
		bookExpress.setAgency_id(loginPortal.getAgency_id());
		
		if (!result.hasErrors()) {
			if (bookExpress.getEditMode().equals("ADD")) {
				res.setValid(true);
				res.setMessage("");
			} else if (bookExpress.getEditMode().equals("MODIFY")) {
				bookExpress.setModify_id(loginPortal.getAgency_id());
				bookExpress.setRequest_status("1");
				service.modifyBookExpress(bookExpress);
				res.setValid(true);
				res.setMessage("선택 신청되었습니다.");
			} else if(bookExpress.getEditMode().equals("INTEREST")) {
				if(service.interestBookCheck(bookExpress) > 0) {
					res.setValid(false);
					res.setMessage("관심도서 추가된 도서입니다.");
					return res;
				}
				bookExpress.setAdd_id(loginPortal.getAgency_id());
				service.addInterestBook(bookExpress);
				res.setValid(true);
				res.setMessage("택배서비스 관심도서 추가되었습니다.");
			} else if(bookExpress.getEditMode().equals("STATUS")) {
				bookExpress.setModify_id(loginPortal.getAgency_id());
				service.modifyBookExpress(bookExpress);
				int status = Integer.parseInt(bookExpress.getRequest_status());
				String msg = "";
				
				switch (status) {
					case 2 :
						msg = "도서택배 신청이 처리중입니다.";
						break;
					case 3 :
						msg = "도서택배 신청이 처리불가 되었습니다.";
						break;
					case 4 :
						msg = "도서택배 신청이 보류되었습니다.";
						break;
					case 5 :
						msg = "신청된 도서가 택배발송 되었습니다.";
						break;
					case 6 :
						msg = "택배 서비스된 도서가 반납처리 되었습니다.";
						break;
				}
				
				res.setValid(true);
				res.setMessage(msg);
			} else if(bookExpress.getEditMode().equals("REASON")) {
				service.setReason(bookExpress);
				res.setValid(true);
				res.setMessage("사유불가 등록되었습니다.");
			} else if(bookExpress.getEditMode().equals("REQUEST")) {
				service.setRequestExpress(bookExpress);
				res.setValid(true);
				res.setMessage("신청자 정보 등록 되었습니다.");
			} else if(bookExpress.getEditMode().equals("DELETE_CHECK")) {
				service.deleteCheckBookExpress(bookExpress);
				res.setValid(true);
				res.setMessage("선택 삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public BookExpressView excel(Model model, BookExpress bookExpress, HttpServletRequest request, HttpServletResponse response) throws Exception {
		PortalMember loginPortal = sessionLoginPortal(request);
		
		if (loginPortal.getAuth_group().equals("2")) {
			bookExpress.setLibrary_code(loginPortal.getLibrary_code());
		} else if(loginPortal.getAuth_group().equals("3")) {
			bookExpress.setAgency_id(loginPortal.getAgency_id());
		}
		
		model.addAttribute("bookExpressXls", service.getBookExpressXls(bookExpress));

		return new BookExpressView();
	}
	
	@RequestMapping(value= {"/mysqlToTibero"})
	public void mysqlToTibero(Model model, BookExpress bookExpress, HttpServletRequest request) {
		
		List<Map<String, Object>> mapList = service.getBookExpressMySQL();
		for (Map<String, Object> map : mapList) {
			BookExpress be = new BookExpress();
			
			be.setBook_express_idx(Integer.parseInt(String.valueOf(map.get("be_num"))));
			String be_lib_id = String.valueOf(map.get("be_lib_id"));
			
			String lib_code = "";
			if(be_lib_id.equals("7240043")) { // 중앙도서관
				lib_code = "122004";
			} else if(be_lib_id.equals("7240044")) { // 두류도서관
				lib_code = "122002";
			} else if(be_lib_id.equals("7240045")) { // 북부도서관
				lib_code = "122003";
			} else if(be_lib_id.equals("7240047")) { // 228기념
				lib_code = "122001";
			} else if(be_lib_id.equals("7240048")) { // 서부도서관
				lib_code = "122008";
			} else if(be_lib_id.equals("7240049")) { // 동부도서관
				lib_code = "122010";
			} else if(be_lib_id.equals("7240050")) { // 남부도서관
				lib_code = "122009";
			} else if(be_lib_id.equals("7240051")) { // 달성도서관
				lib_code = "122011";
			} else if(be_lib_id.equals("7240278")) { // 수성도서관
				lib_code = "122007";
			} else {
				lib_code = "0";
			}
			be.setLibrary_code(lib_code);
			
			be.setAgency_name(String.valueOf(map.get("be_m_name")));
			String be_m_id = String.valueOf(map.get("be_m_id"));
			be.setAgency_id(be_m_id);
			be.setBook_reg_no(String.valueOf(map.get("be_book_regno")));
			be.setBook_call_no(String.valueOf(map.get("be_book_callno")));
			be.setBook_name(String.valueOf(map.get("be_book_title")));
			be.setThumb_image(String.valueOf(map.get("be_book_image")));
			be.setRequest_status(String.valueOf(map.get("be_status")));
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				String request_date = String.valueOf(map.get("be_request_date"));
				if(request_date != null && request_date != "null") {
					be.setRequest_date(sdf.parse(request_date));
				}
				
				be.setAdd_date(sdf.parse(String.valueOf(map.get("be_write_date"))));
				String modify_date = String.valueOf(map.get("be_modi_date"));
				if(modify_date != null && modify_date != "null") {
					be.setModify_date(sdf.parse(modify_date));
					be.setModify_id(be_m_id);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			be.setRequest_name(String.valueOf(map.get("be_worker")));
			be.setRequest_phone(String.valueOf(map.get("be_worker_phone")));
			be.setReason(String.valueOf(map.get("be_comment")));
			be.setAdd_id(be_m_id);
			
			service.addMyGration(be);
		}
	}

}
