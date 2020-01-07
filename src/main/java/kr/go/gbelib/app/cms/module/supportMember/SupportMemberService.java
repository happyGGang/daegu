package kr.go.gbelib.app.cms.module.supportMember;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class SupportMemberService extends BaseService {
	
	@Autowired
	private SupportMemberDao dao;

	public List<SupportMember> getSupportMemberList(SupportMember supportMember) {
		return dao.getSupportMemberList(supportMember);
	}

	public int getSupportMemberCount(SupportMember supportMember) {
		return dao.getSupportMemberCount(supportMember);
	}
	
	public SupportMember getSupportMemberOne(SupportMember supportMember) {
		return dao.getSupportMemberOne(supportMember);
	}
	
	public int memberIdDuplCheck(SupportMember supportMember) {
		return dao.memberIdDuplCheck(supportMember);
	}

	public int addSupportMember(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		return dao.addSupportMember(supportMember);
	}
	
	public int modifySupportMember(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		return dao.modifySupportMember(supportMember);
	}

	public int deleteSupportMember(SupportMember supportMember) {
		return dao.deleteSupportMember(supportMember);
	}

	public int deleteCheckSupportMember(SupportMember supportMember) {
		return dao.deleteCheckSupportMember(supportMember);
	}

}
