package kr.co.whalesoft.app.cms.module.addressBook;

import java.util.Date;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class AddressBook extends PagingUtils {

	private String homepage_id;  //홈페이지ID
	private String member_id;  //사용자ID
	private int address_book_idx;  //주소록IDX
	private int group_idx;  //주소록그룹IDX
	private int parent_address_book_idx;  //부모주소록IDX
	private String address_book_name;  //주소록명
	private Date add_date;  //등록일
	private Date modify_date;  //수정일
	private String ilus_user_id;  //일루스USER_ID
	private String ilus_user_seq;  //일루스USER_SEQ
	private String ilus_web_id;  //일루스WEB_ID

	private int address_idx;  //주소록IDX
	private String address_name;  //이름
	private String address_cell_phone;  //휴대전화번호
	private String address_email;  //이메일
	private List<Integer> address_idx_arr;
	
	private Member memberInfo;
	
	private MultipartFile uploadFile;
	
	private boolean flag = true;
	private String msg;
	
	
	public String getHomepage_id() {
		return homepage_id;
	}
	
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	
	public String getMember_id() {
		return member_id;
	}
	
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public int getAddress_book_idx() {
		return address_book_idx;
	}
	
	public void setAddress_book_idx(int address_book_idx) {
		this.address_book_idx = address_book_idx;
	}
	
	public int getGroup_idx() {
		return group_idx;
	}
	
	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}
	
	public int getParent_address_book_idx() {
		return parent_address_book_idx;
	}
	
	public void setParent_address_book_idx(int parent_address_book_idx) {
		this.parent_address_book_idx = parent_address_book_idx;
	}
	
	public String getAddress_book_name() {
		return address_book_name;
	}
	
	public void setAddress_book_name(String address_book_name) {
		this.address_book_name = address_book_name;
	}
	
	public Date getAdd_date() {
		return add_date;
	}
	
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	
	public Date getModify_date() {
		return modify_date;
	}
	
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	
	public String getIlus_user_id() {
		return ilus_user_id;
	}
	
	public void setIlus_user_id(String ilus_user_id) {
		this.ilus_user_id = ilus_user_id;
	}
	
	public String getIlus_user_seq() {
		return ilus_user_seq;
	}
	
	public void setIlus_user_seq(String ilus_user_seq) {
		this.ilus_user_seq = ilus_user_seq;
	}
	
	public String getIlus_web_id() {
		return ilus_web_id;
	}
	
	public void setIlus_web_id(String ilus_web_id) {
		this.ilus_web_id = ilus_web_id;
	}
	
	public int getAddress_idx() {
		return address_idx;
	}
	
	public void setAddress_idx(int address_idx) {
		this.address_idx = address_idx;
	}
	
	public String getAddress_name() {
		return address_name;
	}
	
	public void setAddress_name(String address_name) {
		this.address_name = address_name;
	}
	
	public String getAddress_cell_phone() {
		return address_cell_phone;
	}
	
	public void setAddress_cell_phone(String address_cell_phone) {
		this.address_cell_phone = address_cell_phone;
	}
	
	public String getAddress_email() {
		return address_email;
	}
	
	public void setAddress_email(String address_email) {
		this.address_email = address_email;
	}

	
	public Member getMemberInfo() {
		return memberInfo;
	}

	
	public void setMemberInfo(Member memberInfo) {
		this.memberInfo = memberInfo;
	}

	
	public List<Integer> getAddress_idx_arr() {
		return address_idx_arr;
	}

	
	public void setAddress_idx_arr(List<Integer> address_idx_arr) {
		this.address_idx_arr = address_idx_arr;
	}

	
	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	
	
	public String getMsg() {
		return msg;
	}

	
	public void setMsg(String msg) {
		this.msg = msg;
	}

	
	public boolean isFlag() {
		return flag;
	}

	
	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	
}
