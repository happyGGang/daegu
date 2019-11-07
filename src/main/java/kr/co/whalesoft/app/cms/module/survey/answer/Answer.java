package kr.co.whalesoft.app.cms.module.survey.answer;

import java.util.Date;
import java.util.List;

import kr.co.whalesoft.app.cms.module.survey.statistics.Statistics;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class Answer extends PagingUtils {
	
	private String homepage_id;
	private int			answer_idx;
	private int			survey_idx;
	private int			quest_idx;
	private int			matrix_idx;
	private List<String>	quest_idx_list;			//객관식 모음
	private int					choice_answer;			//객관식
	private String			short_answer;			//주관식
	private String			quest_type;
	private String			add_user_id;
	private String			add_user_name;
	private String			add_user_ip;
	private String			add_user_div;
	private Date				add_date;
	private String			add_date_str;
	private String			member_key;
	private String			chosen_yn;
	private String			last_short_answer;
	
	private String required_yn;
	
	private List<String> chosenAnswerList;
	
	private List<Statistics> statisticsList;
	
	public String getShort_answer() {
		return short_answer;
	}
	public void setShort_answer(String short_answer) {
		this.short_answer = short_answer;
	}
	public String getQuest_type() {
		return quest_type;
	}
	public void setQuest_type(String quest_type) {
		this.quest_type = quest_type;
	}
	public int getAnswer_idx() {
		return answer_idx;
	}
	public void setAnswer_idx(int answer_idx) {
		this.answer_idx = answer_idx;
	}
	public int getChoice_answer() {
		return choice_answer;
	}
	public void setChoice_answer(int choice_answer) {
		this.choice_answer = choice_answer;
	}
	public int getQuest_idx() {
		return quest_idx;
	}
	public void setQuest_idx(int quest_idx) {
		this.quest_idx = quest_idx;
	}
	public int getMatrix_idx() {
		return matrix_idx;
	}
	public void setMatrix_idx(int matrix_idx) {
		this.matrix_idx = matrix_idx;
	}
	public int getSurvey_idx() {
		return survey_idx;
	}
	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
	}
	public String getAdd_user_id() {
		return add_user_id;
	}
	public void setAdd_user_id(String add_user_id) {
		this.add_user_id = add_user_id;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
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
	public String getRequired_yn() {
		return required_yn;
	}
	public void setRequired_yn(String required_yn) {
		this.required_yn = required_yn;
	}
	public String getAdd_user_name() {
		return add_user_name;
	}
	public void setAdd_user_name(String add_user_name) {
		this.add_user_name = add_user_name;
	}
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public List<String> getQuest_idx_list() {
		return quest_idx_list;
	}
	public void setQuest_idx_list(List<String> quest_idx_list) {
		this.quest_idx_list = quest_idx_list;
	}
	public String getChosen_yn() {
		return chosen_yn;
	}
	public void setChosen_yn(String chosen_yn) {
		this.chosen_yn = chosen_yn;
	}
	public String getMember_key() {
		return member_key;
	}
	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}
	public List<String> getChosenAnswerList() {
		return chosenAnswerList;
	}
	public void setChosenAnswerList(List<String> chosenAnswerList) {
		this.chosenAnswerList = chosenAnswerList;
	}
	public List<Statistics> getStatisticsList() {
		return statisticsList;
	}
	public void setStatisticsList(List<Statistics> statisticsList) {
		this.statisticsList = statisticsList;
	}
	public String getAdd_date_str() {
		return add_date_str;
	}
	public void setAdd_date_str(String add_date_str) {
		this.add_date_str = add_date_str;
	}
	public String getLast_short_answer() {
		return last_short_answer;
	}
	public void setLast_short_answer(String last_short_answer) {
		this.last_short_answer = last_short_answer;
	}
	
}