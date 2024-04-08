package kr.co.whalesoft.app.cms.module.quizReq;

import java.util.List;

import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.app.cms.module.quiz.Quiz;
import kr.co.whalesoft.app.cms.module.quiz.QuizService;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestion;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestionService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class QuizReqService extends BaseService {
	
	@Autowired
	private QuizReqDao quizReqDao;
	
	@Autowired
	private QuizQuestionService quizQuestionService;
	
	@Autowired
	private QuizService quizService;

	@WorkingLogger(comment="독서퀴즈 응모자  관리 조회", type="P")
	public List<QuizReq> getQuizReqList(QuizReq quizReq) {
		return quizReqDao.getQuizReqList(quizReq);
	}

	@WorkingLogger(comment="독서퀴즈 응모자  관리 엑셀 저장", type="P")
	public List<QuizReq> getQuizReqListAll(QuizReq quizReq) {
		return quizReqDao.getQuizReqListAll(quizReq);
	}
	
	public List<QuizReq> getShuffledQuizReqList(QuizReq quizReq) {
		return quizReqDao.getShuffledQuizReqList(quizReq);
	}
	
	public int getQuizReqListCount(QuizReq quizReq) {
		return quizReqDao.getQuizReqListCount(quizReq);
	}
	
	public List<QuizReq> getWinnerCheckedList(List<QuizReq> quizReqList, List<QuizQuestion> quizQuestionList) {
		for ( QuizReq org : quizReqList ) {
			String winnerYn = "Y";
			int quizQuestionListSize = quizQuestionList.size();
			
			if ( StringUtils.isEmpty(org.getQuiz_answer()) ) {
				winnerYn = "N";
			} else {
				String[] answerList = org.getQuiz_answer().split("\\|");
				int answerListSize = answerList.length;
				
				for(int j=0; j < quizQuestionListSize; j++) {
					if(j >= answerListSize) {
						winnerYn = "N";
						break;
					}
					
					String answer = StringUtils.deleteWhitespace(answerList[j]);
					QuizQuestion quizQuestion = quizQuestionList.get(j);
					String quiz_question_answer = StringUtils.deleteWhitespace(quizQuestion.getQuiz_question_answer());
					
					if(StringUtils.isEmpty(quiz_question_answer) || StringUtils.isEmpty(answer)) {
						winnerYn = "N";
					} else if(!StringUtils.equals(quiz_question_answer, answer)) {
						winnerYn = "N";
					}
				}
			}
			
			org.setWinner_yn(winnerYn);
		}
		
		return quizReqList;
	}
	
	public List<QuizReq> getReWinnerCheckedList(List<QuizReq> quizReqList, List<QuizQuestion> quizQuestionList) {
		for ( QuizReq org : quizReqList ) {
			String winnerYn = "Y";
			int quizQuestionListSize = quizQuestionList.size();
			
			if ( StringUtils.isEmpty(org.getQuiz_answer()) ) {
				winnerYn = "N";
			} else {
				String[] answerList = org.getQuiz_answer().split("\\|");
				int answerListSize = answerList.length;
				
				for(int j=0; j < quizQuestionListSize; j++) {
					if(j >= answerListSize) {
						winnerYn = "N";
						break;
					}
					
					String answer = StringUtils.deleteWhitespace(answerList[j]);
					QuizQuestion quizQuestion = quizQuestionList.get(j);
					String quiz_question_answer = StringUtils.deleteWhitespace(quizQuestion.getQuiz_question_answer());
					
					if(StringUtils.isEmpty(quiz_question_answer) || StringUtils.isEmpty(answer)) {
						winnerYn = "N";
					} else if(!StringUtils.equals(quiz_question_answer, answer)) {
						winnerYn = "N";
					}
				}
			}
			
			org.setWinner_yn(winnerYn);
		}
		
		return quizReqList;
	}
	
	public int getQuizReqWinnerListCount(QuizReq quizReq) {
		int winnerCount = 0;
		List<QuizReq> quizReqList = quizReqDao.getQuizReqListAll(quizReq);
		List<QuizQuestion> quizQuestionList = quizQuestionService.getQuizQuestionList(new QuizQuestion(quizReq.getHomepage_id(), quizReq.getQuiz_idx()));

		quizReqList = getWinnerCheckedList(quizReqList, quizQuestionList);
		
		for(QuizReq org: quizReqList) {
			if("Y".equals(org.getWinner_yn())) {
				winnerCount++;
			}
		}
		
		return winnerCount;
	}
	
	public int getQuizReqReWinnerListCount(QuizReq quizReq) {
		int winnerCount = 0;
		List<QuizReq> quizReqList = quizReqDao.getReQuizReqListAll(quizReq);
		List<QuizQuestion> quizQuestionList = quizQuestionService.getQuizQuestionList(new QuizQuestion(quizReq.getHomepage_id(), quizReq.getQuiz_idx()));

		quizReqList = getReWinnerCheckedList(quizReqList, quizQuestionList);
		
		for(QuizReq org: quizReqList) {
			if("Y".equals(org.getWinner_yn())) {
				winnerCount++;
			}
		}
		
		return winnerCount;
	}
	
	@Transactional
	public int updateChosenYn(int max, QuizReq quizReq) {
		int result = 0;
		List<QuizReq> quizReqList = quizReqDao.getShuffledQuizReqList(quizReq);
		List<QuizQuestion> quizQuestionList = quizQuestionService.getQuizQuestionList(new QuizQuestion(quizReq.getHomepage_id(), quizReq.getQuiz_idx()));

		quizReqList = getWinnerCheckedList(quizReqList, quizQuestionList);
		
		for(QuizReq org: quizReqList) {
			if(result >= max) {
				break;
			}
			
			if("Y".equals(org.getWinner_yn())) {
				org.setChosen_yn("Y");
				result += quizReqDao.modifyChosenYn(org);
			}
		}
		
		Quiz quiz = new Quiz();
		quiz.setHomepage_id(quizReq.getHomepage_id());
		quiz.setQuiz_idx(quizReq.getQuiz_idx());
		quizService.increaseSelectCnt(quiz);
		
		return result;
	}
	
	@Transactional
	public int reUpdateChosenYn(int max, QuizReq quizReq) {
		int result = 0;
		List<QuizReq> quizReqList = quizReqDao.getReShuffledQuizReqList(quizReq);
		List<QuizQuestion> quizQuestionList = quizQuestionService.getQuizQuestionList(new QuizQuestion(quizReq.getHomepage_id(), quizReq.getQuiz_idx()));

		quizReqList = getReWinnerCheckedList(quizReqList, quizQuestionList);
		
		for(QuizReq org: quizReqList) {
			if(result >= max) {
				break;
			}
			
			if("Y".equals(org.getWinner_yn())) {
				org.setChosen_yn("Y");
				result += quizReqDao.modifyChosenYn(org);
			}
		}
		
		Quiz quiz = new Quiz();
		quiz.setHomepage_id(quizReq.getHomepage_id());
		quiz.setQuiz_idx(quizReq.getQuiz_idx());
		quizService.increaseReSelectCnt(quiz);
		
		return result;
	}
	
	public int modifyChosenYn(QuizReq quizReq) {
		return quizReqDao.modifyChosenYn(quizReq);
	}

	public QuizReq getQuizReqOne(QuizReq quizReq) {
		return quizReqDao.getQuizReqOne(quizReq);
	}
	
	public int addQuizReq(QuizReq quizReq) {
		return quizReqDao.addQuizReq(quizReq);
	}
	
	public int modifyWinner(QuizReq quizReq) {
		return quizReqDao.modifyWinner(quizReq);
	}
	
	public int checkReqByMemberId(QuizReq quizReq) {
		return quizReqDao.checkReqByMemberId(quizReq);
	}

	@WorkingLogger(comment="독서퀴즈 응모자  관리 개인정보 삭제", type="P")
	public int deletePersonalData(QuizReq quizReq) {
		return quizReqDao.deletePersonalData(quizReq);
	}

	public QuizReq getQuizReqDownOne(QuizReq quizReq) {
        return quizReqDao.getQuizReqOne(quizReq);
	}

}