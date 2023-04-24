package kr.co.whalesoft.app.cms.module.quiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.module.quizReq.QuizReq;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class QuizService extends BaseService {
	
	@Autowired
	private QuizDao dao;
	
	public List<Quiz> getQuizListAll(Quiz quiz) {
		return dao.getQuizListAll(quiz);
	}

	public List<Quiz> getQuizList(Quiz quiz) {
		return dao.getQuizList(quiz);
	}
	
	public int getQuizListCount(Quiz quiz) {
		return dao.getQuizListCount(quiz);
	}
	
	@WorkingLogger(comment="독서퀴즈 응모자 관리 1건 조회", type="P")
	public Quiz getQuizOne(Quiz quiz) {
		return dao.getQuizOne(quiz);
	}
	
	public int addQuiz(Quiz quiz) {
		return dao.addQuiz(quiz);
	}
	
	public int modifyQuiz(Quiz quiz) {
		return dao.modifyQuiz(quiz);
	}
	
	public int deleteQuiz(Quiz quiz) {
		return dao.deleteQuiz(quiz);
	}
	
	public Quiz getQuizUser(Quiz quiz) {
		return dao.getQuizUser(quiz);
	}

	public int getAreadyQuizOne(Quiz quiz) {
		return dao.getAreadyQuizOne(quiz);
	}
	
	public int getQuizCntOfValidDate(QuizReq quizReq) {
		return dao.getQuizCntOfValidDate(quizReq);
	}
	
	public int increaseSelectCnt(Quiz quiz) {
		return dao.increaseSelectCnt(quiz);
	}

	public int increaseReSelectCnt(Quiz quiz) {
		return dao.increaseReSelectCnt(quiz);
	}
	
}