package kr.co.whalesoft.app.cms.authCode;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class AuthCodeService extends BaseService {
	
	@Autowired
	private AuthCodeDao dao;
	
	@Autowired
	private LoginService loginService;

	public List<AuthCode> getAuthGroupTreeList() {
		return dao.getAuthGroupTreeList();
	}
	
	/**
	 * 모든 권한그룹을 가져온다.
	 * @return
	 */
	public List<AuthCode> getAuthGroupList() {
		return dao.getAuthGroupList();
	}
	
	public AuthCode getAuthGroupOne(AuthCode auth) {
		return dao.getAuthGroupOne(auth);
	}
	
	public int addAuthGroup(AuthCode auth, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		auth.setAdd_id(member.getMember_id());
		return dao.addAuthGroup(auth);
	}
	
	public int modifyAuthGroup(AuthCode auth, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		auth.setAdd_id(member.getMember_id());
		return dao.modifyAuthGroup(auth);
	}
	
	public int deleteAuthGroup(AuthCode auth) {
		return dao.deleteAuthGroup(auth);
	}
	
	public int getAuthCount(AuthCode auth) {
		return dao.getAuthCount(auth);
	}
	
	public List<AuthCode> getAuthCode(String auth_group_id) {
		return dao.getAuthCode(auth_group_id);
	}
	
	public AuthCode getAuthOne(AuthCode auth) {
		return dao.getAuthOne(auth);
	}
	
	public int addAuth(AuthCode auth, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		auth.setAdd_id(member.getMember_id());
		return dao.addAuth(auth);
	}
	
	public int modifyAuth(AuthCode auth, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		auth.setAdd_id(member.getMember_id());
		return dao.modifyAuth(auth);
	}
	
	public int deleteAuth(AuthCode auth) {
		return dao.deleteAuth(auth);
	}
	
	public List<AuthCode> getMenuAuth(AuthCode auth) {
		return dao.getMenuAuth(auth);
	}

	/**
	 * 다음 출력순서 가져오기
	 * @param auth
	 * @return
	 */
	public int getNextPrintSeq(AuthCode auth) {
		return dao.getNextPrintSeq(auth);
	}
	
}