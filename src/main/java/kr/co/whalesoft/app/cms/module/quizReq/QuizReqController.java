package kr.co.whalesoft.app.cms.module.quizReq;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

	@Autowired
	@Qualifier("quizReqStorage")
	private FileStorage quizReqStorage;
	
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

	@RequestMapping(value = "/download/{homepage_id}/{quiz_req_idx}.*", method = RequestMethod.GET)
	@ResponseBody
	public byte[] getFile(@PathVariable("homepage_id") String homepage_id,@PathVariable("quiz_req_idx") int quizReq_idx,
		@RequestParam(required=false, value="file_type") String file_type, HttpServletRequest request, HttpServletResponse response) throws Exception {
		QuizReq quizReq = new QuizReq();

		quizReq.setQuiz_idx(quizReq_idx);
		quizReq.setHomepage_id(homepage_id);
		quizReq = quizReqService.getQuizReqDownOne(quizReq);
		String serverName = "";
		String orgName = "";
		String extension = "";

		serverName = quizReq.getServer_file_name();
		orgName = quizReq.getOrigin_file_name();
		extension = quizReq.getFile_extension();
		String filePath = quizReqStorage.getRootPath()+ "/" + homepage_id + "/" + serverName;
		File file = new File(filePath);

		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			quizReqService.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

//		String fileName = "";
		String fileName = String.format("%s.%s", orgName, extension);

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", "application/octet-stream");

		return bytes;
	}
	
}