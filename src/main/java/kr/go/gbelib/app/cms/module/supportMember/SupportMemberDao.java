package kr.go.gbelib.app.cms.module.supportMember;

import java.util.List;

public interface SupportMemberDao {

	public List<SupportMember> getSupportMemberList(SupportMember supportMember);

	public int getSupportMemberCount(SupportMember supportMember);
	
	public SupportMember getSupportMemberOne(SupportMember supportMember);
	
	public int memberIdDuplCheck(SupportMember supportMember);

	public int addSupportMember(SupportMember supportMember);
	
	public int modifySupportMember(SupportMember supportMember);

	public int deleteSupportMember(SupportMember supportMember);

	public int deleteCheckSupportMember(SupportMember supportMember);

	public SupportMember getSupportMemberLogin(SupportMember supportMember);

	public int addLastLogin(SupportMember supportMember);

}
