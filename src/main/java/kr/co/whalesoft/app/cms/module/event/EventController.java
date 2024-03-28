package kr.co.whalesoft.app.cms.module.event;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestion;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestionService;
import kr.co.whalesoft.app.cms.module.eventReq.EventReq;
import kr.co.whalesoft.app.cms.module.eventReq.EventReqService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@Controller
@RequestMapping(value = {"/cms/module/event"})
public class EventController extends BaseController {

	private final String basePath = "/cms/module/event/";

	@Autowired
	private EventService service;
	
	@Autowired
	private EventQuestionService eventQuestionService;
	
	@Autowired
	private EventReqService eventReqService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Event event, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
		event.setHomepage_id(getAsideHomepageId(request));
//		}
		
		int count = service.getEventListCount(event);
		service.setPaging(model, count, event);
		model.addAttribute("event", event);
		model.addAttribute("eventListCount", count);
		model.addAttribute("eventList", service.getEventList(event));
//		Map<String, Code> codeRepo = new HashMap<String, Code>();
//		for ( Code one : codeService.getCode(quiz.getHomepage_id(), "H0003") ) {
//			codeRepo.put(one.getCode_id(), one);
//		}
//		model.addAttribute("quizTypeList", codeRepo);
		model.addAttribute("eventTypeList", codeService.getCode(event.getHomepage_id(), "H0003"));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Event event, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		if (homepage == null) {
			//cms에서는 homepage 객체가 없어서 따로 가져옴.
			Homepage homepageOne = homepageService.getHomepageOne(new Homepage(event.getHomepage_id()));
			model.addAttribute("homepage", homepageOne);
		}
		if(event.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("event", service.copyObjectPaging(event, service.getEventOne(event)));
		} else {
			event.setEvent_year(Calendar.getInstance().get(Calendar.YEAR));
			event.setEvent_month(Calendar.getInstance().get(Calendar.MONTH) + 1);
			
			checkAuth("C", model, request);
			model.addAttribute("event", event);
		}
		
		model.addAttribute("eventTypeList", codeService.getCode(event.getHomepage_id(), "H0003"));
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Event event, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = event.getEditMode();
		
		if ( !event.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "event_year", "이벤트 연도를 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "event_year", "이벤트 연도는 숫자만 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "event_month", "이벤트 월을 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "event_month", "이벤트 월은 숫자만 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "event_type", "이벤트 구분을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "event_name", "이벤트 제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "event_start_date", "이벤트 시작날짜를 지정하세요.");
			ValidationUtils.rejectIfEmpty(result, "event_end_date", "이벤트 종료날짜를 지정하세요.");
			
			try {
    			SimpleDateFormat event_year = new SimpleDateFormat("yyyy");
				event_year.setLenient(false);
				event_year.parse(String.valueOf(event.getEvent_year()));
			} catch(ParseException e) {
				result.rejectValue("event_year", "이벤트연도 yyyy 형식이 맞지 않습니다.");
			}
			
			try {
    			SimpleDateFormat event_month = new SimpleDateFormat("MM");
				event_month.setLenient(false);
				event_month.parse(String.valueOf(event.getEvent_month()));
			} catch(ParseException e) {
				result.rejectValue("event_month", "이벤트연도 MM 형식이 맞지 않습니다.");
			}
		}
		
		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				
				int alreadyCount = service.getAreadyEventOne(event);
				if (alreadyCount >= 1) {
					res.setMessage("해당연도에 동일한 타입이 존재합니다.");
					res.setValid(false);
				} else {
					event.setAdd_id(getSessionMemberId(request));
					service.addEvent(event);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}
			} else if(editMode.equals("MODIFY")) {
				event.setModify_id(getSessionMemberId(request));
				service.modifyEvent(event);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteEvent(event);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/editQuestion.*"})
	public String edit(Model model, EventQuestion eventQuestion) {
		Event event = new Event();
		event.setHomepage_id(eventQuestion.getHomepage_id());
		event.setEvent_idx(eventQuestion.getEvent_idx());
		event = service.getEventOne(event);
		
		model.addAttribute("event", event);
		model.addAttribute("eventQuestion", eventQuestion);
		model.addAttribute("eventQuestionList", eventQuestionService.getEventQuestionList(eventQuestion));
		return basePath + "editQuestion_ajax";
	}
	
	@RequestMapping(value = {"/saveQuestion.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveQuestion(Model model, EventQuestion eventQuestion, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		Event event = new Event();
		event.setHomepage_id(eventQuestion.getHomepage_id());
		event.setEvent_idx(eventQuestion.getEvent_idx());
		event = service.getEventOne(event);
		
		if(event == null) {
			result.reject("오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
		} else if(event.getSelect_cnt() > 0) {
			result.reject("당첨자 추첨이 완료된 상태입니다. 당첨자가 선정이 되면 문항을 수정할 수 없습니다.");
		}
		
		String editMode = eventQuestion.getEditMode();
		
		if ( !eventQuestion.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "event_question_title", "퀴즈 제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "event_question_type", "퀴즈 타입을 선택하세요.");
		}
		
		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				eventQuestionService.addEventQuestion(eventQuestion);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				eventQuestionService.modifyEventQuestion(eventQuestion);
				res.setValid(true);
				//res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				eventQuestionService.deleteEventQuestion(eventQuestion);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/reqList.*"})
	public String reqList(Model model, EventReq eventReq, HttpServletRequest request) {
		//quizReq.setHomepage_id(getSessionHomepageId(request));

		int count = eventReqService.getEventReqListCount(eventReq);
		int winnerCount = eventReqService.getEventReqWinnerListCount(eventReq);
		int reWinnerCount = eventReqService.getEventReqReWinnerListCount(eventReq);
		
		eventReqService.setPaging(model, count, eventReq);
		
		List<EventReq> eventReqList = eventReqService.getEventReqList(eventReq);
		List<EventQuestion> eventQuestionList = eventQuestionService.getEventQuestionList(new EventQuestion(eventReq.getHomepage_id(), eventReq.getEvent_idx()));

		eventReqList = eventReqService.getWinnerCheckedList(eventReqList, eventQuestionList);
		
		model.addAttribute("event", service.getEventOne(new Event(eventReq.getHomepage_id(), eventReq.getEvent_idx())));
		model.addAttribute("eventQuestionList", eventQuestionList);
		model.addAttribute("eventReq", eventReq);
		model.addAttribute("eventReqCount", count);
		model.addAttribute("winnerCount", winnerCount);
		model.addAttribute("reWinnerCount", reWinnerCount);
		model.addAttribute("eventReqList", eventReqList);
		
		return basePath + "reqList_ajax";
	}
	
	@RequestMapping(value = {"/saveWinner.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveWinner(Model model, EventReq eventReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			eventReqService.modifyWinner(eventReq);
			res.setValid(true);
			res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/shuffle.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse shuffle(Model model, @RequestParam(defaultValue = "0") int max, EventReq event, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			eventReqService.updateChosenYn(max, event);
			res.setValid(true);
			res.setMessage("당첨자 선정이 완료됐습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/reShuffle.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse reShuffle(Model model, @RequestParam(defaultValue = "0") int max, EventReq eventReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			eventReqService.reUpdateChosenYn(max, eventReq);
			res.setValid(true);
			res.setMessage("당첨자 재 추첨이 완료됐습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/deletePersonalData.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deletePersonalData(Model model, EventReq eventReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			eventReqService.deletePersonalData(eventReq);
			res.setValid(true);
			res.setMessage("개인정보 삭제가 완료됐습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
}