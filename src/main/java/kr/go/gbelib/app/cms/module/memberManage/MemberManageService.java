package kr.go.gbelib.app.cms.module.memberManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class MemberManageService extends BaseService {
	
	@Autowired
	private MemberManageDao dao;

	public List<MemberManage> getMemberManageList(MemberManage memberManage) {
		return dao.getMemberManageList(memberManage);
	}

	public int getMemberManageCount(MemberManage memberManage) {
		return dao.getMemberManageCount(memberManage);
	}
	
	public MemberManage getMemberManageOne(MemberManage memberManage) {
		return dao.getMemberManageOne(memberManage);
	}
	
	public int memberIdDuplCheck(MemberManage memberManage) {
		return dao.memberIdDuplCheck(memberManage);
	}

	public int addMemberManage(MemberManage memberManage) {
		memberManage.setMember_password(CalculateHashUtils.calculateHash(memberManage.getMember_password()));
		return dao.addMemberManage(memberManage);
	}
	
	public int modifyMemberManage(MemberManage memberManage) {
		memberManage.setMember_password(CalculateHashUtils.calculateHash(memberManage.getMember_password()));
		return dao.modifyMemberManage(memberManage);
	}

	public int deleteMemberManage(MemberManage memberManage) {
		return dao.deleteMemberManage(memberManage);
	}

	public int deleteCheckMemberManage(MemberManage memberManage) {
		return dao.deleteCheckMemberManage(memberManage);
	}

}
