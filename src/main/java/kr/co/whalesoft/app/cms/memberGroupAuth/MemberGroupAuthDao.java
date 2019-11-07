package kr.co.whalesoft.app.cms.memberGroupAuth;

import java.util.List;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.memberGroupSubord.MemberGroupSubord;

public interface MemberGroupAuthDao {

	int deleteMemberGroupAuthModule(MemberGroupAuth memberGroupAuth);

	int deleteMemberGroupAuth(MemberGroupAuth memberGroupAuth);

	int addMemberGroupAuth(MemberGroupAuth memberGroupAuth);

	List<String> getAuthCodeList(MemberGroupAuth memberGroupAuth);

	List<String> getMemberGroupAuthSite(MemberGroupAuth memberGroupAuth);

	List<Homepage> getHomepageList(MemberGroupAuth memberGroupAuth);

	List<Homepage> getHomepageListByMemberGroup(MemberGroupAuth memberGroupAuth);

	int getAuthCodeCount(int member_group_idx);

	int deleteMemberGroupAuth2(Member member);

	List<Integer> getMemberGroupIdxList(MemberGroupAuth memberGroupAuth);

	List<Integer> getAuthGroupIdxList2(MemberGroupAuth memberGroupAuth);

	int getAdminGroupCount(Member member);

	int getPmsGroupCount(Member member);

	int getSiteAdminGroupCount(Member member);

	int getSiteAdminAuthCount(Member member);

	int addMemberGroupSubord(MemberGroupAuth memberGroupAuth);

	int addMemberGroupSubord(MemberGroupSubord memberGroupSubord);

}
