package kr.go.gbelib.app.intro.join;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		model.addAttribute("newMember", member);
		if (!request.getRequestURL().toString().startsWith("https://www.gbelib.kr")) {
			response.sendRedirect("https://www.gbelib.kr/intro/"+homepage.getContext_path()+"/join/index.do");
			return null;
		}
		model.addAttribute("homepage", homepage);
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
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		model.addAttribute("newMember", member);
		model.addAttribute("prtcNotice",MemberAPI.getPrtcNoticeList("WEB"));
		model.addAttribute("libraryList", LibSearchAPI.getLibraryList());
		model.addAttribute("homepage", homepage);
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
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		model.addAttribute("newMember", member);
		model.addAttribute("homepage", homepage);
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

		if (!StringUtils.isEmpty(certType) && certType.toLowerCase().contains("sms")) {
			String sReturnUrl = "https://www.gbelib.kr/intro/join/certResponse.do";
			String sErrorUrl = "https://www.gbelib.kr/intro/join/certResponse.do";
//			String sReturnUrl = "http://whalesoft.co.kr:11880/intro/join/certResponse.do";
//			String sErrorUrl = "http://whalesoft.co.kr:11880/intro/join/certResponse.do";

			model.addAttribute("result", joinService.getSmsEncData(request, sReturnUrl, sErrorUrl));
		} else if (certType.toLowerCase().contains("gpin")) {
			String sReturnUrl = "https://www.gbelib.kr/intro/join/certResponse.do";
//			String sReturnUrl = "http://whalesoft.co.kr:11880/intro/join/certResponse.do";

			model.addAttribute("result", joinService.getIpinEncData(request, sReturnUrl));
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
//		certType = request.getParameter("certType").toLowerCase();
//		certType = "parent";
		String mode = String.valueOf(request.getSession().getAttribute("certMode")).toLowerCase();
//		String certType = request.getParameter("certType").toLowerCase();
//		certType = certType.toLowerCase();
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

		//패스워드찾기 본인인증

		if (StringUtils.isNotEmpty(mode) && mode.equals("findpw")) {
			model.addAttribute("findPw", true);
			Map<String, String> memberInfo = MemberAPI.getDupUser("WEB", member, "0004", member.getCi_value());
			if (memberInfo == null) {
				model.addAttribute("dupCheck2", true);
			} else {
				request.getSession().setAttribute("findPw", "o");
				request.getSession().setAttribute("certMember", member);
			}
			return basePath + "certReseponse_ajax";
		}

		model.addAttribute("member", member);
		request.getSession().setAttribute("certMember", member);
		request.getSession().setAttribute("certType", certType);
		model.addAttribute("parent", false);
		
		// 책 이음 회원 WEB ID 생성
		if(StringUtils.isNotEmpty(mode) && mode.equals("createwebid")) {
			model.addAttribute("createWebId", true);
			
			return basePath + "certReseponse_ajax";
		}
		
		if (!StringUtils.isEmpty(certType) && certType.contains("parent")) {
			//보호자 인증
			model.addAttribute("parent", true);
		} else if (!StringUtils.isEmpty(certType) && !certType.contains("parent")) {
			//실제 가입자 인증
//			System.out.println("@@@@@@@@@@@@@@@@ 인증 성명 : " + member.getMember_name());
//			System.out.println("@@@@@@@@@@@@@@@@ 인증 생년월일 : " + member.getBirth_day());
//			System.out.println("@@@@@@@@@@@@@@@@ 인증 전화번호 : " + member.getCell_phone());
//			System.out.println("@@@@@@@@@@@@@@@@ 인증 CI : " + member.getCi_value());
			//1. ci중복자 확인
			List<Map<String, String>> ilusMemberList = MemberAPI.getDupUserList("WEB", member, "0004", member.getCi_value());
			if (ilusMemberList != null && ilusMemberList.size() > 0) {
				StringBuilder sb = new StringBuilder();
//				System.out.println("@@@@@@@@@@@@@@@@ CI 중복자 : " + ilusMemberList.size());
				sb.append("CI 중복자 : " + ilusMemberList.size() + "\n");
				model.addAttribute("dupCheck", true);
				for ( Map<String, String> map : ilusMemberList ) {
					Member ilusMember = new Member();
					ilusMember.setUser_id(map.get("USER_ID"));
					Map<String, String> ilusMemberMap = MemberAPI.getMember("WEB", ilusMember);
//					System.out.println("@@@@@@@@@@@@@@@@ CI 중복자 상세 : " + ilusMemberMap);
					sb.append("CI 중복자 상세: " + ilusMemberMap + "\n");
					if (map != null && StringUtils.isNotEmpty(ilusMemberMap.get("UN_AGREE_FLAG"))) {
						String unAgreeFlag = ilusMemberMap.get("UN_AGREE_FLAG");
						if (StringUtils.equals(unAgreeFlag, "0001") || StringUtils.equals(unAgreeFlag, "0002")) {
							model.addAttribute("unAgreeFlag", unAgreeFlag);
							break;
						}
					}
				}
				certLogService.addLog(new CertLog(mode, certType, member.getMember_name(), member.getBirth_day(), member.getCell_phone(), member.getCi_value(), sb.toString(), request.getRemoteAddr()));
			}
			
			//2. 이름, 생년월일, 휴대전화번호 동일 중복 확인
			if (certType.contains("sms")) {
				member.setMobile_no(member.getCell_phone());
				ilusMemberList = MemberAPI.getDupUserList("WEB", member, "0001", member.getCi_value());
				if (ilusMemberList != null && ilusMemberList.size() > 0) {
					StringBuilder sb = new StringBuilder();
//					System.out.println("@@@@@@@@@@@@@@@@ 이름, 생년월일, 휴대전화번호 중복자 : " + ilusMemberList.size());
					sb.append("이름, 생년월일, 휴대전화번호 중복자 : " + ilusMemberList.size() + "\n");
					model.addAttribute("dupCheck", true);
					for ( Map<String, String> map : ilusMemberList ) {
						Member ilusMember = new Member();
						ilusMember.setUser_id(map.get("USER_ID"));
						Map<String, String> ilusMemberMap = MemberAPI.getMember("WEB", ilusMember);
//						System.out.println("@@@@@@@@@@@@@@@@ 이름, 생년월일, 휴대전화번호 중복자 상세 : " + ilusMemberMap);
						sb.append("이름, 생년월일, 휴대전화번호 중복자 상세 : " + ilusMemberMap + "\n");
						if (map != null && StringUtils.isNotEmpty(ilusMemberMap.get("CONN_INFO"))) {
							String conn_info = ilusMemberMap.get("CONN_INFO");
							if (StringUtils.isEmpty(conn_info)) {
								model.addAttribute("unAgreeFlag", null);
								break;
							}
						}
						if (map != null && StringUtils.isNotEmpty(ilusMemberMap.get("UN_AGREE_FLAG"))) {
							String unAgreeFlag = ilusMemberMap.get("UN_AGREE_FLAG");
							if (StringUtils.equals(unAgreeFlag, "0001") || StringUtils.equals(unAgreeFlag, "0002")) {
								model.addAttribute("unAgreeFlag", unAgreeFlag);
								break;
							}
						}
					}
					certLogService.addLog(new CertLog(mode, certType, member.getMember_name(), member.getBirth_day(), member.getCell_phone(), member.getCi_value(), sb.toString(), request.getRemoteAddr()));
				}
			}

 			model.addAttribute("parent", false);
//			model.addAttribute("dupCheck", false);
		} else {
			model.addAttribute("parent", false);
			model.addAttribute("certFailed", certResult);
		}

		return basePath + "certReseponse_ajax";
	}

	/**
	 * 회원정보입력
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.POST)
	public String edit(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
//		String returnPage = "redirect:index.do";
		if ( member.getEditMode().equals("MODIFY") ) {
//			returnPage = basePath + "edit";
			Map<String, String> memberInfo = MemberAPI.getMember("WEB", member);
			member.setMember_name(memberInfo.get("USER_NAME"));
			member.setBirth_day(memberInfo.get("BIRTHD"));
			member.setSex(memberInfo.get("SEX"));

			String phone = memberInfo.get("TEL_NO");
			if ( StringUtils.isEmpty(phone) ) {
				String[] arr = phone.split("-");
				member.setPhone1(arr[0]);
				if ( arr.length > 1 ) {
					member.setPhone2(arr[1]);
				}
				if ( arr.length > 2 ) {
					member.setPhone3(arr[2]);
				}
			}

			String cellPhone = memberInfo.get("MOBILE_NO");
			if ( StringUtils.isEmpty(cellPhone) ) {
				String[] arr = cellPhone.split("-");
				member.setCell_phone1(arr[0]);
				if ( arr.length > 1 ) {
					member.setCell_phone2(arr[1]);
				}
				if ( arr.length > 2 ) {
					member.setCell_phone3(arr[2]);
				}
			}

			String email = memberInfo.get("EMAIL");
			if ( StringUtils.isEmpty(email) ) {
				String[] arr = email.split("@");
				member.setEmail1(arr[0]);
				if ( arr.length > 1 ) {
					member.setEmail2(arr[1]);
				}
			}

//			member.setDi_value(memberInfo.get("DUPINFO"));
//			member.setCi_value(memberInfo.get("CONN_INFO"));
			member.setZipcode(memberInfo.get("ZIP_CODE"));

			String address = memberInfo.get("ADDRS");
			if ( StringUtils.isEmpty(address) ) {
				String[] arr = address.split("|");
				member.setAddress1(arr[0]);
				if ( arr.length > 1 ) {
					member.setAddress2(arr[1]);
				}
			}
		}
		else {

			request.getSession().setAttribute("dls_id", null);
			request.getSession().setAttribute("dls_ip", null);

//			String agreeCodes = member.getAgree_codes();
//			if ( agreeCodes != null ) {
//				String[] agreeCodesArr = agreeCodes.split(",");
//				if ( agreeCodesArr.length == 4 ) {
//					returnPage = basePath + "edit";
//					if ( MemberAPI.agreePrtcInfo("WEB", member, agreeCodesArr) ) {
//						returnPage = basePath + "edit";
//					}
//				}
//			}
			Member certMember = (Member) request.getSession().getAttribute("certMember");

			if (certMember != null) {
				member.setMember_name(certMember.getMember_name());
				member.setBirth_day(certMember.getBirth_day());
				if (certMember.getSex().equals("1")) {
					member.setSex("0001");
				} else {
					member.setSex("0002");
				}
				if (StringUtils.isNotEmpty(certMember.getCell_phone())) {
					member.setCell_phone(certMember.getCell_phone());
				}
				member.setCi_value(certMember.getCi_value());
				member.setDi_value(certMember.getDi_value());
			}
		}
		model.addAttribute("newMember", member);
		model.addAttribute("telCode", codeService.getCode("CMS", "C0003"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("email", codeService.getCode("CMS", "C0010"));
		model.addAttribute("libraryList", LibSearchAPI.getLibraryList());
		model.addAttribute("homepage", homepage);
//		return returnPage;
		return basePath + "edit";
	}

	@RequestMapping(value = { "/check.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse check(Member member, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "member_id", "사용자ID를 입력해주세요.");
		ValidationUtils.rejectOnlyEngNum(result, "member_id", 6, 20, "아이디는 영문, 숫자 조합 6자 이상 20자 이하로 입력하세요.");

		if ( !result.hasErrors() ) {
			if ( MemberAPI.checkUserId("WEB", member, "WEBID") ) {
				res.setValid(true);
				res.setMessage("사용 가능한 ID 입니다.");
				res.setData(true);
			}
			else {
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
	public @ResponseBody JsonResponse save(@PathVariable String context_path, Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		JsonResponse res = new JsonResponse(request);
		
		if ( "ADD".equals(member.getEditMode()) ) {
			if (StringUtils.equals(member.getLangMode(), "eng")) {
				ValidationUtils.rejectIfEmpty(result, "member_id", "Please enter ID");
				ValidationUtils.rejectOnlyEngNum(result, "member_id", "ID can only be English or numeric");
				ValidationUtils.rejectOnlyEngNum(result, "member_id", 6, 20, "Please enter 6 or more characters and 20 or less alphanumeric characters.");
				ValidationUtils.rejectIfEmpty(result, "member_pw", "Please enter password");
//			ValidationUtils.rejectIfEmpty(result, "member_name", "이름을 입력해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "birth_day", "생년월을 입력해주세요");
//			ValidationUtils.rejectIfNotDate(result, "birth_day", "생년월일 형식이 올바르지 않습니다.");
//			ValidationUtils.rejectIfEmpty(result, "phone2", "집 전화번호를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "phone3", "집 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "cell_phone", "Please enter Mobile phone number");
//			ValidationUtils.rejectIfEmpty(result, "cell_phone2", "휴대폰 번호를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "cell_phone3", "휴대폰 번호를 입력하세요.");
//			ValidationUtils.rejectNotFullEmailType(result, "email", "이메일 형식이 올바르지 않습니다.");
				ValidationUtils.rejectIfEmpty(result, "zipcode", "Please enter Address");
				ValidationUtils.rejectIfEmpty(result, "address1", "Please enter Address");
				ValidationUtils.rejectIfEmpty(result, "loca", "Please select Affiliated library");


			} else {
				ValidationUtils.rejectIfEmpty(result, "member_id", "아이디를 입력해주세요.");
				ValidationUtils.rejectOnlyEngNum(result, "member_id", "아이디는 한글을 사용 할수 없습니다.");
				ValidationUtils.rejectOnlyEngNum(result, "member_id", 6, 20, "아이디는 영문, 숫자 조합 6자 이상 20자 이하로 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "member_pw", "비밀번호를 입력해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "member_name", "이름을 입력해주세요.");
//			ValidationUtils.rejectIfEmpty(result, "birth_day", "생년월을 입력해주세요");
//			ValidationUtils.rejectIfNotDate(result, "birth_day", "생년월일 형식이 올바르지 않습니다.");
//			ValidationUtils.rejectIfEmpty(result, "phone2", "집 전화번호를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "phone3", "집 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "cell_phone2", "휴대폰 번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "cell_phone3", "휴대폰 번호를 입력하세요.");
//			ValidationUtils.rejectNotFullEmailType(result, "email", "이메일 형식이 올바르지 않습니다.");
				ValidationUtils.rejectIfEmpty(result, "zipcode", "주소를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "address1", "주소를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "loca", "소속 도서관이 선택되지 않았습니다.");
			}

		}
		else if ( "MODIFY".equals(member.getEditMode()) ) {
			if (StringUtils.equals(member.getLangMode(), "eng")) {
				ValidationUtils.rejectIfEmpty(result, "loca", "Please select Affiliated library");
			} else {
				ValidationUtils.rejectIfEmpty(result, "loca", "소속 도서관이 선택되지 않았습니다.");
			}
		}

		if ( !result.hasErrors() ) {
			if ( member.getEditMode().equals("ADD") ) {
				String addResult = joinService.addMember(request, member);
				if (addResult.equals("0")) {
					res.setValid(true);
					res.setMessage("회원가입이 완료되었습니다.");
					res.setUrl(String.format("http://www.gbelib.kr/intro/%s/login/index.do", homepage.getContext_path())); //회원가입 후 홈페이지 메인으로 Redirect.
					request.getSession().invalidate();
				} else {
					res.setValid(true);
					res.setMessage(addResult);
				}
			} else if ( member.getEditMode().equals("MODIFY") ) {
				if ( MemberAPI.updateMember("WEB", member, false) ) {
					res.setValid(true);
					res.setMessage("수정되었습니다.");
					Member sessionMember = getSessionMemberInfo(request);
					sessionMember.setLoca(member.getLoca());
					loginService.setSessionMember(sessionMember, request);
				}
				else {
					res.setValid(false);
					res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요.");
				}
			} else if ( member.getEditMode().equals("INTEGRATION") ) {
				Member certMember = (Member) request.getSession().getAttribute("certMember");
				if(certMember != null) {
					member.setCi_value(certMember.getCi_value());
					member.setDi_value(certMember.getDi_value());
				}
				if ( MemberAPI.updateMember("WEB", member, true) ) {
					try {
						joinService.integrationMember(member);//회원통합 프로시저 콜
					}
					catch ( Exception e ) {
					}
					MemberAPI.agreePrtcInfo("WEB", member.getUser_id(), member.getLoca(), "1,2,6".split(","));
					res.setValid(true);
					res.setMessage("수정되었습니다.");
					res.setUrl(String.format("http://www.gbelib.kr/intro/%s/login/index.do", homepage.getContext_path())); //회원가입 후 홈페이지 메인으로 Redirect.
					request.getSession().invalidate();
				} else {
					res.setValid(false);
					res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요..");
				}
			} else if ( member.getEditMode().equals("DELETE") ) {
				Map<String, String> map = MemberAPI.deleteMember("WEB", member);
				
				if ( map == null ) {
					res.setValid(true);
					res.setMessage("탈퇴되었습니다. 이용해주셔서 감사합니다.");
				}
				else {
					String code = map.get("code");
					String message = map.get("message");
					res.setValid(false);
					if(StringUtils.isEmpty(message)) {
						res.setMessage("삭제 실패하였습니다(" + code + "). 잠시후 다시 시도해주세요.");
					} else {
						res.setMessage(message);
					}
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 회원가입시 DLS인증
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping (value = { "/checkDlsA.*" })
	public String checkDlsA(Model model, HttpServletRequest request) {
		String ck_flag = request.getParameter("ck_flag");
		String member_nm = request.getParameter("member_nm");

		boolean isDlsMember = false;

		if (StringUtils.isNotEmpty(ck_flag)) {
			if (StringUtils.equals(ck_flag.toLowerCase(), "true")) {
				Member member = getSessionMemberInfo(request);
				if (StringUtils.isNotEmpty(member_nm)) {
					if (StringUtils.equals(member.getMember_name(), member_nm)) {
//						MemberAPI.addMemberRegular("WEB", member);
//
//						member.setDls_id(String.valueOf(request.getSession().getAttribute("dls_id")));
//						member.setUser_ip(String.valueOf(request.getSession().getAttribute("dls_ip")));
//						member.setLib_id(member.getUser_id());
//						member.setUser_name(member.getMember_name());
//						memberService.addDlsMember(member);
						isDlsMember = true;
					}
				}
			}
		}

		model.addAttribute("isDlsMember", isDlsMember);
		return basePath + "checkDlsA_ajax";
	}

	@RequestMapping (value = { "/dlsIdCheck.*" })
	public @ResponseBody JsonResponse dlsIdCheck(Member member, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
			boolean hasId = memberService.isPassDlsId(member);
			request.getSession().setAttribute("dls_id", null);
			request.getSession().setAttribute("dls_ip", null);
			if (!hasId) {
				request.getSession().setAttribute("dls_id", member.getDls_id());
				request.getSession().setAttribute("dls_ip", request.getRemoteAddr());
			}
			res.setValid(hasId);
		}

		return res;
	}

	@RequestMapping(value = {"/integration2.*"}, method=RequestMethod.POST)
	public String integration2(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");


//		Menu menuOne = (Menu) request.getAttribute("menuOne");
//		menuOne.setMenu_name("통합회원 전환");
//		request.setAttribute("menuOne", menuOne);
		Object tempObj = request.getSession().getAttribute("certMember");
		Member certMember = null;
		boolean hasCert = false;
		if (tempObj != null && tempObj instanceof Member) {
			certMember = (Member) tempObj;
			hasCert = true;
		} else {
			certMember = getSessionMemberInfo(request);
			if (certMember != null && StringUtils.isEmpty(certMember.getCi_value())) {
//				return "redirect:integration1.do?menu_idx="+member.getMenu_idx();
			}
		}
		List<Map<String, String>> ciList = MemberAPI.getDupUserList("WEB", certMember, "0004", certMember.getCi_value());
		List<Map<String, String>> memberList = new ArrayList<Map<String, String>>();
		List<String> userIdList = new ArrayList<String>();
		List<String> userSeqNoList = new ArrayList<String>();
		if (ciList == null || ciList.size() < 1) {
//			siteService.alertMessage("조회된 결과가 없습니", request, response);
//			return null;
			ciList = MemberAPI.getDupUserList("WEB", certMember, "0001", certMember.getCi_value());
			Member loginMember = getSessionMemberInfo(request);
			if (loginMember.isLogin()) {
				ciList = MemberAPI.getDupUserList("WEB", getSessionMemberInfo(request), "0001", "");
			}
		}
//
//		if (ciList == null || ciList.size() < 1) {
//			if (isLogin(request)) {
//				Member loginMember = getSessionMemberInfo(request);
//				Map<String, String> map = MemberAPI.getMember("WEB", loginMember);
//				if (map != null) {
//					ciList.add(map);
//				}
//			}
//		}

		for (Map<String, String> map : ciList) {
			if (!userIdList.contains(map.get("USER_ID"))) {
				memberList.add(map);
				userIdList.add(map.get("USER_ID"));
				userSeqNoList.add(map.get("SEQ_NO"));
			}

			Member tempMember = new Member();
			tempMember.setMember_name(map.get("USER_NAME"));
			tempMember.setBirth_day(map.get("BIRTHD"));
			tempMember.setMobile_no(map.get("MOBILE_NO"));
			List<Map<String, String>> tempList = MemberAPI.getDupUserList("WEB", tempMember, "0001", "");
			if (tempList != null && tempList.size() > 0) {
				for (Map<String, String> map2 : tempList) {
					if (!userIdList.contains(map2.get("USER_ID"))) {
						memberList.add(map2);
						userIdList.add(map2.get("USER_ID"));
						userSeqNoList.add(map2.get("SEQ_NO"));
					}
				}
			}
		}

		if ( StringUtils.isNotEmpty(certMember.getCell_phone()) ) {
			Member tempMember = new Member();
			tempMember.setMember_name(certMember.getMember_name());
			tempMember.setBirth_day(certMember.getBirth_day());
			tempMember.setMobile_no(certMember.getCell_phone());
			List<Map<String, String>> tempList = MemberAPI.getDupUserList("WEB", tempMember, "0001", "");
			if (tempList != null && tempList.size() > 0) {
				for (Map<String, String> map2 : tempList) {
					if (!userIdList.contains(map2.get("USER_ID"))) {
						memberList.add(map2);
						userIdList.add(map2.get("USER_ID"));
						userSeqNoList.add(map2.get("SEQ_NO"));
					}
				}
			}
		}

		int decLength = 0;
		int asteriskLength = 0;
		for (String str : userIdList) {
			if (str.startsWith("*")) {
				asteriskLength++;
			} else {
				decLength++;
			}
		}
		member.setCi_value(certMember.getCi_value());
		member.setDi_value(certMember.getDi_value());
		member.setIntegrationIdList(StringUtils.join(userIdList, ","));
		member.setIntegrationSeqNoList(StringUtils.join(userSeqNoList, ","));
		if (hasCert) {
			member.setSex(certMember.getSex());
			member.setMember_name(certMember.getMember_name());
			member.setBirth_day(certMember.getBirth_day());
		}
//		request.getSession().setAttribute("certMember", certMember);
		model.addAttribute("multiId", (decLength > 0 && asteriskLength > 0));
		model.addAttribute("dupList", memberList);
		model.addAttribute("newMember", member);
		return String.format(basePath, homepage.getFolder()) + "integration2";
	}

	@RequestMapping(value = {"/integration3.*"})
	public String integration3(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		//member = 일루스에서 선택한 회원.
//		Menu menuOne = (Menu) request.getAttribute("menuOne");
//		if (StringUtils.equals(member.getUnAgreeFlag(), "0002")) {
//			menuOne.setMenu_name("회원정보 수정");
//		} else {
//			menuOne.setMenu_name("통합회원 전환");
//		}
//		request.setAttribute("menuOne", menuOne);

		Member certMember = null;
		try {
			certMember = (Member) request.getSession().getAttribute("certMember");
		} catch ( Exception e ) {
		}


		boolean hasCert = false;
		if (certMember == null || StringUtils.isEmpty(certMember.getCertType())) {
			//로그인하고 인증없이 들어오는 경우 로그인한 세션정보를 가져온다.
			certMember = getSessionMemberInfo(request);
		} else {
			hasCert = true;
			//회원가입 또는 로그인 인증 하고 들어오는 경우
			//request에서 받은 certMember의 값을 그대로 쓴다.
		}

		certMember.setUnAgreeFlag(member.getUnAgreeFlag());
		certMember.setUser_id(member.getIntegrationId());
		certMember.setIntegrationId(member.getIntegrationId());
		certMember.setIntegrationIdList(member.getIntegrationIdList());
		certMember.setIntegrationSeqNo(member.getIntegrationSeqNo());
		certMember.setIntegrationSeqNoList(member.getIntegrationSeqNoList());
		Map<String, String> memberInfo = MemberAPI.getMember("WEB", certMember);

		if (!hasCert) {
			//로그인하고 인증없이 들어오는 경우 선택 아이디의 정보로 넣는다.
			certMember.setMember_name(memberInfo.get("USER_NAME"));
    		certMember.setBirth_day(memberInfo.get("BIRTHD"));
    		certMember.setSex(memberInfo.get("SEX"));
    		//

		} else {
			//인증받고 온 경우
			//certMember자체가 인증결과이기때문에 아무것도 안한다.
			if (StringUtils.equals(certMember.getSex(), "1") || StringUtils.equals(certMember.getSex(), "0001")) {
				//1남자
				certMember.setSex("0001");
			} else {
				//2여자
				certMember.setSex("0002");
			}
		}
		certMember.setWeb_id(memberInfo.get("WEB_ID"));
		certMember.setSms_service_yn(memberInfo.get("SMS_CHECK"));
		certMember.setEmail_service_yn(memberInfo.get("MAIL_CHECK"));

		String phone = memberInfo.get("TEL_NO");
		mergeTelno(certMember, phone);

		if (StringUtils.isEmpty(certMember.getCell_phone())) {
			String cellPhone = memberInfo.get("MOBILE_NO");
			mergeCellphone(certMember, cellPhone);
		}

		String email = memberInfo.get("EMAIL");
		if ( !StringUtils.isEmpty(email) ) {
			String[] arr = email.split("@");
			if (arr != null && arr.length > 1) {
				certMember.setEmail1(arr[0]);
				if ( arr.length > 1 ) {
					certMember.setEmail2(arr[1]);
				}
			}
		}

		/*member.setDi_value(memberInfo.get("DUPINFO"));*/
//		certMember.setCi_value(memberInfo.get("CONN_INFO"));
		certMember.setZipcode(memberInfo.get("ZIP_CODE"));
		certMember.setAddress1(memberInfo.get("ADDRS").replaceAll("null", ""));
		certMember.setLoca(memberInfo.get("LOCA"));
		certMember.setLoca_name(memberInfo.get("LOCA_NAME"));


		model.addAttribute("newMember", new Member());
		model.addAttribute("member", certMember);
		model.addAttribute("memberInfo", certMember);
		model.addAttribute("libList", MemberAPI.getLibInfoQry("WEB", "0001", null));
		model.addAttribute("telCode", codeService.getCode("CMS", "C0003"));
		model.addAttribute("phoneCode", codeService.getCode("CMS", "C0002"));
		model.addAttribute("email", codeService.getCode("CMS", "C0010"));


		return String.format(basePath, homepage.getFolder()) + "integration3";
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