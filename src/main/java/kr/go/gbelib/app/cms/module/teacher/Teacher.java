package kr.go.gbelib.app.cms.module.teacher;

import java.util.Date;
import org.springframework.web.multipart.MultipartFile;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class Teacher extends PagingUtils {

	private int teacher_idx; // 강사IDX
	private String teacher_id;
	private String member_key;
	private String teacher_name; // 강사명
	private String teacher_subject_name; // 과목명
	private String stage; // 강의실
	private String teacher_birth; // 생년월일
	private String teacher_sex; // 성별
	private String teacher_phone; // 전화번호
	private String teacher_cell_phone; // 폰번호
	private String teacher_email;
	private String teacher_nationality; // 국적
	private String teacher_zipcode;
	private String teacher_address; // 주소
	private String teacher_history; // 이력
	private String teacher_history_manage;// 학과 경력
	private String teacher_history_manage2;// 자격증
	private String self_info_yn;
	private String confirm_yn; // 승인여부
	private String add_date; // 등록일
	private String add_id; // 등록자
	private String modify_date; // 수정일
	private String modify_id; // 수정자
	private String delete_yn; // 삭제여부

	private String search_api_type = "WEBID";

	// 경력증명서 기능에 사용
	private long cert_seq_num;

	private String group_name;
	private String category_name;
	private String teach_name; // 이력 화면에 뿌릴 용도로 사용 (디비 컬럼 아님)
	private String start_date;
	private String end_date;
	private String start_time;
	private String end_time;
	private int teach_count;
	private int total_time;
	private int sum_total_time;

	private MultipartFile file;
	private String org_file_name;
	private String server_file_name;
	private String file_extension;
	private long file_size;

	private String homepage_name;

	private String terms_yn = "Y";
	private Date agree_date;

	public Teacher() {
	}

	public Teacher(String homepage_id, int teacher_idx) {
		setHomepage_id(homepage_id);
		this.teacher_idx = teacher_idx;
	}

	public int getTeacher_idx() {
		return teacher_idx;
	}

	public void setTeacher_idx(int teacher_idx) {
		this.teacher_idx = teacher_idx;
	}

	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}

	public String getTeacher_subject_name() {
		return teacher_subject_name;
	}

	public void setTeacher_subject_name(String teacher_subject_name) {
		this.teacher_subject_name = teacher_subject_name;
	}

	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getTeacher_birth() {
		return teacher_birth;
	}

	public void setTeacher_birth(String teacher_birth) {
		this.teacher_birth = teacher_birth;
	}

	public String getTeacher_sex() {
		return teacher_sex;
	}

	public void setTeacher_sex(String teacher_sex) {
		this.teacher_sex = teacher_sex;
	}

	public String getTeacher_phone() {
		return teacher_phone;
	}

	public void setTeacher_phone(String teacher_phone) {
		this.teacher_phone = teacher_phone;
	}

	public String getTeacher_cell_phone() {
		return teacher_cell_phone;
	}

	public void setTeacher_cell_phone(String teacher_cell_phone) {
		this.teacher_cell_phone = teacher_cell_phone;
	}

	public String getTeacher_nationality() {
		return teacher_nationality;
	}

	public void setTeacher_nationality(String teacher_nationality) {
		this.teacher_nationality = teacher_nationality;
	}

	public String getTeacher_address() {
		return teacher_address;
	}

	public void setTeacher_address(String teacher_address) {
		this.teacher_address = teacher_address;
	}

	public String getTeacher_history() {
		return teacher_history;
	}

	public void setTeacher_history(String teacher_history) {
		this.teacher_history = teacher_history;
	}

	public String getAdd_date() {
		return add_date;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public String getTeach_name() {
		return teach_name;
	}

	public void setTeach_name(String teach_name) {
		this.teach_name = teach_name;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public String getTeacher_id() {
		return teacher_id;
	}

	public void setTeacher_id(String teacher_id) {
		this.teacher_id = teacher_id;
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getTeacher_zipcode() {
		return teacher_zipcode;
	}

	public void setTeacher_zipcode(String teacher_zipcode) {
		this.teacher_zipcode = teacher_zipcode;
	}

	public String getConfirm_yn() {
		return confirm_yn;
	}

	public void setConfirm_yn(String confirm_yn) {
		this.confirm_yn = confirm_yn;
	}

	public String getSearch_api_type() {
		return search_api_type;
	}

	public void setSearch_api_type(String search_api_type) {
		this.search_api_type = search_api_type;
	}

	public String getSelf_info_yn() {
		return self_info_yn;
	}

	public void setSelf_info_yn(String self_info_yn) {
		this.self_info_yn = self_info_yn;
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

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public int getTeach_count() {
		return teach_count;
	}

	public void setTeach_count(int teach_count) {
		this.teach_count = teach_count;
	}

	public int getTotal_time() {
		return total_time;
	}

	public void setTotal_time(int total_time) {
		this.total_time = total_time;
	}

	@Override
	public String toString() {
		return "Teacher [teacher_idx=" + teacher_idx + ", teacher_id=" + teacher_id + ", member_key=" + member_key + ", teacher_name=" + teacher_name + ", teacher_subject_name=" + teacher_subject_name + ", stage=" + stage + ", teacher_birth=" + teacher_birth + ", teacher_sex=" + teacher_sex + ", teacher_phone=" + teacher_phone + ", teacher_cell_phone=" + teacher_cell_phone + ", teacher_nationality=" + teacher_nationality + ", teacher_zipcode=" + teacher_zipcode + ", teacher_address=" + teacher_address + ", teacher_history=" + teacher_history + ", self_info_yn=" + self_info_yn + ", confirm_yn=" + confirm_yn + ", add_date=" + add_date + ", add_id=" + add_id + ", modify_date=" + modify_date + ", modify_id=" + modify_id + ", delete_yn=" + delete_yn + ", search_api_type=" + search_api_type + ", teach_name=" + teach_name + ", start_date=" + start_date + ", end_date=" + end_date + ", start_time=" + start_time + ", end_time=" + end_time + ", teach_count=" + teach_count + ", total_time=" + total_time + "]";
	}

	public long getCert_seq_num() {
		return cert_seq_num;
	}

	public void setCert_seq_num(long cert_seq_num) {
		this.cert_seq_num = cert_seq_num;
	}

	public int getSum_total_time() {
		return sum_total_time;
	}

	public void setSum_total_time(int sum_total_time) {
		this.sum_total_time = sum_total_time;
	}

	public String getHomepage_name() {
		return homepage_name;
	}

	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}

	public String getTeacher_history_manage() {
		return teacher_history_manage;
	}

	public void setTeacher_history_manage(String teacher_history_manage) {
		this.teacher_history_manage = teacher_history_manage;
	}

	public String getTeacher_email() {
		return teacher_email;
	}

	public void setTeacher_email(String teacher_email) {
		this.teacher_email = teacher_email;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public String getTeacher_history_manage2() {
		return teacher_history_manage2;
	}

	public void setTeacher_history_manage2(String teacher_history_manage2) {
		this.teacher_history_manage2 = teacher_history_manage2;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getOrg_file_name() {
		return org_file_name;
	}

	public void setOrg_file_name(String file_name) {
		this.org_file_name = file_name;
	}

	public String getServer_file_name() {
		return server_file_name;
	}

	public void setServer_file_name(String real_file_name) {
		this.server_file_name = real_file_name;
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

	public String getModify_date() {
		return modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public String getTerms_yn() {
		return terms_yn;
	}

	public void setTerms_yn(String terms_yn) {
		this.terms_yn = terms_yn;
	}

	public Date getAgree_date() {
		return agree_date;
	}

	public void setAgree_date(Date agree_date) {
		this.agree_date = agree_date;
	}

}
