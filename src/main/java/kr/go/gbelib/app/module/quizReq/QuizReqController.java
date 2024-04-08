package kr.go.gbelib.app.module.quizReq;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.framework.file.FileStorage;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import org.springframework.web.multipart.MultipartFile;

@Controller(value="userQuizReq")
@RequestMapping(value = {"/{homepagePath}/module/quizReq"})
public class QuizReqController extends BaseController {

	private String basePath = "/homepage/%s/module/quizReq/";

	@Autowired
	private QuizService quizService;

	@Autowired
	private QuizReqService quizReqService;

	@Autowired
	private QuizQuestionService quizQuestionService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private TermsService termsService;

	@Autowired
	@Qualifier("quizReqStorage")
	private FileStorage quizReqStorage;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, QuizReq quizReq, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		quizReq.setHomepage_id(homepage.getHomepage_id());

/*		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			quizReq.setBefore_url(String.format("http://www.gbelib.kr/%s/module/quizReq/index.do?menu_idx=%s", homepage.getContext_path(), quizReq.getMenu_idx()));
			quizReqService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), quizReq.getMenu_idx(), quizReq.getBefore_url()), request, response);
			return null;
		}
*/
		List<Code> quizTypeList = codeService.getCode(homepage.getHomepage_id(), "H0003");
		// 등록된 퀴즈 타입이 있는지 확인
		if ( quizTypeList.size() > 0 ) {
			Menu menuOne = (Menu) request.getAttribute("menuOne");

			if("h1".equals(homepage.getHomepage_id())) {
				Terms t = new Terms();
				t.setHomepage_id(homepage.getHomepage_id());

				if(StringUtils.isEmpty(quizReq.getSearch_quiz_type()) || "1".equals(quizReq.getSearch_quiz_type()) || "2".equals(quizReq.getSearch_quiz_type())) {
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

			model.addAttribute("quizTypeList", quizTypeList);
			// 첫번째 퀴즈 타입의 해당하는 년,월 의 퀴즈를 가져옴.

			String searchQuizType = "";
			if ( StringUtils.isEmpty(quizReq.getSearch_quiz_type()) ) {
				searchQuizType = quizTypeList.get(0).getCode_id();
				quizReq.setSearch_quiz_type(searchQuizType);
			}
			else {
				searchQuizType = quizReq.getSearch_quiz_type();
			}

			Quiz quiz = quizService.getQuizUser(new Quiz(homepage.getHomepage_id(), searchQuizType, quizReq.getSearch_quiz_year(), quizReq.getSearch_quiz_month()));

			if ( quiz != null ) {
				// 퀴즈의 문항리스트를 가져옴
				quizReq.setQuiz_idx(quiz.getQuiz_idx());
				model.addAttribute("quiz", quiz);
				model.addAttribute("quizQuestionList", quizQuestionService.getQuizQuestionList(new QuizQuestion(homepage.getHomepage_id(), quiz.getQuiz_idx())));
			}
			else {
				quizReq.setQuiz_idx(0);
			}
		}
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("quizReq", quizReq);



		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, QuizReq quizReq, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResponse res = new JsonResponse(request);
		String editMode = quizReq.getEditMode();

		if ( !quizReq.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "name", "이름을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "phone", "휴대전화번호를 입력하세요.");
			ValidationUtils.rejectPhone(result, "phone", "휴대전화번호 형식(01x-xxxx-xxxx)이 올바르지 않습니다.");
		}

		int matchLength = StringUtils.countMatches(quizReq.getQuiz_answer(), "\\|") + 1;
		int answer_length = quizReq.getQuiz_answer().split("\\|").length;
		if(matchLength - answer_length > 0) {
			int answer_num = answer_length + 1;
			result.reject(answer_num + "번 문항에 답하지 않으셨습니다.");
		}

		if (!result.hasErrors()) {
			if (editMode.equals("ADD")) {
				quizReq.setAdd_id(getSessionMemberId(request));
				if (quizService.getQuizCntOfValidDate(quizReq) == 0) {
					res.setValid(false);
					res.setMessage("퀴즈 참여기간이 아닙니다.");
				} else if (quizReqService.checkReqByMemberId(quizReq) > 0) {
					res.setValid(false);
					res.setMessage("퀴즈는 1회 참여만 가능 합니다.");
				} else {
					StringBuilder sb = new StringBuilder();
					sb.append(quizReq.getName() + "\n");
					sb.append(quizReq.getSchool() + "\n");
					sb.append(quizReq.getBan() + "\n");
					sb.append(quizReq.getQuiz_answer() + "\n");
					String addResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", sb.toString());
					if (addResult != null) {
						res.setValid(true);
						res.setUrl(addResult);
						res.setTargetOpener(true);
						return res;
					}

					MultipartFile mFile = quizReq.getQuizReq_file();
					if (mFile != null) {
						String serverFileName = Long.toString((System.currentTimeMillis()));
						String originFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
						String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
						String filePath = "/" + quizReq.getHomepage_id();

						File f = quizReqStorage.addFile(mFile, serverFileName, filePath);
						quizReq.setServer_file_name(serverFileName);
						quizReq.setOrigin_file_name(originFileName);
						quizReq.setFile_extension(fileExtension);
						quizReq.setFile_size(f.length());
					}

					quizReqService.addQuizReq(quizReq);
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