package kr.go.gbelib.app.cms.module.supportMember;

import java.util.List;
import java.util.Map;

import javax.crypto.Cipher;

import org.apache.commons.lang.StringUtils;
import org.bouncycastle.util.encoders.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuthService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.dataSource.DataSource;
import kr.co.whalesoft.framework.dataSource.DataSourceType;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class SupportMemberService extends BaseService {
	
	@Autowired
	private SupportMemberDao dao;
	
	@Autowired
	private MemberGroupAuthService memberGroupAuthService;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private MemberService memberService;
	
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
		
		supportMember = dao.getSupportMemberLogin(supportMember);
		if(supportMember != null) {
			Member member = new Member(supportMember.getMember_id());
			//최고관리자 여부
			supportMember.setAdmin(memberGroupAuthService.isAdminGroup(member));
			//관리사이트 목록
			supportMember.setAuthorityHomepageList(homepageService.getMySiteList(member));
			if (!supportMember.isAdmin()) {
				/**
				 * 최고관리자가 아닌경우 authMap을 세팅한다.
				 */
				supportMember.setAuthMap(memberService.getMemberAuth(member));
			}
		}
		
		return supportMember;
	}

	public int addLastLogin(SupportMember supportMember) {
		return dao.addLastLogin(supportMember);
	}
	
	public int passwordChange(SupportMember supportMember) {
		supportMember.setMember_password(CalculateHashUtils.calculateHash(supportMember.getMember_password()));
		return dao.passwordChange(supportMember);
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
