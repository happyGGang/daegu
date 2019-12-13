package kr.co.whalesoft.app.cms.module.survey.questDetail;

import java.util.Date;
import java.util.List;

public class QuestDetail {

	private String	homepage_id;
	private String 	editMode;
	private int		survey_idx;
	private int		quest_idx; 
	private int		quest_detail_idx;
	private int		quest_detail_order; 
	private String	quest_detail_title;
	private Date	add_date; 
	private String	add_id;
	
	private Date modify_date;
	private String modify_id;
	
	private int cnt;
	private double ratio;
	private int total_cnt;
	
	private int branch_idx;
	private String quest_content;
	private int quest_order;
	
	private List<QuestDetail> questDetailList;
	
	private int answer_count;
	
	public List<QuestDetail> getQuestDetailList() {
		return questDetailList;
	}
	public int getAnswer_count() {
		return answer_count;
	}
	public void setAnswer_count(int answer_count) {
		this.answer_count = answer_count;
	}
	public void setQuestDetailList(List<QuestDetail> questDetailList) {
		this.questDetailList = questDetailList;
	}
	public String getEditMode() {
		return editMode;
	}
	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}
	public int getQuest_idx() {
		return quest_idx;
	}
	public void setQuest_idx(int quest_idx) {
		this.quest_idx = quest_idx;
	}
	public int getQuest_detail_idx() {
		return quest_detail_idx;
	}
	public void setQuest_detail_idx(int quest_detail_idx) {
		this.quest_detail_idx = quest_detail_idx;
	}
	public int getQuest_detail_order() {
		return quest_detail_order;
	}
	public void setQuest_detail_order(int quest_detail_order) {
		this.quest_detail_order = quest_detail_order;
	}
	public String getQuest_detail_title() {
		return quest_detail_title;
	}
	public void setQuest_detail_title(String quest_detail_title) {
		this.quest_detail_title = quest_detail_title;
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
	public int getSurvey_idx() {
		return survey_idx;
	}
	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public double getRatio() {
		return ratio;
	}
	public void setRatio(double ratio) {
		this.ratio = ratio;
	}
	public int getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(int total_cnt) {
		this.total_cnt = total_cnt;
	}
	public int getBranch_idx() {
		return branch_idx;
	}
	public void setBranch_idx(int branch_idx) {
		this.branch_idx = branch_idx;
	}
	public String getQuest_content() {
		return quest_content;
	}
	public void setQuest_content(String quest_content) {
		this.quest_content = quest_content;
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
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	
	public int getQuest_order() {
		return quest_order;
	}
	
	public void setQuest_order(int quest_order) {
		this.quest_order = quest_order;
	}
	

}