package kr.co.whalesoft.app.board;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;

public class Board extends BoardExt {

	@Override
	protected Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

	private String homepage_id;
	private int menu_idx;
	private int manage_idx; // 게시판 관리번호
	private int board_idx; // 게시물 번호
	private int parent_idx; // 상위 게시물 번호
	private int group_idx; // 그룹 게시물 번호
	private int group_depth; // 그룹 게시물 단계
	private int view_count; // 조회수
	private String title; // 제목
	private String content; // 내용
	private String content_summary; // 내용요약
	private String user_id; // 등록자ID
	private String user_name; // 등록자명
	private String user_ip; // 등록자IP
	private String notice_yn = "N"; // 공지사항여부
	private String delete_yn = "N"; // 삭제여부
	private String secret_yn = "N"; // 비밀글여부
	private String request_code = "B0000"; // 요청 처리 기본 코드 'B0000'공통 코드 사용
	private String request_state; // 질문답변 상태('B0000'공통 코드 사용 대기 : 0, 접수 : 1, 진행중: 2, 완료 : 3)
	private String request_state_str;
	private String reply_list_yn = "Y";
	private List<BoardFile> boardFile = null;

	private String category1;
	private String category1_name;
	private String category1Manage;
	private String category2;
	private String category2_name;
	private String category2Manage;
	private String category3;
	private String category3_name;
	private String category3Manage;
	private String category4;
	private String category4_name;
	private String category4Manage;
	private String category5;
	private String category5_name;
	private String category5Manage;

	private String board_skin;
	private String board_name;

	private String plan_year;
	private String plan_month;
	private String plan_date;

	private String context_path;// ge 공지사항

	private String preview_img; // 미리보기 이미지

	private int date_gap; // 등록날짜와 현재날짜의 일수 차이

	private String[] boardFileArray; // 첨부파일

	private String[] deleteBoardFileArray;// 삭제대상첨부파일

	private String[] boardIdxArray;// 완전삭제리스트

	private String beforeFilePath;
	private String afterFilePath;
	private String add_date_str;
	private String dept_cd;

	private int new_date_count;

	/*** 게시물 복사 또는 이동 ***/
	private int target_manage_idx;
	private String target_category;

	private List<String> mailingList; // 메일링 리스트(메일수신 연동)

	private String board_mode;
	private int file_count;
	private int comment_count; // 덧글 개수

	private String notice_start_date; // 공지사항시작일자
	private String notice_end_date; // 공지사항종료일자

	private String add_id; // 등록ID
	private Date add_date; // 등록날짜
	private String modify_id; // 수정ID
	private Date modify_date; // 수정날짜
	private String delete_id; // 삭제ID
	private Date delete_date; // 삭제날짜

	private List managerList;

	private String user_password;
	private String password_yn;

	private String themeBookSubject;

	private String module;// 모듈 레이아웃 용( ex 새책드림 )

	private String board_type;
	private String start_date;
	private String end_date;
	private String searchStartDate;
	private String searchEndDate;

	private String moveCategory1Target; // 카테고리 변경
	private String moveCategory2Target; // 카테고리 변경
	private String moveCategory3Target; // 카테고리 변경
	private String moveCategory4Target; // 카테고리 변경
	private String moveCategory5Target; // 카테고리 변경

	public Board() {
	}

	/******** 기록관 ***********/
	private String b_num;
	private String board_table;
	private String b_file1;
	private String b_file2;
	private String b_file3;
	private String b_file4;
	private String b_file5;

	// 통합검색 - 상세검색용 변수
	private String searchKeyword1;// searchType1 의 검색어
	private String searchKeyword2;// searchType2 의 검색어
	private String searchKeyword3;// searchType3 의 검색어
	private String searchKeyword4;// searchType4 의 검색어
	private String logicFunction1;// searchKeyowrd1 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private String logicFunction2;// searchKeyowrd2 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private String logicFunction3;// searchKeyowrd3 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private String logicFunction4;// searchKeyowrd4 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private boolean paggingUsed;

	public Board(int manage_idx, int row_count) {
		this.manage_idx = manage_idx;
		setRowCount(row_count);
		setTotalDataCount(row_count);
	}

	public Board(int manage_idx, int row_count, String dept_cd) {
		this.manage_idx = manage_idx;
		setRowCount(row_count);
		setTotalDataCount(row_count);
		this.dept_cd = dept_cd;
	}

	public Board(int board_idx, String preview_img) {
		this.board_idx = board_idx;
		this.preview_img = preview_img;
	}

	public String getUrlParam(BoardManage boardManage, String mode) {
		StringBuffer sb = new StringBuffer();
		if (menu_idx > 0) {
			sb.append("menu_idx=" + menu_idx);
			sb.append("&manage_idx=" + manage_idx);
		} else {
			sb.append("manage_idx=" + manage_idx);
		}
		if (boardManage != null) {
			sb.append("&homepage_id=" + boardManage.getHomepage_id());
		}

		if (getModule() != null) {
			sb.append("&module=" + getModule());
		}

		sb.append("&rowCount=" + getRowCount());

		if (mode.equals("view")) {
			if (parent_idx == 0) {
				sb.append("&board_idx=" + board_idx);
			} else {
				sb.append("&board_idx=" + parent_idx);
			}
			sb.append("&viewPage=" + getViewPage());
		}

		return sb.toString();
	}

	/**
	 * 시큐어 코딩
	 *
	 * @return
	 */
	public List getManagerList() {
		if (managerList != null) {
			List<Integer> arrayList = new ArrayList<Integer>();
			arrayList.addAll(this.managerList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setManagerList(List managerList) {
		if (managerList != null) {
			this.managerList = new ArrayList();
			this.managerList.addAll(managerList);
		}
	}

	public int getManage_idx() {
		return manage_idx;
	}

	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	public int getBoard_idx() {
		return board_idx;
	}

	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}

	public int getParent_idx() {
		return parent_idx;
	}

	public void setParent_idx(int parent_idx) {
		this.parent_idx = parent_idx;
	}

	public int getGroup_idx() {
		return group_idx;
	}

	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}

	public int getGroup_depth() {
		return group_depth;
	}

	public void setGroup_depth(int group_depth) {
		this.group_depth = group_depth;
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

	public String getContent_summary() {
		return content_summary;
	}

	public void setContent_summary(String content_summary) {
		this.content_summary = content_summary;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getSecret_yn() {
		return secret_yn;
	}

	public void setSecret_yn(String secret_yn) {
		this.secret_yn = secret_yn;
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

	public String getBoard_skin() {
		return board_skin;
	}

	public void setBoard_skin(String board_skin) {
		this.board_skin = board_skin;
	}

	public String getBoard_name() {
		return board_name;
	}

	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}

	public String getPreview_img() {
		return preview_img;
	}

	public void setPreview_img(String preview_img) {
		this.preview_img = preview_img;
	}

	public int getDate_gap() {
		return date_gap;
	}

	public void setDate_gap(int date_gap) {
		this.date_gap = date_gap;
	}

	/**
	 * 시큐어 코딩
	 *
	 * @return
	 */
	public String[] getBoardFileArray() {
		String[] ret = null;
		if (this.boardFileArray != null) {
			ret = new String[this.boardFileArray.length];
			for (int i = 0; i < this.boardFileArray.length; i++) {
				ret[i] = this.boardFileArray[i];
			}
		}
		return ret;
	}

	/**
	 * 시큐어 코딩
	 *
	 * @param boardFileArray
	 */
	public void setBoardFileArray(String[] boardFileArray) {
		this.boardFileArray = new String[boardFileArray.length];
		for (int i = 0; i < boardFileArray.length; i++) {
			this.boardFileArray[i] = boardFileArray[i];
		}
	}

	/**
	 * 시큐어 코딩
	 *
	 * @return
	 */
	public String[] getDeleteBoardFileArray() {
		String[] ret = null;
		if (this.deleteBoardFileArray != null) {
			ret = new String[this.deleteBoardFileArray.length];
			for (int i = 0; i < this.deleteBoardFileArray.length; i++) {
				ret[i] = this.deleteBoardFileArray[i];
			}
		}
		return ret;
	}

	/**
	 * 시큐어 코딩
	 *
	 * @param deleteBoardFileArray
	 */
	public void setDeleteBoardFileArray(String[] deleteBoardFileArray) {
		this.deleteBoardFileArray = new String[deleteBoardFileArray.length];
		for (int i = 0; i < deleteBoardFileArray.length; i++) {
			this.deleteBoardFileArray[i] = deleteBoardFileArray[i];
		}
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

	public String getAdd_date_str() {
		return add_date_str;
	}

	public void setAdd_date_str(String add_date_str) {
		this.add_date_str = add_date_str;
	}

	public int getTarget_manage_idx() {
		return target_manage_idx;
	}

	public void setTarget_manage_idx(int target_manage_idx) {
		this.target_manage_idx = target_manage_idx;
	}

	/**
	 * 시큐어 코딩
	 *
	 * @return
	 */
	public List<String> getMailingList() {
		if (mailingList != null) {
			List<String> arrayList = new ArrayList<String>();
			arrayList.addAll(this.mailingList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setMailingList(List<String> mailingList) {
		if (mailingList != null) {
			this.mailingList = new ArrayList<String>();
			this.mailingList.addAll(mailingList);
		}
	}

	public String getBoard_mode() {
		return board_mode;
	}

	public void setBoard_mode(String board_mode) {
		this.board_mode = board_mode;
	}

	public int getFile_count() {
		return file_count;
	}

	public void setFile_count(int file_count) {
		this.file_count = file_count;
	}

	public int getComment_count() {
		return comment_count;
	}

	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
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

	public String getDelete_id() {
		return delete_id;
	}

	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}

	public Date getDelete_date() {
		return delete_date;
	}

	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
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

	public int getMenu_idx() {
		return menu_idx;
	}

	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}

	public String getNotice_start_date() {
		return notice_start_date;
	}

	public void setNotice_start_date(String notice_start_date) {
		this.notice_start_date = notice_start_date;
	}

	public String getNotice_end_date() {
		return notice_end_date;
	}

	public void setNotice_end_date(String notice_end_date) {
		this.notice_end_date = notice_end_date;
	}

	public String getDept_cd() {
		return dept_cd;
	}

	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}

	public String getBoard_table() {
		return board_table;
	}

	public String getB_file1() {
		return b_file1;
	}

	public String getB_file2() {
		return b_file2;
	}

	public String getB_file3() {
		return b_file3;
	}

	public String getB_file4() {
		return b_file4;
	}

	public String getB_file5() {
		return b_file5;
	}

	public void setBoard_table(String board_table) {
		this.board_table = board_table;
	}

	public void setB_file1(String b_file1) {
		this.b_file1 = b_file1;
	}

	public void setB_file2(String b_file2) {
		this.b_file2 = b_file2;
	}

	public void setB_file3(String b_file3) {
		this.b_file3 = b_file3;
	}

	public void setB_file4(String b_file4) {
		this.b_file4 = b_file4;
	}

	public void setB_file5(String b_file5) {
		this.b_file5 = b_file5;
	}

	public String getB_num() {
		return b_num;
	}

	public void setB_num(String b_num) {
		this.b_num = b_num;
	}

	public String getRequest_state() {
		return request_state;
	}

	public void setRequest_state(String request_state) {
		this.request_state = request_state;
	}

	public String getRequest_state_str() {
		return request_state_str;
	}

	public void setRequest_state_str(String request_state_str) {
		this.request_state_str = request_state_str;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getPassword_yn() {
		return password_yn;
	}

	public void setPassword_yn(String password_yn) {
		this.password_yn = password_yn;
	}

	public String getPlan_year() {
		return plan_year;
	}

	public void setPlan_year(String plan_year) {
		this.plan_year = plan_year;
	}

	public String getPlan_month() {
		return plan_month;
	}

	public void setPlan_month(String plan_month) {
		this.plan_month = plan_month;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getContext_path() {
		return context_path;
	}

	public void setContext_path(String context_path) {
		this.context_path = context_path;
	}

	public String getThemeBookSubject() {
		return themeBookSubject;
	}

	public void setThemeBookSubject(String themeBookSubject) {
		this.themeBookSubject = themeBookSubject;
	}

	public int getNew_date_count() {
		return new_date_count;
	}

	public void setNew_date_count(int new_date_count) {
		this.new_date_count = new_date_count;
	}

	public String getCategory1Manage() {
		return category1Manage;
	}

	public void setCategory1Manage(String category1Manage) {
		this.category1Manage = category1Manage;
	}

	public String getCategory2Manage() {
		return category2Manage;
	}

	public void setCategory2Manage(String category2Manage) {
		this.category2Manage = category2Manage;
	}

	public String getCategory3Manage() {
		return category3Manage;
	}

	public void setCategory3Manage(String category3Manage) {
		this.category3Manage = category3Manage;
	}

	public String getCategory4Manage() {
		return category4Manage;
	}

	public void setCategory4Manage(String category4Manage) {
		this.category4Manage = category4Manage;
	}

	public String getCategory5Manage() {
		return category5Manage;
	}

	public void setCategory5Manage(String category5Manage) {
		this.category5Manage = category5Manage;
	}

	public String getCategory1_name() {
		return category1_name;
	}

	public void setCategory1_name(String category1_name) {
		this.category1_name = category1_name;
	}

	public String getCategory2_name() {
		return category2_name;
	}

	public void setCategory2_name(String category2_name) {
		this.category2_name = category2_name;
	}

	public String getCategory3_name() {
		return category3_name;
	}

	public void setCategory3_name(String category3_name) {
		this.category3_name = category3_name;
	}

	public String getCategory4_name() {
		return category4_name;
	}

	public void setCategory4_name(String category4_name) {
		this.category4_name = category4_name;
	}

	public String getCategory5_name() {
		return category5_name;
	}

	public void setCategory5_name(String category5_name) {
		this.category5_name = category5_name;
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
		this.request_code = request_code;
	}

	public List<BoardFile> getBoardFile() {
		return boardFile;
	}

	public void setBoardFile(List<BoardFile> boardFile) {
		this.boardFile = boardFile;
	}

	/**
	 * 시큐어 코딩
	 *
	 * @return
	 */
	public String[] getBoardIdxArray() {
		String[] ret = null;
		if (this.boardIdxArray != null) {
			ret = new String[this.boardIdxArray.length];
			for (int i = 0; i < this.boardIdxArray.length; i++) {
				ret[i] = this.boardIdxArray[i];
			}
		}
		return ret;
	}

	/**
	 * 시큐어 코딩
	 *
	 * @param boardIdxArray
	 */
	public void setBoardIdxArray(String[] boardIdxArray) {
		this.boardIdxArray = new String[boardIdxArray.length];
		for (int i = 0; i < boardIdxArray.length; i++) {
			this.boardIdxArray[i] = boardIdxArray[i];
		}
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getSearchKeyword1() {
		return searchKeyword1;
	}

	public void setSearchKeyword1(String searchKeyword1) {
		this.searchKeyword1 = searchKeyword1;
	}

	public String getSearchKeyword2() {
		return searchKeyword2;
	}

	public void setSearchKeyword2(String searchKeyword2) {
		this.searchKeyword2 = searchKeyword2;
	}

	public String getSearchKeyword3() {
		return searchKeyword3;
	}

	public void setSearchKeyword3(String searchKeyword3) {
		this.searchKeyword3 = searchKeyword3;
	}

	public String getSearchKeyword4() {
		return searchKeyword4;
	}

	public void setSearchKeyword4(String searchKeyword4) {
		this.searchKeyword4 = searchKeyword4;
	}

	public String getLogicFunction1() {
		return logicFunction1;
	}

	public void setLogicFunction1(String logicFunction1) {
		this.logicFunction1 = logicFunction1;
	}

	public String getLogicFunction2() {
		return logicFunction2;
	}

	public void setLogicFunction2(String logicFunction2) {
		this.logicFunction2 = logicFunction2;
	}

	public String getLogicFunction3() {
		return logicFunction3;
	}

	public void setLogicFunction3(String logicFunction3) {
		this.logicFunction3 = logicFunction3;
	}

	public String getLogicFunction4() {
		return logicFunction4;
	}

	public void setLogicFunction4(String logicFunction4) {
		this.logicFunction4 = logicFunction4;
	}

	public boolean getPaggingUsed() {
		return paggingUsed;
	}

	public void setPaggingUsed(boolean paggingUsed) {
		this.paggingUsed = paggingUsed;
	}

	public String getSearchStartDate() {
		return searchStartDate;
	}

	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}

	public String getSearchEndDate() {
		return searchEndDate;
	}

	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}

	public String getTarget_category() {
		return target_category;
	}

	public void setTarget_category(String target_category) {
		this.target_category = target_category;
	}

	public String getMoveCategory1Target() {
		return moveCategory1Target;
	}

	public void setMoveCategory1Target(String moveCategory1Target) {
		this.moveCategory1Target = moveCategory1Target;
	}

	public String getMoveCategory2Target() {
		return moveCategory2Target;
	}

	public void setMoveCategory2Target(String moveCategory2Target) {
		this.moveCategory2Target = moveCategory2Target;
	}

	public String getMoveCategory3Target() {
		return moveCategory3Target;
	}

	public void setMoveCategory3Target(String moveCategory3Target) {
		this.moveCategory3Target = moveCategory3Target;
	}

	public String getMoveCategory4Target() {
		return moveCategory4Target;
	}

	public void setMoveCategory4Target(String moveCategory4Target) {
		this.moveCategory4Target = moveCategory4Target;
	}

	public String getMoveCategory5Target() {
		return moveCategory5Target;
	}

	public void setMoveCategory5Target(String moveCategory5Target) {
		this.moveCategory5Target = moveCategory5Target;
	}

}
