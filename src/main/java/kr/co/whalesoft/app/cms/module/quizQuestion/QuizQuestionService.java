package kr.co.whalesoft.app.cms.module.quizQuestion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class QuizQuestionService extends BaseService {
	
	@Autowired
	private QuizQuestionDao quizQuestionDao;
	
	public List<QuizQuestion> getQuizQuestionList(QuizQuestion quizQuestion) {
		return quizQuestionDao.getQuizQuestionList(quizQuestion);
	}
	
	public int getQuizQuestionListCount(QuizQuestion quizQuestion) {
		return quizQuestionDao.getQuizQuestionListCount(quizQuestion);
	}
	
	public QuizQuestion getQuizQuestionOne(QuizQuestion quizQuestion) {
		return quizQuestionDao.getQuizQuestionOne(quizQuestion);
	}
	
	public int addQuizQuestion(QuizQuestion quizQuestion) {
		return quizQuestionDao.addQuizQuestion(quizQuestion);
	}
	
	public int modifyQuizQuestion(QuizQuestion quizQuestion) {
		return quizQuestionDao.modifyQuizQuestion(quizQuestion);
	}
	
	public int deleteQuizQuestion(QuizQuestion quizQuestion) {
		return quizQuestionDao.deleteQuizQuestion(quizQuestion);
	}
}