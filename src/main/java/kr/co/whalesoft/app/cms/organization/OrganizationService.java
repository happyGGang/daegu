package kr.co.whalesoft.app.cms.organization;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class OrganizationService extends BaseService {

	@Autowired
	private OrganizationDao dao;

	// 조직
	public List<Organization> getStatusList(Organization organization) {
		return dao.getStatusList(organization);
	}

	public int getStatusCount(Organization organization) {
		return dao.getStatusCount(organization);
	}

	public List<Organization> getDivisionList(String homepage_id) {
		return dao.getDivisionList(homepage_id);
	}

	public List<Organization> getStatusList(String homepage_id) {
		return dao.getStatusList(homepage_id);
	}

	public Organization getStatusOne(Organization organization) {
		return dao.getStatusOne(organization);
	}

	public int getStatusNextPrintSeq(Organization organization) {
		return dao.getStatusNextPrintSeq(organization);
	}

	public int getDivisionNextPrintSeq(Organization organization) {
		return dao.getDivisionNextPrintSeq(organization);
	}

	public int addDivision(Organization organization) {
		return dao.addDivision(organization);
	}

	public int modifyDivision(Organization organization) {
		return dao.modifyDivision(organization);
	}

	public int addStatusCnt(Organization organization) {
		return dao.addStatusCnt(organization);
	}

	public int modifyStatusCnt(Organization organization) {
		return dao.modifyStatusCnt(organization);
	}

	public int modifyRatingCnt(Organization organization) {
		return dao.modifyRatingCnt(organization);
	}

	public int statusDelete(Organization organization) {
		return dao.statusDelete(organization);
	}

	public int deleteStatusAll(Organization organization) {
		return dao.deleteStatusAll(organization);
	}

	public List<Organization> getChartDivisionList(String homepage_id) {
		return dao.getChartDivisionList(homepage_id);
	}

	public int statusCnt(Organization organization) {
		return dao.statusCnt(organization);
	}

	public Organization getTotalCnt(String homepage_id) {
		return dao.getTotalCnt(homepage_id);
	}

	// 업무
	public List<Organization> getOrganizationWorkAll(Organization organization) {
		return dao.getOrganizationWorkAll(organization);
	}

	public List<Organization> getOrganizationWorkList(Organization organization) {
		return dao.getOrganizationWorkList(organization);
	}

	public Organization getOrganizationWorkOne(Organization organization) {
		return dao.getOrganizationWorkOne(organization);
	}

	public int getOrganizationWorkCnt(Organization organization) {
		return dao.getOrganizationWorkCnt(organization);
	}

	public List<Organization> getParentList(Organization organization) {
		return dao.getParentList(organization);
	}

	public int getNextPrintSeq(Organization organization) {
		return dao.getNextPrintSeq(organization);
	}

	public int addOrganizationWork(Organization organization) {
		return dao.addOrganizationWork(organization);
	}

	public int modifyOrganizationWork(Organization organization) {
		return dao.modifyOrganizationWork(organization);
	}

	public int deleteOrganizationWork(Organization organization) {
		return dao.deleteOrganizationWork(organization);
	}

	public List<Organization> getOrganizationList(Organization organization) {
		return dao.getOrganizationList(organization);
	}

	public int getOrganizationNextPrintSeq(Organization organization) {
		return dao.getOrganizationNextPrintSeq(organization);
	}

	public int addOrganization(Organization organization) {
		return dao.addOrganization(organization);
	}

	public int modifyOrganization(Organization organization) {
		return dao.modifyOrganization(organization);
	}

	public int deleteOrganization(Organization organization) {
		return dao.deleteOrganization(organization);
	}

	public int deleteWorkAll(Organization organization) {
		return dao.deleteWorkAll(organization);
	}

	public int modifyChartYN(Organization organization) {
		return dao.modifyChartYN(organization);
	}

	public char getOrganizationChartYN(Organization organization) {
		Organization result = dao.getOrganizationChartYN(organization);
		if (result != null) {
			return result.getChart_yn();
		} else {
			return 'N';
		}
	}

	public List<Organization> getOrganizationManage(Organization organization) {
		return dao.getOrganizationManage(organization);
	}

}
