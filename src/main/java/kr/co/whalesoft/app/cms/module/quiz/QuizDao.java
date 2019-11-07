package kr.co.whalesoft.app.cms.module.quiz;

import java.util.List;

import kr.co.whalesoft.app.cms.module.quizReq.QuizReq;

public interface QuizDao  {

	public List<Quiz> getQuizList(Quiz quiz);
	
	public List<Quiz> getQuizListAll(Quiz quiz);
	
	public int getQuizListCount(Quiz quiz);
	
	public Quiz getQuizOne(Quiz quiz);
	
	public int addQuiz(Quiz quiz);
	
	public int modifyQuiz(Quiz quiz);
	
	public int deleteQuiz(Quiz quiz);
	
	public Quiz getQuizUser(Quiz quiz);

	public int getAreadyQuizOne(Quiz quiz);
	
	public int getQuizCntOfValidDate(QuizReq quizReq);
	
	public int increaseSelectCnt(Quiz quiz);
	
}