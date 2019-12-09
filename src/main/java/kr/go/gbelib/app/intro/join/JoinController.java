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
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.certLog.CertLog;
import kr.go.gbelib.app.cms.module.certLog.CertLogService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping (value = {"/intro/join", "/intro/{context_path}/join"})
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
	 * 회원가입 화면 만14세이상, 만14세미만 선택
	 *
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/index.*"})
	public String index(@PathVariable String context_path, Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

		model.addAttribute("newMember", member);

		return basePath + "index";
	}

	/**
	 * 약관인증
	 *
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/step2.*"}, method = RequestMethod.POST)
	public String step2(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {

		model.addAttribute("newMember", member);

		return basePath + "step2";
	}

	/**
	 * 회원구분에 따른 본인인증
	 *
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/step3.*"}, method = RequestMethod.POST)
	public String step3(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {

		model.addAttribute("newMember", member);

		return basePath + "step3";
	}

	/**
	 * 회원구분에 따른 본인인증
	 *
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/cert.*"}, method = RequestMethod.POST)
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

		request.getSession().setAttribute("certType", certType);
		String mode = String.valueOf(request.getParameter("mode"));
		request.getSession().setAttribute("certMode", mode);
		if (StringUtils.equals(mode, "findpw")) {
			// 비밀번호 찾기 시 아이디와 한번더 비교한다.
			String member_id = String.valueOf(request.getParameter("member_id"));
			request.getSession().setAttribute("findPwMemberId", member_id);
		}

		if (StringUtils.equals(mode.toLowerCase(), "changename")) {
			request.getSession().setAttribute("changeNameMenuIdx", request.getParameter("menu_idx"));
			request.getSession().setAttribute("changeNameContextPath", request.getParameter("contextPath"));
		}

		return basePath + "cert_ajax";
	}

	/**
	 * 회원구분에 따른 본인인증 수신
	 *
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/certResponse.*"}, method = RequestMethod.POST)
	public String certResponse(Model model, Member member, HttpServletRequest request, HttpServletResponse response) {
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		if (request.getProtocol().equals("HTTP/1.1")) {
			response.setHeader("Cache-Control", "no-cache");
		}

		String certType = String.valueOf(request.getSession().getAttribute("certType")).toLowerCase();
		String mode = String.valueOf(request.getSession().getAttribute("certMode")).toLowerCase();
		boolean certResult = false;

		// if(StringUtils.equals(System.getProperty("spring.profiles.active"), "localServer")) {
		// member.setCertComplete(true);
		//// member.setMember_name("구봉민");
		//// member.setCi_value("5O7+3vUCnFviqI5tPLgL4lYLbVFp+VEIB6sv8rjdA1M/gtq5xLgFE1oip/AMBGp2McakHtjHpyuZAn/cg4+dug==");
		//// member.setCell_phone("01091992743");
		//// member.setBirth_day("19740228");
		//
		// member.setMember_name("홍길동");
		// member.setDi_value("MC0GCCqGSIb3DQIJAyEAYuPiGVkAsssdflLedxFexNBXOurjsNwVEXZcAABBB=");
		//// member.setCi_value("eMHOwvyxxkueaTHdBNJcb7L4g2lg8S1p1uTZWoM7LOoHvB2KbvPdzA+BVvYeAiYH1rR9fqdz6CkE8k0wnOC/Jg==");
		// member.setCi_value("eMHOwvyxxkueaTHdBNJcb7L4g2lg8S1p1uTZWoM7LOoHvB2KbvPdzA BVvYeAiYH1rR9fqdz6CBBBAA");
		//// member.setCi_value("eMHOwvyxxkueaTHdBNJcb7L4g2lg8S1p1uTZWoM7LOoHvB2KbvPdzA+BVvYeAiYH1rR9fqdz6CkE8k0");
		// member.setCell_phone("01085069542");
		// member.setBirth_day("19870607");
		// member.setSex("1");
		// member.setAge("7");
		//
		// } else {
		if (!StringUtils.isEmpty(certType) && certType.contains("sms")) {
			member = joinService.smsCertProc(request, member);
		} else if (!StringUtils.isEmpty(certType) && certType.contains("gpin")) {
			member = joinService.ipinCertProc(request, member);
		}
		// }

		// 본인인증 실패
		if (!member.isCertComplete()) {
			model.addAttribute("certFailed", true);
			return basePath + "certReseponse_ajax";
		}

		// System.out.println("@@@@@@@@@@@@@@@@ mode : " + mode);
		// System.out.println("@@@@@@@@@@@@@@@@ certType : " + certType);
		// System.out.println("@@@@@@@@@@@@@@@@ 인증 성명 : " + member.getMember_name());
		// System.out.println("@@@@@@@@@@@@@@@@ 인증 생년월일 : " + member.getBirth_day());
		// System.out.println("@@@@@@@@@@@@@@@@ 인증 전화번호 : " + member.getCell_phone());
		// System.out.println("@@@@@@@@@@@@@@@@ 인증 CI : " + member.getCi_value());

		// 개명으로인한 성명변경
		if (StringUtils.isNotEmpty(mode) && mode.equals("changename")) {
			Member sessionMember = getSessionMemberInfo(request);

			// 1. 인증받은 CI와 로그인session CI 비교
			if (!StringUtils.equals(sessionMember.getCi_value(), member.getCi_value())) {
				// 본인 아님!
				model.addAttribute("changeName1", true);
				return basePath + "certReseponse_ajax";
			} else {
				// 로그인session ci_value와 인증받은 session_value가 같다면
				// 2.본인인증결과와 session의 이름 비교
				if (StringUtils.equals(sessionMember.getMember_name(), member.getMember_name())) {
					// 이름이 동일함!
					model.addAttribute("changeName2", true);
					return basePath + "certReseponse_ajax";
				} else {
					// 3. 이름이 다른 경우
					request.getSession().setAttribute("oldName", sessionMember.getMember_name());
					request.getSession().setAttribute("newName", member.getMember_name());
					model.addAttribute("changeName", true);
					return basePath + "certReseponse_ajax";
				}
			}

		}

		// 아이디찾기 본인인증
		// mode = "findId";
		if (StringUtils.isNotEmpty(mode) && mode.equals("findid")) {
			model.addAttribute("findId", true);
			request.getSession().setAttribute("findId", "o");
			List<Map<String, Object>> memberInfo = MemberAPI.checkDupUser("1", member);
			if (memberInfo == null) {
				model.addAttribute("dupCheck2", true);
			} else {
				request.getSession().setAttribute("certMember", memberInfo.get(0));
			}
			return basePath + "certReseponse_ajax";
		}

		// 패스워드찾기 본인인증
		// mode = "findPw";
		if (StringUtils.isNotEmpty(mode) && mode.equals("findpw")) {
			model.addAttribute("findPw", true);
			request.getSession().setAttribute("findPw", "o");
			List<Map<String, Object>> memberInfo = MemberAPI.checkDupUser("1", member);
			model.addAttribute("dupCheck2", true);
			if (CollectionUtils.isNotEmpty(memberInfo)) {
				String member_id = (String) request.getSession().getAttribute("findPwMemberId");
				for (Map<String, Object> map : memberInfo) {
					if (StringUtils.equals(member_id, String.valueOf(map.get("USER_ID")))) {
						request.getSession().setAttribute("certMember", memberInfo.get(0));
						model.addAttribute("dupCheck2", false);
						break;
					}
				}
			}
			return basePath + "certReseponse_ajax";
		}

		// 비회원 게시판 글쓰기
		// mode = "board";
		if (StringUtils.isNotEmpty(mode) && mode.equals("board")) {
			model.addAttribute("board", true);
			request.getSession().setAttribute("board", "o");
			request.getSession().setAttribute("certMember", member);
			return basePath + "certReseponse_ajax";
		}
		// 비회원 게시판 글삭제
		// mode = "boardReply";
		if (StringUtils.isNotEmpty(mode) && mode.equals("boardReply")) {
			model.addAttribute("boardReply", true);
			request.getSession().setAttribute("boardReply", "o");
			request.getSession().setAttribute("certMember", member);
			return basePath + "certReseponse_ajax";
		}

		// 재인증
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
				if (handphone[0] != null && !handphone[0].equals("null") && !handphone[0].equals("")) {
					sessionMember.setCell_phone1(handphone[0]);
				} else {
					sessionMember.setCell_phone1("");
				}
				if (handphone[1] != null && !handphone[1].equals("null") && !handphone[1].equals("")) {
					sessionMember.setCell_phone2(handphone[1]);
				} else {
					sessionMember.setCell_phone2("");
				}
				if (handphone[2] != null && !handphone[2].equals("null") && !handphone[2].equals("")) {
					sessionMember.setCell_phone3(handphone[2]);
				} else {
					sessionMember.setCell_phone3("");
				}
			} catch (Exception e) {}
			sessionMember.setSms_service_yn(String.valueOf(memberInfo.get("SMS_USE_YN")));
			sessionMember.setEmail_service_yn(String.valueOf(memberInfo.get("MAILING_USE_YN")));
			if (String.valueOf(memberInfo.get("H_ZIPCODE")) != null && !String.valueOf(memberInfo.get("H_ZIPCODE")).equals("")) {
				sessionMember.setZipcode(String.valueOf(memberInfo.get("H_ZIPCODE")));
			} else {
				sessionMember.setZipcode("");
			}

			if (String.valueOf(memberInfo.get("H_ADDR1")) != null && !String.valueOf(memberInfo.get("H_ADDR1")).equals("")) {
				sessionMember.setAddress1(String.valueOf(memberInfo.get("H_ADDR1")));
			} else {
				sessionMember.setAddress1("");
			}

			MemberAPI.updateMember(sessionMember);

			request.getSession().setAttribute("certMember", member);
			return basePath + "certReseponse_ajax";
		}

		// 통합인증
		if (StringUtils.isNotEmpty(mode) && mode.equals("integration")) {

			//보호자 인증
			if (!StringUtils.isEmpty(certType) && certType.contains("parent")) {
				model.addAttribute("integration", true);
				model.addAttribute("parent", true);
				request.getSession().setAttribute("parentInfo", member);
			} else {
				//통합 선택한 회원
				@SuppressWarnings ("unchecked")
				Map<String, Object> integrationMember = (Map<String, Object>) request.getSession().getAttribute("integrationMember");
				int	order = Integer.parseInt(String.valueOf(integrationMember.get("INTEGRATION_ORDER")));

				if (order == 1 || order == 2) {//1순위 - 책이음회원 //2순위 - CI 있는 경우
					request.getSession().setAttribute("integration", "o");
					request.getSession().setAttribute("certMember", member);

					String selectedCi = (String) integrationMember.get("IPIN_HASH");

					if (member.getCi_value().equals(selectedCi)) {
						model.addAttribute("integration", true);
						if (StringUtils.equals(member.getAge(), "2")) {//만14세미만인경우 보호자 인증을 받아야한다.
							model.addAttribute("needParentCert", true);
						}
					} else {
						model.addAttribute("integrationFailed2", true);
					}

				} else {//3순위 - CI 없는 경우
					List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("1", member);
					if (CollectionUtils.isEmpty(checkDupUser)) {
						if (StringUtils.equals(member.getAge(), "2")) {//만14세미만인경우 보호자 인증을 받아야한다.
							model.addAttribute("needParentCert", true);
						}
						model.addAttribute("integration", true);
						request.getSession().setAttribute("integration", "o");
						request.getSession().setAttribute("certMember", member);
					} else {
						model.addAttribute("integrationFailedUserNo", checkDupUser.get(0).get("USER_NO"));
						model.addAttribute("integrationFailed", true);
						request.getSession().setAttribute("integrationFailed", "o");
					}
				}
			}

			return basePath + "certReseponse_ajax";
		}

		// 책 이음 회원 WEB ID 생성
		// if(StringUtils.isNotEmpty(mode) && mode.equals("createwebid")) {
		// model.addAttribute("createWebId", true);
		//
		// return basePath + "certReseponse_ajax";
		// }

		model.addAttribute("member", member);
		request.getSession().setAttribute("certMember", member);
		request.getSession().setAttribute("certType", certType);
		model.addAttribute("parent", false);
		// certLogService.addLog(new CertLog(mode, certType, member.getMember_name(), member.getBirth_day(), member.getCell_phone(), member.getCi_value(), sb.toString(), request.getRemoteAddr()));

		if (!StringUtils.isEmpty(certType) && certType.contains("parent")) {
			// 보호자 인증
			model.addAttribute("parent", true);
			request.getSession().setAttribute("parentInfo", member);
		} else if (!StringUtils.isEmpty(certType) && !certType.contains("parent")) {
			// 실제 가입자 인증
			// 1. ci중복자 확인(책이음 가입자 확인)
			// List<Map<String, Object>> memberInfoKl = MemberAPI.checkDupUserId("3", member);
			// if (memberInfoKl != null && memberInfoKl.size() > 0) {
			// model.addAttribute("dupCheckKl", true);
			// }

			// 2. ci중복자 확인
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
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param member
	 * @param result
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/passCheck.*"}, method = RequestMethod.GET)
	public String passCheck(Member member, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		return basePath + "passCheck";
	}

	/**
	 * 회원정보 수정 입력
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/modifyForm.*"}, method = RequestMethod.POST)
	public String modifyForm(@PathVariable String context_path, Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);
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
	 *
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.POST)
	public String edit(@PathVariable String context_path, Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

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
			}
			member.setCi_value(certMember.getCi_value());
			member.setDi_value(certMember.getDi_value());
		}

		model.addAttribute("newMember", member);
		model.addAttribute("telCode", codeService.getCode("CMS", "C0003"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("email", codeService.getCode("CMS", "C0010"));
		// model.addAttribute("libraryList", LibSearchAPI.getLibraryList());

		return basePath + "edit";
	}

	/**
	 * ID 중복 확인
	 *
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

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);

		if ("ADD".equals(member.getEditMode()) || "INTEGRATION".equals(member.getEditMode())) {
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
				member.setManage_code(homepage.getManage_code());
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
			} else if (member.getEditMode().equals("MODIFY")) {
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
						ApiResponse updateMemberPasswd = MemberAPI.updateMemberPasswd(member);
						if (updateMemberPasswd.getStatus()) {
							sessionMember.setMember_pw(member.getMemberNewPw());
						}
					}
					res.setValid(true);
					res.setMessage("수정되었습니다.");
					loginService.setSessionMember(sessionMember, request);
					res.setUrl(String.format("/intro/%s/index.do", homepage.getContext_path()));
				} else {
					res.setValid(false);
					res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요.");
				}

			} else if (member.getEditMode().equals("INTEGRATION")) {
				Member certMember = (Member) request.getSession().getAttribute("certMember");
				if (certMember != null) {
					member.setCi_value(certMember.getCi_value());
					member.setDi_value(certMember.getDi_value());
					member.setRec_key(certMember.getRec_key());
					member.setMember_name(certMember.getMember_name());
					member.setBirth_day(certMember.getBirth_day());
					member.setIn_ip(request.getRemoteAddr());
					member.setSex(certMember.getSex());
					member.setAge(certMember.getAge());
					member.setManage_code(certMember.getManage_code());
					if (StringUtils.isNotEmpty(certMember.getCell_phone())) {
						member.setCell_phone(certMember.getCell_phone());
						member.setCell_phone1(certMember.getCell_phone1());
						member.setCell_phone2(certMember.getCell_phone2());
						member.setCell_phone3(certMember.getCell_phone3());
					}
				} else {
					res.setValid(true);
					res.setMessage("세션이 만료되었습니다.");
					res.setUrl(String.format("/intro/%s/login/index.do", homepage.getContext_path())); // 검색대 메인으로 Redirect.
				}

				ApiResponse modifyMember = MemberAPI.modifyMember(member);
				if (modifyMember.getStatus()) {
					//개인정보 동의
					MemberAPI.agreeInfo(member.getManage_code(), member.getRec_key(), "N");

					//보호자동의
					if (member.getAge().equals("2") && request.getSession().getAttribute("parentInfo") != null) {
						Member parentInfo = (Member) request.getSession().getAttribute("parentInfo");
						MemberAPI.useragentinfoinsert(member.getRec_key(), parentInfo.getMember_name(), member.getManage_code());
					}

					res.setValid(true);
					res.setMessage("통합인증이 완료되었습니다.");
					res.setUrl(String.format("/intro/%s/login/index.do", homepage.getContext_path())); // 검색대 메인으로 Redirect.
					request.getSession().invalidate();
				} else {
					res.setValid(true);
					res.setMessage(modifyMember.getMessage());
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/findIdForm.*"})
	public String findIdForm(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {

		model.addAttribute("memberInfo", member);
		return basePath + "findIdForm";
	}

	@RequestMapping (value = {"/findId.*"}, method = RequestMethod.POST)
	public String findId(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {

		String findIdFlag = (String) request.getSession().getAttribute("findId");
		if (findIdFlag == null) {
			return "redirect:findIdForm.do";
		}

		return basePath + "findId";
	}

	/**
	 * 비밀번호 찾기 - 본인인증
	 *
	 * @author whalesoft YONGJU 2019. 11. 19.
	 * @param context_path
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/findPwForm.*"})
	public String findPwForm(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {

		model.addAttribute("memberInfo", member);

		return basePath + "findPwForm";
	}

	/**
	 * 비밀번호 찾기 폼
	 *
	 * @author whalesoft YONGJU 2019. 11. 19.
	 * @param context_path
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping (value = {"/changePwForm.*"}, method = RequestMethod.POST)
	public String changePwForm(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {

		model.addAttribute("memberInfo", member);

		return basePath + "changePwForm";
	}

	/**
	 * 패스워드 변경
	 *
	 * @author whalesoft YONGJU 2019. 11. 18.
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

	@RequestMapping (value = {"/integration.*"})
	public String integration(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.getSession().invalidate();
		model.addAttribute("newMember", member);

		return basePath + "integration";
	}

	@RequestMapping (value = {"/integration1.*"}, method = RequestMethod.POST)
	public String integration1(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 동일인 목록 가져오기
		List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("2", member);
		if (checkDupUser == null || CollectionUtils.isEmpty(checkDupUser)) {
			joinService.alertMessage("일치하는 회원이 없습니다.", request, response);
			return null;
		} else {
			Member integrationMember = new Member();
			integrationMember.setMember_name(String.valueOf(checkDupUser.get(0).get("NAME")));
			integrationMember.setCell_phone(String.valueOf(checkDupUser.get(0).get("HANDPHONE")).replaceAll("-", ""));
			integrationMember.setBirth_day(String.valueOf(checkDupUser.get(0).get("BIRTHDAY")).replaceAll("/", ""));

			List<Map<String, Object>> integrationMemberList = MemberAPI.checkDupUser("4", integrationMember);
			for (Map<String, Object> map : integrationMemberList) {
				map.put("ORDER2", "N");
				String ipin_hash = String.valueOf(map.get("IPIN_HASH"));
				if (ipin_hash.length() > 80) {
					map.put("ORDER2", "Y");
				}
			}

			request.getSession().setAttribute("integrationMemberList", integrationMemberList);
		}

		model.addAttribute("newMember", member);
		return basePath + "integration1";
	}

	@RequestMapping (value = {"/integration2.*"}, method = RequestMethod.POST)
	public String integration2(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

		model.addAttribute("newMember", member);
		@SuppressWarnings ("unchecked")
		List<Map<String, Object>> intList = (List<Map<String, Object>>) request.getSession().getAttribute("integrationMemberList");
		for (Map<String, Object> map : intList) {
			String rec_key = String.valueOf(map.get("USER_NO"));
			if (StringUtils.equals(rec_key, member.getUser_no())) {

				String kl_member_yn = String.valueOf(map.get("KL_MEMBER_YN"));
				String ipin_hash = String.valueOf(map.get("IPIN_HASH"));

				//선택한 회원의 통합인증 순위
				//1:책이음 회원
				//2:CI 있음
				//3:CI 없음
				int integrationOrder = 0;
				if (StringUtils.equals(kl_member_yn, "Y")) {
					integrationOrder = 1;
				} else if (ipin_hash.length() > 80) {
					integrationOrder = 2;
				} else {
					integrationOrder = 3;
				}
				map.put("INTEGRATION_ORDER", integrationOrder);
				request.getSession().setAttribute("integrationMember", map);

			}
		}
		return basePath + "integration2";
	}

	@RequestMapping (value = {"/integration3.*"}, method = RequestMethod.POST)
	public String integration3(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {

		// TODO 본인인증
		// -> 1순위로 선택한 책이음 회원 정보일 경우에는 중복체크 하지 않고 통과
		// -> 2순위로 선택한 자관 CI있는 회원정보일 경우에는 중복체크 하지 않고 통과
		// -> 3순위로 여러 정보 가운데 정보를 선택한 경우에는 반드시 CI중복체크를 진행
		model.addAttribute("newMember", member);
		return basePath + "integration3";

	}

	@RequestMapping (value = {"/integration4.*"}, method = RequestMethod.POST)
	public String integration4(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		@SuppressWarnings ("unchecked")
		Map<String, Object> integrationMember = (Map<String, Object>) request.getSession().getAttribute("integrationMember");
		Member certMember = (Member) request.getSession().getAttribute("certMember");

		if (certMember.getSex().equals("1")) {
			certMember.setSex("0");// 남
		} else {
			certMember.setSex("1");// 여
		}

		certMember.setRec_key(String.valueOf(integrationMember.get("REC_KEY")));
		certMember.setManage_code(homepage.getManage_code());
		certMember.setEditMode("INTEGRATION");
		request.getSession().setAttribute("certMember", certMember);
		model.addAttribute("newMember", certMember);

		return basePath + "integration4";

	}

}
