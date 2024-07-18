package kr.go.gbelib.app.cms.module.checkInOutSurveyReq;

import kr.go.gbelib.app.cms.module.checkInOutSurvey.CheckInOutSurvey;

import java.util.List;

public interface CheckInOutSurveyReqDao {

	public List<CheckInOutSurveyReq> getQuizReqList(CheckInOutSurveyReq checkInOutSurveyReq);
	
	public List<CheckInOutSurveyReq> getQuizReqListAll(CheckInOutSurveyReq checkInOutSurveyReq);
	
	public int getQuizReqListCount(CheckInOutSurveyReq checkInOutSurveyReq);

	public int addQuizReq(CheckInOutSurveyReq checkInOutSurveyReq);

	List<CheckInOutSurveyReq> getSurveyReqList(CheckInOutSurveyReq checkInOutSurveyReq);
}