package kr.co.whalesoft.app.cms.memberOrganization;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MemberOrganizationService extends BaseService {
	
	@Autowired
	private MemberOrganizationDao dao;
	
	public MemberOrganization getMemberOrganizationOne(MemberOrganization orga) {
		return dao.getMemberOrganizationOne(orga);
	}
	
	public int addMemberOrganization(MemberOrganization orga) {
		for ( String one : orga.getMember_id_list() ) {
			orga.setMember_id(one);
			dao.addMemberOrganization(orga);
		}
		return 1; 
	}
	
	public int deleteMemberOrganization(MemberOrganization orga) {
		return dao.deleteMemberOrganization(orga);
	}

	public List<MemberOrganization> getMemberInOrganization(MemberOrganization orga) {
		return dao.getMemberInOrganization(orga);
	}
	
	public List<MemberOrganization> getMemberNotInOrganization(MemberOrganization orga) {
		return dao.getMemberNotInOrganization(orga);
	}
	
}