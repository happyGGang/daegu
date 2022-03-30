package kr.co.whalesoft.app.cms.module.survey.statistics;

import java.util.List;

public class Statistics {

	private int cnt;
	private double ratio;
	private List<Statistics> cntList;	
	private int quest_idx;
	private String choice_answer;
	private String short_answer;
	
	public List<Statistics> getCntList() {
		return cntList;
	}
	public void setCntList(List<Statistics> cntList) {
		this.cntList = cntList;
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
	public int getQuest_idx() {
		return quest_idx;
	}
	public void setQuest_idx(int quest_idx) {
		this.quest_idx = quest_idx;
	}
	public String getChoice_answer() {
		return choice_answer;
	}
	public void setChoice_answer(String choice_answer) {
		this.choice_answer = choice_answer;
	}
	public String getShort_answer() {
		return short_answer;
	}
	public void setShort_answer(String short_answer) {
		this.short_answer = short_answer;
	}
	
}
