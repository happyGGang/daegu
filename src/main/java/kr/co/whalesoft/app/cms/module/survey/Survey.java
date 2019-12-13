package kr.co.whalesoft.app.cms.module.survey;

import java.util.Date;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Survey extends PagingUtils {

	private int		survey_idx;
	private String	survey_title;
	private String	survey_content;
	private String	survey_start_date;
	private String	survey_end_date;
	private String	survey_open_yn = "N";
	private String	survey_private_yn = "N";
	private Date	add_date;
	private String	add_id;
	
	private String	add_user_name;
	private String	add_user_mobile;
	private String	add_user_email;
	
	private String	add_user_tel;
	private String	add_user_tel1;
	private String	add_user_tel2;
	private String	add_user_tel3;
	
	private String open_yn = "N"; //공개여부
	private String name_yn = "N"; //익명여부
	private String greetings; //인사말
	private String popup_yn = "N"; //팝업유무
	private String annyms_yn = "N";//비로그인사용자 참여여부
	
	private Date modify_date;
	private String modify_id;
	
	private boolean admin = false;
	private boolean subAdmin = false;
	
	private int answer_count;
	
	private String limit_user_yn = "N";
	private String limit_user_id;
	
	private String skin_cd = "1";
	
	private int select_cnt;
	
	private List<String> chosenAnswerList;
	
	public String getUrlParam(Survey survey) {
		StringBuffer sb = new StringBuffer();
		
		sb.append("homepage_id=" + survey.getHomepage_id());
		
		return sb.toString();
	}
	
	public int getSurvey_idx() {
		return survey_idx;
	}
	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
	}
	public String getSurvey_title() {
		return survey_title;
	}
	public void setSurvey_title(String survey_title) {
		this.survey_title = survey_title;
	}
	public String getSurvey_content() {
		return survey_content;
	}
	public void setSurvey_content(String survey_content) {
		this.survey_content = survey_content;
	}
	public String getSurvey_start_date() {
		return survey_start_date;
	}
	public void setSurvey_start_date(String survey_start_date) {
		this.survey_start_date = survey_start_date;
	}
	public String getSurvey_end_date() {
		return survey_end_date;
	}
	public void setSurvey_end_date(String survey_end_date) {
		this.survey_end_date = survey_end_date;
	}
	public String getSurvey_open_yn() {
		return survey_open_yn;
	}
	public void setSurvey_open_yn(String survey_open_yn) {
		this.survey_open_yn = survey_open_yn;
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

	public int getAnswer_count() {
		return answer_count;
	}

	public void setAnswer_count(int answer_count) {
		this.answer_count = answer_count;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getAdd_user_mobile() {
		return add_user_mobile;
	}

	public void setAdd_user_mobile(String add_user_mobile) {
		this.add_user_mobile = add_user_mobile;
	}

	public String getAdd_user_email() {
		return add_user_email;
	}

	public void setAdd_user_email(String add_user_email) {
		this.add_user_email = add_user_email;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public boolean isSubAdmin() {
		return subAdmin;
	}

	public void setSubAdmin(boolean subAdmin) {
		this.subAdmin = subAdmin;
	}

	public String getLimit_user_yn() {
		return limit_user_yn;
	}

	public void setLimit_user_yn(String limit_user_yn) {
		this.limit_user_yn = limit_user_yn;
	}

	public String getLimit_user_id() {
		return limit_user_id;
	}

	public void setLimit_user_id(String limit_user_id) {
		this.limit_user_id = limit_user_id;
	}

	public String getAdd_user_tel() {
		return add_user_tel;
	}

	public void setAdd_user_tel(String add_user_tel) {
		this.add_user_tel = add_user_tel;
	}

	public String getSkin_cd() {
		return skin_cd;
	}

	public void setSkin_cd(String skin_cd) {
		this.skin_cd = skin_cd;
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

	public String getAdd_user_tel1() {
		return add_user_tel1;
	}

	public void setAdd_user_tel1(String add_user_tel1) {
		this.add_user_tel1 = add_user_tel1;
	}

	public String getAdd_user_tel2() {
		return add_user_tel2;
	}

	public void setAdd_user_tel2(String add_user_tel2) {
		this.add_user_tel2 = add_user_tel2;
	}

	public String getAdd_user_tel3() {
		return add_user_tel3;
	}

	public void setAdd_user_tel3(String add_user_tel3) {
		this.add_user_tel3 = add_user_tel3;
	}

	public String getOpen_yn() {
		return open_yn;
	}

	public void setOpen_yn(String open_yn) {
		this.open_yn = open_yn;
	}

	public String getName_yn() {
		return name_yn;
	}

	public void setName_yn(String name_yn) {
		this.name_yn = name_yn;
	}

	public String getGreetings() {
		return greetings;
	}

	public void setGreetings(String greetings) {
		this.greetings = greetings;
	}

	public String getPopup_yn() {
		return popup_yn;
	}

	public void setPopup_yn(String popup_yn) {
		this.popup_yn = popup_yn;
	}

	public String getSurvey_private_yn() {
		return survey_private_yn;
	}

	public void setSurvey_private_yn(String survey_private_yn) {
		this.survey_private_yn = survey_private_yn;
	}

	
	public String getAnnyms_yn() {
		return annyms_yn;
	}

	
	public void setAnnyms_yn(String annyms_yn) {
		this.annyms_yn = annyms_yn;
	}

	public List<String> getChosenAnswerList() {
		return chosenAnswerList;
	}

	public void setChosenAnswerList(List<String> chosenAnswerList) {
		this.chosenAnswerList = chosenAnswerList;
	}

	public int getSelect_cnt() {
		return select_cnt;
	}

	public void setSelect_cnt(int select_cnt) {
		this.select_cnt = select_cnt;
	}
	
}
