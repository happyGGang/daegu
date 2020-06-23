package kr.go.gbelib.app.module.bookExpress;

import java.util.Date;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookExpress extends PagingUtils {

	private int book_express_idx; // 택배 지원 IDX
	private int[] book_express_arr;
	private String library_code; // 도서관 코드
	private String agency_name; // 기관명
	private String agency_id; // 기관ID
	private String book_reg_no; // 도서등록번호
	private String book_call_no; // 청구기호
	private String book_name; // 도서명
	private String thumb_image; // 섬네일 이미지
	private String request_status; // 신청상태
	private Date request_date; // 신청일
	private String request_name; // 신청자명
	private String request_phone; // 신청자 연락처
	private String reason; // 취소 사유
	private Date add_date; // 등록일시
	private String add_id; // 등록ID
	private Date modify_date; // 수정일시
	private String modify_id; // 수정ID

	private String auth_group; // 권한
	
	private List<BookExpress> bookExpressList;

	public int getBook_express_idx() {
		return book_express_idx;
	}

	public void setBook_express_idx(int book_express_idx) {
		this.book_express_idx = book_express_idx;
	}

	public int[] getBook_express_arr() {
		return book_express_arr;
	}

	public void setBook_express_arr(int[] book_express_arr) {
		this.book_express_arr = book_express_arr;
	}

	public String getLibrary_code() {
		return library_code;
	}

	public void setLibrary_code(String library_code) {
		this.library_code = library_code;
	}

	public String getAgency_name() {
		return agency_name;
	}

	public void setAgency_name(String agency_name) {
		this.agency_name = agency_name;
	}

	public String getAgency_id() {
		return agency_id;
	}

	public void setAgency_id(String agency_id) {
		this.agency_id = agency_id;
	}

	public String getBook_reg_no() {
		return book_reg_no;
	}

	public void setBook_reg_no(String book_reg_no) {
		this.book_reg_no = book_reg_no;
	}

	public String getBook_call_no() {
		return book_call_no;
	}

	public void setBook_call_no(String book_call_no) {
		this.book_call_no = book_call_no;
	}

	public String getBook_name() {
		return book_name;
	}

	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}

	public String getThumb_image() {
		return thumb_image;
	}

	public void setThumb_image(String thumb_image) {
		this.thumb_image = thumb_image;
	}

	public String getRequest_status() {
		return request_status;
	}

	public void setRequest_status(String request_status) {
		this.request_status = request_status;
	}

	public Date getRequest_date() {
		return request_date;
	}

	public void setRequest_date(Date request_date) {
		this.request_date = request_date;
	}

	public String getRequest_name() {
		return request_name;
	}

	public void setRequest_name(String request_name) {
		this.request_name = request_name;
	}

	public String getRequest_phone() {
		return request_phone;
	}

	public void setRequest_phone(String request_phone) {
		this.request_phone = request_phone;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public String getAuth_group() {
		return auth_group;
	}

	public void setAuth_group(String auth_group) {
		this.auth_group = auth_group;
	}
	
	public List<BookExpress> getBookExpressList() {
		return bookExpressList;
	}
	
	public void setBookExpressList(List<BookExpress> bookExpressList) {
		this.bookExpressList = bookExpressList;
	}

	@Override
	public String toString() {
		return "BookExpress [book_express_idx=" + book_express_idx + 
				", library_code=" + library_code + ", agency_name=" + agency_name + ", agency_id=" + agency_id + 
				", book_reg_no=" + book_reg_no + ", book_call_no=" + book_call_no + ", book_name=" + book_name + 
				", thumb_image=" + thumb_image + ", request_status=" + request_status + ", request_date=" + request_date + 
				", request_name=" + request_name + ", request_phone=" + request_phone + ", reason=" + reason + ", add_date=" + add_date + 
				", add_id=" + add_id + ", modify_date=" + modify_date + ", modify_id=" + modify_id + "]";
	}
	

}
