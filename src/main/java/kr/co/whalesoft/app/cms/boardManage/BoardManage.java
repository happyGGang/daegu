package kr.co.whalesoft.app.cms.boardManage;

import java.util.Date;

public class BoardManage extends BoardManageExt {

	/*** 기본설정 ***/
	private String homepage_id;
	private int menu_idx;
	private int manage_idx; //게시판idx
	private String board_name; //게시판명
	private String board_type; //게시판종류
	private String board_skin; //게시판 SKIN
	private int record_count = 10; //게시물 출력수(기본 10개)
	private int new_date_count; //새글 표시기간
	private int	title_size; //게시물 제목제한수
	private String ip_use_yn = "N"; //글작성자 IP 사용
	private String reply_use_yn = "N"; //답변 사용
	private String reply_list_yn = "Y"; //답변글 리스트에서 보이기
	private String comment_use_yn = "N"; //댓글 사용
	private String editor_use_yn = "Y"; //에디터 사용
	private String board_use_yn = "Y"; //게시판 사용
	private String secret_use_yn = "N"; //비밀글 여부
	private String request_code = "B0000"; //질의및 응답 처리 단계 코드 정의
	private String anonymize_yn = "N"; //이름 블라인드 여부

	/*** 추가설정 ***/
	private String add_html_use_yn = "N"; //HTML 추가 사용
	private String add_only_yn = "N"; //글등록 전용(목록은 관리자만 가능)
	private String top_html; //상단 추가 HTML
	private String bottom_html; //하단 추가 HTML
	private String content_html; // 본분 HTML

	/*** 사용자 설정값 이외 ***/
	private String add_id;//등록ID
	private Date add_date; //등록일
	private String modify_id;//수정ID
	private Date modify_date; //수정일
	private String edit_type; //각 설정별 구분변수
	private String manager_name;//담당자명
	private String manager_dept;//담당자부서
	private String manager_phone;//담당자전화번호

	/*** 권한설정 ***/
	private String view_auth = "ANONYMOUS"; //글보기 권한
	private String add_auth; //글등록 권한
	private String edit_auth; //글수정 권한
	private String delete_auth; //글삭제 권한
	private String admin_auth; //관리자 권한
	private String admin_id; //관리자 ID

	private boolean add_auth_check; //현재화면에서의 권한
	private boolean edit_auth_check; //현재화면에서의 권한
	private boolean delete_auth_check; //현재화면에서의 권한
	private boolean admin_auth_check; //현재 게시판의 관리자 권한

	/*** 첨부파일설정 ***/
	private String file_use_yn = "Y"; //첨부파일 사용
	private int file_count = 3; //첨부파일 count제한
	private int file_size_total = 10; //첨부파일 용량제한(MB)
	private String file_ban_ext = "jsp|cgi|php|asp|aspx|exe|com|html|htm|cab|php3|pl|java|class|js|css"; //첨부파일 금지확장자

	/*** 카테고리설정 ***/
	private String category_use_yn = "N";
	private String category1;
	private String category2;
	private String category3;
	private String category4;
	private String category5;



	public BoardManage() {}

	public BoardManage(String homepage_id, int manage_idx) {
		this.homepage_id = homepage_id;
		this.manage_idx = manage_idx;
	}

	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getManage_idx() {
		return manage_idx;
	}
	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public String getBoard_skin() {
		return board_skin;
	}

	public void setBoard_skin(String board_skin) {
		this.board_skin = board_skin;
	}

	public int getRecord_count() {
		return record_count;
	}
	public void setRecord_count(int record_count) {
		this.record_count = record_count;
	}
	public int getNew_date_count() {
		return new_date_count;
	}
	public void setNew_date_count(int new_date_count) {
		this.new_date_count = new_date_count;
	}
	public String getIp_use_yn() {
		return ip_use_yn;
	}
	public void setIp_use_yn(String ip_use_yn) {
		this.ip_use_yn = ip_use_yn;
	}
	public String getReply_use_yn() {
		return reply_use_yn;
	}
	public void setReply_use_yn(String reply_use_yn) {
		this.reply_use_yn = reply_use_yn;
	}
	public String getComment_use_yn() {
		return comment_use_yn;
	}
	public void setComment_use_yn(String comment_use_yn) {
		this.comment_use_yn = comment_use_yn;
	}
	public String getEditor_use_yn() {
		return editor_use_yn;
	}
	public void setEditor_use_yn(String editor_use_yn) {
		this.editor_use_yn = editor_use_yn;
	}
	public String getBoard_use_yn() {
		return board_use_yn;
	}
	public void setBoard_use_yn(String board_use_yn) {
		this.board_use_yn = board_use_yn;
	}
	public String getSecret_use_yn() {
		return secret_use_yn;
	}
	public void setSecret_use_yn(String secret_use_yn) {
		this.secret_use_yn = secret_use_yn;
	}
	public String getAdd_html_use_yn() {
		return add_html_use_yn;
	}
	public void setAdd_html_use_yn(String add_html_use_yn) {
		this.add_html_use_yn = add_html_use_yn;
	}
	public String getTop_html() {
		return top_html;
	}
	public void setTop_html(String top_html) {
		this.top_html = top_html;
	}
	public String getBottom_html() {
		return bottom_html;
	}
	public void setBottom_html(String bottom_html) {
		this.bottom_html = bottom_html;
	}
	public String getContent_html() {
		return content_html;
	}
	public void setContent_html(String content_html) {
		this.content_html = content_html;
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
	public String getEdit_type() {
		return edit_type;
	}
	public void setEdit_type(String edit_type) {
		this.edit_type = edit_type;
	}
	public String getView_auth() {
		return view_auth;
	}
	public void setView_auth(String view_auth) {
		this.view_auth = view_auth;
	}
	public String getEdit_auth() {
		return edit_auth;
	}
	public void setEdit_auth(String edit_auth) {
		this.edit_auth = edit_auth;
	}
	public String getDelete_auth() {
		return delete_auth;
	}
	public void setDelete_auth(String delete_auth) {
		this.delete_auth = delete_auth;
	}
	public String getAdmin_auth() {
		return admin_auth;
	}
	public void setAdmin_auth(String admin_auth) {
		this.admin_auth = admin_auth;
	}
	public boolean isEdit_auth_check() {
		return edit_auth_check;
	}
	public void setEdit_auth_check(boolean edit_auth_check) {
		this.edit_auth_check = edit_auth_check;
	}
	public boolean getEdit_auth_check() {
		return edit_auth_check;
	}
	public boolean isDelete_auth_check() {
		return delete_auth_check;
	}
	public void setDelete_auth_check(boolean delete_auth_check) {
		this.delete_auth_check = delete_auth_check;
	}
	public boolean isAdmin_auth_check() {
		return admin_auth_check;
	}
	public void setAdmin_auth_check(boolean admin_auth_check) {
		this.admin_auth_check = admin_auth_check;
	}
	public String getFile_use_yn() {
		return file_use_yn;
	}
	public void setFile_use_yn(String file_use_yn) {
		this.file_use_yn = file_use_yn;
	}
	public int getFile_count() {
		return file_count;
	}
	public void setFile_count(int file_count) {
		this.file_count = file_count;
	}
	public int getFile_size_total() {
		return file_size_total;
	}
	public void setFile_size_total(int file_size_total) {
		this.file_size_total = file_size_total;
	}
	public String getFile_ban_ext() {
		return file_ban_ext;
	}
	public void setFile_ban_ext(String file_ban_ext) {
		this.file_ban_ext = file_ban_ext;
	}
	public String getCategory_use_yn() {
		return category_use_yn;
	}
	public void setCategory_use_yn(String category_use_yn) {
		this.category_use_yn = category_use_yn;
	}
	public String getCategory1() {
		return category1;
	}
	public void setCategory1(String category1) {
		this.category1 = category1;
	}
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	public String getCategory3() {
		return category3;
	}
	public void setCategory3(String category3) {
		this.category3 = category3;
	}
	public String getCategory4() {
		return category4;
	}
	public void setCategory4(String category4) {
		this.category4 = category4;
	}
	public String getCategory5() {
		return category5;
	}
	public void setCategory5(String category5) {
		this.category5 = category5;
	}
	public int getMenu_idx() {
		return menu_idx;
	}
	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}
	public int getTitle_size() {
		return title_size;
	}
	public void setTitle_size(int title_size) {
		this.title_size = title_size;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getAdd_only_yn() {
		return add_only_yn;
	}

	public void setAdd_only_yn(String add_only_yn) {
		this.add_only_yn = add_only_yn;
	}

	public String getAdd_auth() {
		return add_auth;
	}

	public void setAdd_auth(String add_auth) {
		this.add_auth = add_auth;
	}

	public boolean isAdd_auth_check() {
		return add_auth_check;
	}

	public void setAdd_auth_check(boolean add_auth_check) {
		this.add_auth_check = add_auth_check;
	}

	public String getReply_list_yn() {
		return reply_list_yn;
	}

	public void setReply_list_yn(String reply_list_yn) {
		this.reply_list_yn = reply_list_yn;
	}

	public String getRequest_code() {
		return request_code;
	}

	public void setRequest_code(String request_code) {
		if(request_code != null && !request_code.isEmpty()){
			this.request_code = request_code;
		}
	}

	public String getAnonymize_yn() {
		return anonymize_yn;
	}

	public void setAnonymize_yn(String anonymize_yn) {
		this.anonymize_yn = anonymize_yn;
	}


	public String getAdd_id() {
		return add_id;
	}


	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}


	public String getModify_id() {
		return modify_id;
	}


	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}


	public String getManager_name() {
		return manager_name;
	}


	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}


	public String getManager_dept() {
		return manager_dept;
	}


	public void setManager_dept(String manager_dept) {
		this.manager_dept = manager_dept;
	}


	public String getManager_phone() {
		return manager_phone;
	}


	public void setManager_phone(String manager_phone) {
		this.manager_phone = manager_phone;
	}

}
