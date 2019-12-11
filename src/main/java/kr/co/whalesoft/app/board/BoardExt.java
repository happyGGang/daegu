package kr.co.whalesoft.app.board;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BoardExt extends PagingUtils {

	@Override
	protected Object clone() throws CloneNotSupportedException{
		return super.clone();
	}

	private String user_email; //작성자 이메일
	private String user_homepage; //작성자 홈페이지
	private String user_phone; //작성자 전화번호
	private String user_passwd; //작성자 비밀번호
	private String user_email_receive_yn; //작성자 이메일 수신
	private String user_sms_receive_yn; //작성자 SMS 수신
	private String report_state; //게시물 신고상태
	private String ebook_url; //이북 URL
	private int file_download_count; //첨부파일 다운로드 횟수
	private int recommend_count; //추천수
	private int approval_count; //찬성횟수
	private int contrary_count; //반대횟수

	private List<String> board_field_list;

	private String imsi_v_1;
	private String imsi_v_2;
	private String imsi_v_3;
	private String imsi_v_4;
	private String imsi_v_5;
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

	private Date imsi_d_1;
	private Date imsi_d_2;
	private Date imsi_d_3;
	private Date imsi_d_4;
	private Date imsi_d_5;

	private int imsi_n_1;
	private int imsi_n_2;
	private int imsi_n_3;
	private int imsi_n_4;
	private int imsi_n_5;

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
	public String getImsi_v_6() {
		return imsi_v_6;
	}
	public void setImsi_v_6(String imsi_v_6) {
		this.imsi_v_6 = imsi_v_6;
	}
	public String getImsi_v_7() {
		return imsi_v_7;
	}
	public void setImsi_v_7(String imsi_v_7) {
		this.imsi_v_7 = imsi_v_7;
	}
	public String getImsi_v_8() {
		return imsi_v_8;
	}
	public void setImsi_v_8(String imsi_v_8) {
		this.imsi_v_8 = imsi_v_8;
	}
	public String getImsi_v_9() {
		return imsi_v_9;
	}
	public void setImsi_v_9(String imsi_v_9) {
		this.imsi_v_9 = imsi_v_9;
	}
	public String getImsi_v_10() {
		return imsi_v_10;
	}
	public void setImsi_v_10(String imsi_v_10) {
		this.imsi_v_10 = imsi_v_10;
	}
	public String getImsi_v_11() {
		return imsi_v_11;
	}
	public void setImsi_v_11(String imsi_v_11) {
		this.imsi_v_11 = imsi_v_11;
	}
	public String getImsi_v_12() {
		return imsi_v_12;
	}
	public void setImsi_v_12(String imsi_v_12) {
		this.imsi_v_12 = imsi_v_12;
	}
	public String getImsi_v_13() {
		return imsi_v_13;
	}
	public void setImsi_v_13(String imsi_v_13) {
		this.imsi_v_13 = imsi_v_13;
	}
	public String getImsi_v_14() {
		return imsi_v_14;
	}
	public void setImsi_v_14(String imsi_v_14) {
		this.imsi_v_14 = imsi_v_14;
	}
	public String getImsi_v_15() {
		return imsi_v_15;
	}
	public void setImsi_v_15(String imsi_v_15) {
		this.imsi_v_15 = imsi_v_15;
	}
	public String getImsi_v_16() {
		return imsi_v_16;
	}
	public void setImsi_v_16(String imsi_v_16) {
		this.imsi_v_16 = imsi_v_16;
	}
	public String getImsi_v_17() {
		return imsi_v_17;
	}
	public void setImsi_v_17(String imsi_v_17) {
		this.imsi_v_17 = imsi_v_17;
	}
	public String getImsi_v_18() {
		return imsi_v_18;
	}
	public void setImsi_v_18(String imsi_v_18) {
		this.imsi_v_18 = imsi_v_18;
	}
	public String getImsi_v_19() {
		return imsi_v_19;
	}
	public void setImsi_v_19(String imsi_v_19) {
		this.imsi_v_19 = imsi_v_19;
	}
	public String getImsi_v_20() {
		return imsi_v_20;
	}
	public void setImsi_v_20(String imsi_v_20) {
		this.imsi_v_20 = imsi_v_20;
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
	public Date getImsi_d_3() {
		return imsi_d_3;
	}
	public void setImsi_d_3(Date imsi_d_3) {
		this.imsi_d_3 = imsi_d_3;
	}
	public Date getImsi_d_4() {
		return imsi_d_4;
	}
	public void setImsi_d_4(Date imsi_d_4) {
		this.imsi_d_4 = imsi_d_4;
	}
	public Date getImsi_d_5() {
		return imsi_d_5;
	}
	public void setImsi_d_5(Date imsi_d_5) {
		this.imsi_d_5 = imsi_d_5;
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
	public int getImsi_n_3() {
		return imsi_n_3;
	}
	public void setImsi_n_3(int imsi_n_3) {
		this.imsi_n_3 = imsi_n_3;
	}
	public int getImsi_n_4() {
		return imsi_n_4;
	}
	public void setImsi_n_4(int imsi_n_4) {
		this.imsi_n_4 = imsi_n_4;
	}
	public int getImsi_n_5() {
		return imsi_n_5;
	}
	public void setImsi_n_5(int imsi_n_5) {
		this.imsi_n_5 = imsi_n_5;
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
	public String getUser_passwd() {
		return user_passwd;
	}
	public void setUser_passwd(String user_passwd) {
		this.user_passwd = user_passwd;
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
	public String getReport_state() {
		return report_state;
	}
	public void setReport_state(String report_state) {
		this.report_state = report_state;
	}
	public String getEbook_url() {
		return ebook_url;
	}
	public void setEbook_url(String ebook_url) {
		this.ebook_url = ebook_url;
	}
	public int getFile_download_count() {
		return file_download_count;
	}
	public void setFile_download_count(int file_download_count) {
		this.file_download_count = file_download_count;
	}
	public int getRecommend_count() {
		return recommend_count;
	}
	public void setRecommend_count(int recommend_count) {
		this.recommend_count = recommend_count;
	}
	/**
	 * 시크어 코딩
	 * @return
	 */
	public List<String> getBoard_field_list() {
		List<String> arrayList = new ArrayList<String>();
		arrayList.addAll(board_field_list);
		return arrayList;
	}
	public void setBoard_field_list(List<String> board_field_list) {
		if(board_field_list != null) {
			this.board_field_list = new ArrayList<String>();
			this.board_field_list.addAll(board_field_list);
		}
	}
	public int getApproval_count() {
		return approval_count;
	}
	public void setApproval_count(int approval_count) {
		this.approval_count = approval_count;
	}
	public int getContrary_count() {
		return contrary_count;
	}
	public void setContrary_count(int contrary_count) {
		this.contrary_count = contrary_count;
	}

}