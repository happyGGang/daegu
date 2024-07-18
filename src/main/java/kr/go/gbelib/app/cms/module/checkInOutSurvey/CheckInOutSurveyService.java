package kr.go.gbelib.app.cms.module.checkInOutSurvey;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestion;
import kr.go.gbelib.app.cms.module.checkInOutSurveyReq.CheckInOutSurveyReq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CheckInOutSurveyService extends BaseService {
	
	@Autowired
	private CheckInOutSurveyDao dao;

	public List<CheckInOutSurvey> getQuizList(CheckInOutSurvey checkInOutSurvey) {
		return dao.getQuizList(checkInOutSurvey);
	}
	
	public int getQuizListCount(CheckInOutSurvey checkInOutSurvey) {
		return dao.getQuizListCount(checkInOutSurvey);
	}
	
	public CheckInOutSurvey getQuizOne(CheckInOutSurvey checkInOutSurvey) {
		return dao.getQuizOne(checkInOutSurvey);
	}
	
	public int addQuiz(CheckInOutSurvey checkInOutSurvey) {
		return dao.addQuiz(checkInOutSurvey);
	}
	
	public int modifyQuiz(CheckInOutSurvey checkInOutSurvey) {
		return dao.modifyQuiz(checkInOutSurvey);
	}
	
	public int deleteQuiz(CheckInOutSurvey checkInOutSurvey) {
		return dao.deleteQuiz(checkInOutSurvey);
	}

	public boolean checkSurveyUseYn(CheckInOutSurvey checkInOutSurvey) {
		return dao.checkSurveyUseYn(checkInOutSurvey);
	}

	public CheckInOutSurvey getNowCheckInOutSurvey(CheckInOutSurvey checkInOutSurvey) {
		return dao.getNowCheckInOutSurvey(checkInOutSurvey);
	}

    public boolean checkSurveyExists(CheckInOutSurvey checkInOutSurvey) {
		return dao.checkSurveyExists(checkInOutSurvey);
    }

	public List<CheckInOutSurvey> getCheckInOutSurveyList(CheckInOutSurvey checkInOutSurvey) {
		return dao.getCheckInOutSurveyList(checkInOutSurvey);
	}
}