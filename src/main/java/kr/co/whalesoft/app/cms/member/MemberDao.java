package kr.co.whalesoft.app.cms.member;

import java.util.List;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.go.gbelib.app.intro.join.CertificateCitizen;

public interface MemberDao {

	public List<Member> getMember(Member member);

	public Member getMemberOne(Member member);

	public int addMember(Member member);

	public int modifyMember(Member member);

	public int deleteMember(Member member);

	public int getMemberCount(Member member);

	public List<Member> getMemberListNotAuth(Member member);

	public List<Member> getMemberListInAuth(Member member);

	public int checkMemberId(Member member);

	public int checkMemberAuthInHomepage(Member member);

	public List<Member> getMemberListInId(Member member);

	public int getMemberListInAuthCount(Member member);

	public int integrationMember(Member member);

	public int addChangeNameHistory(Member member);

	public List<String> getMemberAuth(Member member);

	public List<Member> getMemberManageList(Member member);

	public int getMemberManageCount(Member member);

	public List<String> getMemberSiteAdminAuth(Member member);

	public List<Member> getMemberListBoardAdmin(BoardManage boardManage);

	public List<String> getAnonymousAuth(Member member);

	public int addMemberLastLogin(Member member);

	public int addCitizenMember(CertificateCitizen certificateCitizen);
}