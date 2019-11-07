package kr.co.whalesoft.app.cms.module.survey.questMatrix;

import java.util.Date;
import java.util.List;

import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetail;
import kr.co.whalesoft.app.cms.module.survey.statistics.Statistics;

public class QuestMatrix {

	private String	homepage_id;
	private int		survey_idx;
	private int		quest_idx;
	private int		matrix_idx;
	private int		matrix_order;
	private String	matrix_title;
	private Date	add_date;
	private String	add_user_id;

	private Date modify_date;
	private String modify_user_id;
	
	private List<Statistics> statisticsList;
	private List<QuestDetail> questDetailList;
	
	private int cnt;
	private double ratio;
	
	private int branch_idx;
	private String quest_content;
	
	private String 	editMode;
	private int answer_count;
	
	private int rowCount;
	
	
	
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
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
	public List<QuestDetail> getQuestDetailList() {
		return questDetailList;
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
	public int getAnswer_count() {
		return answer_count;
	}
	public void setAnswer_count(int answer_count) {
		this.answer_count = answer_count;
	}
	public int getMatrix_idx() {
		return matrix_idx;
	}
	public void setMatrix_idx(int matrix_idx) {
		this.matrix_idx = matrix_idx;
	}
	public int getMatrix_order() {
		return matrix_order;
	}
	public void setMatrix_order(int matrix_order) {
		this.matrix_order = matrix_order;
	}
	public String getMatrix_title() {
		return matrix_title;
	}
	public void setMatrix_title(String matrix_title) {
		this.matrix_title = matrix_title;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public String getAdd_user_id() {
		return add_user_id;
	}
	public void setAdd_user_id(String add_user_id) {
		this.add_user_id = add_user_id;
	}
	public int getQuest_idx() {
		return quest_idx;
	}
	public void setQuest_idx(int quest_idx) {
		this.quest_idx = quest_idx;
	}
	public int getSurvey_idx() {
		return survey_idx;
	}
	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
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
	public List<Statistics> getStatisticsList() {
		return statisticsList;
	}
	public void setStatisticsList(List<Statistics> statisticsList) {
		this.statisticsList = statisticsList;
	}
	
	
}