package kr.co.whalesoft.app.cms.organization;

import java.util.List;

public interface OrganizationDao {

	public List<Organization> getOrganizationTreeList(Organization orga);

	public Organization getOrganizationOne(Organization orga);
	
	public int addOrganization(Organization orga);
	
	public int modifyOrganization(Organization orga);
	
	public int deleteOrganization(Organization orga);

	public int getChildCount(Organization orga);

	public int moveOrganization(Organization orga);
}