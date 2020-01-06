package kr.go.gbelib.app.cms.module.memberManage;

import java.util.List;

public interface MemberManageDao {

	public List<MemberManage> getMemberManageList(MemberManage memberManage);

	public int getMemberManageCount(MemberManage memberManage);
	
	public MemberManage getMemberManageOne(MemberManage memberManage);
	
	public int memberIdDuplCheck(MemberManage memberManage);

	public int addMemberManage(MemberManage memberManage);
	
	public int modifyMemberManage(MemberManage memberManage);

	public int deleteMemberManage(MemberManage memberManage);

	public int deleteCheckMemberManage(MemberManage memberManage);

}
