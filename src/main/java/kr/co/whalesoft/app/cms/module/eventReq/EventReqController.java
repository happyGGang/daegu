package kr.co.whalesoft.app.cms.module.eventReq;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.module.event.Event;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestion;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestionService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping(value = {"/cms/module/eventReq"})
public class EventReqController extends BaseController {

	private final String basePath = "/cms/module/eventReq/";

	@Autowired
	private EventReqService eventReqService;
	
	@Autowired
	private EventQuestionService eventQuestionService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, EventReq eventReq, HttpServletRequest request) {
		eventReq.setHomepage_id(getAsideHomepageId(request));	
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Event event) {
		if(event.getEditMode().equals("MODIFY")) {

		} else {
			model.addAttribute("event", event);
		}
		
		model.addAttribute("eventTypeList", codeService.getCode(event.getHomepage_id(), "H0003"));
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Event event, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = event.getEditMode();
		
		/*if ( !quiz.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "quiz_year", "퀴즈연도를 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "quiz_year", "퀴즈연도는 숫자만 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_month", "퀴즈월을 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "quiz_month", "퀴즈월은 숫자만 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "book_name", "책이름을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_start_date", "퀴즈시작날짜를 지정하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_end_date", "퀴즈종료날짜를 지정하세요.");
		}*/
		
		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public EventReqSearchView excel(Model model, EventReq eventReq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		int count = eventReqService.getEventReqListCount(eventReq);
		eventReqService.setPaging(model, count, eventReq);
		
		List<EventReq> eventQuestionResult = eventReqService.getEventReqListAll(eventReq);
		List<EventQuestion> eventQuestionsList = eventQuestionService.getEventQuestionList(new EventQuestion(eventReq.getHomepage_id(), eventReq.getEvent_idx()));

		eventQuestionResult = eventReqService.getWinnerCheckedList(eventQuestionResult, eventQuestionsList);
		
		model.addAttribute("eventReq", eventReq); 		
		model.addAttribute("eventQuestionResult", eventQuestionResult);
		model.addAttribute("eventQuestionList", eventQuestionsList);
		return new EventReqSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, EventReq eventReq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<EventReq> eventQuestionResult = eventReqService.getEventReqListAll(eventReq);
		List<EventQuestion> eventQuestionsList = eventQuestionService.getEventQuestionList(new EventQuestion(eventReq.getHomepage_id(), eventReq.getEvent_idx()));

		eventQuestionResult = eventReqService.getWinnerCheckedList(eventQuestionResult, eventQuestionsList);
		
		new EventReqXlsToCsv(eventReq, eventQuestionResult, eventQuestionsList, request, response);
	}
	
}