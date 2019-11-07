package kr.co.whalesoft.app.cms.organization;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class OrganizationService extends BaseService {
	
	@Autowired
	private OrganizationDao dao;
	
	public List<Organization> getOrganizationTreeList(Organization orga) {
		return dao.getOrganizationTreeList(orga);
	}
	
	public Organization getOrganizationOne(Organization orga) {
		return dao.getOrganizationOne(orga);
	}
	
	public int addOrganization(Organization orga, HttpServletRequest request) {
		return dao.addOrganization(orga);
	}
	
	public int modifyOrganization(Organization orga, HttpServletRequest request) {
		return dao.modifyOrganization(orga);
	}
	
	public int deleteOrganization(Organization orga) {
		return dao.deleteOrganization(orga);
	}

	public int getChildCount(Organization orga) {
		return dao.getChildCount(orga);
	}

	public int moveOrganization(Organization orga) {
		return dao.moveOrganization(orga);
		
	}
}