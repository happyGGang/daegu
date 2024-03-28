package kr.co.whalesoft.app.cms.module.eventReq;

import kr.co.whalesoft.app.cms.module.event.Event;
import kr.co.whalesoft.app.cms.module.event.EventService;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestion;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestionService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class EventReqService extends BaseService {
	
	@Autowired
	private EventReqDao eventReqDao;
	
	@Autowired
	private EventQuestionService eventQuestionService;
	
	@Autowired
	private EventService eventService;

	@WorkingLogger(comment="독서퀴즈 응모자  관리 조회", type="P")
	public List<EventReq> getEventReqList(EventReq eventReq) {
		return eventReqDao.getEventReqList(eventReq);
	}

	@WorkingLogger(comment="독서퀴즈 응모자  관리 엑셀 저장", type="P")
	public List<EventReq> getEventReqListAll(EventReq eventReq) {
		return eventReqDao.getEventReqListAll(eventReq);
	}
	
	public List<EventReq> getShuffledeventReqList(EventReq eventReq) {
		return eventReqDao.getShuffledeventReqList(eventReq);
	}
	
	public int getEventReqListCount(EventReq eventReq) {
		return eventReqDao.getEventReqListCount(eventReq);
	}
	
	public List<EventReq> getWinnerCheckedList(List<EventReq> eventReqList, List<EventQuestion> eventQuestionList) {
		for ( EventReq org : eventReqList ) {
			String winnerYn = "Y";
			int eventQuestionListSize = eventQuestionList.size();
			
			if ( StringUtils.isEmpty(org.getEvent_answer()) ) {
				winnerYn = "N";
			} else {
				String[] answerList = org.getEvent_answer().split("\\|");
				int answerListSize = answerList.length;
				
				for(int j=0; j < eventQuestionListSize; j++) {
					if(j >= answerListSize) {
						winnerYn = "N";
						break;
					}
					
					String answer = StringUtils.deleteWhitespace(answerList[j]);
					EventQuestion eventQuestion = eventQuestionList.get(j);
					String event_question_answer = StringUtils.deleteWhitespace(eventQuestion.getEvent_question_answer());
					
					if(StringUtils.isEmpty(event_question_answer) || StringUtils.isEmpty(answer)) {
						winnerYn = "N";
					} else if(!StringUtils.equals(event_question_answer, answer)) {
						winnerYn = "N";
					}
				}
			}
			
			org.setWinner_yn(winnerYn);
		}
		
		return eventReqList;
	}
	
	public List<EventReq> getReWinnerCheckedList(List<EventReq> eventReqList, List<EventQuestion> eventQuestionList) {
		for ( EventReq org : eventReqList ) {
			String winnerYn = "Y";
			int eventQuestionListSize = eventQuestionList.size();
			
			if ( StringUtils.isEmpty(org.getEvent_answer()) ) {
				winnerYn = "N";
			} else {
				String[] answerList = org.getEvent_answer().split("\\|");
				int answerListSize = answerList.length;
				
				for(int j=0; j < eventQuestionListSize; j++) {
					if(j >= answerListSize) {
						winnerYn = "N";
						break;
					}
					
					String answer = StringUtils.deleteWhitespace(answerList[j]);
					EventQuestion eventQuestion = eventQuestionList.get(j);
					String event_question_answer = StringUtils.deleteWhitespace(eventQuestion.getEvent_question_answer());
					
					if(StringUtils.isEmpty(event_question_answer) || StringUtils.isEmpty(answer)) {
						winnerYn = "N";
					} else if(!StringUtils.equals(event_question_answer, answer)) {
						winnerYn = "N";
					}
				}
			}
			
			org.setWinner_yn(winnerYn);
		}
		
		return eventReqList;
	}
	
	public int getEventReqWinnerListCount(EventReq eventReq) {
		int winnerCount = 0;
		List<EventReq> eventReqList = eventReqDao.getEventReqListAll(eventReq);
		List<EventQuestion> eventQuestionList = eventQuestionService.getEventQuestionList(new EventQuestion(eventReq.getHomepage_id(), eventReq.getEvent_idx()));

		eventReqList = getWinnerCheckedList(eventReqList, eventQuestionList);
		
		for(EventReq org: eventReqList) {
			if("Y".equals(org.getWinner_yn())) {
				winnerCount++;
			}
		}
		
		return winnerCount;
	}
	
	public int getEventReqReWinnerListCount(EventReq eventReq) {
		int winnerCount = 0;
		List<EventReq> eventReqList = eventReqDao.getReEventReqListAll(eventReq);
		List<EventQuestion> eventQuestionList = eventQuestionService.getEventQuestionList(new EventQuestion(eventReq.getHomepage_id(), eventReq.getEvent_idx()));

		eventReqList = getReWinnerCheckedList(eventReqList, eventQuestionList);
		
		for(EventReq org: eventReqList) {
			if("Y".equals(org.getWinner_yn())) {
				winnerCount++;
			}
		}
		
		return winnerCount;
	}
	
	@Transactional
	public int updateChosenYn(int max, EventReq eventReq) {
		int result = 0;
		List<EventReq> eventReqList = eventReqDao.getShuffledeventReqList(eventReq);
		List<EventQuestion> eventQuestionList = eventQuestionService.getEventQuestionList(new EventQuestion(eventReq.getHomepage_id(), eventReq.getEvent_idx()));

		eventReqList = getWinnerCheckedList(eventReqList, eventQuestionList);
		
		for(EventReq org: eventReqList) {
			if(result >= max) {
				break;
			}
			
			if("Y".equals(org.getWinner_yn())) {
				org.setChosen_yn("Y");
				result += eventReqDao.modifyChosenYn(org);
			}
		}
		
		Event event = new Event();
		event.setHomepage_id(eventReq.getHomepage_id());
		event.setEvent_idx(eventReq.getEvent_idx());
		eventService.increaseSelectCnt(event);
		
		return result;
	}
	
	@Transactional
	public int reUpdateChosenYn(int max, EventReq eventReq) {
		int result = 0;
		List<EventReq> eventReqList = eventReqDao.getReShuffledeventReqList(eventReq);
		List<EventQuestion> eventQuestionList = eventQuestionService.getEventQuestionList(new EventQuestion(eventReq.getHomepage_id(), eventReq.getEvent_idx()));

		eventReqList = getReWinnerCheckedList(eventReqList, eventQuestionList);
		
		for(EventReq org: eventReqList) {
			if(result >= max) {
				break;
			}
			
			if("Y".equals(org.getWinner_yn())) {
				org.setChosen_yn("Y");
				result += eventReqDao.modifyChosenYn(org);
			}
		}
		
		Event event = new Event();
		event.setHomepage_id(eventReq.getHomepage_id());
		event.setEvent_idx(eventReq.getEvent_idx());
		eventService.increaseReSelectCnt(event);

		return result;
	}
	
	public int modifyChosenYn(EventReq eventReq) {
		return eventReqDao.modifyChosenYn(eventReq);
	}

	public EventReq getEventReqOne(EventReq eventReq) {
		return eventReqDao.getEventReqOne(eventReq);
	}
	
	public int addeventReq(EventReq eventReq) {
		return eventReqDao.addeventReq(eventReq);
	}
	
	public int modifyWinner(EventReq eventReq) {
		return eventReqDao.modifyWinner(eventReq);
	}
	
	public int checkReqByMemberId(EventReq eventReq) {
		return eventReqDao.checkReqByMemberId(eventReq);
	}

	@WorkingLogger(comment="독서퀴즈 응모자  관리 개인정보 삭제", type="P")
	public int deletePersonalData(EventReq eventReq) {
		return eventReqDao.deletePersonalData(eventReq);
	}

}