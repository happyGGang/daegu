package kr.go.gbelib.app.cms.module.circlesRoom;

import kr.co.whalesoft.framework.utils.PagingUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

public class CirclesRoom extends PagingUtils {
	
	private int circles_idx; // 동아리방IDX
	private String circles_title; // 제목(동아리이름)
	private String circles_div; // 동아리 구분
	private String user_id; // 이용자ID
	private String user_ci; // 이용자CI
	private String user_name; // 이용자이름
	private String user_addr; // 이용자주소
	private String user_phone; // 이용자핸드폰
	private String user_tel; // 이용자전화
	private String visit_date; // 방문희망일자
	private List<String> visit_time_list; // 이용시간
	private String visit_time;
	private String visit_num; // 신청인원
	private String manage_code; // 도서관구분
	private String etc; // 사용목적
	private int status; // 신청상태
	private String ip; // 등록자IP
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시
	private String rec_key; // 사용자 등록키(sms 전송을 위한 키)
	private String plan_date;
	private List<Integer> idx_chk;
	private String orderText = "visit_date"; // 정렬기준
	private String search_sdt;
	private String search_edt;
	private MultipartFile circles_file;
	private String origin_file_name; // 원본파일명
	private String server_file_name; // 서버파일명
	private String file_extension; // 파일확장자
	private long file_size; // 파일크기

	public int getCircles_idx() {
		return circles_idx;
	}

	public void setCircles_idx(int circles_idx) {
		this.circles_idx = circles_idx;
	}

	public String getCircles_title() {
		return circles_title;
	}

	public void setCircles_title(String circles_title) {
		this.circles_title = circles_title;
	}

	public String getCircles_div() {
		return circles_div;
	}

	public void setCircles_div(String circles_div) {
		this.circles_div = circles_div;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_ci() {
		return user_ci;
	}

	public void setUser_ci(String user_ci) {
		this.user_ci = user_ci;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_addr() {
		return user_addr;
	}

	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public String getVisit_date() {
		return visit_date;
	}

	public void setVisit_date(String visit_date) {
		this.visit_date = visit_date;
	}

	public String getVisit_time() {
		return visit_time;
	}

	public void setVisit_time(String visit_time) {
		this.visit_time = visit_time;
	}

	public List<String> getVisit_time_list() {
		return visit_time_list;
	}

	public void setVisit_time_list(List<String> visit_time_list) {
		this.visit_time_list = visit_time_list;
	}

	public String getVisit_num() {
		return visit_num;
	}

	public void setVisit_num(String visit_num) {
		this.visit_num = visit_num;
	}

	public String getManage_code() {
		return manage_code;
	}

	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
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

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public List<Integer> getIdx_chk() {
		return idx_chk;
	}

	public void setIdx_chk(List<Integer> idx_chk) {
		this.idx_chk = idx_chk;
	}

	public String getOrderText() {
		return orderText;
	}

	public void setOrderText(String orderText) {
		this.orderText = orderText;
	}

	public String getSearch_sdt() {
		return search_sdt;
	}

	public void setSearch_sdt(String search_sdt) {
		this.search_sdt = search_sdt;
	}

	public String getSearch_edt() {
		return search_edt;
	}

	public void setSearch_edt(String search_edt) {
		this.search_edt = search_edt;
	}

	public String getRec_key() {
		return rec_key;
	}

	public void setRec_key(String rec_key) {
		this.rec_key = rec_key;
	}

	public MultipartFile getCircles_file() {
		return circles_file;
	}

	public void setCircles_file(MultipartFile circles_file) {
		this.circles_file = circles_file;
	}

	public String getOrigin_file_name() {
		return origin_file_name;
	}

	public void setOrigin_file_name(String origin_file_name) {
		this.origin_file_name = origin_file_name;
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
}
