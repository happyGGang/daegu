package kr.go.gbelib.app.intro.join;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.rootlab.did.ClaimInfo;
import com.rootlab.did.DidLogin;

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
import kr.go.gbelib.app.cms.module.bringInLog.BringInLogService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.CommonAPI;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PrivateLibSearchAPI;
import kr.go.gbelib.app.common.api.PrivateMemberAPI;

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
	
	@Autowired
	private BringInLogService bringInLogService;

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
		
		if(homepage.getHomepage_id().equals("h37")) {
			model.addAttribute("newMember", member);
			return String.format(basePath, homepage.getFolder()) + "step4";
		} else {
			model.addAttribute("newMember", member);
			return String.format(basePath, homepage.getFolder()) + "step3";
		}
		
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
	public String edit(Model model, Member member, ClaimInfo claimInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if(StringUtils.isNotEmpty(claimInfo.getName())) {
			String privKey = "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCX7UqYJRa46ht4rL6SpFgxnfz9IJjX0UMn3tqkL/0LtRpikW9wRwlOdbJnE0Na4Th65ABiWNFakEZSReMWpgUSNs73e3pelBAW30vkmgONzTdXR82ol2+pnx845LVVuPoPIxgUHCfb6QoVogvFQ865Gih3PpzymptnrPlYiZDZaIoT4jRBB24NGWDdYXyToKKt+PHvu71IBICBht2/0ZecCqh6LyEpBXtE5REwF2ssOkBThq6IDum1UeS9tYYLEit3kWWoN13Qlm9qTOEf0IyLcghtU6VkBiT325IoP2bJxMySM/GlhtzMVJCrY93Z+98xrduR0msjcUU15s6eerNxAgMBAAECggEAfLH4TZPzaGZNkehGqllVQbQoVyIQEOLiubDBx4zTpm5Ib6pqyr6jNtCHUu6Ok+LS1pqYbh/0BN7xuMk/r/EnrGFr0dh5AXOJGRzBT6nRTOuohmyasctJjPDbUXj2FJu0MgRd2PObC3XkHwlXm9shqu97UxQDAWRANQHVzgNq7eUJxtwrCwXzyUufPNrTeHUqAxM2DuN4XXbOL6ZIbkbw86Ryl6R2/19h2KPT8N/TV7q2xyvhGh/sNXG+c5fX9vb4yQ0dQzW7OMJCAh/eISp6gfvIvQX+cMdMocpzutLDsCxAMsJ7oQbYkz3XG/ToVzzUMNNIxI26MCVev96lDcx1gQKBgQDKddYhW48/RPT/LSHc4cxhrBhhV0CbklhMEX1NK6NOIMJRuYySwkZOpGDCAfMT+//1o/abgDs75E4kwq7fLigC737nO2hIXn92y0VOh3PLTM6ZjlOTMph/XlvEFq7qs5ITluv6QBLUO4DGjKnYSA7EfnIdexsw+7pr9NDJGXPqyQKBgQDAGnHWJzWAdq+FPN/gLSXTQgar51p/DZlXQQ+0LOOZW6fMfIGNdbVCgBufQYqxI+uGFO6BjMHgtwKlcjcX8siip1wqYAo166JHvyVE5nfddv788yqfDbw0sg1C+m6djw4G6go1YhJp5FczQydjTEiFzc1PlGonASgr738QNPCvaQKBgQCc7+SxbNjIUXqcBu8V2g3ktFMduVXCghlhtbjsReRLnocidHMsG94F/dNm773uAswxLAzwEuFXlqygQCzvoUawp9c2BM3cMywY+I5bxhGTSJFpZHMSSgj9yjXV9UNXeSTFfJqlHF+8FffHcKgDmC+iTuXERnYYbTjfkCD7kXhSSQKBgQCFh1wtUV+9BcKHSIMNHhS2vaRJhSzAN8Gohs7VnIYvqSf/2WNr4q+1o7qPfk1bR+6EarRGVILHIi6ytatZ+CZB+Tb1NYCjbkCEwnazZ8dVp0sipBuyJyf1MPZK4ixVVISZhcDGzn6iIFgEh98vBG08pIrbj/whVIqJz5VwvHu4UQKBgQC0rF6Bzih4H9pcT8qOzEyO9XmblTwmZWKqsx9B9WLJsJnEa7fH3uJGIG1SPWajCJg7gKwHxmy+J8HbR+/d/up/zfwhaSUwuhwUeT/BwX6X8NFHdNCndxYRcS2qK8ZsH9j9pQ654dWAockTeveDECOLewcvNtpTpGLdcXtSsV2oDA==";
			
			try {
				claimInfo = DidLogin.decryptClaimInfo(claimInfo, privKey);
			} catch (Exception e) {
				System.out.println("다대구 앱 인증 오류 " + e);
				joinService.alertMessageAndHistoryBack("다대구 앱 인증중에 오류가 발생하였습니다.", -4, request, response);
				return null;
			}
			
			if(claimInfo != null) {
				member.setMember_name(claimInfo.getName());
				if (StringUtils.isNotEmpty(claimInfo.getPhoneNumber())) {
					String number = claimInfo.getPhoneNumber().replaceAll("-", "");
					member.setCell_phone(number);
					member.setCell_phone1(number.substring(0,3));
					member.setCell_phone2(number.substring(3,7));
					member.setCell_phone3(number.substring(7,11));
				}
				member.setBirth_day(claimInfo.getBirthdate());
				member.setCi_value(claimInfo.getCi());
				if (claimInfo.getGender().equals("남자")) {
					member.setSex("0");// 남
				} else {
					member.setSex("1");// 여
				}
				if(member.getCi_value().isEmpty()) {
					joinService.alertMessageAndHistoryBack("본인인증이 필요합니다.", -4, request, response);
					return null;
				}
			} else {
				joinService.alertMessageAndHistoryBack("다대구 인증에 실패했습니다. 다시 시도해주세요.", -4, request, response);
				return null;
			}
			
			//책이음
			if (!StringUtils.equals(homepage.getContext_path(), "daegu")) {
				List<Map<String, Object>> klmemberInfo = MemberAPI.checkDupUser("3", member);
				if (klmemberInfo != null && klmemberInfo.size() > 0) {
					model.addAttribute("dupCheckKl", true);
					model.addAttribute("dupUser", klmemberInfo.get(0));
					
					joinService.alertMessageAndHistoryBack("회원님의 대출번호는 "+klmemberInfo.get(0).get("USER_NO")+"이며 책이음회원으로 이미 가입되어 있습니다.", -4, request, response);
					return null;
				}
			}
			
			//자관
			List<Map<String, Object>> memberInfo = MemberAPI.checkDupUser("1", member);
			if (memberInfo != null && memberInfo.size() > 0) {
				model.addAttribute("dupCheck", true);
				model.addAttribute("dupUser", memberInfo.get(0));
				
				if(memberInfo.get(0).get("USER_CLASS") == "3") {
					joinService.alertMessageAndHistoryBack("탈퇴 회원입니다. 도서관으로 문의 바랍니다.", -4, request, response);
					return null;
				} else if(memberInfo.get(0).get("USER_NO") != "") {
					joinService.alertMessageAndHistoryBack("중복된 이용자가 있습니다.\\n대출번호는" + memberInfo.get(0).get("USER_NO") + "입니다.", -4, request, response);
					return null;
				} else {
					joinService.alertMessageAndHistoryBack("준회원으로 가입되어 있습니다.", -4, request, response);
					return null;
				}
			}
			
			member.setCertType("daDaegu");
			request.getSession().setAttribute("certMember", member);
			request.getSession().setAttribute("certType", "daDaegu");
		} else {
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
				
				//통합회원 사립도서관으로 반입할때
				try {
					if (StringUtils.isNotEmpty(certMember.getMember_id())) {
						member.setMember_id(certMember.getMember_id());
					}
					if (StringUtils.isNotEmpty(certMember.getZipcode())) {
						member.setZipcode(certMember.getZipcode());
					}
					if (StringUtils.isNotEmpty(certMember.getAddress1())) {
						member.setAddress1(certMember.getAddress1());
					}
					if (StringUtils.isNotEmpty(certMember.getAddress2())) {
						member.setAddress2(certMember.getAddress2());
					}
					if (StringUtils.isNotEmpty(certMember.getBringIn())) {
						member.setBringIn(certMember.getBringIn());
					}
				} catch (Exception e) {
					System.err.println(e);
				}
				
				member.setCi_value(certMember.getCi_value());
				member.setDi_value(certMember.getDi_value());
			} else {
				joinService.alertMessage("본인인증이 필요합니다.", request, response);
				return null;
			}
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
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "member_id", "사용자ID를 입력해주세요.");
		ValidationUtils.rejectOnlyEngNum(result, "member_id", 6, 20, "아이디는 영문, 숫자 조합 6자 이상 20자 이하로 입력하세요.");

		if (!result.hasErrors()) {
			if(member.getPrivateMemberYn(homepage)) {
				List<Map<String, Object>> checkDupUser = PrivateMemberAPI.checkDupUser("0", member);
				if (CollectionUtils.isEmpty(checkDupUser)) {
					res.setValid(true);
					res.setMessage("사용 가능한 ID 입니다.");
					res.setData(true);
				} else {
					res.setValid(false);
					res.setMessage("사용 불가능한 ID 입니다.");
				}
			} else {
				List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("0", member);
				if (CollectionUtils.isEmpty(checkDupUser)) {
					res.setValid(true);
					res.setMessage("사용 가능한 ID 입니다.");
					res.setData(true);
				} else {
					res.setValid(false);
					res.setMessage("사용 불가능한 ID 입니다.");
				}
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
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/modifyCheck.*"}, method = RequestMethod.GET)
	public String modifyCheck(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		
		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
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
		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http%s://%s/%s/intro/login/index.do?menu_idx=%d", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http%s://%s/%s/intro/login/index.do?menu_idx=%d", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path(), member.getMenu_idx(), loginMenuIdx), request, response);
				return null;
			}
		}

		//비밀번호 확인
		Member sessionMemberInfo = getSessionMemberInfo(request);
		
		if(member.getPrivateMemberYn(homepage)) {
			Map<String, Object> userInfo = PrivateMemberAPI.getUserInfo(sessionMemberInfo.getMember_id(), member.getMember_pw());

			String resultInfo = String.valueOf(userInfo.get("RESULT_INFO"));

			if (!"SUCCESS".equals(resultInfo)) {
				joinService.alertMessage("비밀번호가 일치하지 않습니다.", request, response);
				return null;
			}
		} else {
			Map<String, Object> userInfo = MemberAPI.getUserInfo(sessionMemberInfo.getMember_id(), member.getMember_pw());

			String resultInfo = String.valueOf(userInfo.get("RESULT_INFO"));

			if (!"SUCCESS".equals(resultInfo)) {
				joinService.alertMessage("비밀번호가 일치하지 않습니다.", request, response);
				return null;
			}
		}

		sessionMemberInfo.setMenu_idx(member.getMenu_idx());
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
			if (StringUtils.isNotEmpty(member.getCard_password())) {
				ValidationUtils.rejectExceptNumber(result, "card_password", 4, "대출증 비밀번호 설정은 숫자 4자리로 입력해주세요.");
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
			ValidationUtils.rejectIfEmpty(result, "cell_phone2", "휴대폰 번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone3", "휴대폰 번호를 입력하세요.");
		}

		if ( !result.hasErrors() ) {
			if (member.getEditMode().equals("ADD")) {
				if(member.getPrivateMemberYn(homepage)) {
					String addResult = joinService.addPrivateMember(request, member);
					
					if (addResult.equals("0")) {
						if("반입".equals(member.getBringIn())) {
							res.setValid(true);
							res.setMessage("반입이 완료되었습니다. 정회원 전환을 원하시면 도서관에 방문을 부탁드립니다.");
							res.setUrl(String.format("http%s://%s/%s/index.do", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path()));
							
							try {
								member.setAdd_ip(request.getRemoteAddr());
								bringInLogService.addLog(member);
							} catch (Exception e) {
								log.error("통합회원 사립도서관 반입 에러 : " + e);
							}
							
							request.getSession().invalidate();
						} else if("h80".equals(member.getHomepage_id())) {
							res.setValid(true);
							res.setMessage("대출이용을 원하시는 경우에는 도서관 방문 후, 별도 가입이 필요합니다.");
							res.setUrl(String.format("http%s://%s/%s/index.do", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path()));
							request.getSession().invalidate();
						} else {
							res.setValid(true);
							res.setMessage("신규회원 가입이 완료되었습니다. 신분증 지참 후 데스크에서 회원증을 발급받으시기 바랍니다.");
							res.setUrl(String.format("http%s://%s/%s/index.do", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path()));
							request.getSession().invalidate();
						}
					} else {
						res.setValid(true);
						res.setMessage(addResult);
					}
				} else {
					String addResult = joinService.addMember(request, member);
					
					if (addResult.equals("0")) {
						String message = "신규회원 가입이 완료되었습니다. 신분증 지참 후 데스크에서 회원증을 발급받으시기 바랍니다.";
						if(homepage.getContext_path().equals("228")) {
							message +=  "\n14세 미만 이용자분은 보호자 신분증과 주민등록등본, 가족관계증명서 중 하나를 지참하여 방문하시길 바랍니다.";
						}
						
						res.setValid(true);
						res.setMessage(message);
						
						int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 123));
						
						if(homepage.getContext_path().equals("dalseolib")) {
							res.setUrl(String.format("http%s://%s/%s/index.do", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path()));
						} else {
							res.setUrl(String.format("http%s://%s/%s/intro/join/changeover.do?menu_idx=%d", (request.isSecure() ? "s" : ""), homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx));
						}
						request.getSession().invalidate();
					} else {
						res.setValid(true);
						res.setMessage(addResult);
					}
				}
			} else if ( member.getEditMode().equals("MODIFY") ) {
				member.setRec_key(getSessionMemberInfo(request).getRec_key());
				member.setIn_ip(request.getRemoteAddr());
				if(member.getPrivateMemberYn(homepage)) {
					if (PrivateMemberAPI.updateMember(member)) {
						Member sessionMember = getSessionMemberInfo(request);
						sessionMember.setPhone1(member.getPhone1());
						sessionMember.setPhone2(member.getPhone2());
						sessionMember.setPhone3(member.getPhone3());
						sessionMember.setCell_phone1(member.getCell_phone1());
						sessionMember.setCell_phone2(member.getCell_phone2());
						sessionMember.setCell_phone3(member.getCell_phone3());
						sessionMember.setEmail1(member.getEmail1());
						sessionMember.setEmail2(member.getEmail2());
						sessionMember.setSms_service_yn(member.getSms_service_yn());
						sessionMember.setEmail_service_yn(member.getEmail_service_yn());
						if (StringUtils.isNotBlank(member.getMemberNewPw())) {
							ApiResponse updateMemberPasswd = PrivateMemberAPI.updateMemberPasswd(member);
							if (updateMemberPasswd.getStatus()) {
								sessionMember.setMember_pw(member.getMemberNewPw());
							}
						}
						res.setValid(true);
						res.setMessage("수정되었습니다.");
						loginService.setSessionMember(sessionMember, request);
						res.setUrl(String.format("/%s/intro/join/modifyCheck.do?menu_idx=%d", homepage.getContext_path(), member.getMenu_idx()));
					} else {
						res.setValid(false);
						res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요.");
					}
				} else {
					if (MemberAPI.updateMember(member)) {
						Member sessionMember = getSessionMemberInfo(request);
						sessionMember.setPhone1(member.getPhone1());
						sessionMember.setPhone2(member.getPhone2());
						sessionMember.setPhone3(member.getPhone3());
						sessionMember.setCell_phone1(member.getCell_phone1());
						sessionMember.setCell_phone2(member.getCell_phone2());
						sessionMember.setCell_phone3(member.getCell_phone3());
						sessionMember.setEmail1(member.getEmail1());
						sessionMember.setEmail2(member.getEmail2());
						sessionMember.setSms_service_yn(member.getSms_service_yn());
						sessionMember.setEmail_service_yn(member.getEmail_service_yn());
						if (StringUtils.isNotBlank(member.getMemberNewPw())) {
							ApiResponse updateMemberPasswd = MemberAPI.updateMemberPasswd(member);
							if (updateMemberPasswd.getStatus()) {
								sessionMember.setMember_pw(member.getMemberNewPw());
							}
						}
						res.setValid(true);
						res.setMessage("수정되었습니다.");
						loginService.setSessionMember(sessionMember, request);
						res.setUrl(String.format("/%s/intro/join/modifyCheck.do?menu_idx=%d", homepage.getContext_path(), member.getMenu_idx()));
					} else {
						res.setValid(false);
						res.setMessage("수정 실패하였습니다. 잠시후 다시 시도해주세요.");
					}
				}
			} else if ( member.getEditMode().equals("INTEGRATION") ) {//통합회원 전환
				if(member.getPrivateMemberYn(homepage)) {
					res.setValid(false);
					res.setMessage("사립도서관 회원은 통합회원 전환이 불가능합니다.");
				}
				
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
					res.setUrl(String.format("/%s/intro/login/index.do", homepage.getContext_path())); // 검색대 메인으로 Redirect.
				}

				ApiResponse modifyMember = MemberAPI.modifyMember(member);
				if (modifyMember.getStatus()) {
					//개인정보 동의
					/**
					 * 대구는 통합인증시 무조건 책이음회원 Y
					 * 2019.12.19
					 */
					MemberAPI.agreeInfo(member.getManage_code(), member.getRec_key(), "Y");

					//보호자동의
					if (member.getAge().equals("2") && request.getSession().getAttribute("parentInfo") != null) {
						Member parentInfo = (Member) request.getSession().getAttribute("parentInfo");
						MemberAPI.useragentinfoinsert(member.getRec_key(), parentInfo.getMember_name(), member.getManage_code());
					}

					res.setValid(true);
					res.setMessage("통합인증이 완료되었습니다.");
					res.setUrl(String.format("/%s/index.do", homepage.getContext_path())); // 검색대 메인으로 Redirect.
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
		
		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://%s/%s/intro/login/index.do?menu_idx=%d", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://%s/%s/intro/login/index.do?menu_idx=%d", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
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

		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				res.setValid(true);
				res.setMessage("로그인 후 이용가능합니다.");
				res.setUrl(String.format("http://%s/%s/intro/login/index.do?menu_idx=%d", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx));
				return res;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				res.setValid(true);
				res.setMessage("로그인 후 이용가능합니다.");
				res.setUrl(String.format("http://%s/%s/intro/login/index.do?menu_idx=%d", homepage.getDomainWithoutProtocol(), homepage.getContext_path(), loginMenuIdx));
				return res;
			}
		}
		
		if (!result.hasErrors()) {
			Member sessionMember = getSessionMemberInfo(request);

			if (memberService.decryptMember(member) == false) {
				res.setValid(false);
				res.setMessage("비밀번호가 올바르지 않습니다.");
				return res;
			}
			
			if(member.getPrivateMemberYn(homepage)) {
				Map<String, Object> userInfo = PrivateMemberAPI.getUserInfo(sessionMember.getMember_id(), member.getMember_pw());

				String resultInfo = String.valueOf(userInfo.get("RESULT_INFO"));
				if ("SUCCESS".equals(resultInfo)) {
					try {
						List<Map<String, Object>> listData = LibSearchAPI.getListData(userInfo, "USER_DATA");
						if (listData != null && listData.size() > 0) {
//							Map<String, Object> map = listData.get(0);
//							String birth = String.valueOf(map.get("BIRTHDAY"));
//							birth = birth.substring(0, 4);
//							SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
//							String format = sdf.format(new Date());
//							isChild = ((Integer.parseInt(format) - Integer.parseInt(birth)) + 1) < 14;
						}
					} catch (NumberFormatException e) {} catch (Exception e2) {}
				} else {
					res.setValid(false);
					res.setMessage("비밀번호가 올바르지 않습니다.");
					return res;
				}
			} else {
				Map<String, Object> userInfo = MemberAPI.getUserInfo(sessionMember.getMember_id(), member.getMember_pw());

				String resultInfo = String.valueOf(userInfo.get("RESULT_INFO"));
				if ("SUCCESS".equals(resultInfo)) {
					try {
						List<Map<String, Object>> listData = LibSearchAPI.getListData(userInfo, "USER_DATA");
						if (listData != null && listData.size() > 0) {
//							Map<String, Object> map = listData.get(0);
//							String birth = String.valueOf(map.get("BIRTHDAY"));
//							birth = birth.substring(0, 4);
//							SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
//							String format = sdf.format(new Date());
//							isChild = ((Integer.parseInt(format) - Integer.parseInt(birth)) + 1) < 14;
						}
					} catch (NumberFormatException e) {} catch (Exception e2) {}
				} else {
					res.setValid(false);
					res.setMessage("비밀번호가 올바르지 않습니다.");
					return res;
				}
			}

			if (!StringUtils.equals("0", sessionMember.getOverdue_cnt())) {
				res.setValid(false);
				res.setMessage("연체 중 도서가 있는 경우 탈퇴 하실 수 없습니다.");
				return res;
			}

			if(member.getPrivateMemberYn(homepage)) {
				Map<String, Object> loanResult = PrivateLibSearchAPI.getBookLoanList(sessionMember.getRec_key());

				List<Map<String, Object>> listData = PrivateLibSearchAPI.getListData(loanResult);

				if (listData != null && listData.size() > 0) {
					res.setValid(false);
					res.setMessage("미반납 도서가 있는 경우 탈퇴 하실 수 없습니다.");
					return res;
				}
			} else {
				Map<String, Object> loanResult = LibSearchAPI.getBookLoanList(sessionMember.getRec_key());

				List<Map<String, Object>> listData = LibSearchAPI.getListData(loanResult);

				if (listData != null && listData.size() > 0) {
					res.setValid(false);
					res.setMessage("미반납 도서가 있는 경우 탈퇴 하실 수 없습니다.");
					return res;
				}
			}
			
			if(member.getPrivateMemberYn(homepage)) {
				Map<String, Object> reserveResult = PrivateLibSearchAPI.getReserveList(sessionMember.getRec_key());

				List<Map<String, Object>> reserveData = PrivateLibSearchAPI.getListData(reserveResult);

				if (reserveData != null && reserveData.size() > 0) {
					res.setValid(false);
					res.setMessage("예약 중 도서가 있는 경우 탈퇴 하실 수 없습니다.");
					return res;
				}
			} else {
				Map<String, Object> reserveResult = LibSearchAPI.getReserveList(sessionMember.getRec_key());

				List<Map<String, Object>> reserveData = LibSearchAPI.getListData(reserveResult);

				if (reserveData != null && reserveData.size() > 0) {
					res.setValid(false);
					res.setMessage("예약 중 도서가 있는 경우 탈퇴 하실 수 없습니다.");
					return res;
				}
			}
			
			if(member.getPrivateMemberYn(homepage)) {
				Map<String, Object> apiResult = PrivateMemberAPI.secessionUser(sessionMember.getRec_key(), request.getRemoteAddr());

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
	@RequestMapping(value = {"/findId.*"}, method = RequestMethod.POST)
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
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
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

			if(member.getPrivateMemberYn(homepage)) {
				ApiResponse apiResult = PrivateMemberAPI.updateMemberPasswd(member);
				res.setValid(apiResult.getStatus());
				if (apiResult.getStatus()) {
					res.setMessage("비밀번호가 변경되었습니다.");
					int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
					res.setUrl(String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx));
				} else {
					res.setMessage(apiResult.getMessage());
				}
			} else {
				ApiResponse apiResult = MemberAPI.updateMemberPasswd(member);
				res.setValid(apiResult.getStatus());
				if (apiResult.getStatus()) {
					res.setMessage("비밀번호가 변경되었습니다.");
					int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
					res.setUrl(String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx));
				} else {
					res.setMessage(apiResult.getMessage());
				}
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

		request.getSession().invalidate();
		model.addAttribute("newMember", member);

		return String.format(basePath, homepage.getFolder()) + "integration";
	}

	@RequestMapping(value = {"/integration1.*"}, method=RequestMethod.POST)
	public String integration1(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		
		if(member.getPrivateMemberYn(homepage)) {
			// 사립도서관 동일인 목록 가져오기
			List<Map<String, Object>> checkDupUser = PrivateMemberAPI.checkDupUser("2", member);
			if (checkDupUser == null || CollectionUtils.isEmpty(checkDupUser)) {
				joinService.alertMessage("일치하는 회원이 없습니다.", request, response);
				return null;
			} else {
				String userId = String.valueOf(checkDupUser.get(0).get("USER_ID"));
				if (StringUtils.isNotEmpty(userId) && !StringUtils.containsIgnoreCase(userId, "null")) {
					joinService.alertMessage("이미 통합인증을 완료한 정보입니다.", request, response);
					return null;
				}

				Member integrationMember = new Member();
				integrationMember.setMember_name(String.valueOf(checkDupUser.get(0).get("NAME")));
				integrationMember.setCell_phone(String.valueOf(checkDupUser.get(0).get("HANDPHONE")).replaceAll("-", ""));
				String birthday = String.valueOf(checkDupUser.get(0).get("BIRTHDAY"));
				if (StringUtils.containsIgnoreCase(birthday, "null")) {
					joinService.alertMessage("해당 정보의 생년월일 정보가 누락되었습니다. 데스크에서 생년월일 정보 보정후 다시 통합인증을 진행해주세요.", request, response);
					return null;
				} else {
					integrationMember.setBirth_day(String.valueOf(checkDupUser.get(0).get("BIRTHDAY")).replaceAll("/", ""));
				}

				List<Map<String, Object>> integrationMemberList = PrivateMemberAPI.checkDupUser("4", integrationMember);
				for (Map<String, Object> map : integrationMemberList) {
					map.put("ORDER2", "N");
					String ipin_hash = String.valueOf(map.get("IPIN_HASH"));
					if (ipin_hash.length() > 80) {
						map.put("ORDER2", "Y");
					}
				}

				request.getSession().setAttribute("integrationMemberList", integrationMemberList);
			}
		} else {
			// 동일인 목록 가져오기
			List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("2", member);
			if (checkDupUser == null || CollectionUtils.isEmpty(checkDupUser)) {
				joinService.alertMessage("일치하는 회원이 없습니다.", request, response);
				return null;
			} else {
				String userId = String.valueOf(checkDupUser.get(0).get("USER_ID"));
				if (StringUtils.isNotEmpty(userId) && !StringUtils.containsIgnoreCase(userId, "null")) {
					joinService.alertMessage("이미 통합인증을 완료한 정보입니다.", request, response);
					return null;
				}

				Member integrationMember = new Member();
				integrationMember.setMember_name(String.valueOf(checkDupUser.get(0).get("NAME")));
				integrationMember.setCell_phone(String.valueOf(checkDupUser.get(0).get("HANDPHONE")).replaceAll("-", ""));
				String birthday = String.valueOf(checkDupUser.get(0).get("BIRTHDAY"));
				if (StringUtils.containsIgnoreCase(birthday, "null")) {
					joinService.alertMessage("해당 정보의 생년월일 정보가 누락되었습니다. 데스크에서 생년월일 정보 보정후 다시 통합인증을 진행해주세요.", request, response);
					return null;
				} else {
					integrationMember.setBirth_day(String.valueOf(checkDupUser.get(0).get("BIRTHDAY")).replaceAll("/", ""));
				}

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
		}

		model.addAttribute("newMember", member);
		return String.format(basePath, homepage.getFolder()) + "integration1";
	}

	@RequestMapping(value = {"/integration2.*"}, method=RequestMethod.POST)
	public String integration2(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

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
		return String.format(basePath, homepage.getFolder()) + "integration2";
	}

	@RequestMapping(value = {"/integration3.*"}, method=RequestMethod.POST)
	public String integration3(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);
    	// -> 1순위로 선택한 책이음 회원 정보일 경우에는 중복체크 하지 않고 통과
    	// -> 2순위로 선택한 자관 CI있는 회원정보일 경우에는 중복체크 하지 않고 통과
    	// -> 3순위로 여러 정보 가운데 정보를 선택한 경우에는 반드시 CI중복체크를 진행
    	model.addAttribute("newMember", member);

		return String.format(basePath, homepage.getFolder()) + "integration3";
	}

	@RequestMapping(value = {"/integration4.*"}, method=RequestMethod.POST)
	public String integration4(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		@SuppressWarnings ("unchecked")
		Map<String, Object> integrationMember = (Map<String, Object>) request.getSession().getAttribute("integrationMember");
		Member certMember = (Member) request.getSession().getAttribute("certMemberintegration");

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

		return String.format(basePath, homepage.getFolder()) + "integration4";
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

	/**
	 * 회원가입 후 페이지
	 * @author whalesoft YONGJU 2020. 4. 6.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/changeover.*"})
	public String changeover(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		int dlsMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 124));
		int untactMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 125));

		model.addAttribute("dlsMenuIdx", dlsMenuIdx);
		model.addAttribute("untactMenuIdx", untactMenuIdx);

		return String.format(basePath, homepage.getFolder()) + "changeover";
	}

	/**
	 * DLS 인증 페이지
	 * @author whalesoft YONGJU 2020. 4. 6.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/dls.*"})
	public String dls(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				String before_url = String.format("/%s/intro/join/dls.do?menu_idx=%d", homepage.getContext_path(), member.getMenu_idx());
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				String before_url = String.format("/%s/intro/join/dls.do?menu_idx=%d", homepage.getContext_path(), member.getMenu_idx());
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
				return null;
			}
		}
		
		return String.format(basePath, homepage.getFolder()) + "dls";
	}

	/**
	 * DLS 인증 폼
	 *
	 * @author whalesoft YONGJU 2020. 4. 10.
	 * @param model
	 * @param member
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/dlsCheck.*"}, method = RequestMethod.POST)
	public String dlsCheck(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("loginCheck", true);
		
		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				model.addAttribute("loginCheck", false);
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				model.addAttribute("loginCheck", false);
			}
		}

		model.addAttribute("memberClass", true);
		Member sessionMemberInfo = getSessionMemberInfo(request);
		if (StringUtils.equals(sessionMemberInfo.getMember_class(), "0")) {
			model.addAttribute("memberClass", false);
		}

		model.addAttribute("dlsMember", member);
		HttpSession session = request.getSession();
		session.setAttribute("dlsMember", member);

		return String.format(basePath, homepage.getFolder()) + "dlsCheck_ajax";
	}

	/**
	 * DLS 인증
	 * @author whalesoft YONGJU 2020. 4. 10.
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping (value = {"/dlsCheckA.*"})
	public String dlsCheckA(Model model, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = getSessionHomepage(request);

		String ck_flag = request.getParameter("ck_flag");

		model.addAttribute("certFailed", true);
		model.addAttribute("certResult", false);

		Member sessionMemberInfo = getSessionMemberInfo(request);//로그인한 사용자정보

		if(sessionMemberInfo.getPrivateMemberYn(homepage)) {
			if (StringUtils.equals(ck_flag, "true")) {
				model.addAttribute("certFailed", false);

				HttpSession session = request.getSession();
				Member dlsMember = (Member) session.getAttribute("dlsMember");//dls 인증 데이터(아이디, 이름, 패스워드)

				//dls id 세팅
				sessionMemberInfo.setIntegrationId(dlsMember.getMember_id());//인증받은 dls id 세팅

				//ci 세팅
				List<Map<String, Object>> checkDupUser = PrivateMemberAPI.checkDupUser("0", sessionMemberInfo);//아이디로 조회
				String ci = String.valueOf(checkDupUser.get(0).get("IPIN_HASH"));//ci값 꺼내기
				sessionMemberInfo.setCi_value(ci);//ci 세팅

				String birth_day = sessionMemberInfo.getBirth_day();
				sessionMemberInfo.setBirth_day(birth_day.replaceAll("-", ""));//생년월일세팅
				sessionMemberInfo.setManage_code(sessionMemberInfo.getUser_manage_code());//도서관부호 세팅
				sessionMemberInfo.setIn_ip(request.getRemoteAddr());//아이피 세팅

				Map<String, Object> regularUserInfoInsert = PrivateMemberAPI.regularUserInfoInsert(sessionMemberInfo, "DLS");

				String regular = String.valueOf(regularUserInfoInsert.get("RESULT_INFO"));
				if (StringUtils.equals(regular, "SUCCESS")) {
					model.addAttribute("certResult", true);
				} else {
					System.out.println("@@@@@@@@@@@@@@@@ private dlsCheckA regular false : " + regularUserInfoInsert);
				}
			} else {
				System.out.println("@@@@@@@@@@@@@@@@ private dlsCheckA ck_flag false : " + sessionMemberInfo.getMember_id());
			}
		} else {
			if (StringUtils.equals(ck_flag, "true")) {
				model.addAttribute("certFailed", false);

				HttpSession session = request.getSession();
				Member dlsMember = (Member) session.getAttribute("dlsMember");//dls 인증 데이터(아이디, 이름, 패스워드)

				//dls id 세팅
				sessionMemberInfo.setIntegrationId(dlsMember.getMember_id());//인증받은 dls id 세팅

				//ci 세팅
				List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("0", sessionMemberInfo);//아이디로 조회
				String ci = String.valueOf(checkDupUser.get(0).get("IPIN_HASH"));//ci값 꺼내기
				sessionMemberInfo.setCi_value(ci);//ci 세팅

				String birth_day = sessionMemberInfo.getBirth_day();
				sessionMemberInfo.setBirth_day(birth_day.replaceAll("-", ""));//생년월일세팅
				sessionMemberInfo.setManage_code(sessionMemberInfo.getUser_manage_code());//도서관부호 세팅
				sessionMemberInfo.setIn_ip(request.getRemoteAddr());//아이피 세팅

				Map<String, Object> regularUserInfoInsert = MemberAPI.regularUserInfoInsert(sessionMemberInfo, "DLS");

				String regular = String.valueOf(regularUserInfoInsert.get("RESULT_INFO"));
				if (StringUtils.equals(regular, "SUCCESS")) {
					model.addAttribute("certResult", true);
				} else {
					System.out.println("@@@@@@@@@@@@@@@@ dlsCheckA regular false : " + regularUserInfoInsert);
				}
			} else {
				System.out.println("@@@@@@@@@@@@@@@@ dlsCheckA ck_flag false : " + sessionMemberInfo.getMember_id());
			}
		}

		return String.format(basePath, homepage.getFolder()) + "dlsCheckA_ajax";
	}


	/**
	 * 비대면 확인 입력 폼 - 준회원이 비대면 확인 서비스를 통해 정회원으로 전환
	 * @author whalesoft YONGJU 2020. 4. 10.
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/untactForm.*"})
	public String untactForm(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		//로그인여부확인
		//비로그인은 이용불가
		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				String before_url = String.format("/%s/intro/join/untactForm.do?menu_idx=%d", homepage.getContext_path(), member.getMenu_idx());
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				String before_url = String.format("/%s/intro/join/untactForm.do?menu_idx=%d", homepage.getContext_path(), member.getMenu_idx());
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, before_url), request, response);
				return null;
			}
		}
		
		//정회원여부확인
		//정회원은 이용불가
//		Member sessionMemberInfo = getSessionMemberInfo(request);
//		if (StringUtils.equals(sessionMemberInfo.getMember_class(), "0")) {
//			joinService.alertMessageAndUrl("이미 인증 받은 회원입니다.", String.format("/%s/index.do", homepage.getContext_path()), request, response);
//			return null;
//		}


		return String.format(basePath, homepage.getFolder()) + "untactForm";
	}

	/**
	 * 비대면 확인 로직
	 * 주민등록번호와 이름을 입력 받는다.
	 *
	 * @author whalesoft YONGJU 2020. 4. 10.
	 * @param result
	 * @param request
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	@RequestMapping (value = {"/untactCheck.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse untactCheck(Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);

		//로그인여부확인
		//비로그인은 이용불가
		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				result.reject("로그인 후 이용가능합니다.");
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				result.reject("로그인 후 이용가능합니다.");
			}
		}

		//정회원여부확인
		//정회원은 이용불가
		Member sessionMemberInfo = getSessionMemberInfo(request);
//		if (StringUtils.equals(sessionMemberInfo.getMember_class(), "0")) {
//			result.reject("이미 인증 받은 회원입니다.");
//		}

		String jumin1 = request.getParameter("jumin1");
		if (StringUtils.isEmpty(jumin1)) {
			result.reject("주민등록번호 앞 6자리를 입력하세요.");
		}

		String jumin2 = request.getParameter("jumin2");
		if (StringUtils.isEmpty(jumin2)) {
			result.reject("주민등록번호 뒤 7자리를 입력하세요.");
		}

		if (StringUtils.isEmpty(sessionMemberInfo.getMember_name())) {
			result.reject("비정상적인 접근입니다.");
		}

		if (!result.hasErrors()) {
			String member_name = sessionMemberInfo.getMember_name();
			
			if(member.getPrivateMemberYn(homepage)) {
				Map<String, Object> sendUntact = CommonAPI.sendUntact(jumin1 + jumin2, member_name);
				
				Map<String, Object> envelope = (Map<String, Object>) sendUntact.get("soap:Envelope");
				Map<String, Object> body = (Map<String, Object>) envelope.get("soap:Body");
				Map<String, Object> getResideInsttCnfirmResponse = (Map<String, Object>) body.get("getResideInsttCnfirmResponse");

				System.out.println("@@@@@@@@@@@@@@@@ private untact result serviceResult : " + getResideInsttCnfirmResponse.get("serviceResult"));
				System.out.println("@@@@@@@@@@@@@@@@ private untact result name : " + getResideInsttCnfirmResponse.get("name"));
				System.out.println("@@@@@@@@@@@@@@@@ private untact result hangkikCd : " + getResideInsttCnfirmResponse.get("hangkikCd"));

				String serviceResult = String.valueOf(getResideInsttCnfirmResponse.get("serviceResult"));
				
				/**
				 * 서비스 결과
				 * 1:성공
				 * 2:주민등록번호오류
				 * 3:성명오류
				 * 4:거주자아님
				 * 9:시스템오류
				 * 99:등록된이용기관이아님
				 */
				if (!StringUtils.equals(serviceResult, "1")) {
					System.out.println("@@@@@@@@@@@@@@@@ private untact result serviceResult : " + serviceResult);
					System.out.println("@@@@@@@@@@@@@@@@ private untact failed MemberId : " + getSessionMemberId(request));
					res.setValid(false);
					res.setMessage("주민등록번호를 확인해주세요.");
					return res;
				}

				//행정동코드
				String hangkikCd = String.valueOf(getResideInsttCnfirmResponse.get("hangkikCd"));

				if (StringUtils.isEmpty(hangkikCd) || StringUtils.equalsIgnoreCase(hangkikCd, "null")) {
					System.out.println("@@@@@@@@@@@@@@@@ private untact result hangkikCd is empty : " + getResideInsttCnfirmResponse);
					res.setValid(false);
					res.setMessage("인증에 오류가 발생하였습니다. 다시 시도해주세요.");
					return res;
				}

				if (!StringUtils.startsWith(hangkikCd, "27")) {
					System.out.println("@@@@@@@@@@@@@@@@ private untact result hangkikCd : " + getResideInsttCnfirmResponse.get("hangkikCd"));
					System.out.println("@@@@@@@@@@@@@@@@ private untact result name : " + getResideInsttCnfirmResponse.get("name"));
					res.setValid(false);
					res.setMessage("대구광역시 거주자만 인증 가능합니다.");
					return res;
				}

				//ci 세팅
				List<Map<String, Object>> checkDupUser = PrivateMemberAPI.checkDupUser("0", sessionMemberInfo);//아이디로 조회
				String ci = String.valueOf(checkDupUser.get(0).get("IPIN_HASH"));//ci값 꺼내기
				sessionMemberInfo.setCi_value(ci);//ci 세팅

				String birth_day = sessionMemberInfo.getBirth_day();
				sessionMemberInfo.setBirth_day(birth_day.replaceAll("-", ""));//생년월일세팅
				sessionMemberInfo.setManage_code(sessionMemberInfo.getUser_manage_code());//도서관부호 세팅
				sessionMemberInfo.setIn_ip(request.getRemoteAddr());//아이피 세팅

				Map<String, Object> regularUserInfoInsert = PrivateMemberAPI.regularUserInfoInsert(sessionMemberInfo, "UNTACT");

				String regular = String.valueOf(regularUserInfoInsert.get("RESULT_INFO"));
				if (StringUtils.equals(regular, "SUCCESS")) {
					res.setValid(true);
					res.setMessage("인증이 완료되었습니다."+System.getProperty("line.separator")+"※ 재로그인 후 이용 가능하며, 현재 비대면 인증 회원은 전자도서관만 이용 가능합니다.");
	    			res.setUrl(String.format("/%s/intro/login/logout.do", homepage.getContext_path()));

				} else {
					res.setValid(false);
					try {
						System.out.println("@@@@@@@@@@@@@@@@ private untact failed MemberId 1 : " + getSessionMemberId(request));
						res.setMessage(String.valueOf(regularUserInfoInsert.get("RESULT_MESSAGE")));
					} catch (Exception e) {
						res.setMessage("인증에 실패하였습니다. 도서관으로 문의 바랍니다.");
						System.out.println("@@@@@@@@@@@@@@@@ private untact failed MemberId 2 : " + getSessionMemberId(request));
					}
				}
			} else {
				Map<String, Object> sendUntact = CommonAPI.sendUntact(jumin1 + jumin2, member_name);
				
				Map<String, Object> envelope = (Map<String, Object>) sendUntact.get("soap:Envelope");
				Map<String, Object> body = (Map<String, Object>) envelope.get("soap:Body");
				Map<String, Object> getResideInsttCnfirmResponse = (Map<String, Object>) body.get("getResideInsttCnfirmResponse");

				String serviceResult = String.valueOf(getResideInsttCnfirmResponse.get("serviceResult"));
				
				/**
				 * 서비스 결과
				 * 1:성공
				 * 2:주민등록번호오류
				 * 3:성명오류
				 * 4:거주자아님
				 * 9:시스템오류
				 * 99:등록된이용기관이아님
				 */
				if (!StringUtils.equals(serviceResult, "1")) {
					System.out.println("@@@@@@@@@@@@@@@@ untact result serviceResult : " + serviceResult);
					System.out.println("@@@@@@@@@@@@@@@@ untact failed MemberId : " + getSessionMemberId(request));
					res.setValid(false);
					res.setMessage("주민등록번호를 확인해주세요.");
					return res;
				}

				//행정동코드
				String hangkikCd = String.valueOf(getResideInsttCnfirmResponse.get("hangkikCd"));

				if (StringUtils.isEmpty(hangkikCd) || StringUtils.equalsIgnoreCase(hangkikCd, "null")) {
					System.out.println("@@@@@@@@@@@@@@@@ untact result hangkikCd is empty : " + getResideInsttCnfirmResponse);
					res.setValid(false);
					res.setMessage("인증에 오류가 발생하였습니다. 다시 시도해주세요.");
					return res;
				}

				if (!StringUtils.startsWith(hangkikCd, "27")) {
					System.out.println("@@@@@@@@@@@@@@@@ untact result hangkikCd : " + getResideInsttCnfirmResponse.get("hangkikCd"));
					System.out.println("@@@@@@@@@@@@@@@@ untact result name : " + getResideInsttCnfirmResponse.get("name"));
					res.setValid(false);
					res.setMessage("대구광역시 거주자만 인증 가능합니다.");
					return res;
				}

				//ci 세팅
				List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("0", sessionMemberInfo);//아이디로 조회
				String ci = String.valueOf(checkDupUser.get(0).get("IPIN_HASH"));//ci값 꺼내기
				sessionMemberInfo.setCi_value(ci);//ci 세팅

				String birth_day = sessionMemberInfo.getBirth_day();
				sessionMemberInfo.setBirth_day(birth_day.replaceAll("-", ""));//생년월일세팅
				sessionMemberInfo.setManage_code(sessionMemberInfo.getUser_manage_code());//도서관부호 세팅
				sessionMemberInfo.setIn_ip(request.getRemoteAddr());//아이피 세팅

				Map<String, Object> regularUserInfoInsert = MemberAPI.regularUserInfoInsert(sessionMemberInfo, "UNTACT");

				String regular = String.valueOf(regularUserInfoInsert.get("RESULT_INFO"));
				if (StringUtils.equals(regular, "SUCCESS")) {
					CertificateCitizen certificateCitizen = new CertificateCitizen();

					certificateCitizen.setUser_ci(ci);	//ci
					certificateCitizen.setUser_name(String.valueOf(regularUserInfoInsert.get("NAME")));	//이름
					certificateCitizen.setUser_id(sessionMemberInfo.getMember_id());	//id
					certificateCitizen.setLibrary(homepage.getHomepage_name());	//도서관
					certificateCitizen.setUser_key(String.valueOf(regularUserInfoInsert.get("USER_KEY")));	//이용자key
					certificateCitizen.setUser_number(String.valueOf(regularUserInfoInsert.get("USER_NO")));	//이용자번호

					memberService.addCitizenMember(certificateCitizen);

					res.setValid(true);
					res.setMessage("인증이 완료되었습니다."+ System.lineSeparator() +"※ 재로그인 후 이용 가능하며, 현재 비대면 인증 회원은 전자도서관만 이용 가능합니다.");
	    			res.setUrl(String.format("/%s/intro/login/logout.do", homepage.getContext_path()));

				} else {
					res.setValid(false);
					try {
						System.out.println("@@@@@@@@@@@@@@@@ untact failed MemberId 1 : " + getSessionMemberId(request));
						res.setMessage(String.valueOf(regularUserInfoInsert.get("RESULT_MESSAGE")));
					} catch (Exception e) {
						res.setMessage("인증에 실패하였습니다. 도서관으로 문의 바랍니다.");
						System.out.println("@@@@@@@@@@@@@@@@ untact failed MemberId 2 : " + getSessionMemberId(request));
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
	 * 약관인증(개인정보 재동의) 폼
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/reAgree.*"})
	public String reAgree(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByLinkUrl(new Menu(homepage.getHomepage_id(), "/intro/join/reAgree.do"));
				member.setBefore_url(String.format("/%s/intro/join/reAgree.do?menu_idx=%s", homepage.getContext_path(), member.getMenu_idx()));
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, member.getBefore_url()), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByLinkUrl(new Menu(homepage.getHomepage_id(), "/intro/join/reAgree.do"));
				member.setBefore_url(String.format("/%s/intro/join/reAgree.do?menu_idx=%s", homepage.getContext_path(), member.getMenu_idx()));
				joinService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d&before_url=%s", homepage.getContext_path(), loginMenuIdx, member.getBefore_url()), request, response);
				return null;
			}
		}
		
		model.addAttribute("newMember", member);
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		request.setAttribute("menuOne", menuOne);
		return String.format(basePath, homepage.getFolder()) + "reAgree";
	}

	/**
	 * 약관인증(개인정보 재동의)
	 * @param member
	 * @param request
	 * @return
	 */
	@RequestMapping (value = { "/reAgreeA.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse reAgreeA(Member member, BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
			res.setValid(true);

			Member sessionMember;
			try {
				sessionMember = (Member) request.getSession().getAttribute("tempMemberSession");
			} catch ( Exception e ) {
				sessionMember = getSessionMemberInfo(request);
			}

			if (sessionMember == null) {
				sessionMember = getSessionMemberInfo(request);
			}

			if(member.getPrivateMemberYn(homepage)) {
				//개인정보 수집이용에 대한 동의
				ApiResponse agreeInfo = PrivateMemberAPI.agreeInfo(sessionMember.getManage_code(), sessionMember.getRec_key(), "Y");

				if (agreeInfo.getStatus()) {
					res.setValid(true);
					res.setMessage("동의가 완료되었습니다.");
					res.setUrl(String.format("/%s/index.do", homepage.getContext_path()));
				} else {
					res.setValid(false);
					res.setMessage(agreeInfo.getMessage());
				}
			} else {
				//개인정보 수집이용에 대한 동의
				ApiResponse agreeInfo = MemberAPI.agreeInfo(sessionMember.getManage_code(), sessionMember.getRec_key(), "Y");

				if (agreeInfo.getStatus()) {
					res.setValid(true);
					res.setMessage("동의가 완료되었습니다.");
					res.setUrl(String.format("/%s/index.do", homepage.getContext_path()));
				} else {
					res.setValid(false);
					res.setMessage(agreeInfo.getMessage());
				}
			}

		}
		else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}