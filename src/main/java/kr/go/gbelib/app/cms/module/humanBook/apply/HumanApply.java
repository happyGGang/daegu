package kr.go.gbelib.app.cms.module.humanBook.apply;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.humanBook.HumanBook;

public class HumanApply extends HumanBook {

	private int human_apply_idx; // 신청IDX
	private String human_apply_name; // 신청자명
	private String human_apply_age = "20"; // 신청자 나이대
	private String human_apply_gender = "1"; // 신청자 성별
	private String human_apply_phone; // 신청자 연락처
	private String human_apply_hope_date; // 신청희망일
	private String human_apply_content; // 열람목적
	private String human_apply_place; // 열람장소
	private int human_apply_people; // 열람인원
	private Date human_return_date; // 반납일
	private String human_apply_status; // 신청상태
	private String add_id;
	private Date add_date;
	private String modify_id;
	private Date modify_date;

	public int getHuman_apply_idx() {
		return human_apply_idx;
	}

	public void setHuman_apply_idx(int human_apply_idx) {
		this.human_apply_idx = human_apply_idx;
	}

	public String getHuman_apply_name() {
		return human_apply_name;
	}

	public void setHuman_apply_name(String human_apply_name) {
		this.human_apply_name = human_apply_name;
	}

	public String getHuman_apply_age() {
		return human_apply_age;
	}

	public void setHuman_apply_age(String human_apply_age) {
		this.human_apply_age = human_apply_age;
	}

	public String getHuman_apply_gender() {
		return human_apply_gender;
	}

	public void setHuman_apply_gender(String human_apply_gender) {
		this.human_apply_gender = human_apply_gender;
	}

	public String getHuman_apply_phone() {
		return human_apply_phone;
	}

	public void setHuman_apply_phone(String human_apply_phone) {
		this.human_apply_phone = human_apply_phone;
	}

	public String getHuman_apply_hope_date() {
		return human_apply_hope_date;
	}

	public void setHuman_apply_hope_date(String human_apply_hope_date) {
		this.human_apply_hope_date = human_apply_hope_date;
	}

	public String getHuman_apply_content() {
		return human_apply_content;
	}

	public void setHuman_apply_content(String human_apply_content) {
		this.human_apply_content = human_apply_content;
	}

	public String getHuman_apply_place() {
		return human_apply_place;
	}

	public void setHuman_apply_place(String human_apply_place) {
		this.human_apply_place = human_apply_place;
	}

	public int getHuman_apply_people() {
		return human_apply_people;
	}

	public void setHuman_apply_people(int human_apply_people) {
		this.human_apply_people = human_apply_people;
	}

	public Date getHuman_return_date() {
		return human_return_date;
	}

	public void setHuman_return_date(Date human_return_date) {
		this.human_return_date = human_return_date;
	}

	public String getHuman_apply_status() {
		return human_apply_status;
	}

	public void setHuman_apply_status(String human_apply_status) {
		this.human_apply_status = human_apply_status;
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

}
