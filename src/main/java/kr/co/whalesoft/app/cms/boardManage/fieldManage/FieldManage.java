package kr.co.whalesoft.app.cms.boardManage.fieldManage;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class FieldManage extends PagingUtils {

	private int manage_idx;
	private int field_idx;
	
	private String customType; //게시판 타입
	private String orderByType; //정렬 타입
	private String useColumnType; //사용 유무 컬럼 타입
	
	private String board_field_manage_idx; //게시판 템플릿코드
	
	private String board_column; //컬럼명
	private String board_column_nm; //컬럼 한글명
	private String board_content; //컬럼 내용
	private String column_type; //컬럼 타입
	private String code_mapping; //코드 매핑
	
	private String list_use_yn = "N"; //목록 사용여부
	private int list_seq; //목록 VIEW 순서
	private int list_width; //목록 넓이
	private int list_maxwidth; //목록 글 최대표시길이
	private String content_link_yn = "N"; //본문 링크 여부
	
	private String write_use_yn = "Y"; //등록 사용여부 
	private int write_seq; //등록 VIEW 순서
	private String write_req_cont = "N";		//등록 필수저장여부
	private int write_width; //등록 입력폼 길이
	private int write_height; //등록 항목넓이(TEXTAREA 시 사용)
	
	private String search_use_yn = "N"; //검색 사용여부
	private int search_seq; //검색 순서
	
	private String upd_id; //수정 아이디
	private Date upd_dttm; //수정일자
	private String crt_id; //등록 아이디
	private Date crt_dttm; //등록일자
	
	private int page; //현재 페이지(grid)
	private String sortColumn; //정렬 컬럼
	private String ascDescFlg; //정렬 방식(순차 : 역순)
	private String admin_only = "N"; //관리자전용
	
	private List<String> column_list; //컬럼 목록
	
	public FieldManage() {}
	
	public FieldManage(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	public int getManage_idx() {
		return manage_idx;
	}

	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	public int getField_idx() {
		return field_idx;
	}

	public void setField_idx(int field_idx) {
		this.field_idx = field_idx;
	}

	public String getCustomType() {
		return customType;
	}

	public void setCustomType(String customType) {
		this.customType = customType;
	}

	public String getOrderByType() {
		return orderByType;
	}

	public void setOrderByType(String orderByType) {
		this.orderByType = orderByType;
	}

	public String getUseColumnType() {
		return useColumnType;
	}

	public void setUseColumnType(String useColumnType) {
		this.useColumnType = useColumnType;
	}

	public String getBoard_field_manage_idx() {
		return board_field_manage_idx;
	}

	public void setBoard_field_manage_idx(String board_field_manage_idx) {
		this.board_field_manage_idx = board_field_manage_idx;
	}

	public String getBoard_column() {
		return board_column;
	}

	public void setBoard_column(String board_column) {
		this.board_column = board_column;
	}

	public String getBoard_column_nm() {
		return board_column_nm;
	}

	public void setBoard_column_nm(String board_column_nm) {
		this.board_column_nm = board_column_nm;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getColumn_type() {
		return column_type;
	}

	public void setColumn_type(String column_type) {
		this.column_type = column_type;
	}

	public String getCode_mapping() {
		return code_mapping;
	}

	public void setCode_mapping(String code_mapping) {
		this.code_mapping = code_mapping;
	}

	public String getList_use_yn() {
		return list_use_yn;
	}

	public void setList_use_yn(String list_use_yn) {
		this.list_use_yn = list_use_yn;
	}

	public int getList_seq() {
		return list_seq;
	}

	public void setList_seq(int list_seq) {
		this.list_seq = list_seq;
	}

	public int getList_width() {
		return list_width;
	}

	public void setList_width(int list_width) {
		this.list_width = list_width;
	}

	public int getList_maxwidth() {
		return list_maxwidth;
	}

	public void setList_maxwidth(int list_maxwidth) {
		this.list_maxwidth = list_maxwidth;
	}

	public String getContent_link_yn() {
		return content_link_yn;
	}

	public void setContent_link_yn(String content_link_yn) {
		this.content_link_yn = content_link_yn;
	}

	public String getWrite_use_yn() {
		return write_use_yn;
	}

	public void setWrite_use_yn(String write_use_yn) {
		this.write_use_yn = write_use_yn;
	}

	public int getWrite_seq() {
		return write_seq;
	}

	public void setWrite_seq(int write_seq) {
		this.write_seq = write_seq;
	}

	public String getWrite_req_cont() {
		return write_req_cont;
	}

	public void setWrite_req_cont(String write_req_cont) {
		this.write_req_cont = write_req_cont;
	}

	public int getWrite_width() {
		return write_width;
	}

	public void setWrite_width(int write_width) {
		this.write_width = write_width;
	}

	public int getWrite_height() {
		return write_height;
	}

	public void setWrite_height(int write_height) {
		this.write_height = write_height;
	}

	public String getSearch_use_yn() {
		return search_use_yn;
	}

	public void setSearch_use_yn(String search_use_yn) {
		this.search_use_yn = search_use_yn;
	}

	public int getSearch_seq() {
		return search_seq;
	}

	public void setSearch_seq(int search_seq) {
		this.search_seq = search_seq;
	}

	public String getUpd_id() {
		return upd_id;
	}

	public void setUpd_id(String upd_id) {
		this.upd_id = upd_id;
	}

	public Date getUpd_dttm() {
		return upd_dttm;
	}

	public void setUpd_dttm(Date upd_dttm) {
		this.upd_dttm = upd_dttm;
	}

	public String getCrt_id() {
		return crt_id;
	}

	public void setCrt_id(String crt_id) {
		this.crt_id = crt_id;
	}

	public Date getCrt_dttm() {
		return crt_dttm;
	}

	public void setCrt_dttm(Date crt_dttm) {
		this.crt_dttm = crt_dttm;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getSortColumn() {
		return sortColumn;
	}

	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}

	public String getAscDescFlg() {
		return ascDescFlg;
	}

	public void setAscDescFlg(String ascDescFlg) {
		this.ascDescFlg = ascDescFlg;
	}

	public String getAdmin_only() {
		return admin_only;
	}

	public void setAdmin_only(String admin_only) {
		this.admin_only = admin_only;
	}

	public List<String> getColumn_list() {
		if(column_list != null) {
			List<String> arrayList = new ArrayList<String>();
			arrayList.addAll(this.column_list);
			return column_list;
		} else {
			return null;
		}
	}

	public void setColumn_list(List<String> column_list) {
		if(column_list != null) {
			this.column_list = new ArrayList<String>();
			this.column_list.addAll(column_list);
		}
	}
	
}