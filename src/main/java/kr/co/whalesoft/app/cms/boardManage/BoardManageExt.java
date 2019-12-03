package kr.co.whalesoft.app.cms.boardManage;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BoardManageExt extends PagingUtils {

	private String recommend_yn = "N"; // 추천 사용여부
	private String ebook_yn = "N"; // e-book 사용유무
	private String satisfy_yn = "N"; // 만족도조사 사용유무
	private String rss_yn = "N"; // RSS 사용유무
	private String charge_sms_receive_yn = "N"; // 담당자 SMS 수신여부
	private String write_sms_receive_yn = "N"; // 글쓴이 SMS 수신여부
	private String charge_email_receive_yn = "N"; // 담당자EMAIL수신여부
	private String write_email_receive_yn = "N"; // 글쓴이EMAIL수신여부
	private String board_email_send_yn = "N"; // 게시물메일발송여부

	private String approval_yn = "N"; // 찬성, 반대 사용여부

	private String board_etc1; // 게시판 기타1

	private String board_imsi_v_1_nm;
	private String board_imsi_v_2_nm;
	private String board_imsi_v_3_nm;
	private String board_imsi_v_4_nm;
	private String board_imsi_v_5_nm;
	private String board_imsi_v_6_nm;
	private String board_imsi_v_7_nm;
	private String board_imsi_v_8_nm;
	private String board_imsi_v_9_nm;
	private String board_imsi_v_10_nm;
	private String board_imsi_v_11_nm;
	private String board_imsi_v_12_nm;
	private String board_imsi_v_13_nm;
	private String board_imsi_v_14_nm;
	private String board_imsi_v_15_nm;
	private String board_imsi_v_16_nm;
	private String board_imsi_v_17_nm;
	private String board_imsi_v_18_nm;
	private String board_imsi_v_19_nm;
	private String board_imsi_v_20_nm;

	public String getBoard_imsi_v_1_nm() {
		return board_imsi_v_1_nm;
	}

	public void setBoard_imsi_v_1_nm(String board_imsi_v_1_nm) {
		this.board_imsi_v_1_nm = board_imsi_v_1_nm;
	}

	public String getBoard_imsi_v_2_nm() {
		return board_imsi_v_2_nm;
	}

	public void setBoard_imsi_v_2_nm(String board_imsi_v_2_nm) {
		this.board_imsi_v_2_nm = board_imsi_v_2_nm;
	}

	public String getBoard_imsi_v_3_nm() {
		return board_imsi_v_3_nm;
	}

	public void setBoard_imsi_v_3_nm(String board_imsi_v_3_nm) {
		this.board_imsi_v_3_nm = board_imsi_v_3_nm;
	}

	public String getBoard_imsi_v_4_nm() {
		return board_imsi_v_4_nm;
	}

	public void setBoard_imsi_v_4_nm(String board_imsi_v_4_nm) {
		this.board_imsi_v_4_nm = board_imsi_v_4_nm;
	}

	public String getBoard_imsi_v_5_nm() {
		return board_imsi_v_5_nm;
	}

	public void setBoard_imsi_v_5_nm(String board_imsi_v_5_nm) {
		this.board_imsi_v_5_nm = board_imsi_v_5_nm;
	}

	public String getBoard_imsi_v_6_nm() {
		return board_imsi_v_6_nm;
	}

	public void setBoard_imsi_v_6_nm(String board_imsi_v_6_nm) {
		this.board_imsi_v_6_nm = board_imsi_v_6_nm;
	}

	public String getBoard_imsi_v_7_nm() {
		return board_imsi_v_7_nm;
	}

	public void setBoard_imsi_v_7_nm(String board_imsi_v_7_nm) {
		this.board_imsi_v_7_nm = board_imsi_v_7_nm;
	}

	public String getBoard_imsi_v_8_nm() {
		return board_imsi_v_8_nm;
	}

	public void setBoard_imsi_v_8_nm(String board_imsi_v_8_nm) {
		this.board_imsi_v_8_nm = board_imsi_v_8_nm;
	}

	public String getBoard_imsi_v_9_nm() {
		return board_imsi_v_9_nm;
	}

	public void setBoard_imsi_v_9_nm(String board_imsi_v_9_nm) {
		this.board_imsi_v_9_nm = board_imsi_v_9_nm;
	}

	public String getBoard_imsi_v_10_nm() {
		return board_imsi_v_10_nm;
	}

	public void setBoard_imsi_v_10_nm(String board_imsi_v_10_nm) {
		this.board_imsi_v_10_nm = board_imsi_v_10_nm;
	}

	public String getBoard_imsi_v_11_nm() {
		return board_imsi_v_11_nm;
	}

	public void setBoard_imsi_v_11_nm(String board_imsi_v_11_nm) {
		this.board_imsi_v_11_nm = board_imsi_v_11_nm;
	}

	public String getBoard_imsi_v_12_nm() {
		return board_imsi_v_12_nm;
	}

	public void setBoard_imsi_v_12_nm(String board_imsi_v_12_nm) {
		this.board_imsi_v_12_nm = board_imsi_v_12_nm;
	}

	public String getBoard_imsi_v_13_nm() {
		return board_imsi_v_13_nm;
	}

	public void setBoard_imsi_v_13_nm(String board_imsi_v_13_nm) {
		this.board_imsi_v_13_nm = board_imsi_v_13_nm;
	}

	public String getBoard_imsi_v_14_nm() {
		return board_imsi_v_14_nm;
	}

	public void setBoard_imsi_v_14_nm(String board_imsi_v_14_nm) {
		this.board_imsi_v_14_nm = board_imsi_v_14_nm;
	}

	public String getBoard_imsi_v_15_nm() {
		return board_imsi_v_15_nm;
	}

	public void setBoard_imsi_v_15_nm(String board_imsi_v_15_nm) {
		this.board_imsi_v_15_nm = board_imsi_v_15_nm;
	}

	public String getBoard_imsi_v_16_nm() {
		return board_imsi_v_16_nm;
	}

	public void setBoard_imsi_v_16_nm(String board_imsi_v_16_nm) {
		this.board_imsi_v_16_nm = board_imsi_v_16_nm;
	}

	public String getBoard_imsi_v_17_nm() {
		return board_imsi_v_17_nm;
	}

	public void setBoard_imsi_v_17_nm(String board_imsi_v_17_nm) {
		this.board_imsi_v_17_nm = board_imsi_v_17_nm;
	}

	public String getBoard_imsi_v_18_nm() {
		return board_imsi_v_18_nm;
	}

	public void setBoard_imsi_v_18_nm(String board_imsi_v_18_nm) {
		this.board_imsi_v_18_nm = board_imsi_v_18_nm;
	}

	public String getBoard_imsi_v_19_nm() {
		return board_imsi_v_19_nm;
	}

	public void setBoard_imsi_v_19_nm(String board_imsi_v_19_nm) {
		this.board_imsi_v_19_nm = board_imsi_v_19_nm;
	}

	public String getBoard_imsi_v_20_nm() {
		return board_imsi_v_20_nm;
	}

	public void setBoard_imsi_v_20_nm(String board_imsi_v_20_nm) {
		this.board_imsi_v_20_nm = board_imsi_v_20_nm;
	}

	public String getSatisfy_yn() {
		return satisfy_yn;
	}

	public void setSatisfy_yn(String satisfy_yn) {
		this.satisfy_yn = satisfy_yn;
	}

	public String getRss_yn() {
		return rss_yn;
	}

	public void setRss_yn(String rss_yn) {
		this.rss_yn = rss_yn;
	}

	public String getEbook_yn() {
		return ebook_yn;
	}

	public void setEbook_yn(String ebook_yn) {
		this.ebook_yn = ebook_yn;
	}

	public String getRecommend_yn() {
		return recommend_yn;
	}

	public void setRecommend_yn(String recommend_yn) {
		this.recommend_yn = recommend_yn;
	}

	public String getBoard_etc1() {
		return board_etc1;
	}

	public void setBoard_etc1(String board_etc1) {
		this.board_etc1 = board_etc1;
	}

	public String getCharge_sms_receive_yn() {
		return charge_sms_receive_yn;
	}

	public void setCharge_sms_receive_yn(String charge_sms_receive_yn) {
		this.charge_sms_receive_yn = charge_sms_receive_yn;
	}

	public String getWrite_sms_receive_yn() {
		return write_sms_receive_yn;
	}

	public void setWrite_sms_receive_yn(String write_sms_receive_yn) {
		this.write_sms_receive_yn = write_sms_receive_yn;
	}

	public String getBoard_email_send_yn() {
		return board_email_send_yn;
	}

	public void setBoard_email_send_yn(String board_email_send_yn) {
		this.board_email_send_yn = board_email_send_yn;
	}

	public String getCharge_email_receive_yn() {
		return charge_email_receive_yn;
	}

	public void setCharge_email_receive_yn(String charge_email_receive_yn) {
		this.charge_email_receive_yn = charge_email_receive_yn;
	}

	public String getWrite_email_receive_yn() {
		return write_email_receive_yn;
	}

	public void setWrite_email_receive_yn(String write_email_receive_yn) {
		this.write_email_receive_yn = write_email_receive_yn;
	}

	public String getApproval_yn() {
		return approval_yn;
	}

	public void setApproval_yn(String approval_yn) {
		this.approval_yn = approval_yn;
	}

}
