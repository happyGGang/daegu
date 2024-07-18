package kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion;

import java.util.List;

public interface CheckInOutSurveyQuestionDao {

	public List<CheckInOutSurveyQuestion> getQuizQuestionList(CheckInOutSurveyQuestion checkInOutSurveyQuestion);
	
	public int addQuizQuestion(CheckInOutSurveyQuestion checkInOutSurveyQuestion);
	
	public int modifyQuizQuestion(CheckInOutSurveyQuestion checkInOutSurveyQuestion);
	
	public int deleteQuizQuestion(CheckInOutSurveyQuestion checkInOutSurveyQuestion);

	public int deleteFile(CheckInOutSurveyQuestion checkInOutSurveyQuestion);

	CheckInOutSurveyQuestion getCheckInOutSurveyQuestionOne(CheckInOutSurveyQuestion checkInOutSurveyQuestion);
}