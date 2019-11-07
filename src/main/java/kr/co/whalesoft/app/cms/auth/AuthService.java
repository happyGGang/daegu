package kr.co.whalesoft.app.cms.auth;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class AuthService extends BaseService {
	
	@Autowired
	private AuthDao dao;
	
	@Autowired
	private LoginService loginService;

	public List<Auth> getAuthGroupTreeList() {
		return dao.getAuthGroupTreeList();
	}
	
	public Auth getAuthGroupOne(Auth auth) {
		return dao.getAuthGroupOne(auth);
	}
	
	public int addAuthGroup(Auth auth, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		auth.setAdd_id(member.getMember_id());
		return dao.addAuthGroup(auth);
	}
	
	public int modifyAuthGroup(Auth auth, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		auth.setAdd_id(member.getMember_id());
		return dao.modifyAuthGroup(auth);
	}
	
	public int deleteAuthGroup(Auth auth) {
		return dao.deleteAuthGroup(auth);
	}
	
	public int getAuthCount(Auth auth) {
		return dao.getAuthCount(auth);
	}
	
	public List<Auth> getAuth(String auth_group_id) {
		return dao.getAuth(auth_group_id);
	}
	
	public Auth getAuthOne(Auth auth) {
		return dao.getAuthOne(auth);
	}
	
	public int addAuth(Auth auth, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		auth.setAdd_id(member.getMember_id());
		return dao.addAuth(auth);
	}
	
	public int modifyAuth(Auth auth, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		auth.setAdd_id(member.getMember_id());
		return dao.modifyAuth(auth);
	}
	
	public int deleteAuth(Auth auth) {
		return dao.deleteAuth(auth);
	}
	
	public List<Auth> getMenuAuth(Auth auth) {
		return dao.getMenuAuth(auth);
	}

	/**
	 * 다음 출력순서 가져오기
	 * @param auth
	 * @return
	 */
	public int getNextPrintSeq(Auth auth) {
		return dao.getNextPrintSeq(auth);
	}
	
}