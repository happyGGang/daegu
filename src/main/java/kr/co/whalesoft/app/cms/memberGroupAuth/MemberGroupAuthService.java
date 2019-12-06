package kr.co.whalesoft.app.cms.memberGroupAuth;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.app.cms.adminMenu.AdminMenu;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroup;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroupService;
import kr.co.whalesoft.app.cms.memberGroupSubord.MemberGroupSubord;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MemberGroupAuthService extends BaseService {

	@Autowired
	private MemberGroupAuthDao dao;

	@Autowired
	private MemberGroupService memberGroupService;

	/**
	 * 그룹별 권한등록
	 * 기존 권한을 지우고 등록한다.
	 * @param memberGroupAuth
	 * @param request
	 * @return
	 */
	@Transactional
	public int addMemberGroupAuth(MemberGroupAuth memberGroupAuth, HttpServletRequest request) {
		int result = 0;
		if (StringUtils.equals(memberGroupAuth.getModule_type(), "MODULE")) {
//			result = dao.deleteMemberGroupAuthModule(memberGroupAuth);
		} else {
			memberGroupAuth.setSite_id(memberGroupAuth.getHomepage_id());
			result = dao.deleteMemberGroupAuth(memberGroupAuth);
		}
		if (memberGroupAuth.getAuthCodeList() != null && memberGroupAuth.getAuthCodeList().size() > 0) {
			for ( String str : memberGroupAuth.getAuthCodeList() ) {
				String[] split = str.split("_");
				memberGroupAuth.setMenu_idx(Integer.parseInt(split[0]));
				memberGroupAuth.setModule_idx(Integer.parseInt(split[1]));
				memberGroupAuth.setAuth_code_id(split[2]);
				result += dao.addMemberGroupAuth(memberGroupAuth);
			}
		}
		return result;
	}

	/**
	 * 권한그룹에 사용자를 등록한다.
	 * 기존꺼 다 지우고 다시 새로 다 쓴다.
	 * member.homepage_id에 값이 있으면 해당 homepage_id의 그룹만 삭제함.
	 * 없다면 모든 그룹-회원관계를 다 삭제한다.
	 * @param memberGroupAuth
	 * @param request
	 * @return
	 */
	@Transactional
	public int addMemberGroupAuth(Member member) {
		MemberGroupSubord memberGroupSubord = new MemberGroupSubord();
		int result = 0;
		memberGroupSubord.setMember_id(member.getMember_id());
		memberGroupSubord.setCud_id(member.getMember_id());
		result += dao.deleteMemberGroupAuth2(member);
		if (member.getAuthGroupIdxList() != null && member.getAuthGroupIdxList().size() > 0) {
			for ( int authGroupIdx : member.getAuthGroupIdxList() ) {
				memberGroupSubord.setMember_group_idx(authGroupIdx);
				result += dao.addMemberGroupSubord(memberGroupSubord);
			}
		}
		return result;
	}

	/**
	 * 권한그룹에 사용자를 등록한다.
	 * 기존꺼 다 지우고 다시 새로 다 쓴다.
	 * @param memberGroupAuth
	 * @param request
	 * @return
	 */
	@Transactional
	public int addMemberGroupAuth(Member member, Member member2) {
		MemberGroupSubord memberGroupSubord = new MemberGroupSubord();
		int result = 0;
		memberGroupSubord.setMember_id(member.getMember_id());
		memberGroupSubord.setCud_id(member2.getMember_id());
		result += dao.deleteMemberGroupAuth2(member);
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
		MemberGroupAuth memberGroupAuth = new MemberGroupAuth();
		memberGroupAuth.setMember_id(adminMenu.getMember_id());
		memberGroupAuth.setHomepage_id(adminMenu.getHomepage_id());
		return dao.getMemberGroupIdxList(memberGroupAuth);
	}


	public MemberGroupAuth getMemberGroupAuth(MemberGroupAuth memberGroupAuth) {
		memberGroupAuth.setAuthCodeList(dao.getAuthCodeList(memberGroupAuth));
		if (StringUtils.equals(memberGroupAuth.getModuleType(), "CMS")) {
			memberGroupAuth.setHomepage_id(memberGroupService.getMemberGroupOne(new MemberGroup(memberGroupAuth.getMember_group_idx())).getSite_id());
		}
		return memberGroupAuth;
	}

	public MemberGroupAuth getMemberGroupAuthSite(MemberGroupAuth memberGroupAuth) {
		memberGroupAuth.setAuthCodeList(dao.getMemberGroupAuthSite(memberGroupAuth));
		return memberGroupAuth;
	}

	/**
	 * 권한부여 가능한 홈페이지 목록을 불러온다.
	 * @param memberGroupAuth.member_group_idx
	 * @return
	 */
	public List<Homepage> getHomepageList(MemberGroupAuth memberGroupAuth) {
		return dao.getHomepageList(memberGroupAuth);
	}

	/**
	 * 권한부여 가능한 홈페이지 목록을 불러온다. 그룹이 컨트롤 가능한 것만 불러온다.
	 * @param memberGroupAuth
	 * @return
	 */
	public List<Homepage> getHomepageListByMemberGroup(MemberGroupAuth memberGroupAuth) {
		return dao.getHomepageListByMemberGroup(memberGroupAuth);
	}

	/**
	 * 권한그룹이 가진 모듈권한 가져오기
	 * @param memberGroupAuth
	 * @return
	 */
	public List<String> getAuthCodeList(MemberGroupAuth memberGroupAuth) {
		return dao.getAuthCodeList(memberGroupAuth);
	}

	/**
	 * ㅇ
	 * @param member_group_idx
	 * @return
	 */
	public boolean hasAuth(int member_group_idx) {
		return dao.getAuthCodeCount(member_group_idx) > 0 ? true : false;
	}


	/**
	 * 특정 아이디의 권한그룹 목록으 가져온다.
	 * @param member
	 * @return
	 */
	public List<Integer> getAuthGroupIdxList(Member member) {
		MemberGroupAuth memberGroupAuth = new MemberGroupAuth();
		memberGroupAuth.setMember_id(member.getMember_id());
		memberGroupAuth.setHomepage_id(member.getHomepage_id());
		return dao.getAuthGroupIdxList2(memberGroupAuth);
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
		boolean a = isSiteAdminGroup(member);//사이트최고관리자여부
		boolean b = dao.getSiteAdminAuthCount(member) > 0 ? true : false;//관리자권한 여부
		return a || b;
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
