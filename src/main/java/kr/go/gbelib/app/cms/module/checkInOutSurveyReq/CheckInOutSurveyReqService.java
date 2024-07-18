package kr.go.gbelib.app.cms.module.checkInOutSurveyReq;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.checkInOutSurvey.CheckInOutSurvey;
import kr.go.gbelib.app.cms.module.checkInOutSurvey.CheckInOutSurveyService;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestion;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestionService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CheckInOutSurveyReqService extends BaseService {
	
	@Autowired
	private CheckInOutSurveyReqDao checkInOutSurveyReqDao;

	public List<CheckInOutSurveyReq> getQuizReqList(CheckInOutSurveyReq checkInOutSurveyReq) {
		return checkInOutSurveyReqDao.getQuizReqList(checkInOutSurveyReq);
	}

	public List<CheckInOutSurveyReq> getQuizReqListAll(CheckInOutSurveyReq checkInOutSurveyReq) {
		return checkInOutSurveyReqDao.getQuizReqListAll(checkInOutSurveyReq);
	}
	
	public int getQuizReqListCount(CheckInOutSurveyReq checkInOutSurveyReq) {
		return checkInOutSurveyReqDao.getQuizReqListCount(checkInOutSurveyReq);
	}

	public int addQuizReq(CheckInOutSurveyReq checkInOutSurveyReq) {
		return checkInOutSurveyReqDao.addQuizReq(checkInOutSurveyReq);
	}

	public List<CheckInOutSurveyReq> getSurveyReqList(CheckInOutSurveyReq checkInOutSurveyReq) {
		return checkInOutSurveyReqDao.getSurveyReqList(checkInOutSurveyReq);
	}
}