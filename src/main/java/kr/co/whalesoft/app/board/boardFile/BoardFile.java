package kr.co.whalesoft.app.board.boardFile;

import java.io.File;
import java.util.Date;

import kr.co.whalesoft.app.board.Board;

public class BoardFile {

	private int file_list_seq;
	private int board_idx;
	private int file_idx;
	private String server_file_name;
	private String org_file_name;
	private String file_ext_name;
	private int file_size;
	private boolean	valid;
	private String msg;

	private String file_url;
	private String file_path;

	private String add_id;
	private Date add_date;

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	private String[] boardDataArray;

	public BoardFile() {}

	public BoardFile(int board_idx, int file_idx) {
		this.board_idx = board_idx;
		this.file_idx = file_idx;
	}

	public BoardFile(boolean valid, String msg) {
		this.valid = valid;
		this.msg = msg;
	}

	public BoardFile(File file, String real_file_name, String file_url) {
		if(file!=null) {
			this.org_file_name = file.getName();
			this.server_file_name = real_file_name;
			this.file_url = file_url+"/";
			this.valid = true;
		} else {
			this.valid = false;
		}
	}

	public BoardFile(String[] boardDataArray, Board board) {
		this.board_idx = board.getBoard_idx();
		this.org_file_name = boardDataArray[0].replaceAll(";;", ",");
		this.server_file_name = boardDataArray[1];
		this.file_size = Integer.parseInt(boardDataArray[2]);
		this.file_ext_name = boardDataArray[3];
		this.add_id = board.getAdd_id();
	}

	public BoardFile(String[] boardDataArray, Board board, String file_path) {
		this.board_idx = board.getBoard_idx();
		this.org_file_name = boardDataArray[0].replaceAll(";;", ",");
		this.server_file_name = boardDataArray[1];
		this.file_size = Integer.parseInt(boardDataArray[2]);
		this.file_ext_name = boardDataArray[3];
		this.file_path = file_path;
		this.add_id = board.getAdd_id();
	}

	public String getFile_url() {
		return file_url;
	}

	public void setFile_url(String file_url) {
		this.file_url = file_url;
	}

	public int getBoard_idx() {
		return board_idx;
	}

	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}

	public int getFile_idx() {
		return file_idx;
	}

	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
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

	public String[] getBoardDataArray() {
		return boardDataArray;
	}

	public void setBoardDataArray(String[] boardDataArray) {
		this.boardDataArray = boardDataArray;
	}

	public int getFile_list_seq() {
		return file_list_seq;
	}

	public void setFile_list_seq(int file_list_seq) {
		this.file_list_seq = file_list_seq;
	}


	public String getAdd_id() {
		return add_id;
	}


	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

}