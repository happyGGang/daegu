package kr.co.whalesoft.app.board.boardComment.boardCommentFile;

import java.io.File;
import java.util.Date;
import kr.co.whalesoft.app.board.boardComment.BoardComment;

public class BoardCommentFile {
	
	private int file_list_seq;
	private int comment_idx;
	private int comment_file_idx;
	private String server_file_name;
	private String org_file_name;
	private String file_ext_name;
	private int file_size;
	private Date add_date;
	private boolean	valid;
	private String msg;
	
	private String file_url;
	private String file_path;
	
	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	private String[] boardDataArray;
	
	public BoardCommentFile() {}
	
	public BoardCommentFile(int comment_idx, int comment_file_idx) {
		this.comment_idx = comment_idx;
		this.comment_file_idx = comment_file_idx;
	}
	
	public BoardCommentFile(boolean valid, String msg) {
		this.valid = valid;
		this.msg = msg;
	}
	
	public BoardCommentFile(File file, String server_file_name, String file_url) {
		if(file!=null) {
			this.org_file_name = file.getName();
			this.server_file_name = server_file_name;
			this.file_url = file_url+"/";
			this.valid = true;
		} else {
			this.valid = false;
		}
	}
	
	public BoardCommentFile(String[] boardDataArray, BoardComment boardComment) {
		this.comment_idx = boardComment.getComment_idx();
		this.org_file_name = boardDataArray[0].replaceAll(";;", ",");
		this.server_file_name = boardDataArray[1];
		this.file_size = Integer.parseInt(boardDataArray[2]);
		this.file_ext_name = boardDataArray[3];
	}
	
	public BoardCommentFile(String[] boardDataArray, BoardComment boardComment, String file_path) {
		this.comment_idx = boardComment.getComment_idx();
		this.org_file_name = boardDataArray[0].replaceAll(";;", ",");
		this.server_file_name = boardDataArray[1];
		this.file_size = Integer.parseInt(boardDataArray[2]);
		this.file_ext_name = boardDataArray[3];
		this.file_path = file_path;
	}

	
	public int getFile_list_seq() {
		return file_list_seq;
	}

	
	public void setFile_list_seq(int file_list_seq) {
		this.file_list_seq = file_list_seq;
	}

	
	public int getComment_idx() {
		return comment_idx;
	}

	
	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}

	
	public int getComment_file_idx() {
		return comment_file_idx;
	}

	
	public void setComment_file_idx(int comment_file_idx) {
		this.comment_file_idx = comment_file_idx;
	}

	
	public String getServer_file_name() {
		return server_file_name;
	}

	
	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}

	
	public String getOrg_file_name() {
		return org_file_name;
	}

	
	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
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

	
	public Date getAdd_date() {
		return add_date;
	}

	
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	
	public boolean isValid() {
		return valid;
	}

	
	public void setValid(boolean valid) {
		this.valid = valid;
	}

	
	public String getMsg() {
		return msg;
	}

	
	public void setMsg(String msg) {
		this.msg = msg;
	}

	
	public String getFile_url() {
		return file_url;
	}

	
	public void setFile_url(String file_url) {
		this.file_url = file_url;
	}

	
	public String[] getBoardDataArray() {
		return boardDataArray;
	}

	
	public void setBoardDataArray(String[] boardDataArray) {
		this.boardDataArray = boardDataArray;
	}


}
