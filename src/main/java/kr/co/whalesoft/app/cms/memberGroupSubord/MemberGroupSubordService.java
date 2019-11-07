package kr.co.whalesoft.app.cms.memberGroupSubord;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.whalesoft.app.cms.adminMenu.AdminMenu;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroup;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroupService;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MemberGroupSubordService extends BaseService {

	@Autowired
	private MemberGroupSubordDao dao;
	
	@Autowired
	private MemberGroupService memberGroupService;

	/**
	 * 권한그룹 가져오기 (내가 가진 권한만)
	 * @param memberGroupSubord
	 * @return
	 */
	public List<MemberGroupSubord> getMemberGroupSubordTreeList(MemberGroupSubord memberGroupSubord) {
		return dao.getMemberGroupSubordTreeList(memberGroupSubord);
	}

	/**
	 * 권한에 속한사람을 가져온다.
	 * @param memberGroupSubord
	 * @return
	 */
	public List<MemberGroupSubord> getMemberGroupSubordList(MemberGroupSubord memberGroupSubord) {
		return dao.getMemberGroupSubordList(memberGroupSubord);
	}

	/**
	 * 권한에 속하지 않았지만 줄 수 있는 사람을 가져온다.
	 * @param memberGroupSubord
	 * @return
	 */
	public List<MemberGroupSubord> getMemberGroupSubordReadyList(MemberGroupSubord memberGroupSubord) {
		return dao.getMemberGroupSubordReadyList(memberGroupSubord);
	}

	/**
	 * 권한그룹 1개 가져오기
	 * @param memberGroupSubord
	 * @return
	 */
	public MemberGroupSubord getMemberGroupSubordOne(MemberGroupSubord memberGroupSubord) {
		MemberGroup memberGroup = memberGroupService.getMemberGroupOne(memberGroupSubord);
		memberGroupSubord.setMember_group_name(memberGroup.getMember_group_name());
		memberGroupSubord.setRemark(memberGroup.getRemark());
		memberGroupSubord.setMember_group_idx(memberGroup.getMember_group_idx());
		return memberGroupSubord;
	}

	/**
	 * 권한그룹에 사용자를 등록한다.
	 * 기존꺼 다 지우고 다시 새로 다 쓴다.
	 * @param memberGroupSubord
	 * @param request
	 * @return
	 */
	@Transactional
	public int addMemberGroupSubord(MemberGroupSubord memberGroupSubord) {
		int result = 0;
		result += dao.deleteMemberGroupSubord(memberGroupSubord);
		result += dao.deleteMemberGroupSubord2(new Member(memberGroupSubord.getMember_id()));
		if (memberGroupSubord.getMemberList() != null && memberGroupSubord.getMemberList().size() > 0) {
			for ( String member_id : memberGroupSubord.getMemberList() ) {
				memberGroupSubord.setMember_id(member_id);
				result += dao.addMemberGroupSubord(memberGroupSubord);
			}
		}
		return result;
	}
	
	/**
	 * 권한그룹에 사용자를 등록한다.
	 * 기존꺼 다 지우고 다시 새로 다 쓴다.
	 * @param memberGroupSubord
	 * @param request
	 * @return
	 */
	@Transactional
	public int addAuthGroupMember(Member member) {
		MemberGroupSubord memberGroupSubord = new MemberGroupSubord();
		int result = 0;
		memberGroupSubord.setMember_id(member.getMember_id());
		memberGroupSubord.setCud_id(member.getMember_id());
		result += dao.deleteMemberGroupSubord2(member);
		if (member.getAuthGroupIdxList() != null && member.getAuthGroupIdxList().size() > 0) {
			for ( int authGroupIdx : member.getAuthGroupIdxList() ) {
				memberGroupSubord.setMember_group_idx(authGroupIdx);
				result += dao.addMemberGroupSubord(memberGroupSubord);
			}
		}
		return result;
	}

	/**
	 * 특정 아이디의 권한그룹 목록으 가져온다.
	 * @param adminMenu
	 * @return
	 */
	public List<Integer> getAuthGroupIdxList(AdminMenu adminMenu) {
		MemberGroupSubord memberGroupSubord = new MemberGroupSubord();
		memberGroupSubord.setMember_id(adminMenu.getMember_id());
		memberGroupSubord.setHomepage_id(adminMenu.getHomepage_id());
		return dao.getAuthGroupIdxList(memberGroupSubord);
	}
	
	/**
	 * 특정 아이디의 권한그룹 목록으 가져온다.
	 * @param member
	 * @return
	 */
	public List<Integer> getAuthGroupIdxList(Member member) {
		MemberGroupSubord memberGroupSubord = new MemberGroupSubord();
		memberGroupSubord.setMember_id(member.getMember_id());
		memberGroupSubord.setHomepage_id(member.getHomepage_id());
		return dao.getAuthGroupIdxList2(memberGroupSubord);
	}

	/**
	 * CMS최고관리자 여부 확인
	 * @param member
	 * @return
	 */
	public boolean isAdminGroup(Member member) {
		return dao.getAdminGroupCount(member) > 0 ? true : false;
	}
	
	/**
	 * cms접근가능여부
	 * @param member
	 * @return
	 */
	public boolean hasAdminAuth(Member member) {
		return dao.getSiteAdminAuthCount(member) > 0 ? true : false;
	}
	
	/**
	 * pms접근가능여부
	 * @param member
	 * @return
	 */
	public boolean hasPmsAuth(Member member) {
		return dao.getPmsGroupCount(member) > 0 ? true : false;
	}
	
	
	/**
	 * 사이트최고관리자 여부 확인
	 * @param member
	 * @return
	 */
	public boolean isSiteAdminGroup(Member member) {
		return dao.getSiteAdminGroupCount(member) > 0 ? true : false;
	}
	
}
