package kr.co.whalesoft.app.cms.organization;

import java.util.List;

import kr.co.whalesoft.app.cms.organization.Organization;
import kr.co.whalesoft.app.cms.statusMng.StatusMng;

public interface OrganizationDao {
	
	// 조직
	public List<Organization> getStatusList(Organization organizaation);
	
	public int getStatusCount(Organization organizaation);

	public List<Organization> getDivisionList(String homepage_id);
	
	public List<Organization> getStatusList(String homepage_id);
	
	public Organization getStatusOne(Organization statusMng);
	
	public int getStatusNextPrintSeq(Organization organizaation);
	
	public int getDivisionNextPrintSeq(Organization organization);

	public int addDivision(Organization organization);
	
	public int modifyDivision(Organization organization);
	
	public int addStatusCnt(Organization organization);
	
	public int modifyStatusCnt(Organization organization);

	public int modifyRatingCnt(Organization organization);

	public int statusDelete(Organization organization);
	
	public int deleteStatusAll(Organization organization);
	
	public List<Organization> getChartDivisionList(String homepage_id);
	
	public int statusCnt(Organization organization);

	public Organization getTotalCnt(String homepage_id);
	
	// 업무
	public List<Organization> getOrganizationWorkAll(Organization organization);
	
	public List<Organization> getOrganizationWorkList(Organization organization);
	
	public Organization getOrganizationWorkOne(Organization organization);
	
	public int getOrganizationWorkCnt(Organization organization);

	public List<Organization> getParentList(Organization organization);
	
	public int getNextPrintSeq(Organization organization);
	
	public int addOrganizationWork(Organization organization);
	
	public int modifyOrganizationWork(Organization organization);
	
	public int deleteOrganizationWork(Organization organization);

	
	public List<Organization> getOrganizationList(Organization organization);
	
	public int getOrganizationNextPrintSeq(Organization organization);

	public int addOrganization(Organization organization);
	
	public int modifyOrganization(Organization organization);

	public int deleteOrganization(Organization organization);

	public int deleteWorkAll(Organization organization);

	public int modifyChartYN(Organization organization);

	public Organization getOrganizationChartYN(Organization organization);
	
	public List<Organization> getOrganizationManage(Organization organization);

}
