package kr.co.whalesoft.app.cms.memberGroup;

import java.util.Date;
import java.util.List;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class MemberGroup extends PagingUtils{

	private int member_group_idx;  //그룹IDX
	private String site_id;  //사이트ID
	private String member_group_name;  //그룹명
	private int parent_member_group_idx;  //상위그룹IDX
	private int member_group_depth;  //그룹DEPTH
	private String default_group_yn;  //기본그룹여부
	private String admin_yn;  //CMS최고관리자그룹여부
	private String admin_group_yn;  //사이트관리자그룹여부
	private String user_group_yn;  //사용자그룹여부
	private String guest_group_yn;  //익명사용자그룹여부
	private int print_seq;  //정렬순서
	private String remark;  //비고
	private Date add_dttm;  //등록일
	private String add_id;  //등록ID
	private Date mod_dttm;  //수정일
	private String mod_id;  //수정ID

	private int relation_member_group_idx;  //하위그룹IDX
	private List<Integer> relationList;	//하위그룹 리스트
	
	private int module_idx;  //모듈IDX
	private String auth_id;  //모듈권한ID
	
	public MemberGroup() {}
	
	public MemberGroup(int member_group_idx) {
		this.member_group_idx = member_group_idx;
	}

	
	public int getMember_group_idx() {
		return member_group_idx;
	}

	
	public void setMember_group_idx(int member_group_idx) {
		this.member_group_idx = member_group_idx;
	}

	
	public String getSite_id() {
		return site_id;
	}

	
	public void setSite_id(String site_id) {
		this.site_id = site_id;
	}

	
	public String getMember_group_name() {
		return member_group_name;
	}

	
	public void setMember_group_name(String member_group_name) {
		this.member_group_name = member_group_name;
	}

	
	public int getParent_member_group_idx() {
		return parent_member_group_idx;
	}

	
	public void setParent_member_group_idx(int parent_member_group_idx) {
		this.parent_member_group_idx = parent_member_group_idx;
	}

	
	public int getMember_group_depth() {
		return member_group_depth;
	}

	
	public void setMember_group_depth(int member_group_depth) {
		this.member_group_depth = member_group_depth;
	}

	
	public String getDefault_group_yn() {
		return default_group_yn;
	}

	
	public void setDefault_group_yn(String default_group_yn) {
		this.default_group_yn = default_group_yn;
	}

	
	public String getAdmin_yn() {
		return admin_yn;
	}

	
	public void setAdmin_yn(String admin_yn) {
		this.admin_yn = admin_yn;
	}

	
	public String getAdmin_group_yn() {
		return admin_group_yn;
	}

	
	public void setAdmin_group_yn(String admin_group_yn) {
		this.admin_group_yn = admin_group_yn;
	}

	
	public String getUser_group_yn() {
		return user_group_yn;
	}

	
	public void setUser_group_yn(String user_group_yn) {
		this.user_group_yn = user_group_yn;
	}

	
	public String getGuest_group_yn() {
		return guest_group_yn;
	}

	
	public void setGuest_group_yn(String guest_group_yn) {
		this.guest_group_yn = guest_group_yn;
	}

	
	public int getPrint_seq() {
		return print_seq;
	}

	
	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	
	public String getRemark() {
		return remark;
	}

	
	public void setRemark(String remark) {
		this.remark = remark;
	}

	
	public Date getAdd_dttm() {
		return add_dttm;
	}

	
	public void setAdd_dttm(Date add_dttm) {
		this.add_dttm = add_dttm;
	}

	
	public String getAdd_id() {
		return add_id;
	}

	
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	
	public Date getMod_dttm() {
		return mod_dttm;
	}

	
	public void setMod_dttm(Date mod_dttm) {
		this.mod_dttm = mod_dttm;
	}

	
	public String getMod_id() {
		return mod_id;
	}

	
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	
	
	public int getRelation_member_group_idx() {
		return relation_member_group_idx;
	}

	
	public void setRelation_member_group_idx(int relation_member_group_idx) {
		this.relation_member_group_idx = relation_member_group_idx;
	}

	
	public List<Integer> getRelationList() {
		return relationList;
	}

	
	public void setRelationList(List<Integer> relationList) {
		this.relationList = relationList;
	}

	public int getModule_idx() {
		return module_idx;
	}

	
	public void setModule_idx(int module_idx) {
		this.module_idx = module_idx;
	}

	
	public String getAuth_id() {
		return auth_id;
	}

	
	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}
	
}
