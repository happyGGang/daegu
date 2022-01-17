package kr.go.gbelib.app.module.elib;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import is.tagomor.woothee.Classifier;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.BeanUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.elib.accessIp.ElibAccessIp;
import kr.go.gbelib.app.cms.module.elib.accessIp.ElibAccessIpService;
import kr.go.gbelib.app.cms.module.elib.api.APIService;
import kr.go.gbelib.app.cms.module.elib.api.ElibException;
import kr.go.gbelib.app.cms.module.elib.best.BestService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.book.BookService;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.elib.code.ElibCode;
import kr.go.gbelib.app.cms.module.elib.code.ElibCodeService;
import kr.go.gbelib.app.cms.module.elib.comment.Comment;
import kr.go.gbelib.app.cms.module.elib.comment.CommentService;
import kr.go.gbelib.app.cms.module.elib.config.Config;
import kr.go.gbelib.app.cms.module.elib.config.ConfigService;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;
import kr.go.gbelib.app.cms.module.elib.lending.LendingService;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;
import kr.go.gbelib.app.cms.module.elib.member.ElibMemberService;
import kr.go.gbelib.app.common.api.LibSearchAPI;

@Controller
@RequestMapping(value = {"/elib/module/elib"})
public class ElibController extends BaseController {

	private String basePath = "/homepage/%s/module/elib/";

	@Autowired
	private ElibCategoryService elibCategoryService;

	@Autowired
	private ElibCodeService elibCodeService;

	@Autowired
	private BookService bookService;

	@Autowired
	private LendingService lendingService;

	@Autowired
	private ConfigService configService;

	@Autowired
	private ElibMemberService elibMemberService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private ElibAccessIpService elibAccessIpService;

	@Autowired
	private BestService bestService;

	@Autowired
	private APIService apiService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private RecommendSiteService recommendSiteService;
	
	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	private String encodeURL(String url) {
		if(url == null) {
			return null;
		} else {
			try {
				return URLEncoder.encode(url, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				return url;
			}
		}
	}

	private Book withTypeLabels(Book book) {
		String type = book.getType();

		if("EBK".equals(type)) {
			book.setType_name("전자책");
		} else if("WEB".equals(type)) {
			book.setType_name("이러닝");
		} else if("ADO".equals(type)) {
			book.setType_name("오디오북");
		}

		return book;
	}

	private Book withLabels(Book book, List<ElibCategory> categoryList) {

		book = withTypeLabels(book);

		if(book.getParent_id() == 0 && categoryList.size() > 0) {
			book.setParent_id(categoryList.get(0).getCate_id());
		}

		int parent_id = book.getParent_id();

		for(ElibCategory cat: categoryList) {
			if(cat.getCate_id() == parent_id) {
				book.setParent_name(cat.getCate_name());
			}
		}

		return book;
	}

	private Book withLabels2(Book book	, List<ElibCode> compList) {

		book = withTypeLabels(book);

		if(compList != null && compList.size() > 0) {
			if(StringUtils.isEmpty(book.getCom_code())) {
				book.setCom_code(compList.get(0).getCom_code());
			}

			String com_code = book.getCom_code();

			for(ElibCode code: compList) {
				if(code.getCom_code().equals(com_code)) {
					book.setComp_name(code.getComp_name());
				}
			}
		}

		return book;
	}

	private Map<String, Book> bestBookListToMap(List<Book> bookList) {
		Map<String, Book> map = new HashMap<String, Book>();

		for(Book book: bookList) {
			map.put(String.valueOf(book.getPrint_seq()), book);
		}

		return map;
	}

	@RequestMapping(value = {"/book/index.*"})
	public String book_index(Model model, Book book, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		book.setHomepage_id(homepage.getHomepage_id());

		//		if(!checkLogin(request, response, bookService, book)) return null;

		if("TITLE".equals(book.getSortField())) book.setSortType("ASC");
		if(StringUtils.equals(book.getSortField(), "TITLE")) book.setSortField("book_name");

		setApporve_yn(book, request);

		Device device = DeviceUtils.getCurrentDevice(request);
		boolean isMobile = device.isMobile() || device.isTablet();
		model.addAttribute("isMobile", isMobile);

		String menu = book.getMenu();
		if("CATEGORY".equals(menu)) {
			ElibCategory elibCategory = new ElibCategory(book.getType(), 1);
			ElibCategory elibSubcategory = new ElibCategory(book.getType(), 2, book.getParent_id() == 0 ? 1: book.getParent_id());
			setApporve_yn(elibCategory, request);
			setApporve_yn(elibSubcategory, request);

			List<ElibCategory> categoryList = elibCategoryService.getCategoryWithCntList(elibCategory);
			List<ElibCategory> subcategoryList = elibCategoryService.getCategoryWithCntList(elibSubcategory);

			ElibCategory elibCategory2 = new ElibCategory();
			elibCategory2.setType(book.getType());
			elibCategory2.setCate_id(book.getCate_id() == 0 ? book.getParent_id(): book.getCate_id());

			model.addAttribute("category", elibCategoryService.getCategoryInfo(elibCategory2));
			model.addAttribute("categoryBestBookList", bestService.getCategoryBestBookList(book));
			model.addAttribute("categoryList", categoryList);
			model.addAttribute("subcategoryList", subcategoryList);
			model.addAttribute("book", withLabels(book, categoryList));
		} else if("PROVIDER".equals(menu)) {
			ElibCode elibCode = new ElibCode(book.getType());
			setApporve_yn(elibCode, request);
			List<ElibCode> compList = elibCodeService.getCompWithCntList(elibCode);

			model.addAttribute("compList", compList);
			model.addAttribute("book", withLabels2(book, compList));
		} else if("NEW".equals(menu)) {
			//			book.setSortField("BOOK_PUBDT");
			book.setSortType("DESC");
			model.addAttribute("book", book);
		} else if("BEST".equals(menu)) {
			//			book.setSortField("BOOK_LEND");
			book.setSortType("DESC");
			model.addAttribute("book", book);
		} else if("RECOMMEND".equals(menu)) {
			book.setSortField("RECOMMEND_CNT");
			book.setSortType("DESC");
			model.addAttribute("book", book);
		} else if("DEVICE".equals(menu)) {
			setApporve_yn(book, request);
			List<Book> deviceList = bookService.getBookCountByDevice(book);

			model.addAttribute("book", book);
			model.addAttribute("deviceList", deviceList);
		} else {
			model.addAttribute("book", book);
		}

		int count = bookService.getBookListCnt(book);
		bookService.setPaging(model, count, book);
		List<Book> bookList = bookService.getBookList(book);

		model.addAttribute("bookConfig", configService.getConfig());
		model.addAttribute("bookList", setStatus(bookList, request));
		model.addAttribute("bookListCnt", count);

		return String.format(basePath, homepage.getFolder()) + "book/index";
	}

	private boolean isLoggedIn(HttpServletRequest request) {
		if ( !(isLogin(request) || "HOMEPAGE".equals(getSessionMemberLoginType(request)))) {
			return false;
		} else {
			return true;
		}
	}



	private JsonResponse checkLogin(HttpServletRequest request, BindingResult result, JsonResponse res, BeanUtils bean) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			result.reject("로그인 후 이용가능합니다.");
			res.setValid(false);
			res.setMessage("로그인 후 이용가능합니다.");
			res.setUrl(String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bean.getMenu_idx(), encodeURL(bean.getBefore_url())));
			return res;
		}

		Member member = getSessionMemberInfo(request);
		String member_class = member.getMember_class();
		String user_class = member.getUser_class();

		if(StringUtils.equals(member_class, "2")) {
			res.setValid(false);
			res.setMessage("이용자님은 현재 미승인 회원입니다. 대구광역시 소속도서관에서 정회원으로 승인 받은 후 전자도서관을 이용 바랍니다");
			res.setUrl(String.format("/%s/index.do", homepage.getContext_path()));
			return res;
		}

		/**
		 * 대출중지 회원 체크 기능
		 *
		 if(StringUtils.equals(user_class, "1")) {
		 res.setValid(false);
		 res.setMessage("대출중지 상태입니다.");
		 res.setUrl(String.format("/%s/index.do", homepage.getContext_path()));
		 return res;
		 }
		 */

		res.setValid(true);

		return res;
	}

	private boolean checkCMSLogin(HttpServletRequest request, BindingResult result, JsonResponse res, BeanUtils bean) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"CMS".equals(getSessionMemberLoginType(request))) {
			result.reject("로그인 후 이용가능합니다.");
			res.setValid(false);
			res.setMessage("로그인 후 이용가능합니다.");
			res.setUrl(String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bean.getMenu_idx(), encodeURL(bean.getBefore_url())));
			return false;
		}

		return true;
	}

	private boolean checkLogin(HttpServletRequest request, HttpServletResponse response, BaseService service, BeanUtils bean) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			try {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bean.getMenu_idx(), encodeURL(bean.getBefore_url())), request, response);
			} catch(Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		Member member = getSessionMemberInfo(request);
		String member_class = member.getMember_class();
		String user_class = member.getUser_class();

		if(StringUtils.equals(member_class, "2")) {
			try {
				service.alertMessageAndUrl("이용자님은 현재 미승인 회원입니다. 부산광역시 소속도서관에서 정회원으로 승인 받은 후 전자도서관을 이용 바랍니다", String.format("/%s/index.do", homepage.getContext_path()), request, response);
			} catch(Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		/**
		 * 대출중지 회원 체크 기능
		 *
		 if(StringUtils.equals(user_class, "1")) {
		 try {
		 service.alertMessageAndUrl("대출중지 상태입니다.", String.format("/%s/index.do", homepage.getContext_path()), request, response);
		 } catch(Exception e) {
		 e.printStackTrace();
		 }
		 return false;
		 }
		 */

		return true;
	}

	private int addMemberIfNotExists(HttpServletRequest request, Book book) throws ElibException {
		return elibMemberService.addMemberIfNotExists(new ElibMember(getSessionMemberInfo(request)), book);
	}

	private int addMemberIfNotExistsLocal(HttpServletRequest request) throws ElibException {
		return elibMemberService.addMemberIfNotExistsLocal(new ElibMember(getSessionMemberInfo(request)));
	}

	@RequestMapping(value = {"/book/save.*"})
	public @ResponseBody JsonResponse book_save(Model model, Book book,  BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		book.setHomepage_id(homepage.getHomepage_id());

		JsonResponse res = new JsonResponse(request);
		String editMode = book.getEditMode();
		int ret = 0;

		Book book1 = bookService.getBookInfo(new Book(book.getBook_idx()));
		book1.setMenu_idx(book.getMenu_idx());
		book1.setBefore_url(String.format("/%s/module/elib/book/index.do?menu_idx=%s", homepage.getContext_path(), book.getMenu_idx()));
		res = checkLogin(request, result, res, book1);
		if(!res.isValid()) return res;

		if(!book.getEditMode().equals("DELETE")) {

		}

		if(!result.hasErrors()) {
			try {
				addMemberIfNotExistsLocal(request);
			} catch (ElibException e) {
				res.setValid(false);
				res.setMessage(e.getMessage());
				return res;
			}
			book.setMember_id(getSessionMemberId(request));

			if(elibAccessIpService.getBannedIpCnt(new ElibAccessIp(request.getRemoteAddr())) > 0) {
				res.setValid(false);
				res.setMessage("접근이 제한된 IP입니다.");
			} else if(editMode.equals("RECOMMEND")) {
				//				book.setUser_idx(elibMemberService.getUserIdxByUserId(book.getUser_id()));
				ret = bookService.recommendBook(book);
				if(ret == -1) {
					res.setValid(false);
					res.setMessage("이미 추천하셨습니다.");
				} else if(ret == 0) {
					res.setValid(false);
					res.setMessage("오류가 발생했습니다. 관리자에게 문의하세요.");
				} else {
					res.setValid(true);
					res.setMessage("추천하였습니다.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	private String getMobileOS(HttpServletRequest request) {
		String ua = request.getHeader("User-Agent");
		String os = "android";

		if(ua.indexOf("iPhone") > -1 || ua.indexOf("iPod") > -1) {
			return "iOS";
		} else if(ua.indexOf("iPad") > -1) {
			return "ipad";
		} else if(ua.indexOf("Android") > -1 ) {
			return "Android";
		} else {
			return os;
		}
	}
	
	private String getMobileOSTwo(HttpServletRequest request) {
		String ua = request.getHeader("User-Agent");
		String os = "android";

		if(ua.indexOf("iPhone") > -1 || ua.indexOf("iPod") > -1) {
			return "ios";
		} else if(ua.indexOf("iPad") > -1) {
			return "ios";
		} else if(ua.indexOf("Android") > -1 ) {
			return "android";
		} else {
			return os;
		}
	}

	@RequestMapping(value = {"/lending/index.*"})
	public String lending_index(Model model, Lending lending, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		lending.setHomepage_id(homepage.getHomepage_id());

		lending.setBefore_url(String.format("/%s/module/elib/lending/index.do?menu_idx=%s&menu=%s", homepage.getContext_path(), lending.getMenu_idx(), lending.getMenu()));
		if(!checkLogin(request, response, lendingService, lending)) return null;

		String menu = lending.getMenu();
		int count = 0;
		List<Lending> lendingList = null;
		lending.setMember_id(getSessionMemberId(request));

		if("LENDING".equals(menu)) {
			count = lendingService.getLendMemberListCnt(lending);
			lendingService.setPaging(model, count, lending);
			lendingList = lendingService.getLendMemberList(lending);

			Device device = DeviceUtils.getCurrentDevice(request);
			ElibMember member = new ElibMember(getSessionMemberInfo(request));
			Member my = getSessionMemberInfo(request);
			member.setLib_code(my.getLib_code());

			boolean isMobile = device.isMobile() || device.isTablet();
			model.addAttribute("isMobile", isMobile);

			if(isMobile) {
				model.addAttribute("memberIdBase64", new String(Base64.encodeBase64(lending.getMember_id().getBytes())));
				List<Map<String, String>> mobileList = new ArrayList<Map<String, String>>();
				for(Lending l: lendingList) {
					if(StringUtils.equals(l.getCom_code(), "KYOB")) {
						try {
							mobileList.add(apiService.view(new Book(l)));
						} catch(Exception e) {
							mobileList.add(null);
						}
					} else if(StringUtils.equals(l.getCom_code(), "FXLI")) {
						try {
							Map<String, String> map = apiService.appUrl(new Book(l), member, getMobileOSTwo(request));
							mobileList.add(map);
						} catch(Exception e) {
							mobileList.add(null);
						}
					} else if(StringUtils.equals(l.getCom_code(), "YESB")) {
						try {
							Map<String, String> map = apiService.appUrl(new Book(l), member, getMobileOS(request));
							mobileList.add(map);
						} catch(Exception e) {
							e.printStackTrace();
							mobileList.add(null);
						}
					} else if(StringUtils.equals(l.getCom_code(), "ECO")) {
						try {
							Map<String, String> map = apiService.appUrl(new Book(l), member, getMobileOS(request));
							mobileList.add(map);
						} catch(Exception e) {
							e.printStackTrace();
							mobileList.add(null);
						}
					} else if(StringUtils.equals(l.getCom_code(), "OPMS")) {
						try {
							Map<String, String> map = apiService.appUrl(new Book(l), member, getMobileOS(request));
							mobileList.add(map);
						} catch(Exception e) {
							e.printStackTrace();
							mobileList.add(null);
						}
					}
					
					else {
						mobileList.add(null);
					}

				}
				model.addAttribute("mobileList", mobileList);
			}
		} else if("RESERVE".equals(menu)) {
			count = lendingService.getReserveMemberListCnt(lending);
			lendingService.setPaging(model, count, lending);
			lendingList = lendingService.getReserveMemberList(lending);
		} else if("HISTORY".equals(menu)) {
			lending.setSortField("lend_dt");
			count = lendingService.getLendMemberListCnt(lending);
			lendingService.setPaging(model, count, lending);
			lendingList = lendingService.getLendMemberList(lending);
		} else if("MYSTUDY".equals(menu)) {
			count = lendingService.getFavoritesListCnt(lending);
			lendingService.setPaging(model, count, lending);
			lendingList = setStatus(lendingService.getFavoritesList(lending), request);
		}

		model.addAttribute("lending", lending);
		model.addAttribute("lendingList", lendingList);
		model.addAttribute("lendingListCnt", count);

		return String.format(basePath, homepage.getFolder()) + "lending/index";
	}
	
	@RequestMapping(value = {"/lending/interest.*"})
	public String lending_interest(Model model, Lending lending, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		lending.setHomepage_id(homepage.getHomepage_id());

		lending.setBefore_url(String.format("/%s/module/elib/lending/interest.do?menu_idx=%s", homepage.getContext_path(), lending.getMenu_idx()));
		if(!checkLogin(request, response, lendingService, lending)) return null;
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = cal.getTime();
		cal.add(Calendar.YEAR, -1);
		
		lending.setRec_key(getSessionMemberInfo(request).getRec_key());
		lending.setStart_date(sdf.format(cal.getTime()));
		lending.setEnd_date(sdf.format(date));
		
		String com_code = LibSearchAPI.getBookInterestLoanList(lending);
		
		Book book = new Book();
		book.setType("EBK");
		book.setCom_code(com_code);
		List<Book> bookList = bookService.getBookInterestList(book);
		
		model.addAttribute("book", book);
		model.addAttribute("bookConfig", configService.getConfig());
		model.addAttribute("bookList", setStatus(bookList, request));
		model.addAttribute("bookListCnt", bookList.size());
		

		return String.format(basePath, homepage.getFolder()) + "lending/interest";
	}

	private Book setStatus(Book book, HttpServletRequest request, int max_lend) {
		Lending lending = new Lending();
		lending.setBook_idx(book.getBook_idx());
		lending.setMember_id(getSessionMemberId(request));
		Config config = configService.getConfig();

		if(book.getMax_lend() > 0) max_lend = book.getMax_lend();

		if(book.getBook_lend() < max_lend) {
			if(!isLoggedIn(request)) {
				// 로그인 안 한 상태
				book.setStatus("대출 가능");
			} else if(lendingService.getNotReturnedCnt(lending) == 0) {
				// 대출 가능
				book.setStatus("대출 가능");
			} else {
				// 대출 중(연장 가능)
				book.setStatus("대출 중");
			}
			//  status=5: 대출 중(연장 불가)
		} else {
			if(!isLoggedIn(request)) {
				// 로그인 안 한 상태
				// 개별 책 최대 예약 수 체크
				int book_max_reserve = config.getBook_max_reserve();
				int book_reserve = book.getBook_reserve();
				if(book_reserve >= book_max_reserve) {
					book.setStatus("예약 불가");
				} else {
					book.setStatus("예약 가능");
				}
			} else {
				// 개인 최대 예약 여부 체크
				int max_reserve = config.getMax_reserve();
				int member_reserve_cnt = lendingService.getMemberReserveCnt(lending);
				if(member_reserve_cnt >= max_reserve) {
					book.setStatus("예약 불가");
					return book;
				}

				// 중복 예약 체크
				int dup_reserve_cnt = lendingService.getDupReserveCnt(lending);
				if(dup_reserve_cnt > 0) {
					book.setStatus("예약 불가");
					return book;
				}
				
				// 개별 책 최대 예약 수 체크
				int book_max_reserve = config.getBook_max_reserve();
				int book_reserve = book.getBook_reserve();
				if(book_reserve >= book_max_reserve) {
					book.setStatus("예약 불가");
					return book;
				}
				
				book.setStatus("예약 가능");
			}
		}

		return book;
	}

	private Lending setStatus(Lending lending, HttpServletRequest request, int max_lend) {
		lending.setMember_id(getSessionMemberId(request));
		Book book = bookService.getBookInfo(new Book(lending));

		if(book == null) return lending;

		lending.setBook_lend(book.getBook_lend());
		lending.setBook_reserve(book.getBook_reserve());

		if(book.getMax_lend() > 0) max_lend = book.getMax_lend();

		if(book.getBook_lend() < max_lend) {
			if(!isLoggedIn(request)) {
				// 로그인 안 한 상태
				lending.setStatus("대출 가능");
			} else if(lendingService.getNotReturnedCnt(lending) == 0) {
				// 대출 가능
				lending.setStatus("대출 가능");
			} else {
				// 대출 중(연장 가능)
				lending.setStatus("대출 중");
			}
			//  status=5: 대출 중(연장 불가)
		} else {
			if(!isLoggedIn(request)) {
				// 로그인 안 한 상태
				lending.setStatus("예약 가능");
			} else if(lendingService.getDupReserveCnt(lending) == 0) {
				// 예약 가능
				lending.setStatus("예약 가능");
			} else {
				// 예약 중
				lending.setStatus("예약 중");
			}
		}

		return lending;
	}

	@SuppressWarnings("unchecked")
	private <T> T setStatus(T t, HttpServletRequest request, int max_lend) {
		if(t instanceof Book) {
			return (T) setStatus((Book) t, request, max_lend);
		} else {
			return (T) setStatus((Lending) t, request, max_lend);
		}
	}

	private <T> T setStatus(T t, HttpServletRequest request) {
		int max_lend = configService.getConfig().getBook_max_lend();
		return setStatus(t, request, max_lend);
	}

	private <T> List<T> setStatus(List<T> list, HttpServletRequest request) {
		if(list == null) {
			return null;
		} else {
			int max_lend = configService.getConfig().getBook_max_lend();
			for(T t: list) {
				setStatus(t, request, max_lend);
			}
			return list;
		}
	}

	private void setApporve_yn(Book book, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String debug = (String) session.getAttribute("_elib_debug");

		if(StringUtils.equals(debug, "true"))
			book.setApproved_yn("N");
		else
			book.setApproved_yn("Y");
	}

	private void setApporve_yn(ElibCategory elibCategory, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String debug = (String) session.getAttribute("_elib_debug");

		if(StringUtils.equals(debug, "true"))
			elibCategory.setApproved_yn("N");
		else
			elibCategory.setApproved_yn("Y");
	}

	private void setApporve_yn(ElibCode elibCode, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String debug = (String) session.getAttribute("_elib_debug");

		if(StringUtils.equals(debug, "true"))
			elibCode.setApproved_yn("N");
		else
			elibCode.setApproved_yn("Y");
	}

	@RequestMapping(value = {"/book/view.*", "/lending/view.*", "/reserve/view.*"})
	public String lending_view(Model model, Book book, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		book.setHomepage_id(homepage.getHomepage_id());

		Book book1 = setStatus(bookService.getBookInfo(book), request);
		if("FXLI".equals(book1.getCom_code())) book1 = setStatus(bookService.getBookInfo(book), request);
		book1.setBefore_url(book.getBefore_url());
		book1.setMenu_idx(book.getMenu_idx());

		//		if(!checkLogin(request, response, lendingService, book1)) return null;

		model.addAttribute("book", book1);
		Device device = DeviceUtils.getCurrentDevice(request);
		boolean isMobile = device.isMobile() || device.isTablet();
		model.addAttribute("isMobile", isMobile);
		model.addAttribute("bookConfig", configService.getConfig());

		if(StringUtils.equals(book.getType(), "ADO")) {
			List<Book> audioList = bookService.getAudioList(book);
			model.addAttribute("audioList", audioList);
		}
		else if(StringUtils.equals(book.getType(), "WEB")) {
			List<Book> courseList = bookService.getCourseList(book);
			model.addAttribute("courseList", courseList);
		}

		return String.format(basePath, homepage.getFolder()) + "book/view";
	}


	private String koreanDateFormat(String date) {
		SimpleDateFormat parse = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat format = new SimpleDateFormat("yyyy'.' M'.' d'.' '('EE')'",  Locale.KOREA);
		try {
			return format.format(parse.parse(date));
		} catch (ParseException e) {
			return date;
		}
	}

	@RequestMapping(value = {"/lending/save.*"})
	public @ResponseBody JsonResponse lending_save(Model model, Lending lending,  BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		lending.setHomepage_id(homepage.getHomepage_id());

		JsonResponse res = new JsonResponse(request);
		String editMode = lending.getEditMode();
		int ret = 0;

		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));
		book.setMenu_idx(lending.getMenu_idx());
		book.setBefore_url(String.format("/%s/module/elib/lending/index.do?menu_idx=%s", homepage.getContext_path(), lending.getMenu_idx()));
		res = checkLogin(request, result, res, book);
		if(!res.isValid()) return res;

		lending.setDevice(getDevice(request.getHeader("user-agent")));

		if(!result.hasErrors()) {
			try {
				addMemberIfNotExists(request, book);
			} catch (ElibException e) {
				res.setValid(false);
				res.setMessage(e.getMessage());
				return res;
			}
			lending.setMember_id(getSessionMemberId(request));
			lending.setCom_code(book.getCom_code());

			if(elibAccessIpService.getBannedIpCnt(new ElibAccessIp(request.getRemoteAddr())) > 0) {
				res.setValid(false);
				res.setMessage("접근이 제한된 IP입니다.");
			} else if(editMode.equals("BORROW")) {
				try {
					ret = lendingService.borrowProc(lending, false, homepage);
				} catch(ElibException e) {
					res.setValid(false);
					res.setMessage(e.getMessage());
					return res;
				}
				if(ret == -1) {
					res.setValid(false);
					res.setMessage("설정에 오류가 발생했습니다. 관리자에게 문의하세요.");
				} else if(ret == -6) {
					res.setValid(false);
					res.setMessage("최대 대출 권수를 초과했습니다.");
				} else if(ret == -9) {
					res.setValid(false);
					res.setMessage("이미 예약된 책은 대출할 수 없습니다.");
				} else if(ret == -2) {
					res.setValid(false);
					res.setMessage("반납하지 않은 책은 대출할 수 없습니다.");
				} else if(ret == -4) {
					res.setValid(false);
					res.setMessage("최대 예약 권수를 초과했습니다.");
				} else if(ret == -10) {
					res.setValid(false);
					res.setMessage("해당 도서가 존재하지 않습니다.");
				} else if(ret == 1) {
					res.setValid(false);
					res.setMessage("최대 대출 권수가 초과된 책으로, 예약하실 수 있습니다.");
				} else if(ret == 0) {
					lending = lendingService.getLending(lending);
					res.setValid(true);
					res.setMessage("대출되었습니다. 반납예정일은 " + koreanDateFormat(lending.getReturn_due_dt()) + "입니다.");
				} else {
					res.setValid(false);
					res.setMessage("알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요.");
				}
			} else if(editMode.equals("BORROW_")) {
				try {
					//					Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));
					//					book.setMember_id(lending.getMember_id());
					//					lending.setCom_code(book.getCom_code());
					//					lending.setExtention_count(0);
					//					if (StringUtils.isEmpty(lending.getDevice())) {
					//						lending.setDevice("P");
					//					}
					//					lendingDao.addLending(lending);

					//					ret = lendingService.borrowProc(lending, false, homepage);
					//					ret = lendingService.returnLending(lending);
				} catch(Exception e) {
				}
			} else if(editMode.equals("BORROW_RETURN")) {
				/**
				 * 대출 즉시 반납한다. - 오디오북용 통계 누적 ADO
				 */
				ret = lendingService.borrowImmedReturnProc(lending);
				if (ret > 0) {
					res.setValid(true);
				} else {
					res.setValid(false);
				}
			} else if(editMode.equals("BORROW_RETURN_ELEARN")) {
				/**
				 * 대출 즉시 반납한다. - 이러닝용 통계 누적 WEB
				 */
				ret = lendingService.borrowImmedReturnProcLearning(lending);
				if (ret > 0) {
					res.setValid(true);
				} else {
					res.setValid(false);
				}
			} else if(editMode.equals("RETURN")) {
				try {
					ret = lendingService.returnProc(lending, homepage);
				} catch (ElibException e) {
					res.setValid(false);
					res.setMessage(e.getMessage());
					return res;
				}
				if(ret == -1) {
					res.setValid(false);
					res.setMessage("설정에 오류가 발생했습니다. 관리자에게 문의하세요.");
				} else if(ret == -2) {
					res.setValid(false);
					res.setMessage("대여 기록이 존재하지 않습니다.");
				} else if(ret == -3) {
					res.setValid(false);
					res.setMessage("이미 반납된 도서입니다.");
				} else if(ret == -4) {
					res.setValid(false);
					res.setMessage("해당 도서가 존재하지 않습니다.");
				} else if(ret == 0) {
					res.setValid(true);
					res.setMessage("반납되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요.");
				}
			} else if(editMode.equals("RESERVE")) {
				try {
					ret = lendingService.reserveProc(lending);
				} catch (ElibException e) {
					res.setValid(false);
					res.setMessage(e.getMessage());
					return res;
				}
				if(ret == -1) {
					res.setValid(false);
					res.setMessage("해당 도서가 존재하지 않습니다.");
				} else if(ret == -10) {
					res.setValid(false);
					res.setMessage("최대 예약 권수를 초과했습니다.");
				} else if(ret == -5) {
					res.setValid(false);
					res.setMessage("이미 예약된 상태입니다.");
				} else if(ret == -9) {
					res.setValid(false);
					res.setMessage("이미 대출된 책으로 예약할 수 없습니다.");
				} else if(ret == -11) {
					res.setValid(false);
					res.setMessage("대출 가능한 책은 예약할 수 없습니다.");
				} else if(ret == -12) {
					res.setValid(false);
					res.setMessage("책의 최대 예약 권수를 초과했습니다.");
				} else if(ret == 0) {
					res.setValid(true);
					res.setMessage("예약되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("알 수 없는 오류가 발생했습니다. 관리자에게 문의하세요.");
				}
			} else if(editMode.equals("CANCEL")) {
				try {
					ret = lendingService.reserveCancel(lending);
				} catch (ElibException e) {
					res.setValid(false);
					res.setMessage(e.getMessage());
					return res;
				}
				if(ret == -2 || ret == -3) {
					res.setValid(false);
					res.setMessage("예약돼 있지 않습니다.");
				} else if(ret == 0) {
					res.setValid(true);
					res.setMessage("취소되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("알 수 없는 오류가 발생했습니다.");
				}
			} else if(editMode.equals("EXTEND")) {
				try {
					ret = lendingService.extendProc(lending, book);
				} catch (ElibException e) {
					res.setValid(false);
					res.setMessage(e.getMessage());
					return res;
				}
				if(ret == -2) {
					res.setValid(false);
					res.setMessage("이미 반납한 상태에서 연장할 수 없습니다.");
				} else if(ret == -3) {
					res.setValid(false);
					res.setMessage("최대 연장 횟수를 초과했습니다.");
				} else if(ret == -4 || ret == -5) {
					res.setValid(false);
					res.setMessage("예약된 책은 연장할 수 없습니다.");
				} else if(ret == -6) {
					res.setValid(false);
					res.setMessage("대출하지 않은 책은 연장할 수 없습니다.");
				} else if(ret == -7) {
					res.setValid(false);
					res.setMessage("해당 도서가 존재하지 않습니다.");
				} else if(ret == 1) {
					res.setValid(true);
					res.setMessage("연장되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("알 수 없는 오류가 발생했습니다. " + ret);
				}
			} else if(editMode.equals("ADDFAVORITE")) {
				ret = lendingService.addFavorite(lending);
				if(ret == 0) {
					res.setValid(false);
					res.setMessage("오류가 발생했습니다. 관리자에게 문의하세요.");
				} else if(ret == -1) {
					res.setValid(false);
					res.setMessage("이미 추가되어 있습니다.");
				} else {
					res.setValid(true);
					res.setMessage("추가되었습니다.");
				}
			} else if(editMode.equals("DELETEFAVORITE")) {
				ret = lendingService.deleteFavorite(lending);
				if(ret == 0) {
					res.setValid(false);
					res.setMessage("오류가 발생했습니다. 관리자에게 문의하세요.");
				} else {
					res.setValid(true);
					res.setMessage("삭제되었습니다.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	@RequestMapping(value = {"/extlink_save.*"})
	public @ResponseBody JsonResponse extlink_save(Model model, Book book,  BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		book.setHomepage_id(homepage.getHomepage_id());

		JsonResponse res = new JsonResponse(request);
		String editMode = book.getEditMode();
		int ret = 0;

		book.setDevice(getDevice(request.getHeader("user-agent")));

		if(!result.hasErrors()) {
			try {
				addMemberIfNotExists(request, book);
			} catch (ElibException e) {
				res.setValid(false);
				res.setMessage(e.getMessage());
				return res;
			}
			book.setMember_id(getSessionMemberId(request));
			book.setCom_code(book.getCom_code());

			if(elibAccessIpService.getBannedIpCnt(new ElibAccessIp(request.getRemoteAddr())) > 0) {
				res.setValid(false);
				res.setMessage("접근이 제한된 IP입니다.");
			} else if(editMode.equals("EXTLINK")) {
				ret = lendingService.addExtlinkStat(book);
				if(ret == 0) {
					res.setValid(false);
				} else {
					res.setValid(true);
				}
			}
		}

		return res;
	}


	@RequestMapping(value = {"/comment/save.*"})
	public @ResponseBody JsonResponse comment_save(Model model, Comment comment,  BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		comment.setHomepage_id(homepage.getHomepage_id());

		JsonResponse res = new JsonResponse(request);
		String editMode = comment.getEditMode();

		comment.setBefore_url(String.format("/%s/module/elib/book/view.do?menu_idx=%s&book_idx=%s", homepage.getContext_path(), comment.getMenu_idx(), comment.getBook_idx()));
		res = checkLogin(request, result, res, comment);
		if(!res.isValid()) return res;

		if(!comment.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "user_comment", "서평을 입력하세요.");
		}

		if(!result.hasErrors()) {
			try {
				addMemberIfNotExistsLocal(request);
			} catch (ElibException e) {
				res.setValid(false);
				res.setMessage(e.getMessage());
				return res;
			}
			//			comment.setMember_id(getSessionMemberId(request));
			comment.setMember_id(getSessionMemberId(request));

			if(elibAccessIpService.getBannedIpCnt(new ElibAccessIp(request.getRemoteAddr())) > 0) {
				res.setValid(false);
				res.setMessage("접근이 제한된 IP입니다.");
			} else if(editMode.equals("ADD")) {
				commentService.addComment(comment);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if(editMode.equals("DELETE")) {
				commentService.deleteComment(comment);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	@RequestMapping(value = {"/search/index.*"})
	public String search_index(Model model, Book book, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		book.setHomepage_id(homepage.getHomepage_id());

		if ( !StringUtils.isEmpty(book.getSearch_text()) ) {
			book.setViewPage(1);
			book.setType(null);
			book.setAuthor_name(null);
			book.setBook_pubname(null);
			book.setBook_year(null);

			int count = 0;
			int rowCount = book.getRowCount();

			book.setRowCount(5);
			setApporve_yn(book, request);

			count = bookService.getBookCountByTypeCnt(book);
			book.setTotalDataCount(count);
			model.addAttribute("countByType", count);
			model.addAttribute("moreByType", bookService.getBookCountByType(book));

			count = bookService.getBookCountByAuthorCnt(book);
			book.setTotalDataCount(count);
			model.addAttribute("countByAuthor", count);
			model.addAttribute("moreByAuthor", bookService.getBookCountByAuthor(book));

			count = bookService.getBookCountByPublisherCnt(book);
			book.setTotalDataCount(count);
			model.addAttribute("countByPublisher", count);
			model.addAttribute("moreByPublisher", bookService.getBookCountByPublisher(book));

			count = bookService.getBookCountByYearCnt(book);
			book.setTotalDataCount(count);
			model.addAttribute("countByYear", count);
			model.addAttribute("moreByYear", bookService.getBookCountByYear(book));

			count = bookService.getBookCountByDeviceCnt(book);
			book.setTotalDataCount(count);
			model.addAttribute("countByDevice", count);
			model.addAttribute("moreByDevice", bookService.getBookCountByDevice(book));

			book.setRowCount(rowCount);
			count = bookService.getBookSearchedListCnt(book);
			bookService.setPaging(model, count, book);
			List<Book> bookList = bookService.getBookSearchedList(book);
			model.addAttribute("bookList", setStatus(bookList, request));
			model.addAttribute("bookListCnt", count);
		}

		return String.format(basePath, homepage.getFolder()) + "search/index";
	}

	@RequestMapping(value = {"/search/table.*"})
	public String table(Model model, Book book, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		book.setHomepage_id(homepage.getHomepage_id());

		if ( !StringUtils.isEmpty(book.getSearch_text()) ) {

			setApporve_yn(book, request);

			int count = bookService.getBookSearchedListCnt(book);
			bookService.setPaging(model, count, book);
			List<Book> bookList = bookService.getBookSearchedList(book);

			model.addAttribute("libraryList", elibCodeService.getLibraryList());
			model.addAttribute("bookList", bookList);
			model.addAttribute("bookListCnt", count);

			//			if ( book.getViewPage() > 1) { // 화면에서 페이지 버튼 클릭
			//				//librarySearch.setSearch_type("GOPAGE"); // GOPAGE 사용시 검색 카테고리 바꾸면 페이징 안됨. (API가 안됨...)
			//				viewPage = book.getViewPage();
			//			}

		}

		return String.format(basePath, homepage.getFolder()) + "search/table_ajax";
	}

	@RequestMapping(value = {"/search/table/{menu}.*"})
	public String table2(@PathVariable String menu, Model model, Book book, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		book.setHomepage_id(homepage.getHomepage_id());

		menu = menu.toUpperCase();
		book.setMenu(menu);

		if ( !StringUtils.isEmpty(book.getSearch_text()) ) {
			int count = 0;
			setApporve_yn(book, request);

			if("TYPE".equals(menu)) {
				count = bookService.getBookCountByTypeCnt(book);
				book.setTotalDataCount(count);
				model.addAttribute("countByType", count);
				model.addAttribute("bookCountByType", bookService.getBookCountByType(book));
			} else if("AUTHOR".equals(menu)) {
				//				book.setType(null);
				book.setBook_pubname(null);
				book.setBook_year(null);
				book.setDevice(null);
				count = bookService.getBookCountByAuthorCnt(book);
				book.setTotalDataCount(count);
				model.addAttribute("countByAuthor", count);
				model.addAttribute("bookCountByAuthor", bookService.getBookCountByAuthor(book));
			} else if("PUBLISHER".equals(menu)) {
				//				book.setType(null);
				book.setAuthor_name(null);
				book.setBook_year(null);
				book.setDevice(null);
				count = bookService.getBookCountByPublisherCnt(book);
				book.setTotalDataCount(count);
				model.addAttribute("countByPublisher", count);
				model.addAttribute("bookCountByPublisher", bookService.getBookCountByPublisher(book));
			} else if("YEAR".equals(menu)) {
				//				book.setType(null);
				book.setAuthor_name(null);
				book.setBook_pubname(null);
				book.setDevice(null);
				count = bookService.getBookCountByYearCnt(book);
				book.setTotalDataCount(count);
				model.addAttribute("countByYear", count);
				model.addAttribute("bookCountByYear", bookService.getBookCountByYear(book));
			} else if("DEVICE".equals(menu)) {
				book.setAuthor_name(null);
				book.setBook_pubname(null);
				book.setBook_year(null);
				count = bookService.getBookCountByDeviceCnt(book);
				book.setTotalDataCount(count);
				model.addAttribute("countByDevice", count);
				model.addAttribute("bookCountByDevice", bookService.getBookCountByDevice(book));
			}
		}

		model.addAttribute("menu", menu);
		return String.format(basePath, homepage.getFolder()) + "search/table2_ajax";
	}

	@RequestMapping(value = {"/book/comments.*"})
	public String comments(Model model, Book book, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		book.setHomepage_id(homepage.getHomepage_id());

		//		if(!checkLogin(request, response, bookService, book)) return null;

		Comment comment = new Comment(book);
		int count = commentService.getCommentListCnt(comment);
		commentService.setPaging(model, count, comment);
		List<Comment> commentList = commentService.getCommentList(comment);

		model.addAttribute("commentList", commentList);

		return String.format(basePath, homepage.getFolder()) + "book/comments_ajax";
	}

	@RequestMapping(value = {"/set.*"}, method = RequestMethod.GET)
	public String set(Model model, @RequestParam(defaultValue = "") String loca, @RequestParam(defaultValue = "") String debug, HttpServletRequest request, HttpServletResponse response) throws Exception{
		if(StringUtils.isNotEmpty(loca)) {
			Member member = getSessionMemberInfo(request);
			member.setLoca(loca);
			loginService.setSessionMember(member, request);
			member = getSessionMemberInfo(request);
			//			response.getOutputStream().println("loca: " + member.getLoca());
		} else {
			HttpSession session = request.getSession();

			if(StringUtils.equals(debug, "true")) {
				session.setAttribute("_elib_debug", "true");
				//			response.getOutputStream().println("debug: " + debug);
			} else if(StringUtils.equals(debug, "false")) {
				session.removeAttribute("_elib_debug");
				//			response.getOutputStream().println("debug: " + debug);
			}
		}

		return "redirect:https://library.daegu.go.kr/elib/index.do";
	}

	@RequestMapping(value = {"/redirect.*", "/goto.*", "/redirec.*"})
	public String redirect(Model model, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "redirect_ajax";
	}

	private static final String[] IPHONE = {"iPhone", "iPad", "iPod", "iOS"};

	private String getDevice(String user_agent) {
		Map<String, String> r = Classifier.parse(user_agent);
		//		String name = r.get("name");
		String category = r.get("category");
		String os = r.get("os");
		//		String version = r.get("version");
		//		String os_version = r.get("os_version");
		String device = "P";

		if("pc".equals(category)) {
			device = "P";
		} else if("smartphone".equals(category)) {
			if("Android".equals(os)) {
				device = "A";
			} else if(ArrayUtils.contains(IPHONE, os)) {
				device = "I";
			} else {
				device = "E";
			}
		} else {
			device = "E";
		}

		return device;
	}

	@RequestMapping(value = {"/asp/{directory}/{file}.*"})
	public String index(Model model, HttpServletRequest request, @PathVariable ("directory") String d, @PathVariable ("file") String f) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + d +"/" + f;
	}

}
