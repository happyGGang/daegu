package kr.go.gbelib.app.cms.module.teach.teachCode;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class TeachCode extends PagingUtils {

	private String large_code;  //대분류코드
	private String mid_code;  //중분류코드
	private String small_code;  //소분류코드
	private String code_name;  //분류명
	private String remark;  //비고
	private int print_seq;  //출력순서
	private Date add_date;  //등록일
	private String add_id;  //등록ID
	private Date mod_date;  //수정일
	private String mod_id;  //수정ID
	
	private String tempCode;  //입력용 임시변수 - 코드
	
	public String getLarge_code() {
		return large_code;
	}
	
	public void setLarge_code(String large_code) {
		this.large_code = large_code;
	}
	
	public String getMid_code() {
		return mid_code;
	}
	
	public void setMid_code(String mid_code) {
		this.mid_code = mid_code;
	}
	
	public String getSmall_code() {
		return small_code;
	}
	
	public void setSmall_code(String small_code) {
		this.small_code = small_code;
	}
	
	public String getCode_name() {
		return code_name;
	}
	
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	
	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public int getPrint_seq() {
		return print_seq;
	}
	
	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
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
	
	public Date getMod_date() {
		return mod_date;
	}
	
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	
	public String getMod_id() {
		return mod_id;
	}
	
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	
	public String getTempCode() {
		return tempCode;
	}

	
	public void setTempCode(String tempCode) {
		this.tempCode = tempCode;
	}

}
