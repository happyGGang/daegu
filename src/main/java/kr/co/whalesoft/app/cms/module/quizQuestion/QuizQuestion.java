package kr.co.whalesoft.app.cms.module.quizQuestion;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class QuizQuestion extends PagingUtils {

	private int quiz_idx;  //퀴즈IDX
	private int quiz_question_idx;  //퀴즈문항IDX
	private String quiz_question_title;  //퀴즈문항제목
	private String quiz_question_type;  //퀴즈문항타입
	private String quiz_question_item;  //퀴즈문항보기
	private String quiz_question_answer;  //정답
	
	public QuizQuestion() { }

	public QuizQuestion(String homepage_id, int quiz_idx) {
		setHomepage_id(homepage_id);
		this.quiz_idx = quiz_idx;
	}
	
	public int getQuiz_idx() {
		return quiz_idx;
	}
	public void setQuiz_idx(int quiz_idx) {
		this.quiz_idx = quiz_idx;
	}
	public int getQuiz_question_idx() {
		return quiz_question_idx;
	}
	public void setQuiz_question_idx(int quiz_question_idx) {
		this.quiz_question_idx = quiz_question_idx;
	}
	public String getQuiz_question_title() {
		return quiz_question_title;
	}
	public void setQuiz_question_title(String quiz_question_title) {
		this.quiz_question_title = quiz_question_title;
	}
	public String getQuiz_question_type() {
		return quiz_question_type;
	}
	public void setQuiz_question_type(String quiz_question_type) {
		this.quiz_question_type = quiz_question_type;
	}
	public String getQuiz_question_item() {
		return quiz_question_item;
	}
	public void setQuiz_question_item(String quiz_question_item) {
		this.quiz_question_item = quiz_question_item;
	}

	public String getQuiz_question_answer() {
		return quiz_question_answer;
	}

	public void setQuiz_question_answer(String quiz_question_answer) {
		this.quiz_question_answer = quiz_question_answer;
	}
}

