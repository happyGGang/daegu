package kr.go.gbelib.app.cms.module.dlscMember;

import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.MemberAPI;

@Service
public class DlscMemberService extends BaseService {

	@Autowired
	private DlscMemberDao dao;
	
	public int getDlscMemberCount(DlscMember dlscMember) {
		return dao.getDlscMemberCount(dlscMember);
	}

	public List<DlscMember> getDlscMember(DlscMember dlscMember) {
		if (StringUtils.equals(dlscMember.getSortField(), "TITLE")) {
			dlscMember.setSortField("add_date");
		}
		List<DlscMember> list = dao.getDlscMember(dlscMember);
		if (list != null && list.size() > 0) {
			for ( DlscMember dls : list ) {
				Member tempMember = new Member();
				tempMember.setUser_id(dls.getLib_id());
				Map<String, String> map = MemberAPI.getMember("WEB", tempMember);
				try {
					dls.setWeb_id(map.get("WEB_ID"));
				}
				catch ( Exception e ) {
					// TODO: handle exception
				}
			}
		}
		return list;
	}

}
