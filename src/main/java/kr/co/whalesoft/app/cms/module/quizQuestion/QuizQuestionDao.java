package kr.co.whalesoft.app.cms.module.quizQuestion;

import java.util.List;

public interface QuizQuestionDao  {

	public List<QuizQuestion> getQuizQuestionList(QuizQuestion quizQuestion);
	
	public int getQuizQuestionListCount(QuizQuestion quizQuestion);
	
	public QuizQuestion getQuizQuestionOne(QuizQuestion quizQuestion);
	
	public int addQuizQuestion(QuizQuestion quizQuestion);
	
	public int modifyQuizQuestion(QuizQuestion quizQuestion);
	
	public int deleteQuizQuestion(QuizQuestion quizQuestion);
}