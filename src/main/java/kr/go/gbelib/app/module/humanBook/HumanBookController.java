package kr.go.gbelib.app.module.humanBook;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.humanBook.HumanBook;
import kr.go.gbelib.app.cms.module.humanBook.HumanBookService;

@Controller(value="userHumanBook")
@RequestMapping(value = {"/{homepagePath}/module/humanBook"})
public class HumanBookController extends BaseController {

	private final String basePath = "/homepage/%s/module/humanBook/";

	@Autowired
	private HumanBookService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, HumanBook humanBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		humanBook.setHomepage_id(homepage.getHomepage_id());

//		Member member = getSessionMemberInfo(request);
//		if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
//			service.alertMessage("정회원만 이용가능합니다.", request, response);
//			return null;
//		}
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			humanBook.setBefore_url(String.format("/%s/module/humanBook/index.do?menu_idx=%s", homepage.getContext_path(), humanBook.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), humanBook.getMenu_idx(), humanBook.getBefore_url()), request, response);
			return null;
		}

		if ( isLogin(request) && !getSessionIsAdmin(request) ) {
			humanBook.setAdd_id(getSessionMemberId(request));
		}

		service.setPaging(model, service.getHumanBookCount(humanBook), humanBook);

		model.addAttribute("humanBook", humanBook);
		model.addAttribute("humanBookAll", service.getHumanBookAll(humanBook));
		model.addAttribute("activityCateList", codeService.getCode(humanBook.getHomepage_id(), "H0005"));

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, HumanBook humanBook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		humanBook.setHomepage_id(homepage.getHomepage_id());

//		Member member = getSessionMemberInfo(request);
//		if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
//			service.alertMessage("정회원만 이용가능합니다.", request, response);
//			return null;
//		}
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			humanBook.setBefore_url(String.format("/%s/module/humanBook/edit.do?menu_idx=%s", homepage.getContext_path(), humanBook.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), humanBook.getMenu_idx(), humanBook.getBefore_url()), request, response);
			return null;
	    }

		if(humanBook.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("humanBook", service.copyObjectPaging(humanBook, service.getHumanBookOne(humanBook)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("humanBook", humanBook);
		}

		model.addAttribute("activityCateList", codeService.getCode(humanBook.getHomepage_id(), "H0005"));

		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(HumanBook humanBook, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "teacher_name", "성명은 필수 입력입니다.");
		ValidationUtils.rejectIfEmpty(result, "teacher_birth", "생년월일은 필수 입력입니다.");
		ValidationUtils.rejectIfEmpty(result, "teacher_phone", "휴대폰번호는 필수 입력입니다.");
		ValidationUtils.rejectIfEmpty(result, "teacher_agency", "소속은 필수 입력입니다.");
		ValidationUtils.rejectIfEmpty(result, "teacher_zipcode", "우편번호는 필수 입력입니다.");
		ValidationUtils.rejectIfEmpty(result, "teacher_address", "주소는 필수 입력입니다.");
		
		Homepage homepage = getSessionHomepage(request);
		if(!homepage.getHomepage_id().equals("h51")) {
			ValidationUtils.rejectIfEmpty(result, "activity_day", "활동가능요일을 선택해주세요.");
			ValidationUtils.rejectIfEmpty(result, "activity_time", "활동가능시간을 선택해주세요.");
			ValidationUtils.rejectIfEmpty(result, "teacher_content", "활동가능지역은 필수 입력입니다.");
		}
		
//		if(StringUtils.contains(humanBook.getActivity_time(), "3")) {
//			ValidationUtils.rejectIfEmpty(result, "activity_time_txt", "활동가능시간 상시 내용을 입력하세요.");
//		}
//		ValidationUtils.rejectIfEmpty(result, "human_book_title", "휴먼북 제목은 필수 입력입니다.");
		ValidationUtils.rejectIfEmpty(result, "human_book_content", "우선순위는 필수 입력입니다.");
		
		if(StringUtils.isNotEmpty(humanBook.getTeacher_email())) {
			ValidationUtils.rejectNotFullEmailType(result, "teacher_email", "이메일 형식이 아닙니다.");
		}
		ValidationUtils.rejectPhone(result, "teacher_phone", "휴대폰번호 형식 (01x-xxxx-xxxx) or (01x-xxx-xxxx) 입니다.");
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (humanBook.getEditMode().equals("ADD")) {
				humanBook.setAdd_id(getSessionMemberId(request));
				if(service.addHumanBook(humanBook) > 0) {
					res.setValid(true);
					res.setMessage("등록되었습니다.");
					res.setUrl("index.do");
					res.setData("menu_idx="+humanBook.getMenu_idx());
				} else {
					res.setValid(false);
					res.setMessage("도서관에 문의하세요.");
				}
			} else if (humanBook.getEditMode().equals("MODIFY")) {
				humanBook.setModify_id(getSessionMemberId(request));
				if(service.modifyHumanBook(humanBook) > 0) {
					res.setValid(true);
					res.setMessage("수정되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("도서관에 문의하세요.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/list.*"}, method = RequestMethod.GET)
	public String list(Model model, HumanBook humanBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		humanBook.setHomepage_id(homepage.getHomepage_id());

		service.setPaging(model, service.getHumanBookListCount(humanBook), humanBook);

		model.addAttribute("humanBook", humanBook);
		model.addAttribute("humanBookList", service.getHumanBookList(humanBook));
		model.addAttribute("activityCateList", codeService.getCode(humanBook.getHomepage_id(), "H0005"));

		return String.format(basePath, homepage.getFolder()) + "list";
	}

	@RequestMapping (value = {"/detail.*"}, method = RequestMethod.GET)
	public String detail(Model model, HumanBook humanBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = getHomepageOne(humanBook.getHomepage_id());
		int menu_idx = humanBook.getMenu_idx();

		humanBook = (HumanBook) service.copyObjectPaging(humanBook, service.getHumanBookOne(humanBook));
		humanBook.setMenu_idx(menu_idx);

		model.addAttribute("humanBook", humanBook);
		model.addAttribute("activityCateList", codeService.getCode(humanBook.getHomepage_id(), "H0005"));

		return String.format(basePath, homepage.getFolder()) + "detail";
	}


}
