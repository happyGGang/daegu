package kr.go.gbelib.app.cms.module.checkInOutSurvey;

import kr.go.gbelib.app.cms.module.checkInOutSurveyReq.CheckInOutSurveyReq;

import java.util.List;

public interface CheckInOutSurveyDao {

	public List<CheckInOutSurvey> getQuizList(CheckInOutSurvey checkInOutSurvey);
	
	public int getQuizListCount(CheckInOutSurvey checkInOutSurvey);
	
	public CheckInOutSurvey getQuizOne(CheckInOutSurvey checkInOutSurvey);
	
	public int addQuiz(CheckInOutSurvey checkInOutSurvey);
	
	public int modifyQuiz(CheckInOutSurvey checkInOutSurvey);
	
	public int deleteQuiz(CheckInOutSurvey checkInOutSurvey);

	public boolean checkSurveyUseYn(CheckInOutSurvey checkInOutSurvey);

	public CheckInOutSurvey getNowCheckInOutSurvey(CheckInOutSurvey checkInOutSurvey);

	public boolean checkSurveyExists(CheckInOutSurvey checkInOutSurvey);

	public List<CheckInOutSurvey> getCheckInOutSurveyList(CheckInOutSurvey checkInOutSurvey);
}