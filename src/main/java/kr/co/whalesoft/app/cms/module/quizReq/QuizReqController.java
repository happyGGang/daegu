package kr.co.whalesoft.app.cms.module.quizReq;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.module.quiz.Quiz;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestion;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestionService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/module/quizReq"})
public class QuizReqController extends BaseController {

	private final String basePath = "/cms/module/quizReq/";

	@Autowired
	private QuizReqService quizReqService;
	
	@Autowired
	private QuizQuestionService quizQuestionService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, QuizReq quizReq, HttpServletRequest request) {
		quizReq.setHomepage_id(getAsideHomepageId(request));	
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Quiz quiz) {
		if(quiz.getEditMode().equals("MODIFY")) {

		} else {
			model.addAttribute("quiz", quiz);
		}
		
		model.addAttribute("quizTypeList", codeService.getCode(quiz.getHomepage_id(), "H0003"));
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Quiz quiz, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = quiz.getEditMode();
		
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
	public QuizReqSearchView excel(Model model, QuizReq quizReq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		int count = quizReqService.getQuizReqListCount(quizReq);
		quizReqService.setPaging(model, count, quizReq);
		
		List<QuizReq> quizQuestionResult = quizReqService.getQuizReqListAll(quizReq);
		List<QuizQuestion> quizQuestionsList = quizQuestionService.getQuizQuestionList(new QuizQuestion(quizReq.getHomepage_id(), quizReq.getQuiz_idx()));
		
		quizQuestionResult = quizReqService.getWinnerCheckedList(quizQuestionResult, quizQuestionsList);
		
		model.addAttribute("quizReq", quizReq); 		
		model.addAttribute("quizQuestionResult", quizQuestionResult);
		model.addAttribute("quizQuestionList", quizQuestionsList);
		return new QuizReqSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, QuizReq quizReq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<QuizReq> quizQuestionResult = quizReqService.getQuizReqListAll(quizReq);
		List<QuizQuestion> quizQuestionsList = quizQuestionService.getQuizQuestionList(new QuizQuestion(quizReq.getHomepage_id(), quizReq.getQuiz_idx()));
		
		quizQuestionResult = quizReqService.getWinnerCheckedList(quizQuestionResult, quizQuestionsList);
		
		new QuizReqXlsToCsv(quizReq, quizQuestionResult, quizQuestionsList, request, response);
	}
	
}