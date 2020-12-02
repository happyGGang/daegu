package kr.go.gbelib.app.cms.module.bestPracticesContest;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BestPracticesContest extends PagingUtils {
	
	private int best_practices_idx;  //우수사례IDX
	private String title;  //제목
	private String user_name;  //작성자
	private String user_phone;  //연락처
	private String user_email;  //이메일
	private String user_address;  //주소
	private String contest_field;  //공모분야
	private String contents;  //내용
	private String password;  //비밀번호
	private String org_file_name;  //원본파일명
	private String server_file_name;  //서버파일명
	private String file_extension;  //파일확장자
	private long file_size;  //파일크기
	private String org_file_name2;  //원본파일명2
	private String server_file_name2;  //서버파일명2
	private String file_extension2;  //파일확장자2
	private long file_size2;  //파일크기2
	private String org_file_name3;  //원본파일명3
	private String server_file_name3;  //서버파일명3
	private String file_extension3;  //파일확장자3
	private long file_size3;  //파일크기3
	private String delete_yn = "N";  //삭제여부
	private String add_id;  //등록ID
	private Date add_date;  //등록일
	private String modify_id;  //수정ID
	private Date modify_date;  //수정일
	private String delete_id;  //삭제ID
	private int view_count; // 조회수
	
	public BestPracticesContest() {}
	
	public BestPracticesContest(String homepage_id, int best_practices_idx) {
		setHomepage_id(homepage_id);
		this.best_practices_idx = best_practices_idx;
	}
	
	public int getBest_practices_idx() {
		return best_practices_idx;
	}

	public void setBest_practices_idx(int best_practices_idx) {
		this.best_practices_idx = best_practices_idx;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public String getContest_field() {
		return contest_field;
	}

	public void setContest_field(String contest_field) {
		this.contest_field = contest_field;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getOrg_file_name() {
		return org_file_name;
	}

	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}

	public String getServer_file_name() {
		return server_file_name;
	}

	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}

	public String getFile_extension() {
		return file_extension;
	}

	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getOrg_file_name2() {
		return org_file_name2;
	}

	public void setOrg_file_name2(String org_file_name2) {
		this.org_file_name2 = org_file_name2;
	}

	public String getServer_file_name2() {
		return server_file_name2;
	}

	public void setServer_file_name2(String server_file_name2) {
		this.server_file_name2 = server_file_name2;
	}

	public String getFile_extension2() {
		return file_extension2;
	}

	public void setFile_extension2(String file_extension2) {
		this.file_extension2 = file_extension2;
	}

	public long getFile_size2() {
		return file_size2;
	}

	public void setFile_size2(long file_size2) {
		this.file_size2 = file_size2;
	}

	public String getOrg_file_name3() {
		return org_file_name3;
	}

	public void setOrg_file_name3(String org_file_name3) {
		this.org_file_name3 = org_file_name3;
	}

	public String getServer_file_name3() {
		return server_file_name3;
	}

	public void setServer_file_name3(String server_file_name3) {
		this.server_file_name3 = server_file_name3;
	}

	public String getFile_extension3() {
		return file_extension3;
	}

	public void setFile_extension3(String file_extension3) {
		this.file_extension3 = file_extension3;
	}

	public long getFile_size3() {
		return file_size3;
	}

	public void setFile_size3(long file_size3) {
		this.file_size3 = file_size3;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getDelete_id() {
		return delete_id;
	}

	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

}
