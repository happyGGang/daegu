package kr.co.whalesoft.app.cms.module.quizReq;

import java.util.List;

public interface QuizReqDao  {

	public List<QuizReq> getQuizReqList(QuizReq quizReq);
	
	public List<QuizReq> getQuizReqListAll(QuizReq quizReq);
	
	public List<QuizReq> getShuffledQuizReqList(QuizReq quizReq);

	public List<QuizReq> getReShuffledQuizReqList(QuizReq quizReq);
	
	public int getQuizReqListCount(QuizReq quizReq);
	
	public int getQuizReqWinnerListCount(QuizReq quizReq);
	
	public int modifyChosenYn(QuizReq quizReq);

	public QuizReq getQuizReqOne(QuizReq quizReq);
	
	public int addQuizReq(QuizReq quizReq);
	
	public int modifyWinner(QuizReq quizReq);

	public int checkReqByMemberId(QuizReq quizReq);
	
	public int deletePersonalData(QuizReq quizReq);

	public List<QuizReq> getReQuizReqListAll(QuizReq quizReq);
}