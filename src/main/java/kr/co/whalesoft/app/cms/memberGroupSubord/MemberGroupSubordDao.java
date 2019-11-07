package kr.co.whalesoft.app.cms.memberGroupSubord;

import java.util.List;
import kr.co.whalesoft.app.cms.member.Member;

public interface MemberGroupSubordDao {

	List<MemberGroupSubord> getMemberGroupSubordTreeList(MemberGroupSubord authGroupMember);

	List<MemberGroupSubord> getMemberGroupSubordList(MemberGroupSubord authGroupMember);

	List<MemberGroupSubord> getMemberGroupSubordReadyList(MemberGroupSubord authGroupMember);

	int deleteMemberGroupSubord(MemberGroupSubord authGroupMember);

	int addMemberGroupSubord(MemberGroupSubord authGroupMember);

	List<Integer> getAuthGroupIdxList(MemberGroupSubord authGroupMember);

	List<Integer> getAuthGroupIdxList2(MemberGroupSubord authGroupMember);

	int deleteMemberGroupSubord2(Member member);

	int getAdminGroupCount(Member member);

	int getSiteAdminGroupCount(Member member);

	int getPmsGroupCount(Member member);

	int getSiteAdminAuthCount(Member member);

}
