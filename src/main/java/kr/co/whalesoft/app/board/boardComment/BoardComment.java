package kr.co.whalesoft.app.board.boardComment;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import kr.co.whalesoft.app.board.boardComment.boardCommentFile.BoardCommentFile;

public class BoardComment {

	private String editMode = "ADD";
	private int board_idx; //게시물 번호
	private int comment_idx; //댓글 번호
	private int group_comment_idx; //그룹 코멘트 IDX
	private int parent_comment_idx; //상위 코멘트 IDX
	private int group_comment_depth; //그룹 코멘트 단계
	private String comment_content; //내용
	private String user_id; //등록자ID
	private String user_name; //등록자명
	private String user_ip; //등록자IP
	private String delete_yn; //삭제여부
	private Date add_date; //등록날짜
	private Date modify_date; //수정날짜
	
	private String ilus_user_id; //
	private String ilus_user_seq; //
	
	private int manage_idx;
	private String imsi_v_18;
	private String imsi_v_19;
	private String imsi_v_20;
	private int imsi_n_1;
	
	private String[] boardCommentFileArray; //첨부파일
	private String[] deleteBoardCommentFileArray;//삭제대상첨부파일
	private String beforeFilePath;
	private String afterFilePath;
	private int file_count;//첨부파일갯수
	private List<BoardCommentFile> fileList = new ArrayList<BoardCommentFile>();
	
	public String getUrlParam(String mode) {
		StringBuffer sb = new StringBuffer();
		sb.append("board_idx=" + board_idx);
		sb.append("&manage_idx=" + manage_idx);
		
		return sb.toString();
	}

	public String getEditMode() {
		return editMode;
	}

	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}

	public int getBoard_idx() {
		return board_idx;
	}

	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
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

	public String getUser_ip() {
		return user_ip;
	}

	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
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

	
	public int getImsi_n_1() {
		return imsi_n_1;
	}

	
	public void setImsi_n_1(int imsi_n_1) {
		this.imsi_n_1 = imsi_n_1;
	}

	
	public int getManage_idx() {
		return manage_idx;
	}

	
	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	
	public String[] getBoardCommentFileArray() {
		return boardCommentFileArray;
	}

	
	public void setBoardCommentFileArray(String[] boardCommentFileArray) {
		this.boardCommentFileArray = boardCommentFileArray;
	}

	
	public String[] getDeleteBoardCommentFileArray() {
		return deleteBoardCommentFileArray;
	}

	
	public void setDeleteBoardCommentFileArray(String[] deleteBoardCommentFileArray) {
		this.deleteBoardCommentFileArray = deleteBoardCommentFileArray;
	}

	
	public String getBeforeFilePath() {
		return beforeFilePath;
	}

	
	public void setBeforeFilePath(String beforeFilePath) {
		this.beforeFilePath = beforeFilePath;
	}

	
	public String getAfterFilePath() {
		return afterFilePath;
	}

	
	public void setAfterFilePath(String afterFilePath) {
		this.afterFilePath = afterFilePath;
	}

	
	public int getFile_count() {
		return file_count;
	}

	
	public void setFile_count(int file_count) {
		this.file_count = file_count;
	}

	
	public List<BoardCommentFile> getFileList() {
		return fileList;
	}

	
	public void setFileList(List<BoardCommentFile> fileList) {
		this.fileList = fileList;
	}
	
}