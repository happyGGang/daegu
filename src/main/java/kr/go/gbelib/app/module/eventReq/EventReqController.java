package kr.go.gbelib.app.module.eventReq;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.module.event.Event;
import kr.co.whalesoft.app.cms.module.event.EventService;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestion;
import kr.co.whalesoft.app.cms.module.eventQuestion.EventQuestionService;
import kr.co.whalesoft.app.cms.module.eventReq.EventReq;
import kr.co.whalesoft.app.cms.module.eventReq.EventReqService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import org.apache.commons.lang.StringUtils;
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

@Controller(value="userEventReq")
@RequestMapping(value = {"/{homepagePath}/module/eventReq"})
public class EventReqController extends BaseController {

	private String basePath = "/homepage/%s/module/eventReq/";

	@Autowired
	private EventService eventService;

	@Autowired
	private EventReqService eventReqService;

	@Autowired
	private EventQuestionService eventQuestionService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private TermsService termsService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, EventReq eventReq, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		eventReq.setHomepage_id(homepage.getHomepage_id());

/*		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			eventReq.setBefore_url(String.format("http://www.gbelib.kr/%s/module/eventReq/index.do?menu_idx=%s", homepage.getContext_path(), eventReq.getMenu_idx()));
			quizReqService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), eventReq.getMenu_idx(), eventReq.getBefore_url()), request, response);
			return null;
		}
*/
		List<Code> eventTypeList = codeService.getCode(homepage.getHomepage_id(), "H0004");
		// 등록된 퀴즈 타입이 있는지 확인
		if ( eventTypeList.size() > 0 ) {
			Menu menuOne = (Menu) request.getAttribute("menuOne");
			
			if("h1".equals(homepage.getHomepage_id())) {
				Terms t = new Terms();
				t.setHomepage_id(homepage.getHomepage_id());
				
				if(StringUtils.isEmpty(eventReq.getSearch_event_type()) || "1".equals(eventReq.getSearch_event_type()) || "2".equals(eventReq.getSearch_event_type())) {
					t.setTerms_idx(91);
					model.addAttribute("termsList", termsService.getTermsListOne(t));
				} else {
					t.setTerms_idx(92);
					model.addAttribute("termsList", termsService.getTermsListOne(t));
				}
			} else {
				Terms t = new Terms();
				t.setModule_idx(menuOne.getManage_idx());
				t.setHomepage_id(homepage.getHomepage_id());
				model.addAttribute("termsList", termsService.getTermsListInModule(t));
			}
			
			model.addAttribute("eventTypeList", eventTypeList);
			// 첫번째 퀴즈 타입의 해당하는 년,월 의 퀴즈를 가져옴.

			String searchEventType = "";
			if ( StringUtils.isEmpty(eventReq.getSearch_event_type()) ) {
				searchEventType = eventTypeList.get(0).getCode_id();
				eventReq.setSearch_event_type(searchEventType);
			}
			else {
				searchEventType = eventReq.getSearch_event_type();
			}

			Event event = eventService.getEventUser(new Event(homepage.getHomepage_id(), searchEventType, eventReq.getSearch_event_year(), eventReq.getSearch_event_month()));

			if ( event != null ) {
				// 퀴즈의 문항리스트를 가져옴
				eventReq.setEvent_idx(event.getEvent_idx());
				model.addAttribute("event", event);
				model.addAttribute("eventQuestionList", eventQuestionService.getEventQuestionList(new EventQuestion(homepage.getHomepage_id(), event.getEvent_idx())));
			}
			else {
				eventReq.setEvent_idx(0);
			}
		}
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("eventReq", eventReq);



		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, EventReq eventReq, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResponse res = new JsonResponse(request);
		String editMode = eventReq.getEditMode();

		if ( !eventReq.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "name", "이름을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "phone", "휴대전화번호를 입력하세요.");
			ValidationUtils.rejectPhone(result, "phone", "휴대전화번호 형식(01x-xxxx-xxxx)이 올바르지 않습니다.");
		}

		int matchLength = StringUtils.countMatches(eventReq.getEvent_answer(), "\\|") + 1;
		int answer_length = eventReq.getEvent_answer().split("\\|").length;
		if(matchLength - answer_length > 0) {
			int answer_num = answer_length + 1;
			result.reject(answer_num + "번 문항에 답하지 않으셨습니다.");
		}

		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				eventReq.setAdd_id(getSessionMemberId(request));
				if(eventService.getEventCntOfValidDate(eventReq) == 0) {
					res.setValid(false);
					res.setMessage("퀴즈 참여기간이 아닙니다.");
				} else if ( eventReqService.checkReqByMemberId(eventReq) > 0 ) {
					res.setValid(false);
					res.setMessage("퀴즈는 1회 참여만 가능 합니다.");
				} else {
					StringBuilder sb = new StringBuilder();
					sb.append(eventReq.getName() + "\n");
					sb.append(eventReq.getSchool() + "\n");
					sb.append(eventReq.getBan() + "\n");
					sb.append(eventReq.getEvent_answer() + "\n");
					String addResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", sb.toString());
					if (addResult != null) {
						res.setValid(true);
						res.setUrl(addResult);
						res.setTargetOpener(true);
						return res;
					}

					eventReqService.addeventReq(eventReq);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}