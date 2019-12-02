package kr.go.gbelib.app.intro.join;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;
import kr.go.gbelib.app.cms.module.elib.lending.LendingService;
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
	private LendingService lendingService;

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

	@RequestMapping(value = {"/modifyForm.*"})
	public String modifyForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		String requestURL = request.getRequestURL().toString();
		if ( !requestURL.startsWith("https://") ) {
//			return "redirect:https://" + requestURL.substring(6) + "?menu_idx=" + request.getParameter("menu_idx");
//			return "redirect:" + String.format("https://%s/%s/intro/join/modifyForm.do?menu_idx=%s", homepage.getDomainWithoutProtocol(),homepage.getContext_path(), member.getMenu_idx());
		}

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			member.setBefore_url(String.format("https://%s/%s/intro/join/modifyForm.do?menu_idx=%s", homepage.getDomainWithoutProtocol(),homepage.getContext_path(), member.getMenu_idx()));
			codeService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("https://%s/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx(), member.getBefore_url()), request, response);
			return null;
		}
		member = getSessionMemberInfo(request);
		Map<String, String> memberInfo = MemberAPI.getMember("WEB", member);
		member.setMember_name(memberInfo.get("USER_NAME"));
		member.setWeb_id(memberInfo.get("WEB_ID"));
		member.setBirth_day(memberInfo.get("BIRTHD"));
		member.setSex(memberInfo.get("SEX"));
		member.setSms_service_yn(memberInfo.get("SMS_CHECK"));
		member.setEmail_service_yn(memberInfo.get("MAIL_CHECK"));

		String phone = memberInfo.get("TEL_NO");
		mergeTelno(member, phone);
		String cellPhone = memberInfo.get("MOBILE_NO");
		mergeCellphone(member, cellPhone);

		String email = memberInfo.get("EMAIL");
		if ( !StringUtils.isEmpty(email) ) {
			String[] arr = email.split("@");
			if (arr != null && arr.length > 1) {
				member.setEmail1(arr[0]);
				if ( arr.length > 1 ) {
					member.setEmail2(arr[1]);
				}
			}
		}

		// FIXME

		/*member.setDi_value(memberInfo.get("DUPINFO"));*/
		member.setCi_value(memberInfo.get("CONN_INFO"));
		member.setZipcode(memberInfo.get("ZIP_CODE"));
		member.setAddress1(memberInfo.get("ADDRS").replaceAll(" null", ""));
		member.setLoca(memberInfo.get("LOCA"));
		member.setLoca_name(memberInfo.get("LOCA_NAME"));


		Lending lending = new Lending();
		lending.setMember_id(getSessionMemberId(request));
		lending.setMenu("LENDING");
		int elibLendCnt = lendingService.getLendMemberListCnt(lending);
		lending.setMenu("RESERVE");
		int elibReserveCnt = lendingService.getReserveMemberListCnt(lending);

		model.addAttribute("elibLendCnt", elibLendCnt + elibReserveCnt);
		model.addAttribute("newMember", new Member());
		model.addAttribute("member", member);
		model.addAttribute("memberInfo", member);
		model.addAttribute("telCode", codeService.getCode("CMS", "C0003"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("email", codeService.getCode("CMS", "C0010"));
		return String.format(basePath, homepage.getFolder()) + "modifyForm";
	}

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
		} else if ("MODIFY".equals(member.getEditMode()) || "MODIFY2".equals(member.getEditMode())) {
			if (StringUtils.isNotEmpty(member.getCard_password())) {
				ValidationUtils.rejectExceptNumber(result, "card_password", 4, "대출증 비밀번호 설정은 숫자 4자리로 입력해주세요.");
			}
			if ("MODIFY2".equals(member.getEditMode())) {
				ValidationUtils.rejectIfEmpty(result, "web_id", "아이디를 입력해주세요.");
				ValidationUtils.rejectOnlyEngNum(result, "web_id", "아이디는 영문 또는 숫자만 사용가능합니다.");
				ValidationUtils.rejectOnlyEngNum(result, "web_id", 6, 20, "아이디는 영문, 숫자 조합 6자 이상 20자 이하로 입력하세요.");
			}
//			ValidationUtils.rejectIfEmpty(result, "member_pw", "비밀번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone2", "휴대폰 번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone3", "휴대폰 번호를 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "cell_phone2", 3, 4, "휴대전화 4자리로 입력해주세요.");
			ValidationUtils.rejectExceptNumber(result, "cell_phone3", 4, "휴대전화 4자리로 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "zipcode", "주소를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "address1", "주소를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "loca", "소속 도서관이 선택되지 않았습니다.");

			Lending lending = new Lending();
			lending.setMember_id(getSessionMemberId(request));
			lending.setMenu("LENDING");
			int elibLendCnt = lendingService.getLendMemberListCnt(lending);
			lending.setMenu("RESERVE");
			int elibReserveCnt = lendingService.getReserveMemberListCnt(lending);

			if ((elibLendCnt + elibReserveCnt) > 0) {
				String currLoca = getSessionMemberInfo(request).getLoca();
				String modLoca = member.getLoca();
				if (StringUtils.isNotEmpty(modLoca)) {
					if (!StringUtils.equals(currLoca, modLoca)) {
						result.reject("대출, 예약중인 전자 콘텐츠가 있는 경우 소속도서관을 변경할 수 없습니다.");
					}
				}
			}
		}

		if ( !result.hasErrors() ) {
			if (member.getEditMode().equals("ADD")) {
				member.setManage_code(homepage.getHomepage_code());
				String addResult = joinService.addMember(request, member);
				if (addResult.equals("0")) {
					res.setValid(true);
					res.setMessage("준회원 가입이 완료되었습니다. 도서관에 방문하여 대출증 발급 승인 절차를 진행해주시길 바랍니다.");
					int menuIdx = homepageService.getMenuIdxByLinkUrl(homepage.getHomepage_id(), "/intro/login/index.do");
					res.setUrl(String.format("http%s://%s/%s/intro/login/index.do?menu_idx=%d", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path(), menuIdx));
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
					res.setUrl(String.format("/%s/index.do", homepage.getContext_path()));
				} else {
					res.setValid(false);
					res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요.");
				}


//				if ( MemberAPI.checkMemberPasswd("WEB", member) ) {
//					if ( MemberAPI.updateMember("WEB", member, false) ) {
//						res.setValid(true);
//						res.setMessage("수정되었습니다.");
//						Member sessionMember = getSessionMemberInfo(request);
//						sessionMember.setLoca(member.getLoca());
//						loginService.setSessionMember(sessionMember, request);
//						int menuIdx = homepageService.getMenuIdxByLinkUrl(homepage.getHomepage_id(), "/intro/join/modifyForm.do");
//						res.setUrl(String.format("https://%s/%s/intro/join/modifyForm.do?menu_idx=%d", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), menuIdx));
//					} else {
//						res.setValid(false);
//						res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요.");
//					}
//				} else {
//					res.setValid(false);
//					res.setMessage("비밀번호를 확인해주세요.");
//				}
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

	@RequestMapping(value = {"/editAgree.*"})
	public String editAgree(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			member.setBefore_url(String.format("https://%s/%s/intro/join/modifyForm.do?menu_idx=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx()));
			codeService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("https://%s/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx(), member.getBefore_url()), request, response);
			return null;
		}

		model.addAttribute("member", getSessionMemberInfo(request));

		return String.format(basePath, homepage.getFolder()) + "editAgree";
	}

	@RequestMapping(value = { "/saveAgree.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveAgree(Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
//			MemberAPI.agreePrtcInfo("WEB", member.getMember_id(), member.getLoca(), member.getAgree_codes().replaceAll(" ", "").split(","));
//			res.setValid(true);
//			res.setUrl(String.format("http://%s/%s/index.do", homepage.getDomainWithoutProtocol(), homepage.getContext_path()));
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/changePwForm.*"})
	public String changePwForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			member.setBefore_url(String.format("https://%s/%s/intro/join/changePwForm.do?menu_idx=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx()));
			codeService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("https://%s/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx(), member.getBefore_url()), request, response);
			return null;
		}
		member = getSessionMemberInfo(request);
		Map<String, String> memberInfo = MemberAPI.getMember("WEB", member);
		member.setMember_name(memberInfo.get("USER_NAME"));
		member.setBirth_day(memberInfo.get("BIRTHD"));
		member.setSex(memberInfo.get("SEX"));


//		model.addAttribute("member", member);
		model.addAttribute("memberInfo", member);
		return String.format(basePath, homepage.getFolder()) + "changePwForm";
	}

	@RequestMapping(value = {"/setPwForm.*"})
	public String changePwForm2(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);


		String findpw = String.valueOf(request.getSession().getAttribute("findPw"));
		Member certMember = (Member) request.getSession().getAttribute("certMember");
		if ( StringUtils.isNotEmpty(findpw) && findpw.equals("o")) {

//			Map<String, String> memberInfo = MemberAPI.getDupUser("WEB", new Member(), "0004", certMember.get("CONN_INFO"));//ci로 유저 가져온다
		Map<String, String> memberInfo = null;
//		List<Map<String, String>> memberInfoList = MemberAPI.getDupUserList("WEB", new Member(), "0004", certMember.getCi_value());//ci로 유저 가져온다
//
//		if (memberInfoList == null || memberInfoList.size() < 1) {
//			model.addAttribute("unusual", "true");
//			joinService.alertMessage("통합회원 전환 진행을 하지 않았거나 존재하지 않는 회원입니다.", request, response);
//			return null;
//		}

//		if(member != null && member.getWeb_id() != null) {
//			for ( Map<String, String> map : memberInfoList ) {
//				if (member.getWeb_id().equals(map.get("WEB_ID"))) {
//					memberInfo = map;
//					break;
//				}
//			}
//		}

//		Member certMember = (Member) request.getSession().getAttribute("certMember");
//		if ( StringUtils.isNotEmpty(findpw) && findpw.equals("o")) {
//
//			Map<String, String> memberInfo = MemberAPI.getDupUser("WEB", new Member(), "0004", certMember.getCi_value());//ci로 유저 가져온다

			if ( memberInfo == null) {
				model.addAttribute("unusual", "true");
				joinService.alertMessage("가입된 이용자가 아닙니다.", request, response);
				return null;
			}

			if (!member.getMember_name().equals(memberInfo.get("USER_NAME"))) {
				model.addAttribute("unusual", "true");
				joinService.alertMessage("입력하신 정보가 올바르지 않습니다. 입력 정보를 확인해주세요. ", request, response);
				System.out.println("@@@@@@@@@@@@@@@@ setPwError : 001 : " + certMember.getCi_value() + ", " + member.getMember_name() + ", " + memberInfo.get("USER_NAME"));
				return null;
			}

			if (!member.getWeb_id().equals(memberInfo.get("WEB_ID"))) {
				model.addAttribute("unusual", "true");
				joinService.alertMessage("입력하신 정보가 올바르지 않습니다. 입력 정보를 확인해주세요.", request, response);
				System.out.println("@@@@@@@@@@@@@@@@ setPwError : 002 : "  + certMember.getCi_value() + ", " + member.getWeb_id() + ", " + memberInfo.get("WEB_ID"));
				return null;
			}

			if (!member.getCell_phone().equals(memberInfo.get("MOBILE_NO"))) {
				model.addAttribute("unusual", "true");
				joinService.alertMessage("입력하신 정보가 올바르지 않습니다. 입력 정보를 확인해주세요.", request, response);
				System.out.println("@@@@@@@@@@@@@@@@ setPwError : 003 : "  + certMember.getCi_value() + ", " + member.getCell_phone() + ", " + memberInfo.get("MOBILE_NO"));
				return null;
			}

			model.addAttribute("unusual", "false");

			member.setUser_id(memberInfo.get("USER_ID"));
			model.addAttribute("memberInfo", member);
		} else {
			model.addAttribute("unusual", "true");
			joinService.alertMessage("잘못된 접근입니다.", request, response);
			return null;
		}

		return String.format(basePath, homepage.getFolder()) + "changePwForm2";
	}

	@RequestMapping(value = {"/createIdForm.*"})
	public String createIdForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			member.setBefore_url(String.format("https://%s/%s/intro/join/changePwForm.do?menu_idx=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx()));
			codeService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("https://%s/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx(), member.getBefore_url()), request, response);
			return null;
		}
		member = getSessionMemberInfo(request);
		Map<String, String> memberInfo = MemberAPI.getMember("WEB", member);
		member.setMember_name(memberInfo.get("USER_NAME"));
		member.setBirth_day(memberInfo.get("BIRTHD"));
		member.setSex(memberInfo.get("SEX"));


		model.addAttribute("member", member);
		model.addAttribute("memberInfo", member);
		return String.format(basePath, homepage.getFolder()) + "createIdForm";
	}

	@RequestMapping(value = { "/changePw.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse changePw(Member member, BindingResult result, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			member.setBefore_url(String.format("https://%s/%s/intro/join/changePwForm.do?menu_idx=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx()));
			codeService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("https://%s/%s/intro/login/index.do?menu_idx=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx()), request, response);
			return null;
		}
		JsonResponse res = new JsonResponse(request);
		if (memberService.decryptMember(member) == false) {
			result.reject("member_pw_tmp", "비밀번호를 다시 확인해주세요.");
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
				res.setUrl(String.format("/intro/%s/login/index.do", homepage.getContext_path()));
			} else {
				res.setMessage(apiResult.getMessage());
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
			member.setBefore_url(String.format("http://%s/%s/intro/join/changePwForm.do?menu_idx=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx()));
			codeService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://%s/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx(), member.getBefore_url()), request, response);
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

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			codeService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://%s/%s/intro/login/index.do?menu_idx=%s", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx()), request, response);
			return null;
		}

		JsonResponse res = new JsonResponse(request);

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

	@RequestMapping(value = {"/findMemberIdForm.*"})
	public String findMemberIdForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("memberInfo", member);
		return String.format(basePath, homepage.getFolder()) + "findMemberIdForm";
	}

	@RequestMapping(value = {"/findId.*"})
	public String findId(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("memberInfo", MemberAPI.getMember("WEB", member));
		return String.format(basePath, homepage.getFolder()) + "findId_ajax";
	}

	@RequestMapping(value = {"/findMemberPwForm.*"})
	public String findMemberPwForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("memberInfo", member);
		return String.format(basePath, homepage.getFolder()) + "findMemberPwForm";
	}

	@RequestMapping(value = {"/bookConnIdForm.*"})
	public String bookConnIdForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("memberInfo", member);
		return String.format(basePath, homepage.getFolder()) + "bookConnIdForm";
	}


	@RequestMapping(value = { "/findMemberId.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse findMemberId(Member member, BindingResult result, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "member_name", "성명을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "birth_day", "생년월일을 입력해주세요.");
		ValidationUtils.rejectExceptNumber(result, "birth_day", "생년월일은 숫자만 입력가능합니다.");
		ValidationUtils.rejectIfEmpty(result, "cell_phone", "휴대전화번호를 입력해주세요.");
		ValidationUtils.rejectExceptNumber(result, "cell_phone", "휴대저화번호는 숫자만 입력가능합니다.");

		if (!result.hasErrors()) {
//			member.setCheck_certify_type("MOBILE");
//			member.setCheck_certify_data(member.getCell_phone());
//			Map<String, String> memberInfo = MemberAPI.getMemberCertify("WEB", member);
//			if (memberInfo != null) {
//				res.setUrl("findId.do?user_id="+memberInfo.get("USER_ID"));
//				res.setValid(true);
//			} else {
//				res.setValid(false);
//				res.setMessage("입력하신 정보와 일치하는 정보가 존재하지 않습니다.\n입력 정보를 확인해주세요");
//			}
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
	 * 약관인증(개인정보 재동의) 폼
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/reAgree.*"})
	public String reAgree(Model model, Member member, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("newMember", member);
//		model.addAttribute("prtcNotice",MemberAPI.getPrtcNoticeList("WEB"));
//		model.addAttribute("libraryList", LibSearchAPI.getLibraryList());
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		menuOne.setMenu_name("이용약관 및 개인정보 수집·이용 재동의");
		request.setAttribute("menuOne", menuOne);
		return String.format(basePath, homepage.getFolder()) + "reAgree";
	}

	/**
	 * 약관인증(개인정보 재동의)
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping (value = { "/reAgreeA.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse reAgreeA(Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
			res.setValid(true);
			Member sessionMember = getSessionMemberInfo(request);
			sessionMember.setAgree_codes(member.getAgree_codes());
//			MemberAPI.agreePrtcInfo("WEB", sessionMember.getUser_id(), sessionMember.getLoca(), sessionMember.getAgree_codes().replaceAll(" ", "").split(","));

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, 2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
			sessionMember.setAgree_date_str(sdf.format(cal.getTime()));
			HttpSession session = request.getSession();
			session.setAttribute(StaticVariables.MEMBER, sessionMember);

			res.setMessage("재동의가 완료되었습니다.");
			res.setUrl(String.format("/%s/index.do", homepage.getContext_path()));
		}
		else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
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

	private void mergeTelno(Member member, String phone) {
		if ( !StringUtils.isEmpty(phone) ) {
			phone = phone.replaceAll("-", "");
			try {
				Long.parseLong(phone);
				if ( phone.length() > 3 ) {
					member.setPhone1(phone.substring(0, 3));
				} else {
					member.setPhone1(phone.substring(0));
				}

				String phoneTemp = phone.substring(3);
				if ( phoneTemp.length() >= 8 ) {
					member.setPhone2(phone.substring(3, 7));
					member.setPhone3(phone.substring(7));
				} else {
					member.setPhone2(phone.substring(3, 6));
					member.setPhone3(phone.substring(6));
				}
			}
			catch (NumberFormatException e) {
				if (phone.length() >= 11) {
					member.setPhone1(phone.substring(0, 3));
					member.setPhone2(phone.substring(3, 7));
					member.setPhone3(phone.substring(7));
				} else if (phone.length() == 10) {
					member.setPhone1(phone.substring(0, 3));
					member.setPhone2(phone.substring(3, 6));
					member.setPhone3(phone.substring(6));
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
	}

	private void mergeCellphone(Member member, String cellPhone) {
		if ( !StringUtils.isEmpty(cellPhone) ) {
			try {
				cellPhone = cellPhone.replaceAll("-", "");
				Long.parseLong(cellPhone);
				if ( cellPhone.length() > 3 ) {
					member.setCell_phone1(cellPhone.substring(0, 3));
				} else {
					member.setCell_phone1(cellPhone.substring(0));
				}

				String phoneTemp = cellPhone.substring(3);
				if ( phoneTemp.length() >= 8 ) {
					member.setCell_phone2(cellPhone.substring(3, 7));
					member.setCell_phone3(cellPhone.substring(7));
				} else {
					member.setCell_phone2(cellPhone.substring(3, 6));
					member.setCell_phone3(cellPhone.substring(6));
				}
			} catch (NumberFormatException e) {
				// 숫자가 아니면 파싱안함.
				if (cellPhone.length() >= 11) {
					member.setCell_phone1(cellPhone.substring(0, 3));
					member.setCell_phone2(cellPhone.substring(3, 7));
					member.setCell_phone3(cellPhone.substring(7));
				} else if (cellPhone.length() == 10) {
					member.setCell_phone1(cellPhone.substring(0, 3));
					member.setCell_phone2(cellPhone.substring(3, 6));
					member.setCell_phone3(cellPhone.substring(6));
				}
			}catch (Exception e) {
				// TODO: handle exception
			}
		}
	}

}