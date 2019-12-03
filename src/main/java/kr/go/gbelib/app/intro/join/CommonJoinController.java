package kr.go.gbelib.app.intro.join;

import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping(value = {"/{homepagePath}/intro/join"})
public class CommonJoinController extends BaseController {

	private String basePath = "/homepage/%s/commonIntro/join/";

	@Autowired
	private JoinService joinService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MenuService menuService;

	/**
	 * 회원가입 step1 - 만14세이상, 만14세미만 선택
	 * @author whalesoft YONGJU 2019. 12. 2.
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Member member, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		model.addAttribute("newMember", member);
		return String.format(basePath, homepage.getFolder()) + "index";
	}

	/**
	 * 회원가입 step2 - 약관인증
	 * @author whalesoft YONGJU 2019. 12. 2.
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/step2.*"}, method = RequestMethod.POST)
	public String step2(Model model, Member member, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		model.addAttribute("newMember", member);
		return String.format(basePath, homepage.getFolder()) + "step2";
	}

	/**
	 * 회원가입 step3 - 본인인증
	 * @author whalesoft YONGJU 2019. 12. 2.
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/step3.*"}, method = RequestMethod.POST)
	public String step3(Model model, Member member, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		model.addAttribute("newMember", member);
		return String.format(basePath, homepage.getFolder()) + "step3";
	}

	/**
	 * 회원가입 step4 - 정보입력
	 * @author whalesoft YONGJU 2019. 12. 2.
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.POST)
	public String edit(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		Member certMember = (Member) request.getSession().getAttribute("certMember");
		if (certMember != null) {
			member.setMember_name(certMember.getMember_name());
			member.setBirth_day(certMember.getBirth_day());
			if (certMember.getSex().equals("1")) {
				member.setSex("0");// 남
			} else {
				member.setSex("1");// 여
			}
			if (StringUtils.isNotEmpty(certMember.getCell_phone())) {
				member.setCell_phone(certMember.getCell_phone());
				member.setCell_phone1(certMember.getCell_phone1());
				member.setCell_phone2(certMember.getCell_phone2());
				member.setCell_phone3(certMember.getCell_phone3());
			}
			member.setCi_value(certMember.getCi_value());
			member.setDi_value(certMember.getDi_value());
		} else {
			joinService.alertMessage("본인인증이 필요합니다.", request, response);
			return null;
		}

		model.addAttribute("newMember", member);
		model.addAttribute("telCode", codeService.getCode("CMS", "C0003"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("email", codeService.getCode("CMS", "C0010"));

		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	/**
	 * ID 중복 확인
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param member
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/check.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse check(Member member, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "member_id", "사용자ID를 입력해주세요.");
		ValidationUtils.rejectOnlyEngNum(result, "member_id", 6, 20, "아이디는 영문, 숫자 조합 6자 이상 20자 이하로 입력하세요.");

		if (!result.hasErrors()) {
			List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("0", member);
			if (CollectionUtils.isEmpty(checkDupUser)) {
				res.setValid(true);
				res.setMessage("사용 가능한 ID 입니다.");
				res.setData(true);
			} else {
				res.setValid(false);
				res.setMessage("사용 불가능한 ID 입니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 회원정보 수정 전 패스워드 체크
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param member
	 * @param result
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/modifyCheck.*"}, method = RequestMethod.GET)
	public String modifyCheck(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 2));
			joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		return String.format(basePath, homepage.getFolder()) + "modifyCheck";
	}

	/**
	 * 회원정보수정 폼
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/modifyForm.*"}, method = RequestMethod.POST)
	public String modifyForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		// 비번 복호화
		if (memberService.decryptMember(member) == false) {
			joinService.alertMessage("비밀번호를 다시 확인하세요", request, response);
			return null;
		}

		//로그인확인
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 2));
			joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http%s://%s/%s/intro/login/index.do?menu_idx=%d", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx(), loginMenuIdx), request, response);
			return null;
		}

		//비밀번호 확인
		Member sessionMemberInfo = getSessionMemberInfo(request);
		if (!member.getMember_pw().equals(sessionMemberInfo.getMember_pw())) {
			joinService.alertMessage("비밀번호가 일치하지 않습니다.", request, response);
			return null;
		}

		sessionMemberInfo.setEditMode("MODIFY");
		model.addAttribute("memberInfo", sessionMemberInfo);
		model.addAttribute("telCode", codeService.getCode("CMS", "C0003"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("email", codeService.getCode("CMS", "C0010"));

		return String.format(basePath, homepage.getFolder()) + "modifyForm";
	}

	/**
	 * 회원가입 & 회원정보수정
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param member
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);

		if ("ADD".equals(member.getEditMode())) {
			ValidationUtils.rejectIfEmpty(result, "member_id", "아이디를 입력해주세요.");
			ValidationUtils.rejectOnlyEngNum(result, "member_id", "아이디는 한글을 사용 할수 없습니다.");
			ValidationUtils.rejectOnlyEngNum(result, "member_id", 6, 20, "아이디는 영문, 숫자 조합 6자 이상 20자 이하로 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "member_pw", "비밀번호를 입력해주세요.");
			if (StringUtils.isNotBlank(member.getMember_pw())) {
				String regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d$!@#$%^&*]{9,20}$";
				Pattern pattern = Pattern.compile(regexp);
				Matcher matcher = pattern.matcher(member.getMember_pw());
				if (!matcher.matches()) {
					result.rejectValue("member_pw", "비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.");
				}
			}
			ValidationUtils.rejectIfEmpty(result, "cell_phone2", "휴대폰 번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone3", "휴대폰 번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "zipcode", "주소를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "address1", "주소를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "address2", "주소를 입력해주세요.");
		} else if ("MODIFY".equals(member.getEditMode())) {
			if (StringUtils.isNotBlank(member.getMember_pw())) {
				String regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d$!@#$%^&*]{9,20}$";
				Pattern pattern = Pattern.compile(regexp);
				Matcher matcher = pattern.matcher(member.getMember_pw());
				if (!matcher.matches()) {
					result.rejectValue("member_pw", "비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.");
				}
			}
			if (StringUtils.isNotEmpty(member.getCard_password())) {
				ValidationUtils.rejectExceptNumber(result, "card_password", 4, "대출증 비밀번호 설정은 숫자 4자리로 입력해주세요.");
			}
//			ValidationUtils.rejectIfEmpty(result, "member_pw", "비밀번호를 입력해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "cell_phone2", "휴대폰 번호를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "cell_phone3", "휴대폰 번호를 입력하세요.");
//			ValidationUtils.rejectExceptNumber(result, "cell_phone2", 3, 4, "휴대전화 4자리로 입력해주세요.");
//			ValidationUtils.rejectExceptNumber(result, "cell_phone3", 4, "휴대전화 4자리로 입력해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "zipcode", "주소를 입력해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "address1", "주소를 입력해주세요.");

//			Lending lending = new Lending();
//			lending.setMember_id(getSessionMemberId(request));
//			lending.setMenu("LENDING");
//			int elibLendCnt = lendingService.getLendMemberListCnt(lending);
//			lending.setMenu("RESERVE");
//			int elibReserveCnt = lendingService.getReserveMemberListCnt(lending);
//
//			if ((elibLendCnt + elibReserveCnt) > 0) {
//				String currLoca = getSessionMemberInfo(request).getLoca();
//				String modLoca = member.getLoca();
//				if (StringUtils.isNotEmpty(modLoca)) {
//					if (!StringUtils.equals(currLoca, modLoca)) {
//						result.reject("대출, 예약중인 전자 콘텐츠가 있는 경우 소속도서관을 변경할 수 없습니다.");
//					}
//				}
//			}
		}

		if ( !result.hasErrors() ) {
			if (member.getEditMode().equals("ADD")) {
				member.setManage_code(homepage.getHomepage_code());
				String addResult = joinService.addMember(request, member);
				if (addResult.equals("0")) {
					res.setValid(true);
					res.setMessage("준회원 가입이 완료되었습니다. 도서관에 방문하여 대출증 발급 승인 절차를 진행해주시길 바랍니다.");
					int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 2));
					res.setUrl(String.format("http%s://%s/%s/intro/login/index.do?menu_idx=%d", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx));
					request.getSession().invalidate();
				} else {
					res.setValid(true);
					res.setMessage(addResult);
				}
			} else if ( member.getEditMode().equals("MODIFY") ) {
				member.setRec_key(getSessionMemberInfo(request).getRec_key());
				member.setIn_ip(request.getRemoteAddr());
				if (MemberAPI.updateMember(member)) {
					Member sessionMember = getSessionMemberInfo(request);
					sessionMember.setPhone1(member.getPhone1());
					sessionMember.setPhone2(member.getPhone2());
					sessionMember.setPhone3(member.getPhone3());
					sessionMember.setEmail1(member.getEmail1());
					sessionMember.setEmail2(member.getEmail2());
					if (StringUtils.isNotBlank(member.getMemberNewPw())) {
						ApiResponse updateMemberPasswd = MemberAPI.updateMemberPasswd(member);
						if (updateMemberPasswd.getStatus()) {
							sessionMember.setMember_pw(member.getMemberNewPw());
						}
					}
					res.setValid(true);
					res.setMessage("수정되었습니다.");
					loginService.setSessionMember(sessionMember, request);
					res.setUrl(String.format("/%s/join/modifyCheck.do?menu_idx=%d", homepage.getContext_path(), member.getMenu_idx()));
				} else {
					res.setValid(false);
					res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요.");
				}
			} else if ( member.getEditMode().equals("INTEGRATION") ) {//통합회원 전환
				Member certMember = (Member) request.getSession().getAttribute("certMember");
				if(certMember != null) {
					member.setCi_value(certMember.getCi_value());
					member.setDi_value(certMember.getDi_value());
				}
//				if ( MemberAPI.updateMember("WEB", member, true) ) {
//					try {
//						joinService.integrationMember(member);//회원통합 프로시저 콜
//					}
//					catch ( Exception e ) {
//					}
//					MemberAPI.agreePrtcInfo("WEB", member.getUser_id(), member.getLoca(), "1,2,6".split(","));
//					res.setValid(true);
//					res.setMessage("수정되었습니다.");
////					int menuIdx = homepageService.getMenuIdxByLinkUrl(homepage.getHomepage_id(), "/intro/join/modifyForm.do");
////					res.setUrl(String.format("https://%s/%s/intro/join/modifyForm.do?menu_idx=%d", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), menuIdx));
//					res.setUrl(String.format("http://%s/%s/index.do", homepage.getDomainWithoutProtocol(), homepage.getContext_path()));
//				} else {
//					res.setValid(false);
//					res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요..");
//				}

			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 회원탈퇴 폼
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/secessionForm.*"})
	public String secessionForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 2));
			joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://%s/%s/intro/login/index.do?menu_idx=%d", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		model.addAttribute("memberInfo", new Member());
		return String.format(basePath, homepage.getFolder()) + "secessionForm";
	}

	/**
	 * 회원 탈퇴
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param member
	 * @param result
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/secession.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse secession(Member member, BindingResult result, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		JsonResponse res = new JsonResponse(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 2));
			res.setValid(true);
			res.setMessage("로그인 후 이용가능합니다.");
			res.setUrl(String.format("http://%s/%s/intro/login/index.do?menu_idx=%d", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx));
			return res;
		}

		if (!result.hasErrors()) {
			Member sessionMember = getSessionMemberInfo(request);

			if (memberService.decryptMember(member) == false) {
				res.setValid(false);
				res.setMessage("비밀번호가 올바르지 않습니다.");
				return res;
			}
			Map<String, Object> userInfo = MemberAPI.getUserInfo(sessionMember.getMember_id(), member.getMember_pw());

			String resultInfo = String.valueOf(userInfo.get("RESULT_INFO"));

//			boolean isChild = false;
			if ("SUCCESS".equals(resultInfo)) {
				try {
					List<Map<String, Object>> listData = LibSearchAPI.getListData(userInfo, "USER_DATA");
					if (listData != null && listData.size() > 0) {
//						Map<String, Object> map = listData.get(0);
//						String birth = String.valueOf(map.get("BIRTHDAY"));
//						birth = birth.substring(0, 4);
//						SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
//						String format = sdf.format(new Date());
//						isChild = ((Integer.parseInt(format) - Integer.parseInt(birth)) + 1) < 14;
					}
				} catch (NumberFormatException e) {} catch (Exception e2) {}
			} else {
				res.setValid(false);
				res.setMessage("비밀번호가 올바르지 않습니다.");
				return res;
			}

			if (!StringUtils.equals("0", sessionMember.getOverdue_cnt())) {
				res.setValid(false);
				res.setMessage("연체 중 도서가 있는 경우 탈퇴 하실 수 없습니다.");
				return res;
			}

			Map<String, Object> loanResult = LibSearchAPI.getBookLoanList(sessionMember.getRec_key());

			List<Map<String, Object>> listData = LibSearchAPI.getListData(loanResult);

			if (listData != null && listData.size() > 0) {
				res.setValid(false);
				res.setMessage("미반납 도서가 있는 경우 탈퇴 하실 수 없습니다.");
				return res;
			}

			Map<String, Object> reserveResult = LibSearchAPI.getReserveList(sessionMember.getRec_key());

			List<Map<String, Object>> reserveData = LibSearchAPI.getListData(reserveResult);

			if (reserveData != null && reserveData.size() > 0) {
				res.setValid(false);
				res.setMessage("예약 중 도서가 있는 경우 탈퇴 하실 수 없습니다.");
				return res;
			}

			Map<String, Object> apiResult = MemberAPI.secessionUser(sessionMember.getRec_key(), request.getRemoteAddr());

			if (apiResult == null) {
				res.setValid(false);
				res.setMessage("오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			} else {
				try {
					String RESULT_INFO = String.valueOf(apiResult.get("RESULT_INFO"));

					if ("SUCCESS".equals(RESULT_INFO)) {
						res.setValid(true);
						res.setMessage("탈퇴되었습니다.");
						res.setUrl(String.format("http%s://%s/%s/index.do", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path()));
						loginService.logout(request);
					} else {
						res.setValid(false);
						res.setMessage(String.valueOf(apiResult.get("RESULT_MESSAGE") + " [" + String.valueOf(apiResult.get("RESULT_CODE")) + "]"));
					}
				} catch (Exception e) {
					res.setValid(false);
					res.setMessage("오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 아이디찾기 폼
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/findIdForm.*"})
	public String findIdForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("memberInfo", member);
		return String.format(basePath, homepage.getFolder()) + "findIdForm";
	}

	/**
	 * 아이디찾기 결과
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/findId.*"})
	public String findId(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		String findIdFlag = (String) request.getSession().getAttribute("findId");
		if (findIdFlag == null) {
			return "redirect:findIdForm.do";
		}

		return String.format(basePath, homepage.getFolder()) + "findId";
	}

	/**
	 * 비밀번호찾기 폼
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/findPwForm.*"})
	public String findPwForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("memberInfo", member);
		return String.format(basePath, homepage.getFolder()) + "findPwForm";
	}

	/**
	 * 비밀번호 변경 폼
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/changePwForm.*"})
	public String changePwForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (request.getSession().getAttribute("certMember") == null) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 2));
			joinService.alertMessageAndUrl("본인인증 후 이용가능합니다.", String.format("http%s://%s/%s/intro/jogin/findPwForm.do?menu_idx=%s", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		model.addAttribute("memberInfo", member);
		return String.format(basePath, homepage.getFolder()) + "changePwForm";
	}

	/**
	 * 비밀번호 변경
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param member
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/changeMemberPw.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse changeMemberPw(Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);

		JsonResponse res = new JsonResponse(request);

		if (memberService.decryptMember(member) == false) {
			result.reject("member_pw_tmp", "비밀번호를 다시 확인해주세요.");
		}

		if (request.getSession().getAttribute("certMember") == null) {
			result.reject("본인인증 후 가능합니다.");
		}

		if (!result.hasErrors()) {

			@SuppressWarnings ("unchecked")
			Map<String, Object> certMember = (Map<String, Object>) request.getSession().getAttribute("certMember");

			member.setRec_key(String.valueOf(certMember.get("REC_KEY")));
			member.setIn_ip(request.getRemoteAddr());

			ApiResponse apiResult = MemberAPI.updateMemberPasswd(member);
			res.setValid(apiResult.getStatus());
			if (apiResult.getStatus()) {
				res.setMessage("비밀번호가 변경되었습니다.");
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 2));
				res.setUrl(String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx));
			} else {
				res.setMessage(apiResult.getMessage());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/integration.*"})
	public String integration(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		Member sessionMember = getSessionMemberInfo(request);
		sessionMember.setMenu_idx(member.getMenu_idx());
		model.addAttribute("newMember", sessionMember);
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		menuOne.setMenu_name("통합회원 전환");
		request.setAttribute("menuOne", menuOne);
		return String.format(basePath, homepage.getFolder()) + "integration";
	}

	@RequestMapping(value = {"/integration1.*"})
	public String integration1(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		Member sessionMember = getSessionMemberInfo(request);
		sessionMember.setMenu_idx(member.getMenu_idx());
		model.addAttribute("newMember", sessionMember);
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		menuOne.setMenu_name("통합회원 전환");
		request.setAttribute("menuOne", menuOne);
		return String.format(basePath, homepage.getFolder()) + "integration1";
	}

	@RequestMapping(value = {"/integration2.*"}, method=RequestMethod.POST)
	public String integration2(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);


		Menu menuOne = (Menu) request.getAttribute("menuOne");
		menuOne.setMenu_name("아이디 선택");
		request.setAttribute("menuOne", menuOne);
		return String.format(basePath, homepage.getFolder()) + "integration2";
	}

	@RequestMapping(value = {"/integration3.*"})
	public String integration3(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		//member = 일루스에서 선택한 회원.
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		if (StringUtils.equals(member.getUnAgreeFlag(), "0002")) {
			menuOne.setMenu_name("회원정보 수정");
		} else {
			menuOne.setMenu_name("통합회원 전환");
		}
		request.setAttribute("menuOne", menuOne);



		return String.format(basePath, homepage.getFolder()) + "integration3";
	}

	/**
	 * 최근접속등 표시 페이지
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/accessInfo.*"})
	public String accessInfo(Model model, Member member, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("newMember", member);
//		model.addAttribute("libraryList", LibSearchAPI.getLibraryList());
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		if (menuOne == null) {

			int menuIdx = homepageService.getMenuIdxByLinkUrl(homepage.getHomepage_id(), "/intro/join/modifyForm.do");
			return "redirect:/"+homepage.getContext_path()+"/intro/join/accessInfo.do?menu_idx="+menuIdx;
		}
		menuOne.setMenu_name("최근 접속 기록");
		request.setAttribute("menuOne", menuOne);
		return String.format(basePath, homepage.getFolder()) + "accessInfo";
	}


	/**
	 * 패스워드 만료 페이지
	 * @author YONGJU 2018. 9. 27.
	 * @param member
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/passwordExpiry.*"})
	public String passwordExpiry(Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		return String.format(basePath, homepage.getFolder()) + "passwordExpiry";
	}

}