package kr.co.whalesoft.app.cms.module.survey.quest;

import java.util.Date;
import java.util.List;

import kr.co.whalesoft.app.cms.module.survey.answer.Answer;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetail;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrix;
import kr.co.whalesoft.framework.utils.PagingUtils;

import org.springframework.web.multipart.MultipartFile;

public class Quest extends PagingUtils {

	private String	homepage_id;
	private int		survey_idx;
	private int		quest_idx;
	private String	quest_type;
	private String	quest_content;
	private String	quest_auth = "ALL";
	private int		quest_count;
	private int		quest_order;
	private int		matrix_count;
	private String	add_date;
	private String	add_user_id;
	private String	member_key;
	private String	add_user_name;
	private String	add_user_ip;
	private String	add_user_div;
	private String  popup_yn;
	private String	survey_open_yn;
	private String	open_yn;

	private Date modify_date;
	private String modify_user_id;
	
	private String	quest_detail_free_yn = "N";
	
	private List<QuestMatrix> quest_matrix_list;
	private List<QuestDetail> quest_detail_list;
	
	private List<Answer> answer_list;
	private List<Answer> desc_list;
	private Answer answer;
	
	private String	editMode = "add";
	private String searchMode;
	
	private String userAuth;
	
	private int		quest_idx_fr;
	
	private MultipartFile multiFile;
	
	private int branch;
	private String required_yn = "Y";
	
	private int menu_idx;
	
	private List<Quest> questList;
	
	private int answer_count;
	
	private String imgData;
	

	
	public int getAnswer_count() {
		return answer_count;
	}

	public void setAnswer_count(int answer_count) {
		this.answer_count = answer_count;
	}
	
	public String getUrlParam(Quest quest) {
		StringBuffer sb = new StringBuffer();
		
		sb.
		append("survey_idx=" + quest.getSurvey_idx())
		.append("&homepage_id=" + quest.getHomepage_id());
		
		return sb.toString();
	}
	
	public int getSurvey_idx() {
		return survey_idx;
	}
	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
	}
	public int getQuest_idx() {
		return quest_idx;
	}
	public void setQuest_idx(int quest_idx) {
		this.quest_idx = quest_idx;
	}
	public String getQuest_type() {
		return quest_type;
	}
	public void setQuest_type(String quest_type) {
		this.quest_type = quest_type;
	}
	public String getQuest_content() {
		return quest_content;
	}
	public void setQuest_content(String quest_content) {
		this.quest_content = quest_content;
	}
	public String getQuest_auth() {
		return quest_auth;
	}
	public void setQuest_auth(String quest_auth) {
		this.quest_auth = quest_auth;
	}
	public int getQuest_count() {
		return quest_count;
	}
	public void setQuest_count(int quest_count) {
		this.quest_count = quest_count;
	}
	public int getQuest_order() {
		return quest_order;
	}
	public void setQuest_order(int quest_order) {
		this.quest_order = quest_order;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getAdd_user_id() {
		return add_user_id;
	}
	public void setAdd_user_id(String add_user_id) {
		this.add_user_id = add_user_id;
	}
	public int getMatrix_count() {
		return matrix_count;
	}
	public void setMatrix_count(int matrix_count) {
		this.matrix_count = matrix_count;
	}
	public String getEditMode() {
		return editMode;
	}

	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}

	public int getQuest_idx_fr() {
		return quest_idx_fr;
	}

	public void setQuest_idx_fr(int quest_idx_fr) {
		this.quest_idx_fr = quest_idx_fr;
	}

	public String getQuest_detail_free_yn() {
		return quest_detail_free_yn;
	}

	public void setQuest_detail_free_yn(String quest_detail_free_yn) {
		this.quest_detail_free_yn = quest_detail_free_yn;
	}

	public String getSearchMode() {
		return searchMode;
	}

	public void setSearchMode(String searchMode) {
		this.searchMode = searchMode;
	}

	public String getUserAuth() {
		return userAuth;
	}

	public void setUserAuth(String userAuth) {
		this.userAuth = userAuth;
	}

	public String getAdd_user_ip() {
		return add_user_ip;
	}

	public void setAdd_user_ip(String add_user_ip) {
		this.add_user_ip = add_user_ip;
	}

	public String getAdd_user_div() {
		return add_user_div;
	}

	public void setAdd_user_div(String add_user_div) {
		this.add_user_div = add_user_div;
	}

	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
	}

	public MultipartFile getMultiFile() {
		return multiFile;
	}

	public void setMultiFile(MultipartFile multiFile) {
		this.multiFile = multiFile;
	}

	public int getBranch() {
		return branch;
	}

	public void setBranch(int branch) {
		this.branch = branch;
	}

	public String getRequired_yn() {
		return required_yn;
	}

	public void setRequired_yn(String required_yn) {
		this.required_yn = required_yn;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getModify_user_id() {
		return modify_user_id;
	}

	public void setModify_user_id(String modify_user_id) {
		this.modify_user_id = modify_user_id;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getMenu_idx() {
		return menu_idx;
	}

	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}

	public String getPopup_yn() {
		return popup_yn;
	}

	public void setPopup_yn(String popup_yn) {
		this.popup_yn = popup_yn;
	}

	public String getAdd_user_name() {
		return add_user_name;
	}

	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}

	public String getSurvey_open_yn() {
		return survey_open_yn;
	}

	public void setSurvey_open_yn(String survey_open_yn) {
		this.survey_open_yn = survey_open_yn;
	}

	public String getOpen_yn() {
		return open_yn;
	}

	public void setOpen_yn(String open_yn) {
		this.open_yn = open_yn;
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}

	public List<QuestDetail> getQuest_detail_list() {
		return quest_detail_list;
	}

	public void setQuest_detail_list(List<QuestDetail> quest_detail_list) {
		this.quest_detail_list = quest_detail_list;
	}

	public List<QuestMatrix> getQuest_matrix_list() {
		return quest_matrix_list;
	}

	public void setQuest_matrix_list(List<QuestMatrix> quest_matrix_list) {
		this.quest_matrix_list = quest_matrix_list;
	}

	public List<Answer> getAnswer_list() {
		return answer_list;
	}

	public void setAnswer_list(List<Answer> answer_list) {
		this.answer_list = answer_list;
	}

	
	public List<Answer> getDesc_list() {
		return desc_list;
	}

	
	public void setDesc_list(List<Answer> desc_list) {
		this.desc_list = desc_list;
	}

	public List<Quest> getQuestList() {
		return questList;
	}

	public void setQuestList(List<Quest> questList) {
		this.questList = questList;
	}

	public String getImgData() {
		return imgData;
	}

	public void setImgData(String imgData) {
		this.imgData = imgData;
	}
	
}