package kr.co.whalesoft.app.cms.memberAuth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MemberAuthService extends BaseService {
	
	@Autowired
	private MemberAuthDao dao;
	
	public List<MemberAuth> getMemberAuthIn(MemberAuth memberAuth) {
		return dao.getMemberAuthIn(memberAuth);
	}
	
	public List<MemberAuth> getMemberAuthNotIn(MemberAuth memberAuth) {
		return dao.getMemberAuthNotIn(memberAuth);
	}
	
	@Transactional
	public void addMemberAuth(MemberAuth memberAuth) {
		for(String member_id : memberAuth.getMember_id_list()) {
			memberAuth.setMember_id(member_id);
			dao.addMemberAuth(memberAuth);
		}
	}
	
	public int modifyMemberAuth(MemberAuth memberAuth) {
		return dao.modifyMemberAuth(memberAuth);
	}
	
	public int deleteMemberAuth(MemberAuth memberAuth) {
		int result = 0;
		if ( memberAuth.getMember_id_list() != null && memberAuth.getMember_id_list().size() > 0 ) {
			for(String member_id : memberAuth.getMember_id_list()) {
				memberAuth.setMember_id(member_id);
				dao.deleteMemberAuthByAuthId(memberAuth);
			}
		}
		else {
			result = dao.deleteMemberAuthByAuthId(memberAuth);
		}
		return result;
	}

}