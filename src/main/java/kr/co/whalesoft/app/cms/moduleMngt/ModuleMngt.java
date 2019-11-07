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
	private Date add_dttm; // 등록일
	private String add_id; // 등록자
	private Date mod_dttm; // 수정일
	private String mod_id; // 수정자

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

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public String getTerms_idx() {
		return terms_idx;
	}

	public void setTerms_idx(String terms_idx) {
		this.terms_idx = terms_idx;
	}

	public Date getAdd_dttm() {
		return add_dttm;
	}

	public void setAdd_dttm(Date add_dttm) {
		this.add_dttm = add_dttm;
	}

	public Date getMod_dttm() {
		return mod_dttm;
	}

	public void setMod_dttm(Date mod_dttm) {
		this.mod_dttm = mod_dttm;
	}

}