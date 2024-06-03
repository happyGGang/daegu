package kr.go.gbelib.app.cms.module.portalMember;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.dataSource.DataSourceType;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.co.whalesoft.framework.dataSource.DataSource;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;

@Service
public class PortalMemberService extends BaseService {
	
	@Autowired
	private PortalMemberDao dao;

	@WorkingLogger(comment="대표도서관 회원관리 조회", type="P")
	public List<PortalMember> getPortalMemberList(PortalMember portalMember) {
		return dao.getPortalMemberList(portalMember);
	}

	public int getPortalMemberCount(PortalMember portalMember) {
		return dao.getPortalMemberCount(portalMember);
	}

	@WorkingLogger(comment="대표도서관 회원관리 1건 조회", type="P")
	public PortalMember getPortalMemberOne(PortalMember portalMember) {
		return dao.getPortalMemberOne(portalMember);
	}

	public int addPortalMember(PortalMember portalMember) {
		portalMember.setAgency_password(CalculateHashUtils.calculateHash(portalMember.getAgency_password()));
		return dao.addPortalMember(portalMember);
	}

	@WorkingLogger(comment="대표도서관 회원관리 1건 수정", type="P", tableName = "PORTAL_MEMBER")
	public int modifyPortalMember(PortalMember portalMember) {
		if(StringUtils.isNotEmpty(portalMember.getAgency_password())) {
			portalMember.setAgency_password(CalculateHashUtils.calculateHash(portalMember.getAgency_password()));
		}
		return dao.modifyPortalMember(portalMember);
	}

	@WorkingLogger(comment="대표도서관 회원관리 1건 삭제", type="P")
	public int deletePortalMember(PortalMember portalMember) {
		return dao.deletePortalMember(portalMember);
	}

	@WorkingLogger(comment="대표도서관 회원관리 선택 회원 삭제", type="P")
	public int deletePortalMemberArr(PortalMember portalMember) {
		return dao.deletePortalMemberArr(portalMember);
	}

	public PortalMember getPortalMemberLogin(PortalMember portalMember) {
		portalMember.setAgency_password(CalculateHashUtils.calculateHash(portalMember.getAgency_password()));
		return dao.getPortalMemberLogin(portalMember);
	}

	public int addLastLogin(PortalMember loginPortal) {
		return dao.addLastLogin(loginPortal);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getPortalMemberMySQL() {
		return dao.getPortalMemberMySQL();
	}

	public int addMyGration(PortalMember portalMember) {
		portalMember.setAgency_password(CalculateHashUtils.calculateHash(portalMember.getAgency_password()));
		return dao.addMyGration(portalMember);
	}

}
