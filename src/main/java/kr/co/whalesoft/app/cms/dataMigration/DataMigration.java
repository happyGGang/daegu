package kr.co.whalesoft.app.cms.dataMigration;

import java.util.Date;
import java.util.List;

public class DataMigration {

	private List<String> manager_seq_arr;
	private List<String> manage_idx_arr;

	private int board_idx;
	private int manage_idx;

	private int manager_seq;  //
	private int board_seq;  //
	private int group_seq;  //
	private int parent_seq;  //
	private int group_step;  //
	private String title;  //
	private String content;  //
	private String content_summary;  //
	private String preview_content;  //
	private String preview_img;  //
	private String preview_img_name;  //
	private String user_id;  //
	private String user_name;  //
	private String user_email;  //
	private String user_homepage;  //
	private String user_phone;  //
	private String user_password;  //
	private String user_ip;  //
	private String request_state;
	private int board_file_count;  //
	private String category1;  //
	private String category2;  //
	private String category3;  //
	private String category4;  //
	private String category5;  //
	private int view_count;  //
	private String notice_yn = "N";  //
	private String secret_yn = "N";  //
	private Date notice_start_date;  //
	private Date notice_end_date;  //
	private String notice_start_date_str;  //
	private String notice_end_date_str;  //
	private String modify_id;  //
	private String delete_id;  //
	private int board_file_download_count;  //
	private int recom_count;  //
	private String report_state;  //
	private String imsi_v_1;  //
	private String imsi_v_2;  //
	private String imsi_v_3;  //
	private String imsi_v_4;  //
	private String imsi_v_5;  //
	private String imsi_v_6;
	private String imsi_v_7;
	private String imsi_v_8;
	private String imsi_v_9;
	private String imsi_v_10;
	private String imsi_v_11;
	private String imsi_v_12;
	private String imsi_v_13;
	private String imsi_v_14;
	private String imsi_v_15;
	private String imsi_v_16;
	private String imsi_v_17;
	private String imsi_v_18;
	private String imsi_v_19;
	private String imsi_v_20;

	private String fileColumns;
	private String tableName;
	private String dbUser;

	public DataMigration() {
		// TODO Auto-generated constructor stub
	}

	public DataMigration(String tableName) {
		this.tableName = tableName;
	}

	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getImsi_v_6() {
		return imsi_v_6;
	}
	public String getImsi_v_7() {
		return imsi_v_7;
	}
	public String getImsi_v_8() {
		return imsi_v_8;
	}
	public String getImsi_v_9() {
		return imsi_v_9;
	}
	public String getImsi_v_10() {
		return imsi_v_10;
	}
	public String getImsi_v_11() {
		return imsi_v_11;
	}
	public String getImsi_v_12() {
		return imsi_v_12;
	}
	public String getImsi_v_13() {
		return imsi_v_13;
	}
	public String getImsi_v_14() {
		return imsi_v_14;
	}
	public String getImsi_v_15() {
		return imsi_v_15;
	}
	public String getImsi_v_16() {
		return imsi_v_16;
	}
	public String getImsi_v_17() {
		return imsi_v_17;
	}
	public String getImsi_v_18() {
		return imsi_v_18;
	}
	public String getImsi_v_19() {
		return imsi_v_19;
	}
	public String getImsi_v_20() {
		return imsi_v_20;
	}
	public void setImsi_v_6(String imsi_v_6) {
		this.imsi_v_6 = imsi_v_6;
	}
	public void setImsi_v_7(String imsi_v_7) {
		this.imsi_v_7 = imsi_v_7;
	}
	public void setImsi_v_8(String imsi_v_8) {
		this.imsi_v_8 = imsi_v_8;
	}
	public void setImsi_v_9(String imsi_v_9) {
		this.imsi_v_9 = imsi_v_9;
	}
	public void setImsi_v_10(String imsi_v_10) {
		this.imsi_v_10 = imsi_v_10;
	}
	public void setImsi_v_11(String imsi_v_11) {
		this.imsi_v_11 = imsi_v_11;
	}
	public void setImsi_v_12(String imsi_v_12) {
		this.imsi_v_12 = imsi_v_12;
	}
	public void setImsi_v_13(String imsi_v_13) {
		this.imsi_v_13 = imsi_v_13;
	}
	public void setImsi_v_14(String imsi_v_14) {
		this.imsi_v_14 = imsi_v_14;
	}
	public void setImsi_v_15(String imsi_v_15) {
		this.imsi_v_15 = imsi_v_15;
	}
	public void setImsi_v_16(String imsi_v_16) {
		this.imsi_v_16 = imsi_v_16;
	}
	public void setImsi_v_17(String imsi_v_17) {
		this.imsi_v_17 = imsi_v_17;
	}
	public void setImsi_v_18(String imsi_v_18) {
		this.imsi_v_18 = imsi_v_18;
	}
	public void setImsi_v_19(String imsi_v_19) {
		this.imsi_v_19 = imsi_v_19;
	}
	public void setImsi_v_20(String imsi_v_20) {
		this.imsi_v_20 = imsi_v_20;
	}
	private Date imsi_d_1;  //
	private Date imsi_d_2;  //
	private int imsi_n_1;  //
	private int imsi_n_2;  //
	private Date del_dt;  //
	private Date upt_dt;  //
	private Date upt_dt2;  //
	private Date crt_dt;  //
	private int recom_email_receive_count;  //
	private String user_email_receive_yn;  //
	private String user_sms_receive_yn;  //
	private String writer_auth_key;  //

	private String add_date;
	private String modify_date;

	private int file_idx;  //파일IDX
	private String real_file_name;  //실제파일명
	private String rename_file_name;  //실제파일명
	private String file_name;  //파일명
	private String file_ext_name;  //파일확장자명
	private int file_size;  //파일사이즈
	private int file_down_count;  //다운로드 횟수
	private int file_count;

	private String org_file_name;
	private String server_file_name;

	private int comment_idx;  //댓글IDX
	private int group_comment_idx;  //그룹 코멘트 IDX
	private int parent_comment_idx;  //상위 코멘트 IDX
	private int group_comment_depth;  //그룹 코멘트 단계
	private String comment_content;  //내용
	private String delete_yn = "N";  //삭제여부


	public int getManager_seq() {
		return manager_seq;
	}
	public void setManager_seq(int manager_seq) {
		this.manager_seq = manager_seq;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public int getGroup_seq() {
		return group_seq;
	}
	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	public int getGroup_step() {
		return group_step;
	}
	public void setGroup_step(int group_step) {
		this.group_step = group_step;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPreview_content() {
		return preview_content;
	}
	public void setPreview_content(String preview_content) {
		this.preview_content = preview_content;
	}
	public String getPreview_img() {
		return preview_img;
	}
	public void setPreview_img(String preview_img) {
		this.preview_img = preview_img;
	}
	public String getPreview_img_name() {
		return preview_img_name;
	}
	public void setPreview_img_name(String preview_img_name) {
		this.preview_img_name = preview_img_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_homepage() {
		return user_homepage;
	}
	public void setUser_homepage(String user_homepage) {
		this.user_homepage = user_homepage;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public int getBoard_file_count() {
		return board_file_count;
	}
	public void setBoard_file_count(int board_file_count) {
		this.board_file_count = board_file_count;
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
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public String getNotice_yn() {
		return notice_yn;
	}
	public void setNotice_yn(String notice_yn) {
		this.notice_yn = notice_yn;
	}
	public String getSecret_yn() {
		return secret_yn;
	}
	public void setSecret_yn(String secret_yn) {
		this.secret_yn = secret_yn;
	}
	public Date getNotice_start_date() {
		return notice_start_date;
	}
	public void setNotice_start_date(Date notice_start_date) {
		this.notice_start_date = notice_start_date;
	}
	public Date getNotice_end_date() {
		return notice_end_date;
	}
	public void setNotice_end_date(Date notice_end_date) {
		this.notice_end_date = notice_end_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public String getDelete_id() {
		return delete_id;
	}
	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}
	public int getBoard_file_download_count() {
		return board_file_download_count;
	}
	public void setBoard_file_download_count(int board_file_download_count) {
		this.board_file_download_count = board_file_download_count;
	}
	public int getRecom_count() {
		return recom_count;
	}
	public void setRecom_count(int recom_count) {
		this.recom_count = recom_count;
	}
	public String getReport_state() {
		return report_state;
	}
	public void setReport_state(String report_state) {
		this.report_state = report_state;
	}
	public String getImsi_v_1() {
		return imsi_v_1;
	}
	public void setImsi_v_1(String imsi_v_1) {
		this.imsi_v_1 = imsi_v_1;
	}
	public String getImsi_v_2() {
		return imsi_v_2;
	}
	public void setImsi_v_2(String imsi_v_2) {
		this.imsi_v_2 = imsi_v_2;
	}
	public String getImsi_v_3() {
		return imsi_v_3;
	}
	public void setImsi_v_3(String imsi_v_3) {
		this.imsi_v_3 = imsi_v_3;
	}
	public String getImsi_v_4() {
		return imsi_v_4;
	}
	public void setImsi_v_4(String imsi_v_4) {
		this.imsi_v_4 = imsi_v_4;
	}
	public String getImsi_v_5() {
		return imsi_v_5;
	}
	public void setImsi_v_5(String imsi_v_5) {
		this.imsi_v_5 = imsi_v_5;
	}
	public Date getImsi_d_1() {
		return imsi_d_1;
	}
	public void setImsi_d_1(Date imsi_d_1) {
		this.imsi_d_1 = imsi_d_1;
	}
	public Date getImsi_d_2() {
		return imsi_d_2;
	}
	public void setImsi_d_2(Date imsi_d_2) {
		this.imsi_d_2 = imsi_d_2;
	}
	public int getImsi_n_1() {
		return imsi_n_1;
	}
	public void setImsi_n_1(int imsi_n_1) {
		this.imsi_n_1 = imsi_n_1;
	}
	public int getImsi_n_2() {
		return imsi_n_2;
	}
	public void setImsi_n_2(int imsi_n_2) {
		this.imsi_n_2 = imsi_n_2;
	}
	public Date getDel_dt() {
		return del_dt;
	}
	public void setDel_dt(Date del_dt) {
		this.del_dt = del_dt;
	}
	public Date getUpt_dt() {
		return upt_dt;
	}
	public void setUpt_dt(Date upt_dt) {
		this.upt_dt = upt_dt;
	}
	public Date getUpt_dt2() {
		return upt_dt2;
	}
	public void setUpt_dt2(Date upt_dt2) {
		this.upt_dt2 = upt_dt2;
	}
	public Date getCrt_dt() {
		return crt_dt;
	}
	public void setCrt_dt(Date crt_dt) {
		this.crt_dt = crt_dt;
	}
	public int getRecom_email_receive_count() {
		return recom_email_receive_count;
	}
	public void setRecom_email_receive_count(int recom_email_receive_count) {
		this.recom_email_receive_count = recom_email_receive_count;
	}
	public String getUser_email_receive_yn() {
		return user_email_receive_yn;
	}
	public void setUser_email_receive_yn(String user_email_receive_yn) {
		this.user_email_receive_yn = user_email_receive_yn;
	}
	public String getUser_sms_receive_yn() {
		return user_sms_receive_yn;
	}
	public void setUser_sms_receive_yn(String user_sms_receive_yn) {
		this.user_sms_receive_yn = user_sms_receive_yn;
	}
	public String getWriter_auth_key() {
		return writer_auth_key;
	}
	public void setWriter_auth_key(String writer_auth_key) {
		this.writer_auth_key = writer_auth_key;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public int getManage_idx() {
		return manage_idx;
	}
	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public int getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}
	public String getReal_file_name() {
		return real_file_name;
	}
	public void setReal_file_name(String real_file_name) {
		this.real_file_name = real_file_name;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_ext_name() {
		return file_ext_name;
	}
	public void setFile_ext_name(String file_ext_name) {
		this.file_ext_name = file_ext_name;
	}
	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	public int getFile_down_count() {
		return file_down_count;
	}
	public void setFile_down_count(int file_down_count) {
		this.file_down_count = file_down_count;
	}
	public int getComment_idx() {
		return comment_idx;
	}
	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}
	public int getGroup_comment_idx() {
		return group_comment_idx;
	}
	public void setGroup_comment_idx(int group_comment_idx) {
		this.group_comment_idx = group_comment_idx;
	}
	public int getParent_comment_idx() {
		return parent_comment_idx;
	}
	public void setParent_comment_idx(int parent_comment_idx) {
		this.parent_comment_idx = parent_comment_idx;
	}
	public int getGroup_comment_depth() {
		return group_comment_depth;
	}
	public void setGroup_comment_depth(int group_comment_depth) {
		this.group_comment_depth = group_comment_depth;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	public int getFile_count() {
		return file_count;
	}
	public void setFile_count(int file_count) {
		this.file_count = file_count;
	}
	public String getRename_file_name() {
		return rename_file_name;
	}
	public void setRename_file_name(String rename_file_name) {
		this.rename_file_name = rename_file_name;
	}
	public List<String> getManager_seq_arr() {
		return manager_seq_arr;
	}
	public void setManager_seq_arr(List<String> manager_seq_arr) {
		this.manager_seq_arr = manager_seq_arr;
	}
	public List<String> getManage_idx_arr() {
		return manage_idx_arr;
	}
	public void setManage_idx_arr(List<String> manage_idx_arr) {
		this.manage_idx_arr = manage_idx_arr;
	}
	public String getNotice_start_date_str() {
		return notice_start_date_str;
	}
	public void setNotice_start_date_str(String notice_start_date_str) {
		this.notice_start_date_str = notice_start_date_str;
	}
	public String getNotice_end_date_str() {
		return notice_end_date_str;
	}
	public void setNotice_end_date_str(String notice_end_date_str) {
		this.notice_end_date_str = notice_end_date_str;
	}


	public String getContent_summary() {
		return content_summary;
	}


	public void setContent_summary(String content_summary) {
		this.content_summary = content_summary;
	}


	public String getUser_password() {
		return user_password;
	}


	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}


	public String getRequest_state() {
		return request_state;
	}


	public void setRequest_state(String request_state) {
		this.request_state = request_state;
	}


	public String getDbUser() {
		return dbUser;
	}


	public void setDbUser(String dbUser) {
		this.dbUser = dbUser;
	}


	public String getFileColumns() {
		return fileColumns;
	}


	public void setFileColumns(String fileColumns) {
		this.fileColumns = fileColumns;
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

}
