package kr.go.gbelib.app.cms.module.dlscMember;

import java.util.List;

public interface DlscMemberDao {

	public int getDlscMemberCount(DlscMember dlscMember);

	public List<DlscMember> getDlscMember(DlscMember dlscMember);

}
