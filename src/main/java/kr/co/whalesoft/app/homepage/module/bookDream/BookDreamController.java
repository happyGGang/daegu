package kr.co.whalesoft.app.homepage.module.bookDream;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.whalesoft.app.cms.accountLock.AccountLock;
import kr.co.whalesoft.app.cms.accountLock.AccountLockService;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.homepageAccess.HomepageAccessService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StrUtil;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;
import kr.go.gbelib.app.cms.module.elib.lending.LendingService;
import kr.go.gbelib.app.cms.module.teacher.Teacher;
import kr.go.gbelib.app.cms.module.teacher.TeacherService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.LoginAPI;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PushAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.module.loginLog.LoginLog;
import kr.go.gbelib.app.module.loginLog.LoginLogService;

@Controller(value = "userBookDreamController")
@RequestMapping(value = { "/ad/module/bookDream" })
public class BookDreamController extends BaseController {

	private final String basePath = "/homepage/module/bookDream/";

	@Autowired
	private BookDreamService service;

	@Autowired
	private CodeService codeService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private HomepageAccessService homepageAccessService;

	@Autowired
	private LendingService lendingService;

	@Autowired
	private TeacherService teacherService;	

	@Autowired
	private MemberService memberService;

	@Autowired
	private AccountLockService accountLockService;
	
	@Autowired
	private LoginLogService loginLogService;

	/**
	 * 첫화면
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		return basePath + "index";
	}

	/**
	 * 신청안내
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/info.*" }, method = RequestMethod.GET)
	public String info(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		return basePath + "info";
	}

	/**
	 * 북드림 로그인
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/login.*" }, method = RequestMethod.GET)
	public String login(Model model, Member member, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		model.addAttribute("member", member);
		return basePath + "login";
	}

	/**
	 * 북드림 로그인
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/loginProc.*" }, method = RequestMethod.POST)
	public String loginProc(Model model, Member member, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		// 아이디, 비번, 이름 복호화
		if(memberService.decryptMember(member) == false) {
			codeService.alertMessage("아이디 또는 비밀번호를 다시 확인하세요", request, response);
			return null;
		}

		// 비번 틀려서 계정이 잠김
		if("Y".equals(accountLockService.isLocked(new AccountLock(member, request.getRemoteAddr())))) {
			codeService.alertMessage("로그인 5회 중 5회 이상 실패\\n입력하신 아이디에 대해서 10분간 접속을 차단합니다.", request, response);
			return null;
		}

		Object result = LoginAPI.login(member);
		if ( result instanceof Member ) {
			accountLockService.loginSucceeded(new AccountLock(member, request.getRemoteAddr()));
			loginLogService.addLoginLog(new LoginLog(member, request, homepage));

			member = (Member) result;
			member.setLogin(true);
			member.setLast_login_ip(homepageAccessService.getLastHomepageAccess(member));
			memberService.addMemberLastLogin(member, request);

			/**
			 * 개인정보 동의 기간 설정
			 */
			Date lastLoanDate = new Date();
			Calendar cal = Calendar.getInstance();
			String[] parsePatterns = {"yyyyMMdd"};
			String[] parsePatterns2 = {"yyyy-MM-dd"};
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

			Map<String, Object> loanListTmp = LibSearchAPI.getMyLibraryList("WEB", member.getUser_id(), "LOAN", null);
			if (loanListTmp != null) {
				try {
					@SuppressWarnings ("unchecked")
					List<Map<String, String>> loanList = (List<Map<String, String>>) loanListTmp.get("dsMyLibraryList");
					if (loanList != null && loanList.size() > 0) {
						Map<String, String> lastLoan = loanList.get(0);
						String lastLoanDateStr = lastLoan.get("LOAN_DATE");
						if (StringUtils.isNotEmpty(lastLoanDateStr)) {
							lastLoanDate = DateUtils.parseDate(lastLoanDateStr, parsePatterns);
							if (member.getAgree_date() == null) {
								lastLoanDate = cal.getTime();
								cal.setTime(lastLoanDate);
								cal.add(Calendar.YEAR, 2);
								member.setAgree_date_str(sdf.format(cal.getTime()));
							} else {
								if (member.getAgree_date().compareTo(lastLoanDate) < 0) {
									lastLoanDate = cal.getTime();
								} else {
									lastLoanDate = member.getAgree_date();
								}
								cal.setTime(lastLoanDate);
								cal.add(Calendar.YEAR, 2);
								member.setAgree_date_str(sdf.format(cal.getTime()));
							}
						} else {
							if (member.getAgree_date() != null) {
								lastLoanDate = member.getAgree_date();
								cal.setTime(lastLoanDate);
								cal.add(Calendar.YEAR, 2);
								member.setAgree_date_str(sdf.format(cal.getTime()));
							}
						}
					}
				}
				catch ( Exception e ) {
				}

			}

			Lending lending = new Lending();
			lending.setMember_id(member.getUser_id());
			List<Lending> lendingList = lendingService.getLendMemberList(lending);
			if (lendingList != null && lendingList.size() > 0) {
				String LastlendDtStr = lendingList.get(0).getLend_dt();
				if (StringUtils.isNotEmpty(LastlendDtStr)) {
					Date elibLastLendDate = DateUtils.parseDate(lendingList.get(0).getLend_dt(), parsePatterns2);
					if (member.getAgree_date() == null) {
						cal.setTime(elibLastLendDate);
						cal.add(Calendar.YEAR, 2);
						member.setAgree_date_str(sdf.format(cal.getTime()));
					} else {
						if (member.getAgree_date().compareTo(elibLastLendDate) < 0) {
							cal.setTime(elibLastLendDate);
							cal.add(Calendar.YEAR, 2);
							member.setAgree_date_str(sdf.format(cal.getTime()));
						}
					}
				}
			}

			Teacher teacher = new Teacher();
			teacher.setMember_key(member.getSeq_no());
			teacher = teacherService.checkTeacher2(teacher);
			if (teacher != null && teacher.getTeacher_idx() != 0) {
				member.setTeacher_yn("Y");
			}

			loginService.setSessionMember(member, request);
			return "redirect:/ad/module/bookDream/index.do";
		}
		else {
			member.setHomepage_id(homepage.getHomepage_id());
			member.setLoginType("HOMEPAGE");
			accountLockService.loginFailed(new AccountLock(member, request.getRemoteAddr()));
			ApiResponse errorResult = (ApiResponse) result;

			if("Y".equals(accountLockService.isLocked(new AccountLock(member, request.getRemoteAddr())))) {
				codeService.alertMessage("로그인 5회 중 5회 이상 실패\\n입력하신 아이디에 대해서 10분간 접속을 차단합니다.", request, response);
				return null;
			} else if("아이디 또는 비밀번호를 다시 확인하세요".equals(errorResult.getMessage())) {
				AccountLock accountLock = accountLockService.getAccountLock(new AccountLock(member, request.getRemoteAddr()));
				codeService.alertMessage(String.format("로그인 5회 중 %d회 실패\\n아이디 또는 비밀번호를 다시 확인하세요", accountLock.getCount()), request, response);
				return null;
			} else {
				codeService.alertMessage(errorResult.getMessage(), request, response);
				return null;
			}
		}
	}

	
	/**
	 * 신청 폼(검색)
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/requestForm.*" }, method = RequestMethod.GET)
	public String requestForm(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = getSessionMemberInfo(request);
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		Date out = new Date(2018-1900, 10, 1, 0, 0, 0); // 2018-11-01
		
		if (now.compareTo(out) >= 0) {
			service.alertMessage("2018년 11월 1일부로 새 책 드림 서비스가 종료되었습니다.", request, response);
			return null;
		}
		
		if (member == null || StringUtils.isEmpty(member.getUser_id())) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "login.do", request, response);
			return null;
		}

		if (StringUtils.isNotEmpty(member.getUser_id()) && member.getUser_id().startsWith("*")) {
			service.alertMessage("관외대출회원만 이용 가능합니다.", request, response);
			return null;
		}

		/**
		 * 00147010 안동
		 * 00147011 용상
		 * 00147039 풍산
		 */
		if (!"00147010,00147011,00147039".contains(member.getLoca())) {
			service.alertMessage("안동도서관(본관, 용상분관, 풍산분관) 회원만 이용 가능합니다.", request, response);
			return null;
		}

		model.addAttribute("bookDream", bookDream);
		return basePath + "requestForm";
	}


	/**
	 * 신청 폼(검색)
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/requestForm2.*" }, method = RequestMethod.POST)
	public String requestForm2(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = getSessionMemberInfo(request);

		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		Date out = new Date(2018-1900, 10, 1, 0, 0, 0); // 2018-11-01
		
		if (now.compareTo(out) >= 0) {
			service.alertMessage("2018년 11월 1일부로 새 책 드림 서비스가 종료되었습니다.", request, response);
			return null;
		}
		
		if (member == null || StringUtils.isEmpty(member.getUser_id())) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "login.do", request, response);
			return null;
		}

		if (StringUtils.isNotEmpty(member.getUser_id()) && member.getUser_id().startsWith("*")) {
			service.alertMessage("관외대출회원만 이용 가능합니다.", request, response);
			return null;
		}

		/**
		 * 00147010 안동
		 * 00147011 용상
		 * 00147039 풍산
		 */
		if (!"00147010,00147011,00147039".contains(member.getLoca())) {
			service.alertMessage("안동도서관(본관, 용상분관, 풍산분관) 회원만 이용 가능합니다.", request, response);
			return null;
		}

		//1-1.소장자료 존재 여부 확인
//		if (LibSearchAPI.getSameBookList("WEB", bookDream.getIsbn(), member.getLoca()) != null) {
//			service.alertMessage("소장자료는 신청 할 수 없습니다..", request, response);
//			return null;
//		}

		Map<String, Object> map = service.getNaverSearch(bookDream, "detail");
		model.addAttribute("naverResult",map);
		model.addAttribute("bookDream", bookDream);
		model.addAttribute("member", MemberAPI.getMember("WEB", getSessionMemberInfo(request)));
		model.addAttribute("storeList", codeService.getCode("h3", "H0005"));
		return basePath + "requestForm2";
	}

	/**
	 * 신청 process
	 * @param bookDream
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookDream bookDream, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member member = getSessionMemberInfo(request);
		JsonResponse res = new JsonResponse(request);

		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		Date out = new Date(2018-1900, 10, 1, 0, 0, 0); // 2018-11-01
		
		if (now.compareTo(out) >= 0) {
			result.reject("2018년 11월 1일부로 새 책 드림 서비스가 종료되었습니다.");
		}
		
		//유효성검사.
		//1. 예산 체크
		int totalPrice = service.getTotalPrice() - 50000;//예산
		int currentTotalPrice = service.getCurrentTotalPrice();//이번달 구입금액
		if (totalPrice < currentTotalPrice) {
			result.reject("이번달 지정 예산이 초과 되었습니다.");
		}

		bookDream.setUser_no(member.getUser_id());
		if (member.getLoca().equals("00147039")) {
			bookDream.setR_src("pungsan");
		} else if (member.getLoca().equals("00147011")) {
			bookDream.setR_src("yongsang");
		} else {
			bookDream.setR_src("andong");
		}

		//2. 개인당 일별 최대 신청 횟수 검사 (ex 2권) - 도서관별
		int dayCount = service.getDayCount();//하루 신청 제한 권수
		int requestCount = service.getRequestCountByMember(bookDream);//개인 하루 신청 권수
		if (dayCount == requestCount) {
			result.reject("한 사람당 하루에 "+dayCount+"권까지 신청 가능합니다.");
		}
		//3. 개인당 월별 최대 신청 횟수 검사(ex 월 4권) - 도서관별
		int priCount = service.getPriCount();//월 신청 제한 권수
		int monthRequestCount = service.getMonthRequestCountByMember(bookDream);//개인 한달 신청 권수
		if (priCount == monthRequestCount) {
			result.reject("한 사람당 한달에 "+priCount+"권까지 신청 가능합니다.");
		}

		if (!result.hasErrors()) {
			//1. 희망도서 신청 가능 여부 확인.
			LibrarySearch librarySearch = new LibrarySearch();
//			ApiResponse hopeUserCheck = LibSearchAPI.hopeUserCheck("WEB", librarySearch, member.getUser_id(), member.getLoca());
			ApiResponse hopeUserCheck = new ApiResponse(true);
			if ( hopeUserCheck.getStatus() ) {

				//2. 희망도서 신청
				librarySearch.setTitle(bookDream.getTitle());
				librarySearch.setAuthor(bookDream.getAuthor());
				librarySearch.setPubler(bookDream.getPublisher());
				librarySearch.setPubler_year(bookDream.getPubdate().substring(0,4));
				librarySearch.setIsbn(bookDream.getIsbn().split(" ")[0]);
				librarySearch.setPrice(String.valueOf(bookDream.getPrice()));
				librarySearch.setUser_remark("책드림 서비스");
				ApiResponse apiResult = LibSearchAPI.reqHope("WEB", librarySearch, member.getUser_id(), member.getLoca(), "0008");//새책드림 희망도서 신청
//				ApiResponse apiResult = new ApiResponse(true);
				if ( apiResult.getStatus() ) {
					//3. 북드림 DB insert
					bookDream.setUser_no(member.getUser_id());
					bookDream.setR_name(member.getMember_name());
					bookDream.setRh_ip(request.getRemoteAddr());
					bookDream.setRh_url(request.getHeader("referer"));
					bookDream.setRh_referer(request.getHeader("referer"));
					if (member.getLoca().equals("00147039")) {
						bookDream.setR_src("pungsan");
					} else if (member.getLoca().equals("00147011")) {
						bookDream.setR_src("yongsang");
					} else {
						bookDream.setR_src("andong");
					}
					service.addBookDream(bookDream);
					Homepage homepage = new Homepage();
					homepage.setHomepage_code(member.getLoca());
					homepage = homepageService.getHomepageOneByCode(homepage);
					bookDream.setC_no(10);
					String smsMsg = service.getBookDreamConfigOne(bookDream);

					if (member.getLoca().equals("00147039")) {
//						bookDream.setR_src("pungsan");
						bookDream.setC_no(3);
					} else if (member.getLoca().equals("00147011")) {
//						bookDream.setR_src("yongsang");
						bookDream.setC_no(2);
					} else {
//						bookDream.setR_src("andong");
						bookDream.setC_no(1);
					}
					String fromTel = service.getBookDreamConfigOne(bookDream);
					smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(bookDream.getTitle(), 20));
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, bookDream.getMobileno(), smsMsg, fromTel, false);

					//담당자에게 전송
					if (member.getLoca().equals("00147039")) {
//						bookDream.setR_src("pungsan");
						bookDream.setC_no(25);
					} else if (member.getLoca().equals("00147011")) {
//						bookDream.setR_src("yongsang");
						bookDream.setC_no(24);
					} else {
//						bookDream.setR_src("andong");
						bookDream.setC_no(23);
					}
					String toTel = service.getBookDreamConfigOne(bookDream);
					bookDream.setC_no(22);
					smsMsg = service.getBookDreamConfigOne(bookDream);
					smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(bookDream.getTitle(), 20));
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, toTel, smsMsg, fromTel, false);
					//담당자에게 전송 끝

					res.setValid(true);
					res.setMessage("새 책 드림 서비스 신청되었습니다.");
					res.setUrl("mypage.do");
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}
			else {
				res.setValid(false);
				res.setMessage(hopeUserCheck.getMessage());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}


	/**
	 * 수정 process(from 이용자)
	 * @param bookDream
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/modify.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modify(BookDream bookDream, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member member = getSessionMemberInfo(request);
		JsonResponse res = new JsonResponse(request);
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		if (bookDream.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "r_hp", "휴대폰번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "r_email", "이메일주소를 입력해주세요.");
		}

		if (!result.hasErrors()) {
			bookDream.setRh_ip(request.getRemoteAddr());
			bookDream.setRh_url(request.getHeader("referer"));
			bookDream.setRh_referer(request.getHeader("referer"));
			String fromTel = "";
			if (bookDream.getEditMode().equals("MODIFY")) {
				service.modifyBookDream(bookDream);
				res.setValid(true);
				res.setMessage("수정 완료되었습니다.");
				res.setUrl("mypage.do");
				if ("13,15,17,20".contains(bookDream.getR_state())) {
					Homepage homepage = new Homepage();
					homepage.setHomepage_code(member.getLoca());
					homepage = homepageService.getHomepageOneByCode(homepage);
					int msgType = 0;
					if (bookDream.getR_state().equals("13")) {//재고있음
						bookDream.setC_no(17);
					} else if (bookDream.getR_state().equals("15")) {//주문중
						bookDream.setC_no(18);
					} else if (bookDream.getR_state().equals("17")) {//입고완료
						bookDream.setC_no(19);
					} else if (bookDream.getR_state().equals("20")) {//구매확정
						bookDream.setC_no(21);
					}

					String smsMsg = service.getBookDreamConfigOne(bookDream);
					BookDream bookDreamOne = service.getBookDreamOne(bookDream);
					if (member.getLoca().equals("00147010")) {
						fromTel = bookDreamOne.getFromTel();
					} else if (member.getLoca().equals("00147011")) {
						fromTel = bookDreamOne.getFromTel2();
					} else if (member.getLoca().equals("00147039")) {
						fromTel = bookDreamOne.getFromTel3();
					}
					smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(bookDreamOne.getR_title(), 20));
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					smsMsg =  smsMsg.replace("{{D_DAY}}", sdf.format(bookDreamOne.getR_return_close()));
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, bookDreamOne.getMobileno(), smsMsg, fromTel, false);
				}
			} else if (bookDream.getEditMode().equals("CANCEL")) {
				Homepage homepage = new Homepage();
				homepage.setHomepage_code(member.getLoca());
				homepage = homepageService.getHomepageOneByCode(homepage);
				bookDream.setC_no(11);
				String smsMsg = service.getBookDreamConfigOne(bookDream);
				BookDream bookDreamOne = service.getBookDreamOne(bookDream);
				if (member.getLoca().equals("00147010")) {
					fromTel = bookDreamOne.getFromTel();
				} else if (member.getLoca().equals("00147011")) {
					fromTel = bookDreamOne.getFromTel2();
				} else if (member.getLoca().equals("00147039")) {
					fromTel = bookDreamOne.getFromTel3();
				}
				smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(bookDreamOne.getR_title(), 20));
				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, bookDreamOne.getR_hp(), smsMsg, fromTel, false);
				bookDream.setR_state("-10");
				bookDream.setRh_set("-10");
				service.modifyBookDream(bookDream);
				res.setValid(true);
				res.setMessage("신청 취소되었습니다.");
				res.setUrl("mypage.do");
			} else if (bookDream.getEditMode().equals("HAVE")) {
				Homepage homepage = new Homepage();
				homepage.setHomepage_code(member.getLoca());
				homepage = homepageService.getHomepageOneByCode(homepage);
				bookDream.setC_no(12);
				String smsMsg = service.getBookDreamConfigOne(bookDream);
				BookDream bookDreamOne = service.getBookDreamOne(bookDream);
				if (member.getLoca().equals("00147010")) {
					fromTel = bookDreamOne.getFromTel();
				} else if (member.getLoca().equals("00147011")) {
					fromTel = bookDreamOne.getFromTel2();
				} else if (member.getLoca().equals("00147039")) {
					fromTel = bookDreamOne.getFromTel3();
				}
				smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(bookDreamOne.getR_title(), 20));
				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, bookDreamOne.getR_hp(), smsMsg, fromTel, false);
				bookDream.setR_state("-20");
				bookDream.setRh_set("-20");
				service.modifyBookDream(bookDream);
				res.setValid(true);
				res.setMessage("개인소장 처리되었습니다.");
				res.setUrl("mypage.do");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 수정 process(from 서점관리자)
	 * @param bookDream
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/modify2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modify2(BookDream bookDream, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
		Member member = getSessionMemberInfo(request);
		JsonResponse res = new JsonResponse(request);
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}

		if (StringUtils.isNotEmpty(bookDream.getR_pay_type())) {
			ValidationUtils.rejectIfEmpty(result, "r_pay", "구매가격을 입력해주세요.");
		}

		if (!result.hasErrors()) {
			bookDream.setRh_ip(request.getRemoteAddr());
			bookDream.setRh_url(request.getHeader("referer"));
			bookDream.setRh_referer(request.getHeader("referer"));
			if (bookDream.getEditMode().equals("MODIFY")) {
				service.modifyBookDream(bookDream);
				res.setValid(true);
				res.setMessage("수정 완료되었습니다.");
				res.setReload(true);
				if ("13,15,17,20".contains(bookDream.getR_state())) {
					BookDream bookDreamOne = service.getBookDreamOne(bookDream);
					String homepageCode = bookDreamOne.getR_src();
					String fromTel = "";
//					00147010 안동
//					 * 00147011 용상
//					 * 00147039풍산
					if (homepageCode.equals("andong")) {
						homepageCode ="00147010";
						fromTel = bookDreamOne.getFromTel();
					} else if (homepageCode.equals("yongsang")) {
						homepageCode ="00147011";
						fromTel = bookDreamOne.getFromTel2();
					} else if (homepageCode.equals("pungsan")) {
						homepageCode ="00147039";
						fromTel = bookDreamOne.getFromTel3();
					}

					Homepage homepage = new Homepage();
					homepage.setHomepage_code(homepageCode);
					homepage = homepageService.getHomepageOneByCode(homepage);

					if (bookDream.getR_state().equals("13")) {//재고있음
						bookDream.setC_no(17);
					} else if (bookDream.getR_state().equals("15")) {//주문중
						bookDream.setC_no(18);
					} else if (bookDream.getR_state().equals("17")) {//입고완료
						bookDream.setC_no(19);
					} else if (bookDream.getR_state().equals("20")) {//구매확정
						bookDream.setC_no(21);
					}
					String smsMsg = service.getBookDreamConfigOne(bookDream);
					smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(bookDreamOne.getR_title(), 20));
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.DATE, 14);
					smsMsg =  smsMsg.replace("{{D_DAY}}", sdf.format(cal.getTime()));
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, bookDreamOne.getR_hp(), smsMsg, fromTel, false);
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 신청내역
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/requestList.*" }, method = RequestMethod.GET)
	public String requestList(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		service.setPaging(model, service.getRequestListCount(bookDream), bookDream);
		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamList", service.getRequestList(bookDream));
		return basePath + "requestList";
	}

	/**
	 * 이용후기
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/review.*" }, method = RequestMethod.GET)
	public String review(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}

		return basePath + "review";
	}

	/**
	 * 마이페이지
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/mypage.*" }, method = RequestMethod.GET)
	public String mypage(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = getSessionMemberInfo(request);
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}

		if (member == null || StringUtils.isEmpty(member.getUser_id())) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "login.do", request, response);
			return null;
		}

		if (StringUtils.isNotEmpty(member.getUser_id()) && member.getUser_id().startsWith("*")) {
			service.alertMessage("관외대출회원만 이용 가능합니다.", request, response);
			return null;
		}

		/**
		 * 00147010 안동
		 * 00147011 용상
		 * 00147039풍산
		 */
		if (!"00147010,00147011,00147039".contains(member.getLoca())) {
			service.alertMessage("안동도서관(본관, 용상분관, 풍산분관) 회원만 이용 가능합니다.", request, response);
			return null;
		}


		bookDream.setUser_no(getSessionUserId(request));
		service.setPaging(model, service.getMyRequestListCount(bookDream), bookDream);
		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamList", service.getMyRequestList(bookDream));
		return basePath + "mypage";
	}

	/**
	 * 수정 폼
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/modifyForm.*" }, method = RequestMethod.GET)
	public String modifyForm(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = getSessionMemberInfo(request);
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}

		if (member == null || StringUtils.isEmpty(member.getUser_id())) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "login.do", request, response);
			return null;
		}

		if (StringUtils.isNotEmpty(member.getUser_id()) && member.getUser_id().startsWith("*")) {
			service.alertMessage("관외대출회원만 이용 가능합니다.", request, response);
			return null;
		}

		/**
		 * 00147010 안동
		 * 00147011 용상
		 * 00147039풍산
		 */
		if (!"00147010,00147011,00147039".contains(member.getLoca())) {
			service.alertMessage("안동도서관(본관, 용상분관, 풍산분관) 회원만 이용 가능합니다.", request, response);
			return null;
		}

		BookDream requestOne = null;

		try {
			bookDream.setUser_no(getSessionMemberInfo(request).getUser_id());
			bookDream.setUser_id(getSessionMemberId(request));
			requestOne = service.getMyRequestOne(bookDream);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (requestOne == null) {
			service.alertMessage("잘못된 경로로 접근하였습니다.", request, response);
			return null;
		}

		model.addAttribute("bookDream", requestOne);
		return basePath + "modifyForm";
	}

	/**
	 * 네이버 검색결과
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = { "/naverSearch.*" }, method = RequestMethod.GET)
	public String naverSearch(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = getSessionMemberInfo(request);
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		Map<String, Object> map = service.getNaverSearch(bookDream, "list");
		String totalCount = String.valueOf(((Map<String, Object>)((Map<String, Object>)map.get("rss")).get("channel")).get("total"));
		List<Map<String, Object>> itemList = null;
		if ("1".equals(totalCount)) {
			itemList = new ArrayList<Map<String, Object>>();
			Map<String, Object> a = (Map<String, Object>)((Map<String, Object>)((Map<String, Object>)map.get("rss")).get("channel")).get("item");
			itemList.add((Map<String, Object>)((Map<String, Object>)((Map<String, Object>)map.get("rss")).get("channel")).get("item"));
		} else {
			itemList = (List<Map<String, Object>>)((Map<String, Object>)((Map<String, Object>)map.get("rss")).get("channel")).get("item");
		}
		if (itemList != null && itemList.size() > 0) {
			for (Map<String, Object> map2 : itemList) {
				String isbn = String.valueOf(map2.get("isbn"));
				String isbn10 = String.valueOf(map2.get("isbn")).split(" ")[0];
				String isbn13 = String.valueOf(map2.get("isbn")).split(" ").length > 1 ? String.valueOf(map2.get("isbn")).split(" ")[1] : "";

				if (StringUtils.isNotEmpty(isbn10)) {
					isbn = isbn.replaceAll("<b>", "").replaceAll("</b>", "");
				}
				if (StringUtils.isNotEmpty(isbn13)) {
					isbn13 = isbn13.replaceAll("<b>", "").replaceAll("</b>", "");
				}


				boolean already = false;
				int requestCount = service.getRequestCountByIsbn(new BookDream(member.getLoca(), isbn));

				if (StringUtils.isNotEmpty(isbn)) {
					List<Map<String, String>> isbn10List = (List<Map<String, String>>) LibSearchAPI.getSameBookList("WEB", isbn10, member.getLoca()).get("dsSameBookList");
					if (isbn10List != null && isbn10List.size() > 0) {
						if (isbn10List.size() > 1) {//소유권수가 2권이상이라면 신청 못함.
							map2.put("already", true);
							already = true;
						} else if (isbn10List.size() == 1 && requestCount > 0) {//소유권수가 2권미만 0권이상(1권)이고, 신청횟수가 있으면 신청 불가.
							map2.put("already", true);
							already = true;
						}
					}

					int isbn10ListSize = isbn10List == null ? 0 : isbn10List.size();

					if (!already) {
						if (StringUtils.isNotEmpty(isbn13)) {
							List<Map<String, String>> isbn13List = (List<Map<String, String>>) LibSearchAPI.getSameBookList("WEB", isbn13, member.getLoca()).get("dsSameBookList");
							if (isbn13List != null && isbn13List.size() > 0) {
								if (isbn13List.size() > 1 || (isbn10ListSize + isbn13List.size()) > 1) {//소유권수가 2권이상이라면 신청 못함.
									map2.put("already", true);
									already = true;
								} else if ((isbn13List.size() == 1 || (isbn10List.size() + isbn13List.size()) == 1) && requestCount > 0) {//소유권수가 2권미만 0권이상(1권)이고, 신청횟수가 있으면 신청 불가.
									map2.put("already", true);
									already = true;
								}
							}
						}
					}

					if (!already && requestCount > 1) {
						map2.put("cantRequest", true);
						already = true;
					}
				} else {

				}


			}
			service.setPaging(model, Integer.parseInt(totalCount), bookDream);
			model.addAttribute("naverResult", map);
		}
		model.addAttribute("bookDream", bookDream);
		return basePath + "search_ajax";
	}

	/**
	 * 서점관리자 로그인
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/storeLogin.*" }, method = RequestMethod.GET)
	public String storeLogin(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = getSessionMemberInfo(request);
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}

		return basePath + "storeLogin_ajax";
	}


	/**
	 * 신청 process
	 * @param bookDream
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/storeLoginProc.*" }, method = RequestMethod.POST)
	public String storeLoginProc(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) {

		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		String redirectURL = "http://" + request.getServerName() + ":" + request.getServerPort();

		BookDream bd = service.getNewBookStoreAdmin(bookDream);
		if(bd != null) {
			HttpSession session = request.getSession();
			session.setAttribute("bookDreamStoreAdmin", bd);
			redirectURL = "redirect:" + redirectURL + "/ad/module/bookDream/store.do";
		} else {
			redirectURL = "redirect:" + redirectURL + "/ad/module/bookDream/storeLogin.do";
		}

		return redirectURL;
	}

	/**
	 * 서점관리자 로그아웃 process
	 * @param bookDream
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/storeLogoutProc.*" }, method = RequestMethod.GET)
	public String storeLogoutProc(Model model, BookDream bookDream, HttpServletRequest request) {

		HttpSession session = request.getSession();
		session.setAttribute("bookDreamStoreAdmin", "");

		return "redirect:/ad/module/bookDream/index.do";
	}


	/**
	 * 서점관리자 신청내역
	 * @param model
	 * @param bookDream
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/store.*" }, method = RequestMethod.GET)
	public String store(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		HttpSession session = request.getSession();
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		BookDream bdSess = null;
		try {
			bdSess = (BookDream)session.getAttribute("bookDreamStoreAdmin");

			if (bdSess == null) {
				return "redirect:/ad/module/bookDream/storeLogin.do";
			}
		} catch (ClassCastException e) {
			return "redirect:/ad/module/bookDream/storeLogin.do";
		}


		/**
		 * 00147010 안동
		 * 00147011 용상
		 * 00147039풍산
		 */
//		if (!"00147010,00147011,00147039".contains(member.getLoca())) {
//			service.alertMessage("안동도서관(본관, 용상분관, 풍산분관) 회원만 이용 가능합니다.", request, response);
//			return null;
//		}
		model.addAttribute("bookDreamEdit", bookDream);
		bookDream.setStore_no(bdSess.getS_no());
		if (bookDream.getSearch_state() == null) {
			List<String> list = new ArrayList<String>();
			list.add("10");
			list.add("13");
			list.add("15");
			list.add("17");
			list.add("20");
			list.add("30");
			list.add("40");
			bookDream.setSearch_state(list);
		}
		service.setPaging(model, service.getRequestListCount(bookDream), bookDream);
		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamList", service.getRequestList(bookDream));

		return basePath + "store_ajax";
	}

	/**
	 * 서점관리자 거래내역 process
	 * @param bookDream
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/storeHistoryList.*" }, method = RequestMethod.GET)
	public String storeHistoryList(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		BookDream bdSess = (BookDream)session.getAttribute("bookDreamStoreAdmin");

		if (bdSess == null) {
			return "redirect:/ad/module/bookDream/storeLogin.do";
		}

		if (StringUtils.isEmpty(bookDream.getSearch_type())) {
			bookDream.setSearch_type("r_name");
		}



		model.addAttribute("bookDreamEdit", bookDream);
		bookDream.setStore_no(bdSess.getS_no());
		if (bookDream.getSearch_state() == null) {
			List<String> list = new ArrayList<String>();
			list.add("20");
			list.add("30");
			list.add("40");
			list.add("50");
			bookDream.setSearch_state(list);
		}
		if (bookDream.getSearch_lib() == null) {
			List<String> list = new ArrayList<String>();
			list.add("andong");
			list.add("yongsang");
			list.add("pungsan");
			bookDream.setSearch_lib(list);
		}
		service.setPaging(model, service.getRequestListCount(bookDream), bookDream);
		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamList", service.getRequestList(bookDream));

		return basePath + "storeHistoryList_ajax";
	}

	/**
	 * 서점관리자 신청도서
	 * @param bookDream
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/storeRequestList.*" }, method = RequestMethod.GET)
	public String storeRequestlist(Model model, BookDream bookDream, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		Date now = new Date();
		Date end = new Date(2018-1900, 10, 21, 0, 0, 0); // 2018-11-21
		
		if (now.compareTo(end) >= 0) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return null;
		}
		
		BookDream bdSess = (BookDream)session.getAttribute("bookDreamStoreAdmin");

		if (bdSess == null) {
			return "redirect:/ad/module/bookDream/storeLogin.do";
		}

		model.addAttribute("bookDreamEdit", bookDream);
		bookDream.setStore_no(bdSess.getS_no());
		service.setPaging(model, service.getRequestListCount(bookDream), bookDream);
		model.addAttribute("bookDream", bookDream);
		model.addAttribute("bookDreamList", service.getRequestList(bookDream));


		return basePath + "storeRequestList_ajax";
	}
}
