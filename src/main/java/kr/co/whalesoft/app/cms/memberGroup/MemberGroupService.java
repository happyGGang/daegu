package kr.co.whalesoft.app.cms.memberGroup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MemberGroupService extends BaseService {

	@Autowired
	private MemberGroupDao dao;

	/**
	 * 그룹 목록
	 * @param memberGroup
	 * @return
	 */
	public List<MemberGroup> getMemberGroupList(MemberGroup memberGroup) {
		MemberGroup memberGroupOne = dao.getMemberGroupOne(memberGroup);
		if (memberGroupOne != null && !StringUtils.equals(memberGroupOne.getSite_id(), "CMS")) {
			memberGroup.setSite_id(memberGroupOne.getSite_id());
		} else if (StringUtils.equals(memberGroup.getSite_id(), "CMS")) {
			memberGroup.setSite_id(null);
		}
		return dao.getMemberGroupList(memberGroup);
	}

	/**
	 * 1개 그룹
	 * @param memberGroup
	 * @return
	 */
	public MemberGroup getMemberGroupOne(MemberGroup memberGroup) {
		MemberGroup memberGroupOne = dao.getMemberGroupOne(memberGroup);
		if (memberGroupOne != null && memberGroupOne.getMember_group_idx() > 0) {
			memberGroupOne.setRelationList(dao.getMemberGroupRelation(memberGroupOne));
			memberGroup = memberGroupOne;
		}
		return memberGroup;
	}

	/**
	 * 미통합회원을 위한 사용자 그룹
	 * @param memberGroup
	 * @return
	 */
	public MemberGroup getSiteUserGroupOne(MemberGroup memberGroup) {
		return dao.getSiteUserGroupOne(memberGroup);
	}

	public int addMemberGroup(MemberGroup memberGroup) {
		return dao.addMemberGroup(memberGroup);
	}

	public int modifyMemberGroup(MemberGroup memberGroup) {
		return dao.modifyMemberGroup(memberGroup);
	}

	public int getMemberGroupCount(MemberGroup memberGroup) {
		return dao.getMemberGroupCount(memberGroup);
	}

	public int deleteMemberGroup(MemberGroup memberGroup) {
		return dao.deleteMemberGroup(memberGroup);
	}

	public int addMemberGroupRelation(MemberGroup memberGroup) {
		return dao.addMemberGroupRelation(memberGroup);
	}

	/**
	 * 연계그룹 삭제 및 등록
	 * 수정은 없다. 다 지우고 다시 다 쓴다.
	 * @param memberGroup
	 * @param request
	 * @return
	 */
	@Transactional
	public int addMemberGroupRelation(MemberGroup memberGroup, HttpServletRequest request) {
		int result = 0;
		dao.deleteMemberGroupRelation(memberGroup);
		for ( int relation_member_group_idx : memberGroup.getRelationList() ) {
			memberGroup.setRelation_member_group_idx(relation_member_group_idx);
			result += dao.addMemberGroupRelation(memberGroup);
		}
		return result;
	}

}
