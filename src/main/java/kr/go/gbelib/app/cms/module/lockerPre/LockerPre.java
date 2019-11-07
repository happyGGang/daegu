package kr.go.gbelib.app.cms.module.lockerPre;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LockerPre extends PagingUtils {

	private int locker_pre_idx;
	private int locker_count;
	private String locker_pre_name;
	private String locker_pre_type;
	private String assign_start_date;
	private String assign_end_date;
	private String apply_start_date;
	private String apply_start_time;
	private String apply_end_date;
	private String apply_end_time;
	private int apply_count; //현재 신청 인원 수
	private int apply_backup_count; // 설정된 신청 대기 인원수
	private String start_date;
	private String end_date;
	private String add_date;
	private String add_id;
	private String mod_date;
	private String mod_id;
	private String state;

	private MultipartFile image_file;
	private String image_file_name;
	private String real_file_name;
	private long image_file_size;
	private String image_file_extension;
	
	public LockerPre() {
	}

	public LockerPre(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	
	public LockerPre(String homepage_id, int locker_pre_idx) {
		setHomepage_id(homepage_id);
		this.locker_pre_idx = locker_pre_idx;
	}

	public int getLocker_pre_idx() {
		return locker_pre_idx;
	}

	public void setLocker_pre_idx(int locker_pre_idx) {
		this.locker_pre_idx = locker_pre_idx;
	}

	public String getLocker_pre_name() {
		return locker_pre_name;
	}

	public void setLocker_pre_name(String locker_pre_name) {
		this.locker_pre_name = locker_pre_name;
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

	public String getAdd_date() {
		return add_date;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public String getMod_date() {
		return mod_date;
	}

	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public int getLocker_count() {
		return locker_count;
	}

	public void setLocker_count(int locker_count) {
		this.locker_count = locker_count;
	}

	public String getApply_start_date() {
		return apply_start_date;
	}

	public void setApply_start_date(String apply_start_date) {
		this.apply_start_date = apply_start_date;
	}

	public String getApply_end_date() {
		return apply_end_date;
	}

	public void setApply_end_date(String apply_end_date) {
		this.apply_end_date = apply_end_date;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getApply_start_time() {
		return apply_start_time;
	}

	public void setApply_start_time(String apply_start_time) {
		this.apply_start_time = apply_start_time;
	}

	public String getApply_end_time() {
		return apply_end_time;
	}

	public void setApply_end_time(String apply_end_time) {
		this.apply_end_time = apply_end_time;
	}

	public String getLocker_pre_type() {
		return locker_pre_type;
	}

	public void setLocker_pre_type(String locker_pre_type) {
		this.locker_pre_type = locker_pre_type;
	}

	public String getImage_file_name() {
		return image_file_name;
	}

	public void setImage_file_name(String image_file_name) {
		this.image_file_name = image_file_name;
	}

	public String getReal_file_name() {
		return real_file_name;
	}

	public void setReal_file_name(String real_file_name) {
		this.real_file_name = real_file_name;
	}

	public MultipartFile getImage_file() {
		return image_file;
	}

	public void setImage_file(MultipartFile image_file) {
		this.image_file = image_file;
	}

	public long getImage_file_size() {
		return image_file_size;
	}

	public void setImage_file_size(long image_file_size) {
		this.image_file_size = image_file_size;
	}

	public String getImage_file_extension() {
		return image_file_extension;
	}

	public void setImage_file_extension(String image_file_extension) {
		this.image_file_extension = image_file_extension;
	}

	public String getAssign_start_date() {
		return assign_start_date;
	}

	public void setAssign_start_date(String assign_start_date) {
		this.assign_start_date = assign_start_date;
	}

	public String getAssign_end_date() {
		return assign_end_date;
	}

	public void setAssign_end_date(String assign_end_date) {
		this.assign_end_date = assign_end_date;
	}

	public int getApply_backup_count() {
		return apply_backup_count;
	}

	public void setApply_backup_count(int apply_backup_count) {
		this.apply_backup_count = apply_backup_count;
	}

	public int getApply_count() {
		return apply_count;
	}

	public void setApply_count(int apply_count) {
		this.apply_count = apply_count;
	}

}
