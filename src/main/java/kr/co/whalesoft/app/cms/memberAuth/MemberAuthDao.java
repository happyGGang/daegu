package kr.co.whalesoft.app.cms.memberAuth;

import java.util.List;

public interface MemberAuthDao {
	
	public List<MemberAuth> getMemberAuthIn(MemberAuth memberAuth);
	
	public List<MemberAuth> getMemberAuthNotIn(MemberAuth memberAuth);

	public int addMemberAuth(MemberAuth memberAuth);
	
	public int modifyMemberAuth(MemberAuth memberAuth);
	
	public int deleteMemberAuth(MemberAuth memberAuth);
	
	public int deleteMemberAuthByAuthId(MemberAuth memberAuth);
}
