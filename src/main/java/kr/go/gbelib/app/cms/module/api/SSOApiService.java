package kr.go.gbelib.app.cms.module.api;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.homepageAccess.HomepageAccessService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroup;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroupService;
import kr.co.whalesoft.app.cms.memberGroupSubord.MemberGroupSubordService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;
import kr.go.gbelib.app.cms.module.elib.lending.LendingService;
import kr.go.gbelib.app.cms.module.teacher.Teacher;
import kr.go.gbelib.app.cms.module.teacher.TeacherService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LoginAPI;
import kr.go.gbelib.app.common.api.MemberAPI;

@Service
public class SSOApiService extends BaseService {

	@Autowired
	private ApiLogService apiLogService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private CodeService codeService;


	@Autowired
	private LoginService service;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private HomepageAccessService homepageAccessService;

	@Autowired
	private LendingService lendingService;

	@Autowired
	private TeacherService teacherService;

	@Autowired
	private MemberGroupService memberGroupService;

	@Autowired
	private MemberGroupSubordService memberGroupSubordService;

	private static final String LOGIN_PAGE = "/elib/intro/login/index.do?menu_idx=43";
	private static final String MAIN_PAGE = "http://www.gbelib.kr/elib/index.do";

	public String getData(SSO sso, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String flag = sso.getFlag();
		String ssoId = sso.getSsoId();
		String ssoNo = sso.getSsoNo();
		String goPage = sso.getGoPage();

		if(!"app".equals(flag)) {
			String errmsg = "잘못된 flag 파라미터";
			apiLogService.addApiLog(new ApiLog("SSO", "-1", errmsg, makeParamUrl(sso), request.getRemoteAddr()));
			return "redirect:" + LOGIN_PAGE;
		}

		if(StringUtils.isEmpty(sso.getSsoId())) {
			String errmsg = "잘못된 ssoId 파라미터";
			apiLogService.addApiLog(new ApiLog("SSO", "-2", errmsg, makeParamUrl(sso), request.getRemoteAddr()));
			return "redirect:" + LOGIN_PAGE;
		}

		if(StringUtils.isEmpty(sso.getSsoNo())) {
			String errmsg = "잘못된 ssoNo 파라미터";
			apiLogService.addApiLog(new ApiLog("SSO", "-3", errmsg, makeParamUrl(sso), request.getRemoteAddr()));
			return "redirect:" + LOGIN_PAGE;
		}

		Member member = new Member();
		member.setUser_id(ssoId);
		member.setMember_id(ssoId);
		Map<String, String> data = MemberAPI.getMember("WEB", member);

		if(data == null) {
			String errmsg = "존재하지 않는 ssoId";
			apiLogService.addApiLog(new ApiLog("SSO", "-4", errmsg, makeParamUrl(sso), request.getRemoteAddr()));
			return "redirect:" + LOGIN_PAGE;
		}

		String seq_no = data.get("SEQ_NO");

		if(!seq_no.equals(ssoNo)) {
			String errmsg = "존재하지 않는 ssoNo";
			apiLogService.addApiLog(new ApiLog("SSO", "-5", errmsg, makeParamUrl(sso), request.getRemoteAddr()));
			return "redirect:" + LOGIN_PAGE;
		}

		member.setMember_name(data.get("USER_NAME"));
//		member.setLoginType2("num");
		Object result = LoginAPI.login(member);

		if(result instanceof Member) {
			try {

				Member tempMember = (Member) result;

				member = (Member) result;


				member.setLogin(true);

				member.setLast_login_ip(homepageAccessService.getLastHomepageAccess(member));
				memberService.addMemberLastLogin(member, request);

				//관리자확인
				String memberId = member.getMember_id();
				member.setMember_id(member.getWeb_id());
				Member adminMember = memberService.getMemberOne(member);
				if(adminMember != null) {
//				member.setAuthMap(adminMember.getAuthMap());
					member.setLink_member_yn(adminMember.getLink_member_yn());
					member.setAdmin(adminMember.isAdmin());
					member.setAuthorityHomepageList(adminMember.getAuthorityHomepageList());
//				member.setAuth_id(adminMember.getAuth_id());
//				member.setAuth_id_list(adminMember.getAuth_id_list());
//				member.setHomepage_id(adminMember.getHomepage_id());
//				if (StringUtils.equals(adminMember.getAuth_id(), "100")) {
//					member.setAdmin(true);
//				}
				}
				member.setMember_id(memberId);

				Teacher teacher = new Teacher();
				teacher.setMember_key(member.getSeq_no());
				teacher = teacherService.checkTeacher2(teacher);
//				if (teacher != null && teacher.getTeacher_idx() != 0) {
//					member.setTeacher_yn("Y");
//				}

				/**
				 * 개인정보 동의 기간 설정
				 */
				Date lastLoanDate = new Date();
				Calendar cal = Calendar.getInstance();
				String[] parsePatterns = {"yyyyMMdd"};
				String[] parsePatterns2 = {"yyyy-MM-dd"};
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

//				Map<String, Object> loanListTmp = LibSearchAPI.getMyLibraryList("WEB", member.getUser_id(), "LOAN", null);
//				if (loanListTmp != null) {
//					@SuppressWarnings ("unchecked")
//					List<Map<String, String>> loanList = (List<Map<String, String>>) loanListTmp.get("dsMyLibraryList");
//					if (loanList != null && loanList.size() > 0) {
//						Map<String, String> lastLoan = loanList.get(0);
//						String lastLoanDateStr = lastLoan.get("LOAN_DATE");
//						if (StringUtils.isNotEmpty(lastLoanDateStr)) {
//							lastLoanDate = DateUtils.parseDate(lastLoanDateStr, parsePatterns);
//							if (member.getAgree_date() == null) {
//								lastLoanDate = cal.getTime();
//								cal.setTime(lastLoanDate);
//								cal.add(Calendar.YEAR, 2);
//								member.setAgree_date_str(sdf.format(cal.getTime()));
//							} else {
//								if (member.getAgree_date().compareTo(lastLoanDate) < 0) {
//									lastLoanDate = cal.getTime();
//								} else {
//									lastLoanDate = member.getAgree_date();
//								}
//								cal.setTime(lastLoanDate);
//								cal.add(Calendar.YEAR, 2);
//								member.setAgree_date_str(sdf.format(cal.getTime()));
//							}
//						} else {
//							if (member.getAgree_date() != null) {
//								lastLoanDate = member.getAgree_date();
//								cal.setTime(lastLoanDate);
//								cal.add(Calendar.YEAR, 2);
//								member.setAgree_date_str(sdf.format(cal.getTime()));
//							}
//						}
//					}
//				}

				Lending lending = new Lending();
				lending.setMember_id(member.getWeb_id());
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
							if (lastLoanDate.compareTo(elibLastLendDate) < 0) {
								cal.setTime(elibLastLendDate);
								cal.add(Calendar.YEAR, 2);
								member.setAgree_date_str(sdf.format(cal.getTime()));
							}
						}
					}
				}

				if ((member.getAuthMap() == null || member.getAuthMap().isEmpty()) && !member.isAdmin()) {

					if (StringUtils.equals(member.getUnAgreeFlag(), "0001")) {
						//통합회원
						if(adminMember != null) {
							//관리자 링크회원이면 기존 그룹에 추가
							member.setAuthGroupIdxList(memberGroupSubordService.getAuthGroupIdxList(adminMember));
							//통합회원그룹에 속하게 한다. 도서관은 하드코딩한다...
							if (!member.getAuthGroupIdxList().contains(149)) {
								member.getAuthGroupIdxList().add(149);
							}
						} else if (member.getAuthGroupIdxList() == null || member.getAuthGroupIdxList().size() < 1) {
							//관리자 링크회원 아니면 새로 생성
							member.setAuthGroupIdxList(new ArrayList<Integer>());
							//통합회원그룹에 속하게 한다. 도서관은 하드코딩한다...
							member.getAuthGroupIdxList().add(149);
						}
//					String imsiId = member.getMember_id();
//					member.setMember_id(member.getSeq_no());
						//그룹-멤버 관계 테이블에 넣는다.
						memberGroupSubordService.addAuthGroupMember(member);
						//권한맵을 새로 불러온다.
						member.setAuthMap(memberService.getMemberAuth(member));
					} else {
						if(adminMember != null) {
							member.setAuthGroupIdxList(memberGroupSubordService.getAuthGroupIdxList(adminMember));
							Homepage homepageTmp = new Homepage();
							homepageTmp.setHomepage_code(member.getLoca());
							String locaHomepageId = homepageService.getHomepageOneByCode(homepageTmp).getHomepage_id();

							MemberGroup memberGroup = new MemberGroup();
							memberGroup.setSite_id(locaHomepageId);

							//내 소속도서관의 사용자 그룹에만 지정한다.
							member.getAuthGroupIdxList().add(memberGroupService.getSiteUserGroupOne(memberGroup).getMember_group_idx());
						}
						if (member.getAuthGroupIdxList() == null || member.getAuthGroupIdxList().size() < 1) {
							member.setAuthGroupIdxList(new ArrayList<Integer>());
							//통합회원그룹에 속하게 한다.
							Homepage homepageTmp = new Homepage();
							homepageTmp.setHomepage_code(member.getLoca());
							String locaHomepageId = homepageService.getHomepageOneByCode(homepageTmp).getHomepage_id();

							MemberGroup memberGroup = new MemberGroup();
							memberGroup.setSite_id(locaHomepageId);

							//내 소속도서관의 사용자 그룹에만 지정한다.
							member.getAuthGroupIdxList().add(memberGroupService.getSiteUserGroupOne(memberGroup).getMember_group_idx());
						}
						//그룹-회원 관계테이블에 넣는다.
						memberGroupSubordService.addAuthGroupMember(member);
//					//권한정보를 다시 가져온다.
						member.setAuthMap(memberService.getMemberAuth(member));
					}

				}
			} catch ( Exception e ) {
				System.out.println("@@@@@@@@@@@@@@@@ loginProcFailed : " + e.getMessage());
			}

			service.setSessionMember(member, request);





			apiLogService.addApiLog(new ApiLog("SSO", "0", "", makeParamUrl(sso), request.getRemoteAddr()));
			if(StringUtils.isEmpty(goPage)) {
				return "redirect:" + MAIN_PAGE;
			} else {
				return "redirect:" + goPage;
			}
		} else {
			ApiResponse errorResult = (ApiResponse) result;
			codeService.alertMessage(errorResult.getMessage(), request, response);
			String errmsg = errorResult.getMessage();
			apiLogService.addApiLog(new ApiLog("SSO", "-6", errmsg, makeParamUrl(sso), request.getRemoteAddr()));
			return null;
		}
	}

	private String defaultString(String s) {
		if(s == null) return "";
		else return s;
	}

	private String makeParamUrl(SSO sso) {
		StringBuilder sb = new StringBuilder();

		sb.append("flag=" + sso.getFlag());
		sb.append("&ssoId=" + sso.getSsoId());
		sb.append("&ssoNo=" + sso.getSsoNo());
		try {
			sb.append("&goPage=" + URLDecoder.decode(defaultString(sso.getGoPage()), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			sb.append("&goPage=" + defaultString(sso.getGoPage()));
		}

		return sb.toString();
	}

}
