package kr.go.gbelib.app.intro.join;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
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
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.certLog.CertLog;
import kr.go.gbelib.app.cms.module.certLog.CertLogService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping(value = {"/intro/join", "/intro/{context_path}/join"})
public class JoinController extends BaseController {

	private final String basePath = "/intro/join/";

	@Autowired
	private CodeService codeService;

	@Autowired
	private JoinService joinService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private CertLogService certLogService;

	/**
	 * 회원가입 화면
	 * 만14세이상, 만14세미만 선택
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/index.*"})
	public String index(@PathVariable String context_path, Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

		model.addAttribute("newMember", member);

		return basePath + "index";
	}

	/**
	 * 약관인증
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/step2.*"}, method = RequestMethod.POST)
	public String step2(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {

		model.addAttribute("newMember", member);

		return basePath + "step2";
	}

	/**
	 * 회원구분에 따른 본인인증
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/step3.*"}, method = RequestMethod.POST)
	public String step3(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {

		model.addAttribute("newMember", member);

		return basePath + "step3";
	}

	/**
	 * 회원구분에 따른 본인인증
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/cert.*"}, method = RequestMethod.POST)
	public String cert(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String certType = request.getParameter("certType");
		if (StringUtils.isEmpty(certType)) {
			codeService.alertMessagePopup("잘못된 접근입니다.", request, response);
			return null;
		}

		String returnUrl = String.format("%s://%s:%d/intro/join/certResponse.do", request.isSecure() ? "https" : "http", request.getServerName(), request.getServerPort());
		if (!StringUtils.isEmpty(certType) && certType.toLowerCase().contains("sms")) {
			model.addAttribute("result", joinService.getSmsEncData(request, returnUrl, returnUrl));
		} else if (certType.toLowerCase().contains("gpin")) {
			model.addAttribute("result", joinService.getIpinEncData(request, returnUrl));
		}

		String mode = String.valueOf(request.getParameter("mode"));
		request.getSession().setAttribute("certType", certType);
		request.getSession().setAttribute("certMode", mode);

		if (StringUtils.equals(mode.toLowerCase(), "changename")) {
			request.getSession().setAttribute("changeNameMenuIdx", request.getParameter("menu_idx"));
			request.getSession().setAttribute("changeNameContextPath", request.getParameter("contextPath"));
		}

		return basePath + "cert_ajax";
	}

	/**
	 * 회원구분에 따른 본인인증 수신
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/certResponse.*"}, method = RequestMethod.POST)
	public String certResponse(Model model, Member member, HttpServletRequest request, HttpServletResponse response) {
		response.setHeader("Cache-Control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader("Expires",0);
		if (request.getProtocol().equals("HTTP/1.1")) {
		        response.setHeader("Cache-Control", "no-cache");
		}

		String certType = String.valueOf(request.getSession().getAttribute("certType")).toLowerCase();
		String mode = String.valueOf(request.getSession().getAttribute("certMode")).toLowerCase();
		boolean certResult = false;

//		if(StringUtils.equals(System.getProperty("spring.profiles.active"), "localServer")) {
//			member.setCertComplete(true);
////			member.setMember_name("구봉민");
////			member.setCi_value("5O7+3vUCnFviqI5tPLgL4lYLbVFp+VEIB6sv8rjdA1M/gtq5xLgFE1oip/AMBGp2McakHtjHpyuZAn/cg4+dug==");
////			member.setCell_phone("01091992743");
////			member.setBirth_day("19740228");
//
//			member.setMember_name("홍길동");
//			member.setDi_value("MC0GCCqGSIb3DQIJAyEAYuPiGVkAsssdflLedxFexNBXOurjsNwVEXZcAABBB=");
////			member.setCi_value("eMHOwvyxxkueaTHdBNJcb7L4g2lg8S1p1uTZWoM7LOoHvB2KbvPdzA+BVvYeAiYH1rR9fqdz6CkE8k0wnOC/Jg==");
//			member.setCi_value("eMHOwvyxxkueaTHdBNJcb7L4g2lg8S1p1uTZWoM7LOoHvB2KbvPdzA BVvYeAiYH1rR9fqdz6CBBBAA");
////			member.setCi_value("eMHOwvyxxkueaTHdBNJcb7L4g2lg8S1p1uTZWoM7LOoHvB2KbvPdzA+BVvYeAiYH1rR9fqdz6CkE8k0");
//			member.setCell_phone("01085069542");
//			member.setBirth_day("19870607");
//			member.setSex("1");
//			member.setAge("7");
//
//		} else {
			if (!StringUtils.isEmpty(certType) && certType.contains("sms")) {
				member = joinService.smsCertProc(request, member);
			} else if (!StringUtils.isEmpty(certType) && certType.contains("gpin")) {
				member = joinService.ipinCertProc(request, member);
			}
//		}

		//본인인증 실패
		if (!member.isCertComplete()) {
			model.addAttribute("certFailed", true);
			return basePath + "certReseponse_ajax";
		}

//		System.out.println("@@@@@@@@@@@@@@@@ mode : " + mode);
//		System.out.println("@@@@@@@@@@@@@@@@ certType : " + certType);
//		System.out.println("@@@@@@@@@@@@@@@@ 인증 성명 : " + member.getMember_name());
//		System.out.println("@@@@@@@@@@@@@@@@ 인증 생년월일 : " + member.getBirth_day());
//		System.out.println("@@@@@@@@@@@@@@@@ 인증 전화번호 : " + member.getCell_phone());
//		System.out.println("@@@@@@@@@@@@@@@@ 인증 CI : " + member.getCi_value());

		//개명으로인한 성명변경
		if (StringUtils.isNotEmpty(mode) && mode.equals("changename")) {
			Member sessionMember = getSessionMemberInfo(request);

			//1. 인증받은 CI와 로그인session CI 비교
			if (!StringUtils.equals(sessionMember.getCi_value(), member.getCi_value())) {
				//본인 아님!
				model.addAttribute("changeName1", true);
				return basePath + "certReseponse_ajax";
			} else {
				//로그인session ci_value와 인증받은 session_value가 같다면
				//2.본인인증결과와 session의 이름 비교
				if (StringUtils.equals(sessionMember.getMember_name(), member.getMember_name())) {
					//이름이 동일함!
					model.addAttribute("changeName2", true);
					return basePath + "certReseponse_ajax";
				} else {
					//3. 이름이 다른 경우
					request.getSession().setAttribute("oldName", sessionMember.getMember_name());
					request.getSession().setAttribute("newName", member.getMember_name());
					model.addAttribute("changeName", true);
					return basePath + "certReseponse_ajax";
				}
			}

		}

		//아이디찾기 본인인증
//		mode = "findId";
		if (StringUtils.isNotEmpty(mode) && mode.equals("findid")) {
			model.addAttribute("findId", true);
			List<Map<String, Object>> memberInfo = MemberAPI.checkDupUser("1", member);
			if (memberInfo == null) {
				model.addAttribute("dupCheck2", true);
			} else {
				request.getSession().setAttribute("findId", "o");
				request.getSession().setAttribute("certMember", memberInfo);
			}
			return basePath + "certReseponse_ajax";
		}

		//패스워드찾기 본인인증
//		mode = "findPw";
		if (StringUtils.isNotEmpty(mode) && mode.equals("findpw")) {
			model.addAttribute("findPw", true);
			List<Map<String, Object>> memberInfo = MemberAPI.checkDupUser("1", member);
			if (memberInfo == null) {
				model.addAttribute("dupCheck2", true);
			} else {
				request.getSession().setAttribute("findPw", "o");
				request.getSession().setAttribute("certMember", memberInfo);
			}
			return basePath + "certReseponse_ajax";
		}

		//비회원 게시판 글쓰기
//		mode = "board";
		if (StringUtils.isNotEmpty(mode) && mode.equals("board")) {
			model.addAttribute("board", true);
			request.getSession().setAttribute("board", "o");
			request.getSession().setAttribute("certMember", member);
			return basePath + "certReseponse_ajax";
		}
		//비회원 게시판 글삭제
//		mode = "boardReply";
		if (StringUtils.isNotEmpty(mode) && mode.equals("boardReply")) {
			model.addAttribute("boardReply", true);
			request.getSession().setAttribute("boardReply", "o");
			request.getSession().setAttribute("certMember", member);
			return basePath + "certReseponse_ajax";
		}

		//재인증
		if (StringUtils.isNotEmpty(mode) && mode.equals("recert")) {
			model.addAttribute("reCert", true);
			request.getSession().setAttribute("reCert", "o");

			Member sessionMember = (Member) request.getSession().getAttribute("tempMemberSession");
			sessionMember.setCi_value(member.getCi_value());
			sessionMember.setIn_ip(request.getRemoteAddr());
			Map<String, Object> userInfo = MemberAPI.getUserInfo(sessionMember.getMember_id(), sessionMember.getMember_pw());

			Map<String, Object> memberInfo = LibSearchAPI.getListData(userInfo, "USER_DATA").get(0);

			sessionMember.setMember_id(String.valueOf(memberInfo.get("USER_ID")));
			sessionMember.setMember_name(String.valueOf(memberInfo.get("NAME")));
			sessionMember.setSex(String.valueOf(memberInfo.get("GPIN_SEX")));
			sessionMember.setBirth_day(String.valueOf(memberInfo.get("BIRTHDAY")));
			try {
				String[] handphone = String.valueOf(memberInfo.get("HANDPHONE")).split("-");
				if (String.valueOf(memberInfo.get("HANDPHONE")) != null && !String.valueOf(memberInfo.get("HANDPHONE")).equals("")) {
					sessionMember.setCell_phone(String.valueOf(memberInfo.get("HANDPHONE")));
				}
				if (handphone[0] != null && !handphone[0].equals("null")&& !handphone[0].equals("") ) {
					sessionMember.setCell_phone1(handphone[0]);
				} else {
					sessionMember.setCell_phone1("");
				}
				if (handphone[1] != null && !handphone[1].equals("null")&& !handphone[1].equals("") ) {
					sessionMember.setCell_phone2(handphone[1]);
				} else {
					sessionMember.setCell_phone2("");
				}
				if (handphone[2] != null && !handphone[2].equals("null")&& !handphone[2].equals("")) {
					sessionMember.setCell_phone3(handphone[2]);
				} else {
					sessionMember.setCell_phone3("");
				}
			} catch ( Exception e ) {
			}
			sessionMember.setSms_service_yn(String.valueOf(memberInfo.get("SMS_USE_YN")));
			sessionMember.setEmail_service_yn(String.valueOf(memberInfo.get("MAILING_USE_YN")));
			if (String.valueOf(memberInfo.get("H_ZIPCODE")) !=null && !String.valueOf(memberInfo.get("H_ZIPCODE")).equals("")) {
				sessionMember.setZipcode(String.valueOf(memberInfo.get("H_ZIPCODE")));
			} else {
				sessionMember.setZipcode("");
			}

			if (String.valueOf(memberInfo.get("H_ADDR1"))!=null && !String.valueOf(memberInfo.get("H_ADDR1")).equals("")) {
				sessionMember.setAddress1(String.valueOf(memberInfo.get("H_ADDR1")));
			} else {
				sessionMember.setAddress1("");
			}

			MemberAPI.updateMember(sessionMember);

			request.getSession().setAttribute("certMember", member);
			return basePath + "certReseponse_ajax";
		}

		//회원가입 - 아이디, 패스워드만 업데이트
		if (StringUtils.isNotEmpty(mode) && mode.equals("integration")) {
			@SuppressWarnings ("unchecked")
			Map<String, Object> integrationResultMember = (Map<String, Object>) request.getSession().getAttribute("integrationResultMember");

			//대출번호+이름으로 조회한 CI값
			String integrationResultMemberCI = String.valueOf(integrationResultMember.get("IPIN_HASH"));

			if (StringUtils.equals(integrationResultMemberCI, "null")) {
				//대출번호+이름으로 조회한 CI값이 없는 경우
				//ip, pw를 입력받기 위해 간다.
				model.addAttribute("integration", true);
				request.getSession().setAttribute("integration", "o");
				request.getSession().setAttribute("certMember", member);
			} else {
				//대출번호+이름으로 조회한 CI값이 존재하는 경우
				//팅겨내기
				if (StringUtils.equals(integrationResultMemberCI, member.getCi_value())) {
					model.addAttribute("integration", true);
					request.getSession().setAttribute("integration", "o");
					request.getSession().setAttribute("certMember", member);
				} else {
					System.out.println("@@@@@@@@@@@@@@@@ API CI : " + integrationResultMemberCI);
					System.out.println("@@@@@@@@@@@@@@@@ CERT CI: " + member.getCi_value());
					model.addAttribute("integrationFailed", true);
					request.getSession().setAttribute("integrationFailed", "o");
				}

			}

			return basePath + "certReseponse_ajax";
		}

		// 책 이음 회원 WEB ID 생성
//		if(StringUtils.isNotEmpty(mode) && mode.equals("createwebid")) {
//			model.addAttribute("createWebId", true);
//
//			return basePath + "certReseponse_ajax";
//		}

		model.addAttribute("member", member);
		request.getSession().setAttribute("certMember", member);
		request.getSession().setAttribute("certType", certType);
		model.addAttribute("parent", false);
//		certLogService.addLog(new CertLog(mode, certType, member.getMember_name(), member.getBirth_day(), member.getCell_phone(), member.getCi_value(), sb.toString(), request.getRemoteAddr()));

		if (!StringUtils.isEmpty(certType) && certType.contains("parent")) {
			//보호자 인증
			model.addAttribute("parent", true);
			request.getSession().setAttribute("parentInfo", member);
		} else if (!StringUtils.isEmpty(certType) && !certType.contains("parent")) {
			//실제 가입자 인증
			//1. ci중복자 확인(책이음 가입자 확인)
//			List<Map<String, Object>> memberInfoKl = MemberAPI.checkDupUserId("3", member);
//			if (memberInfoKl != null && memberInfoKl.size() > 0) {
//				model.addAttribute("dupCheckKl", true);
//			}

			//2. ci중복자 확인
			List<Map<String, Object>> memberInfo = MemberAPI.checkDupUser("1", member);
			if (memberInfo != null && memberInfo.size() > 0) {
				certLogService.addLog(new CertLog(mode, certType, member.getMember_name(), member.getBirth_day(), member.getCell_phone(), member.getCi_value(), "", request.getRemoteAddr()));
				model.addAttribute("dupCheck", true);
				model.addAttribute("dupUser", memberInfo.get(0));
			}


 			model.addAttribute("parent", false);
		} else {
			model.addAttribute("parent", false);
			model.addAttribute("certFailed", certResult);
		}

		return basePath + "certReseponse_ajax";
	}

	/**
	 * 회원정보 수정 전 패스워드 체크
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param member
	 * @param result
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/passCheck.*" }, method = RequestMethod.GET)
	public String passCheck(Member member, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		return basePath + "passCheck";
	}

	/**
	 * 회원정보 수정 입력
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/modifyForm.*"}, method = RequestMethod.POST)
	public String modifyForm(@PathVariable String context_path, Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		// 비번 복호화
		if (memberService.decryptMember(member) == false) {
			joinService.alertMessage("비밀번호를 다시 확인하세요", request, response);
			return null;
		}

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

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

		return basePath + "modifyForm";
	}

	/**
	 * 회원가입 정보입력
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.POST)
	public String edit(@PathVariable String context_path, Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Member certMember = (Member) request.getSession().getAttribute("certMember");
		if (certMember != null) {
			member.setMember_name(certMember.getMember_name());
			member.setBirth_day(certMember.getBirth_day());
			if (certMember.getSex().equals("1")) {
				member.setSex("0");//남
			} else {
				member.setSex("1");//여
			}
			if (StringUtils.isNotEmpty(certMember.getCell_phone())) {
				member.setCell_phone(certMember.getCell_phone());
			}
			member.setCi_value(certMember.getCi_value());
			member.setDi_value(certMember.getDi_value());
		}

		model.addAttribute("newMember", member);
		model.addAttribute("telCode", codeService.getCode("CMS", "C0003"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("email", codeService.getCode("CMS", "C0010"));
//		model.addAttribute("libraryList", LibSearchAPI.getLibraryList());

		return basePath + "edit";
	}

	/**
	 * ID 중복 확인
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param member
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/check.*"}, method = RequestMethod.POST)
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

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
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
		}

		if (!result.hasErrors()) {
			if (member.getEditMode().equals("ADD")) {
				member.setManage_code(homepage.getHomepage_code());
				String addResult = joinService.addMember(request, member);
				if (addResult.equals("0")) {
					res.setValid(true);
					res.setMessage("준회원 가입이 완료되었습니다. 데스크에 방문하여 대출증 발급 승인 절차를 진행해주시길 바랍니다.");
					res.setUrl(String.format("/intro/%s/login/index.do", homepage.getContext_path())); // 회원가입 후 홈페이지 메인으로 Redirect.
					request.getSession().invalidate();
				} else {
					res.setValid(true);
					res.setMessage(addResult);
				}
			} else if ( member.getEditMode().equals("MODIFY") ) {
				member.setRec_key(getSessionMemberInfo(request).getRec_key());
				member.setIn_ip(request.getRemoteAddr());
				member.setSms_service_yn("");
				member.setEmail_service_yn("");
				if (MemberAPI.updateMember(member)) {
					Member sessionMember = getSessionMemberInfo(request);
					sessionMember.setPhone1(member.getPhone1());
					sessionMember.setPhone2(member.getPhone2());
					sessionMember.setPhone3(member.getPhone3());
					sessionMember.setEmail1(member.getEmail1());
					sessionMember.setEmail2(member.getEmail2());
					if (StringUtils.isNotBlank(member.getMemberNewPw())) {
						MemberAPI.updateMemberPasswd(member);
						sessionMember.setMember_pw(member.getMemberNewPw());
					}
					res.setValid(true);
					res.setMessage("수정되었습니다.");
					loginService.setSessionMember(sessionMember, request);
					res.setUrl(String.format("/intro/%s/index.do", homepage.getContext_path()));
				} else {
					res.setValid(false);
					res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요.");
				}

			} else if ( member.getEditMode().equals("INTEGRATION") ) {
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
//					res.setUrl(String.format("http://www.gbelib.kr/intro/%s/login/index.do", homepage.getContext_path())); //회원가입 후 홈페이지 메인으로 Redirect.
//					request.getSession().invalidate();
//				} else {
//					res.setValid(false);
//					res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요..");
//				}
			} else if ( member.getEditMode().equals("DELETE") ) {
//				Map<String, String> map = MemberAPI.deleteMember("WEB", member);
//
//				if ( map == null ) {
//					res.setValid(true);
//					res.setMessage("탈퇴되었습니다. 이용해주셔서 감사합니다.");
//				}
//				else {
//					String code = map.get("code");
//					String message = map.get("message");
//					res.setValid(false);
//					if(StringUtils.isEmpty(message)) {
//						res.setMessage("삭제 실패하였습니다(" + code + "). 잠시후 다시 시도해주세요.");
//					} else {
//						res.setMessage(message);
//					}
//				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/integration.*"})
	public String integration(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

		model.addAttribute("newMember", member);

		return basePath + "integration";
	}

	@RequestMapping(value = {"/integration1.*"}, method=RequestMethod.POST)
	public String integration1(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

		//TODO 동일인 목록 가져오기
		model.addAttribute("newMember", member);
		return basePath + "integration1";
	}

	@RequestMapping(value = {"/integration2.*"}, method=RequestMethod.POST)
	public String integration2(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		//TODO 약관동의
		model.addAttribute("newMember", member);
		return basePath + "integration2";
//
////		Menu menuOne = (Menu) request.getAttribute("menuOne");
////		menuOne.setMenu_name("통합회원 전환");
////		request.setAttribute("menuOne", menuOne);
//		Object tempObj = request.getSession().getAttribute("certMember");
//		Member certMember = null;
//		boolean hasCert = false;
//		if (tempObj != null && tempObj instanceof Member) {
//			certMember = (Member) tempObj;
//			hasCert = true;
//		} else {
//			certMember = getSessionMemberInfo(request);
//			if (certMember != null && StringUtils.isEmpty(certMember.getCi_value())) {
////				return "redirect:integration1.do?menu_idx="+member.getMenu_idx();
//			}
//		}
//		List<Map<String, String>> ciList = MemberAPI.getDupUserList("WEB", certMember, "0004", certMember.getCi_value());
//		List<Map<String, String>> memberList = new ArrayList<Map<String, String>>();
//		List<String> userIdList = new ArrayList<String>();
//		List<String> userSeqNoList = new ArrayList<String>();
//		if (ciList == null || ciList.size() < 1) {
////			siteService.alertMessage("조회된 결과가 없습니", request, response);
////			return null;
//			ciList = MemberAPI.getDupUserList("WEB", certMember, "0001", certMember.getCi_value());
//			Member loginMember = getSessionMemberInfo(request);
//			if (loginMember.isLogin()) {
//				ciList = MemberAPI.getDupUserList("WEB", getSessionMemberInfo(request), "0001", "");
//			}
//		}
////
////		if (ciList == null || ciList.size() < 1) {
////			if (isLogin(request)) {
////				Member loginMember = getSessionMemberInfo(request);
////				Map<String, String> map = MemberAPI.getMember("WEB", loginMember);
////				if (map != null) {
////					ciList.add(map);
////				}
////			}
////		}
//
//		for (Map<String, String> map : ciList) {
//			if (!userIdList.contains(map.get("USER_ID"))) {
//				memberList.add(map);
//				userIdList.add(map.get("USER_ID"));
//				userSeqNoList.add(map.get("SEQ_NO"));
//			}
//
//			Member tempMember = new Member();
//			tempMember.setMember_name(map.get("USER_NAME"));
//			tempMember.setBirth_day(map.get("BIRTHD"));
//			tempMember.setMobile_no(map.get("MOBILE_NO"));
//			List<Map<String, String>> tempList = MemberAPI.getDupUserList("WEB", tempMember, "0001", "");
//			if (tempList != null && tempList.size() > 0) {
//				for (Map<String, String> map2 : tempList) {
//					if (!userIdList.contains(map2.get("USER_ID"))) {
//						memberList.add(map2);
//						userIdList.add(map2.get("USER_ID"));
//						userSeqNoList.add(map2.get("SEQ_NO"));
//					}
//				}
//			}
//		}
//
//		if ( StringUtils.isNotEmpty(certMember.getCell_phone()) ) {
//			Member tempMember = new Member();
//			tempMember.setMember_name(certMember.getMember_name());
//			tempMember.setBirth_day(certMember.getBirth_day());
//			tempMember.setMobile_no(certMember.getCell_phone());
//			List<Map<String, String>> tempList = MemberAPI.getDupUserList("WEB", tempMember, "0001", "");
//			if (tempList != null && tempList.size() > 0) {
//				for (Map<String, String> map2 : tempList) {
//					if (!userIdList.contains(map2.get("USER_ID"))) {
//						memberList.add(map2);
//						userIdList.add(map2.get("USER_ID"));
//						userSeqNoList.add(map2.get("SEQ_NO"));
//					}
//				}
//			}
//		}
//
//		int decLength = 0;
//		int asteriskLength = 0;
//		for (String str : userIdList) {
//			if (str.startsWith("*")) {
//				asteriskLength++;
//			} else {
//				decLength++;
//			}
//		}
//		member.setCi_value(certMember.getCi_value());
//		member.setDi_value(certMember.getDi_value());
//		member.setIntegrationIdList(StringUtils.join(userIdList, ","));
//		member.setIntegrationSeqNoList(StringUtils.join(userSeqNoList, ","));
//		if (hasCert) {
//			member.setSex(certMember.getSex());
//			member.setMember_name(certMember.getMember_name());
//			member.setBirth_day(certMember.getBirth_day());
//		}
////		request.getSession().setAttribute("certMember", certMember);
//		model.addAttribute("multiId", (decLength > 0 && asteriskLength > 0));
//		model.addAttribute("dupList", memberList);
//		model.addAttribute("newMember", member);
//		return String.format(basePath, homepage.getFolder()) + "integration2";
	}

	@RequestMapping(value = {"/integration3.*"}, method=RequestMethod.POST)
	public String integration3(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		//TODO 본인인증
//		-> 1순위로 선택한 책이음 회원 정보일 경우에는 중복체크 하지 않고 통과
//		-> 2순위로 선택한 자관 CI있는 회원정보일 경우에는 중복체크 하지 않고 통과
//		-> 3순위로 여러 정보 가운데 정보를 선택한 경우에는 반드시 CI중복체크를 진행
		model.addAttribute("newMember", member);
		return basePath + "integration3";

		//member = 일루스에서 선택한 회원.
////		Menu menuOne = (Menu) request.getAttribute("menuOne");
////		if (StringUtils.equals(member.getUnAgreeFlag(), "0002")) {
////			menuOne.setMenu_name("회원정보 수정");
////		} else {
////			menuOne.setMenu_name("통합회원 전환");
////		}
////		request.setAttribute("menuOne", menuOne);
//
//		Member certMember = null;
//		try {
//			certMember = (Member) request.getSession().getAttribute("certMember");
//		} catch ( Exception e ) {
//		}
//
//
//		boolean hasCert = false;
//		if (certMember == null || StringUtils.isEmpty(certMember.getCertType())) {
//			//로그인하고 인증없이 들어오는 경우 로그인한 세션정보를 가져온다.
//			certMember = getSessionMemberInfo(request);
//		} else {
//			hasCert = true;
//			//회원가입 또는 로그인 인증 하고 들어오는 경우
//			//request에서 받은 certMember의 값을 그대로 쓴다.
//		}
//
//		certMember.setUnAgreeFlag(member.getUnAgreeFlag());
//		certMember.setUser_id(member.getIntegrationId());
//		certMember.setIntegrationId(member.getIntegrationId());
//		certMember.setIntegrationIdList(member.getIntegrationIdList());
//		certMember.setIntegrationSeqNo(member.getIntegrationSeqNo());
//		certMember.setIntegrationSeqNoList(member.getIntegrationSeqNoList());
//		Map<String, String> memberInfo = MemberAPI.getMember("WEB", certMember);
//
//		if (!hasCert) {
//			//로그인하고 인증없이 들어오는 경우 선택 아이디의 정보로 넣는다.
//			certMember.setMember_name(memberInfo.get("USER_NAME"));
//    		certMember.setBirth_day(memberInfo.get("BIRTHD"));
//    		certMember.setSex(memberInfo.get("SEX"));
//    		//
//
//		} else {
//			//인증받고 온 경우
//			//certMember자체가 인증결과이기때문에 아무것도 안한다.
//			if (StringUtils.equals(certMember.getSex(), "1") || StringUtils.equals(certMember.getSex(), "0001")) {
//				//1남자
//				certMember.setSex("0001");
//			} else {
//				//2여자
//				certMember.setSex("0002");
//			}
//		}
//		certMember.setWeb_id(memberInfo.get("WEB_ID"));
//		certMember.setSms_service_yn(memberInfo.get("SMS_CHECK"));
//		certMember.setEmail_service_yn(memberInfo.get("MAIL_CHECK"));
//
//		String phone = memberInfo.get("TEL_NO");
//		mergeTelno(certMember, phone);
//
//		if (StringUtils.isEmpty(certMember.getCell_phone())) {
//			String cellPhone = memberInfo.get("MOBILE_NO");
//			mergeCellphone(certMember, cellPhone);
//		}
//
//		String email = memberInfo.get("EMAIL");
//		if ( !StringUtils.isEmpty(email) ) {
//			String[] arr = email.split("@");
//			if (arr != null && arr.length > 1) {
//				certMember.setEmail1(arr[0]);
//				if ( arr.length > 1 ) {
//					certMember.setEmail2(arr[1]);
//				}
//			}
//		}
//
//		/*member.setDi_value(memberInfo.get("DUPINFO"));*/
////		certMember.setCi_value(memberInfo.get("CONN_INFO"));
//		certMember.setZipcode(memberInfo.get("ZIP_CODE"));
//		certMember.setAddress1(memberInfo.get("ADDRS").replaceAll("null", ""));
//		certMember.setLoca(memberInfo.get("LOCA"));
//		certMember.setLoca_name(memberInfo.get("LOCA_NAME"));
//
//
//		model.addAttribute("newMember", new Member());
//		model.addAttribute("member", certMember);
//		model.addAttribute("memberInfo", certMember);
//		model.addAttribute("libList", MemberAPI.getLibInfoQry("WEB", "0001", null));
//		model.addAttribute("telCode", codeService.getCode("CMS", "C0003"));
//		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0002"));
//		model.addAttribute("email", codeService.getCode("CMS", "C0010"));
//
//
//		return String.format(basePath, homepage.getFolder()) + "integration3";
	}

	@RequestMapping(value = {"/integration4.*"}, method=RequestMethod.POST)
	public String integration4(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		//TODO 정보입력

		return basePath + "integration4";

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