package kr.go.gbelib.app.cms.module.teachBook;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.teach.Teach;

public class TeachBook extends PagingUtils {
	/** TEACH_BOOK_TIME **/
	private int teach_book_time_idx;  //출석부시간IDX
	private String homepage_id;  //홈페이지ID
	private int group_idx;
	private int category_idx;  //카테고리IDX
	private int large_category_idx;  //대분류IDX
	private int teach_idx;  //강좌IDX
	private String teach_date;  //강좌날짜
	private String delete_yn;  //삭제여부
	
	/** TEACH_BOOK_DETAIL **/
	private int student_idx;  //수강생IDX
	private String status;  //출석상태  , 1=출석 , 2=지각, 3=결석, 0=데이터 없음
	private Date confirm_date;  //출석확인일자
	private Date add_date;  //등록일
	private String add_id;  //등록ID
	private Date mod_date;  //수정일
	private String mod_id;  //수정ID
	
	private String sel_date;

	private String[] studentList;
	private String student_name;
	
	private String[] pay1List;
	private String[] pay2List;
	private String[] pay3List;
	private String pay1; //수강료
	private String pay2; //교재비
	private String pay3; //재료비
	
	private String pay_type;
	private String pay_value;
	private String pay1_yn;
	private String pay2_yn;
	private String pay3_yn;
	
	public TeachBook() {}
	
	public TeachBook(String homepage_id, int group_idx, int category_idx, int teach_idx) {
		this.homepage_id = homepage_id;
		this.group_idx = group_idx;
		this.category_idx = category_idx;
		this.teach_idx = teach_idx;
	}

	public TeachBook(Teach teach, String date) {
		this.homepage_id = teach.getHomepage_id();
		this.group_idx = teach.getGroup_idx();
		this.category_idx = teach.getCategory_idx();
		this.teach_idx = teach.getTeach_idx();
		this.teach_date = date;
	}
	
	
	public int getTeach_book_time_idx() {
		return teach_book_time_idx;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public int getCategory_idx() {
		return category_idx;
	}

	public int getTeach_idx() {
		return teach_idx;
	}

	public String getTeach_date() {
		return teach_date;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public int getStudent_idx() {
		return student_idx;
	}

	public String getStatus() {
		return status;
	}

	public Date getConfirm_date() {
		return confirm_date;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public String getAdd_id() {
		return add_id;
	}

	public Date getMod_date() {
		return mod_date;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setTeach_book_time_idx(int teach_book_time_idx) {
		this.teach_book_time_idx = teach_book_time_idx;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public void setCategory_idx(int category_idx) {
		this.category_idx = category_idx;
	}

	public void setTeach_idx(int teach_idx) {
		this.teach_idx = teach_idx;
	}

	public void setTeach_date(String teach_date) {
		this.teach_date = teach_date;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public void setStudent_idx(int student_idx) {
		this.student_idx = student_idx;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setConfirm_date(Date confirm_date) {
		this.confirm_date = confirm_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public String getSel_date() {
		return sel_date;
	}

	public void setSel_date(String sel_date) {
		this.sel_date = sel_date;
	}

	public String[] getStudentList() {
		String[] ret = null;
		if(this.studentList != null) {
			ret = new String[this.studentList.length];
			for(int i=0; i<this.studentList.length; i++) {
				ret[i] = this.studentList[i];
			}
		}
		return ret;
	}

	public String getStudent_name() {
		return student_name;
	}

	public void setStudentList(String[] studentList) {
		this.studentList = new String[studentList.length];
		for(int i=0; i<studentList.length; i++) {
			this.studentList[i] = studentList[i];
		}
	}

	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}

	public int getGroup_idx() {
		return group_idx;
	}

	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}

	public String getPay1() {
		return pay1;
	}

	public void setPay1(String pay1) {
		this.pay1 = pay1;
	}

	public String getPay2() {
		return pay2;
	}

	public void setPay2(String pay2) {
		this.pay2 = pay2;
	}

	public String getPay3() {
		return pay3;
	}

	public void setPay3(String pay3) {
		this.pay3 = pay3;
	}

	public String[] getPay1List() {
		return pay1List;
	}

	public void setPay1List(String[] pay1List) {
		this.pay1List = pay1List;
	}

	public String[] getPay2List() {
		return pay2List;
	}

	public void setPay2List(String[] pay2List) {
		this.pay2List = pay2List;
	}

	public String[] getPay3List() {
		return pay3List;
	}

	public void setPay3List(String[] pay3List) {
		this.pay3List = pay3List;
	}

	public String getPay1_yn() {
		return pay1_yn;
	}

	public void setPay1_yn(String pay1_yn) {
		this.pay1_yn = pay1_yn;
	}

	public String getPay2_yn() {
		return pay2_yn;
	}

	public void setPay2_yn(String pay2_yn) {
		this.pay2_yn = pay2_yn;
	}

	public String getPay3_yn() {
		return pay3_yn;
	}

	public void setPay3_yn(String pay3_yn) {
		this.pay3_yn = pay3_yn;
	}

	public String getPay_type() {
		return pay_type;
	}

	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}

	public String getPay_value() {
		return pay_value;
	}

	public void setPay_value(String pay_value) {
		this.pay_value = pay_value;
	}

	
	public int getLarge_category_idx() {
		return large_category_idx;
	}

	
	public void setLarge_category_idx(int large_category_idx) {
		this.large_category_idx = large_category_idx;
	}
	
}
