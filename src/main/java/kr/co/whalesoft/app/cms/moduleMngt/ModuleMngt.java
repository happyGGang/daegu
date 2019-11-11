package kr.co.whalesoft.app.cms.moduleMngt;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * 모듈관리 개편
 * 
 * @author YONGJU
 *
 */
public class ModuleMngt extends PagingUtils {

	private int module_idx; // 모듈IDX
	private String module_type = "CMS"; // 모듈타입
	private String module_name; // 모듈명
	private String remark; // 비고
	private String link_url; // 링크URL
	private String link_param; // 링크URL
	private String auth_group_id; // 링크URL
	private Date add_date; // 등록일
	private String add_id; // 등록자
	private Date modify_date; // 수정일
	private String modify_id; // 수정자

	private String terms_idx;

	public ModuleMngt() {
	}

	public ModuleMngt(int module_idx) {
		this.module_idx = module_idx;
	}

	public int getModule_idx() {
		return module_idx;
	}

	public void setModule_idx(int module_idx) {
		this.module_idx = module_idx;
	}

	public String getModule_type() {
		return module_type;
	}

	public void setModule_type(String module_type) {
		this.module_type = module_type;
	}

	public String getModule_name() {
		return module_name;
	}

	public void setModule_name(String module_name) {
		this.module_name = module_name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	public String getLink_param() {
		return link_param;
	}

	public void setLink_param(String link_param) {
		this.link_param = link_param;
	}

	public String getAuth_group_id() {
		return auth_group_id;
	}

	public void setAuth_group_id(String auth_group_id) {
		this.auth_group_id = auth_group_id;
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

	public String getTerms_idx() {
		return terms_idx;
	}

	public void setTerms_idx(String terms_idx) {
		this.terms_idx = terms_idx;
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

}
