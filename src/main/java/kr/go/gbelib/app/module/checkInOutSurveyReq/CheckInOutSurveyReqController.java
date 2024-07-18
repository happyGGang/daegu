package kr.go.gbelib.app.module.checkInOutSurveyReq;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.module.quiz.Quiz;
import kr.co.whalesoft.app.cms.module.quiz.QuizService;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestion;
import kr.co.whalesoft.app.cms.module.quizQuestion.QuizQuestionService;
import kr.co.whalesoft.app.cms.module.quizReq.QuizReq;
import kr.co.whalesoft.app.cms.module.quizReq.QuizReqService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.cms.module.checkInOutSurveyReq.CheckInOutSurveyReq;
import kr.go.gbelib.app.cms.module.checkInOutSurveyReq.CheckInOutSurveyReqService;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

@Controller(value="userCheckInOutSurveyReq")
@RequestMapping(value = {"/{homepagePath}/module/checkInOutSurveyReq"})
public class CheckInOutSurveyReqController extends BaseController {

	@Autowired
	private CheckInOutSurveyReqService checkInOutSurveyReqService;

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, CheckInOutSurveyReq checkInOutSurveyReq, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResponse res = new JsonResponse(request);
		HttpSession session = request.getSession();
		Homepage homepage = getSessionHomepage(request);

		String message = checkInOutSurveyReq.getCheckOut_msg();

		if (!result.hasErrors()) {
			checkInOutSurveyReqService.addQuizReq(checkInOutSurveyReq);
			res.setValid(true);

			checkInOutSurveyReqService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), message, String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		} else {
			checkInOutSurveyReqService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), "설문조사에 문제가 발생하였습니다. 관리자에게 문의해주세요.", String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		}
	}
}