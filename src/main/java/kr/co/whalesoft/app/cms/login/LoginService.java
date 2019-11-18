package kr.co.whalesoft.app.cms.login;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.app.cms.accountLock.AccountLock;
import kr.co.whalesoft.app.cms.accountLock.AccountLockService;
import kr.co.whalesoft.app.cms.homepageAccess.HomepageAccessService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;
import kr.go.gbelib.app.cms.module.elib.lending.LendingService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.LoginAPI;
import kr.go.gbelib.app.module.loginLog.LoginLog;
import kr.go.gbelib.app.module.loginLog.LoginLogService;

@Service
public class LoginService extends BaseService {

	@Autowired
	private MemberService memberService;

	@Autowired
	private LendingService lendingService;

	@Autowired
	private HomepageAccessService homepageAccessService;

	@Autowired
	private AccountLockService accountLockService;

	@Autowired
	private LoginLogService loginLogService;

	/**
	 * 로그인 처리
	 * @param getMember( ID, PW 정보를 담고 있는 Member 객체 )
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@Transactional(readOnly = true)
	public String login(Member getMember, HttpServletRequest request) throws Exception {
		String orgPassword = getMember.getMember_pw();
		getMember.setMember_pw(CalculateHashUtils.calculateHash(getMember.getMember_pw()));
		getMember.setLoginType("CMS");
		Member member = new Member();
		member = memberService.getMemberOne(getMember);

		// 비번 틀려서 계정이 잠김
		if("Y".equals(accountLockService.isLocked(new AccountLock(getMember, request.getRemoteAddr())))) {
			return "LOCKED";
		}

		// 로그인 체크
		if(member != null) {
			// 링크 회원확인
			if( member.getLink_member_yn().equals("Y") ){
				member.setMember_pw(orgPassword);
//				member.setLoginType2("id");
//				String auth_id = member.getAuth_id();
//				String auth_id_list = member.getAuth_id_list();
				Object result = LoginAPI.login(member);
				if ( result instanceof Member ) {
					member.setLogin(true);
//					if (auth_id.equals("10000")) {
//						member.setLoginType("PMS");
//					} else {
//						member.setLoginType("CMS");
//					}
//					member.setAuth_id(auth_id);
//					member.setAuth_id_list(auth_id_list);
//					member.setAdmin(member.getAuth_id().equals("100"));

					/**
					 * 최근접속아이피 추가
					 */
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

//					Map<String, Object> loanListTmp = LibSearchAPI.getMyLibraryList("WEB", member.getUser_id(), "LOAN", null);
//					if (loanListTmp != null) {
//						@SuppressWarnings ("unchecked")
//						List<Map<String, String>> loanList = (List<Map<String, String>>) loanListTmp.get("dsMyLibraryList");
//						if (loanList != null && loanList.size() > 0) {
//							Map<String, String> lastLoan = loanList.get(0);
//							String lastLoanDateStr = lastLoan.get("LOAN_DATE");
//							if (StringUtils.isNotEmpty(lastLoanDateStr)) {
//								lastLoanDate = DateUtils.parseDate(lastLoanDateStr, parsePatterns);
//								if (member.getAgree_date() == null) {
//									lastLoanDate = cal.getTime();
//									cal.setTime(lastLoanDate);
//									cal.add(Calendar.YEAR, 2);
//									member.setAgree_date_str(sdf.format(cal.getTime()));
//								} else {
//									if (member.getAgree_date().compareTo(lastLoanDate) < 0) {
//										lastLoanDate = member.getAgree_date();
//									}
//									cal.setTime(lastLoanDate);
//									cal.add(Calendar.YEAR, 2);
//									member.setAgree_date_str(sdf.format(cal.getTime()));
//								}
//							} else {
//								if (member.getAgree_date() != null) {
//									lastLoanDate = member.getAgree_date();
//									cal.setTime(lastLoanDate);
//									cal.add(Calendar.YEAR, 2);
//									member.setAgree_date_str(sdf.format(cal.getTime()));
//								}
//							}
//						}
//					}

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


					setSessionMember(member, request);
					accountLockService.loginSucceeded(new AccountLock(getMember, request.getRemoteAddr()));
					loginLogService.addLoginLog(new LoginLog(member, request, "CMS"));
					return "LOGIN";
				}
				accountLockService.loginFailed(new AccountLock(getMember, request.getRemoteAddr()));
				if("Y".equals(accountLockService.isLocked(new AccountLock(getMember, request.getRemoteAddr())))) {
					return "LOCKED";
				} else {
					return "FAILED";
				}
			}else if ( getMember.getMember_pw().equals(member.getMember_pw()) ) {
				member.setLogin(true);
//				member.setAdmin(member.getAuth_id().equals("100"));
				setSessionMember(member, request);
				accountLockService.loginSucceeded(new AccountLock(getMember, request.getRemoteAddr()));
				loginLogService.addLoginLog(new LoginLog(member, request, "CMS"));
				return "LOGIN";
			}
			else {
				accountLockService.loginFailed(new AccountLock(getMember, request.getRemoteAddr()));
				if("Y".equals(accountLockService.isLocked(new AccountLock(getMember, request.getRemoteAddr())))) {
					return "LOCKED";
				} else {
					return "FAILED";
				}
			}
		}
		else {
			accountLockService.loginFailed(new AccountLock(getMember, request.getRemoteAddr()));
			if("Y".equals(accountLockService.isLocked(new AccountLock(getMember, request.getRemoteAddr())))) {
				return "LOCKED";
			} else {
				return "FAILED";
			}
		}
	}

	/**
	 * 로그아웃 처리
	 * @param request
	 */
	public void logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
	}

	/**
	 * 세션에 member 객체를 담는다.
	 * @param member
	 * @param request
	 */
	public void setSessionMember(Member member, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute(StaticVariables.MEMBER, member);
	}

	/**
	 * 세션에서 member 객체를 가져온다.
	 * @param request
	 * @return
	 */
	public Member getSessionMember(HttpServletRequest request) {
		HttpSession session = request.getSession();
		return (Member)session.getAttribute(StaticVariables.MEMBER);
	}
}