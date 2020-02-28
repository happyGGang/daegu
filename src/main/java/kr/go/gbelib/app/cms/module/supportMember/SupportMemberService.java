package kr.go.gbelib.app.cms.module.supportMember;

import java.util.List;
import java.util.Map;

import javax.crypto.Cipher;

import org.apache.commons.lang.StringUtils;
import org.bouncycastle.util.encoders.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.dataSource.DataSource;
import kr.co.whalesoft.framework.dataSource.DataSourceType;
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
		if(StringUtils.isNotEmpty(supportMember.getMember_password())) {
			supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		}
		return dao.modifySupportMember(supportMember);
	}

	public int deleteSupportMember(SupportMember supportMember) {
		return dao.deleteSupportMember(supportMember);
	}

	public int deleteCheckSupportMember(SupportMember supportMember) {
		return dao.deleteCheckSupportMember(supportMember);
	}

	public SupportMember getSupportMemberLogin(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		return dao.getSupportMemberLogin(supportMember);
	}

	public int addLastLogin(SupportMember supportMember) {
		return dao.addLastLogin(supportMember);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getMySqlList() {
		return dao.getMySqlList();
	}

	public int addParseTibero(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		return dao.addParseTibero(supportMember);
	}
	
}
