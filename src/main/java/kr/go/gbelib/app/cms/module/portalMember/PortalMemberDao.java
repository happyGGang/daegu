package kr.go.gbelib.app.cms.module.portalMember;

import java.util.List;
import java.util.Map;

public interface PortalMemberDao {

	public List<PortalMember> getPortalMemberList(PortalMember portalMember);

	public int getPortalMemberCount(PortalMember portalMember);

	public PortalMember getPortalMemberOne(PortalMember portalMember);

	public int memberIdDuplCheck(PortalMember portalMember);

	public int addPortalMember(PortalMember portalMember);

	public int modifyPortalMember(PortalMember portalMember);

	public int deletePortalMember(PortalMember portalMember);

	public int deletePortalMemberArr(PortalMember portalMember);

	public PortalMember getPortalMemberLogin(PortalMember portalMember);

	public int addLastLogin(PortalMember loginPortal);

	public List<Map<String, Object>> getPortalMemberMySQL();

	public int addMyGration(PortalMember portalMember);

}
