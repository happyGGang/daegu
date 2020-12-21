package kr.go.gbelib.app.module.bestPracticesContest;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.bestPracticesContest.BestPracticesContest;
import kr.go.gbelib.app.cms.module.bestPracticesContest.BestPracticesContestService;

@Controller(value = "userBestPracticesContest")
@RequestMapping(value = {"/{homepagePath}/module/bestPracticesContest"})
public class BestPracticesContestController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/bestPracticesContest/";

	@Autowired
	private BestPracticesContestService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bestPracticesContest.setHomepage_id(homepage.getHomepage_id());
		
		service.setPaging(model, service.bestPracticesContestCount(bestPracticesContest), bestPracticesContest);
		
		model.addAttribute("bestPracticesContest", bestPracticesContest);
		model.addAttribute("bestPracticesContestList", service.bestPracticesContestList(bestPracticesContest));

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/step2.*"})
	public String step2(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bestPracticesContest", bestPracticesContest);
		
		return String.format(basePath, homepage.getFolder()) + "step2";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bestPracticesContest.setHomepage_id(homepage.getHomepage_id());
		
		if(bestPracticesContest.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("bestPracticesContest", service.copyObjectPaging(bestPracticesContest, service.getBestPracticesContest(bestPracticesContest)));
		} else {
			checkAuth("C", model, request);
			bestPracticesContest.setAdd_id(getSessionMemberId(request));
			model.addAttribute("bestPracticesContest", bestPracticesContest);
		}
		
		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bestPracticesContest.setHomepage_id(homepage.getHomepage_id());
		
		service.setPaging(model, service.bestPracticesContestCount(bestPracticesContest), bestPracticesContest);
		
		model.addAttribute("bestPracticesContest", bestPracticesContest);
		model.addAttribute("getBestPracticesContest", service.getBestPracticesContest(bestPracticesContest));
		
		return String.format(basePath, homepage.getFolder()) + "view";
	}
	
	@RequestMapping (value = {"/viewPw.*"})
	public String viewPw(Model model, BestPracticesContest bestPracticesContest, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bestPracticesContest.setHomepage_id(homepage.getHomepage_id());
		
		service.addViewCount(bestPracticesContest);
		
		model.addAttribute("bestPracticesContest", bestPracticesContest);
		model.addAttribute("getBestPracticesContest", service.getBestPracticesContest(bestPracticesContest));
		
		return String.format(basePath, homepage.getFolder()) + "viewPw";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		if(bestPracticesContest.getEditMode().equals("ADD") || bestPracticesContest.getEditMode().equals("MODIFY") ) {
			ValidationUtils.rejectIfEmpty(result, "contest_field", "공모분야를 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_name", "작성자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "password", "비밀번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_email", "이메일을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_address", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "contents", "내용을 입력하세요.");

    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bestPracticesContest.getUser_email())) {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "user_name", 20, "이름");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "user_address", 1000, "주소");
    		ValidationUtils.rejectIfStringLength(result, "title", 500, "제목");
    		ValidationUtils.rejectIfStringLength(result, "contents", 40000, "내용");
		}
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bestPracticesContest.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			if (bestPracticesContest.getEditMode().equals("ADD")) {
				if (!member.isLogin() && member.isAnonymous()) {
					bestPracticesContest.setAdd_id("ANONYMOUS");
				} else {
					bestPracticesContest.setAdd_id(getSessionMemberId(request));
				}
				service.addBestPracticesContest(bestPracticesContest, mpRequest);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
				res.setUrl("index.do?menu_idx=" + bestPracticesContest.getMenu_idx());
			} else if (bestPracticesContest.getEditMode().equals("MODIFY")) {
				bestPracticesContest.setModify_id(getSessionMemberId(request));
				service.modifyBestPracticesContest(bestPracticesContest, mpRequest);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
				res.setUrl("index.do?menu_idx=" + bestPracticesContest.getMenu_idx());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bestPracticesContest.setHomepage_id(homepage.getHomepage_id());
		
		if (!result.hasErrors()) {
			if (bestPracticesContest.getEditMode().equals("DELETE")) {
				service.deleteBestPracticesContest(bestPracticesContest);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
				res.setUrl("index.do?menu_idx=" + bestPracticesContest.getMenu_idx());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}	

	@RequestMapping(value = { "/deleteFile.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile(Model model, BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		service.deleteFile(bestPracticesContest);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}

	@RequestMapping(value = { "/deleteFile2.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile2(Model model, BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		service.deleteFile2(bestPracticesContest);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}

	@RequestMapping(value = { "/deleteFile3.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile3(Model model, BestPracticesContest bestPracticesContest, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		service.deleteFile3(bestPracticesContest);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}
	
}
