package kr.co.whalesoft.app.cms.module.quiz;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestion;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestionService;
import kr.co.whalesoft.app.cms.module.quizReq.QuizReq;
import kr.co.whalesoft.app.cms.module.quizReq.QuizReqService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/quiz"})
public class QuizController extends BaseController {

	private final String basePath = "/cms/module/quiz/";

	@Autowired
	private QuizService service;
	
	@Autowired
	private QuizQuestionService quizQuestionService;
	
	@Autowired
	private QuizReqService quizReqService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Quiz quiz, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			quiz.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		int count = service.getQuizListCount(quiz);
		service.setPaging(model, count, quiz);
		model.addAttribute("quiz", quiz);
		model.addAttribute("quizListCount", count);
		model.addAttribute("quizList", service.getQuizList(quiz));
//		Map<String, Code> codeRepo = new HashMap<String, Code>();
//		for ( Code one : codeService.getCode(quiz.getHomepage_id(), "H0003") ) {
//			codeRepo.put(one.getCode_id(), one);
//		}
//		model.addAttribute("quizTypeList", codeRepo);
		model.addAttribute("quizTypeList", codeService.getCode(quiz.getHomepage_id(), "H0003"));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Quiz quiz, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		if (homepage == null) {
			//cms에서는 homepage 객체가 없어서 따로 가져옴.
			Homepage homepageOne = homepageService.getHomepageOne(new Homepage(quiz.getHomepage_id()));
			model.addAttribute("homepage", homepageOne);
		}
		if(quiz.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("quiz", service.copyObjectPaging(quiz, service.getQuizOne(quiz)));
		} else {
			quiz.setQuiz_year(Calendar.getInstance().get(Calendar.YEAR));
			quiz.setQuiz_month(Calendar.getInstance().get(Calendar.MONTH) + 1);
			
			checkAuth("C", model, request);
			model.addAttribute("quiz", quiz);
		}
		
		model.addAttribute("quizTypeList", codeService.getCode(quiz.getHomepage_id(), "H0003"));
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Quiz quiz, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = quiz.getEditMode();
		
		if ( !quiz.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "quiz_year", "퀴즈연도를 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "quiz_year", "퀴즈연도는 숫자만 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_month", "퀴즈월을 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "quiz_month", "퀴즈월은 숫자만 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_type", "퀴즈구분을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_name", "퀴즈제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_start_date", "퀴즈시작날짜를 지정하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_end_date", "퀴즈종료날짜를 지정하세요.");
			
			try {
    			SimpleDateFormat quiz_year = new SimpleDateFormat("yyyy");
    			quiz_year.setLenient(false);
    			quiz_year.parse(String.valueOf(quiz.getQuiz_year()));
			} catch(ParseException e) {
				result.rejectValue("quiz_year", "퀴즈연도 yyyy 형식이 맞지 않습니다.");
			}
			
			try {
    			SimpleDateFormat quiz_month = new SimpleDateFormat("MM");
    			quiz_month.setLenient(false);
    			quiz_month.parse(String.valueOf(quiz.getQuiz_month()));
			} catch(ParseException e) {
				result.rejectValue("quiz_month", "퀴즈연도 MM 형식이 맞지 않습니다.");
			}
		}
		
		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				
				int alreadyCount = service.getAreadyQuizOne(quiz);
				if (alreadyCount >= 1) {
					res.setMessage("해당연도에 동일한 타입이 존재합니다.");
					res.setValid(false);
				} else {
					quiz.setAdd_id(getSessionMemberId(request));
					service.addQuiz(quiz);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}
			} else if(editMode.equals("MODIFY")) {
				quiz.setModify_id(getSessionMemberId(request));
				service.modifyQuiz(quiz);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteQuiz(quiz);
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
	public String edit(Model model, QuizQuestion quizQuestion) {
		Quiz quiz = new Quiz();
		quiz.setHomepage_id(quizQuestion.getHomepage_id());
		quiz.setQuiz_idx(quizQuestion.getQuiz_idx());
		quiz = service.getQuizOne(quiz);
		
		model.addAttribute("quiz", quiz);
		model.addAttribute("quizQuestion", quizQuestion);
		model.addAttribute("quizQuestionList", quizQuestionService.getQuizQuestionList(quizQuestion));
		return basePath + "editQuestion_ajax";
	}
	
	@RequestMapping(value = {"/saveQuestion.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveQuestion(Model model, QuizQuestion quizQuestion, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		Quiz quiz = new Quiz();
		quiz.setHomepage_id(quizQuestion.getHomepage_id());
		quiz.setQuiz_idx(quizQuestion.getQuiz_idx());
		quiz = service.getQuizOne(quiz);
		
		if(quiz == null) {
			result.reject("오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
		} else if(quiz.getSelect_cnt() > 0) {
			result.reject("당첨자 추첨이 완료된 상태입니다. 당첨자가 선정이 되면 문항을 수정할 수 없습니다.");
		}
		
		String editMode = quizQuestion.getEditMode();
		
		if ( !quizQuestion.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "quiz_question_title", "퀴즈 제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "quiz_question_type", "퀴즈 타입을 선택하세요.");
		}
		
		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				quizQuestionService.addQuizQuestion(quizQuestion);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				quizQuestionService.modifyQuizQuestion(quizQuestion);
				res.setValid(true);
				//res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				quizQuestionService.deleteQuizQuestion(quizQuestion);
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
	public String reqList(Model model, QuizReq quizReq, HttpServletRequest request) {
		//quizReq.setHomepage_id(getSessionHomepageId(request));

		int count = quizReqService.getQuizReqListCount(quizReq);
		int winnerCount = quizReqService.getQuizReqWinnerListCount(quizReq);
		int reWinnerCount = quizReqService.getQuizReqReWinnerListCount(quizReq);
		
		quizReqService.setPaging(model, count, quizReq);
		
		List<QuizReq> quizReqList = quizReqService.getQuizReqList(quizReq);
		List<QuizQuestion> quizQuestionList = quizQuestionService.getQuizQuestionList(new QuizQuestion(quizReq.getHomepage_id(), quizReq.getQuiz_idx()));
		
		quizReqList = quizReqService.getWinnerCheckedList(quizReqList, quizQuestionList);
		
		model.addAttribute("quiz", service.getQuizOne(new Quiz(quizReq.getHomepage_id(), quizReq.getQuiz_idx())));
		model.addAttribute("quizQuestionList", quizQuestionList);
		model.addAttribute("quizReq", quizReq);
		model.addAttribute("quizReqCount", count);
		model.addAttribute("winnerCount", winnerCount);
		model.addAttribute("reWinnerCount", reWinnerCount);
		model.addAttribute("quizReqList", quizReqList);
		
		return basePath + "reqList_ajax";
	}
	
	@RequestMapping(value = {"/saveWinner.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveWinner(Model model, QuizReq quizReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			quizReqService.modifyWinner(quizReq);
			res.setValid(true);
			res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/shuffle.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse shuffle(Model model, @RequestParam(defaultValue = "0") int max, QuizReq quizReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			quizReqService.updateChosenYn(max, quizReq);
			res.setValid(true);
			res.setMessage("당첨자 선정이 완료됐습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/reShuffle.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse reShuffle(Model model, @RequestParam(defaultValue = "0") int max, QuizReq quizReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			quizReqService.reUpdateChosenYn(max, quizReq);
			res.setValid(true);
			res.setMessage("당첨자 재 추첨이 완료됐습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/deletePersonalData.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deletePersonalData(Model model, QuizReq quizReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			quizReqService.deletePersonalData(quizReq);
			res.setValid(true);
			res.setMessage("개인정보 삭제가 완료됐습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
}