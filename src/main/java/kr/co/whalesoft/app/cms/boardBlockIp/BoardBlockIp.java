package kr.co.whalesoft.app.cms.boardBlockIp;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BoardBlockIp extends PagingUtils {

	private String block_ip; //접근가능IP
	private String use_yn; //허용여부
	private String remark; //설명
	private Date add_date; //등록일
	private String add_id; //등록ID
	
	public String getBlock_ip() {
		return block_ip;
	}
	public void setBlock_ip(String block_ip) {
		this.block_ip = block_ip;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	
}