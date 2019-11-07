package kr.co.whalesoft.app.cms.memberOrganization;

import java.util.List;

public interface MemberOrganizationDao {

	public MemberOrganization getMemberOrganizationOne(MemberOrganization memberOrga);
	
	public int addMemberOrganization(MemberOrganization memberOrga);
	
	public int deleteMemberOrganization(MemberOrganization memberOrga);

	public List<MemberOrganization> getMemberInOrganization(MemberOrganization memberOrga);

	public List<MemberOrganization> getMemberNotInOrganization(MemberOrganization memberOrga);
}