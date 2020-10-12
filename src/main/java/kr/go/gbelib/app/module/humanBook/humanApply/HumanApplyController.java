package kr.go.gbelib.app.module.humanBook.humanApply;

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
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.humanBook.HumanBook;
import kr.go.gbelib.app.cms.module.humanBook.HumanBookService;
import kr.go.gbelib.app.cms.module.humanBook.apply.HumanApply;
import kr.go.gbelib.app.cms.module.humanBook.apply.HumanApplyService;

@Controller(value="userHumanApply")
@RequestMapping(value = {"/{homepagePath}/module/humanApply/"})
public class HumanApplyController extends BaseController {

	private final String basePath = "/homepage/%s/module/humanBook/humanApply/";

	@Autowired
	private HumanApplyService service;

	@Autowired
	private HumanBookService humanBookService;

	@Autowired
	private CodeService codeService;

	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, HumanApply humanApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		humanApply.setHomepage_id(homepage.getHomepage_id());

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			humanApply.setBefore_url(String.format("/%s/module/humanBook/list.do?menu_idx=%s", homepage.getContext_path(), humanApply.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), humanApply.getMenu_idx(), humanApply.getBefore_url()), request, response);
			return null;
		}

		if ( isLogin(request) && !getSessionIsAdmin(request) ) {
			humanApply.setAdd_id(getSessionMemberId(request));
		}

		service.setPaging(model, service.getHumanBookApplyCount(humanApply), humanApply);
		model.addAttribute("humanApply", humanApply);
		model.addAttribute("humanApplyList", service.getHumanBookApplyList(humanApply));
		model.addAttribute("activityCateList", codeService.getCode(humanApply.getHomepage_id(), "H0005"));

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping (value = {"/apply.*"}, method = RequestMethod.GET)
	public String apply(Model model, HumanApply humanApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			humanApply.setBefore_url(String.format("/%s/module/humanBook/list.do?menu_idx=%s", homepage.getContext_path(), humanApply.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), humanApply.getMenu_idx(), humanApply.getBefore_url()), request, response);
			return null;
		}

//		Member member = getSessionMemberInfo(request);
//		if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
//			service.alertMessage("정회원만 이용가능합니다.", request, response);
//			return null;
//		}

		HumanBook humanBook = new HumanBook();
		humanBook.setHomepage_id(humanApply.getHomepage_id());
		humanBook.setHuman_book_idx(humanApply.getHuman_book_idx());
		humanBook = humanBookService.getHumanBookOne(humanBook);
		humanApply.setHuman_book_title(humanBook.getHuman_book_title());

		model.addAttribute("humanApply", humanApply);

		return String.format(basePath, homepage.getFolder()) + "apply";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(HumanApply humanApply, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(humanApply.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "human_apply_name", "신청자명을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "human_apply_phone", "연락처를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "human_apply_hope_date", "열람희망일 및 시간을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "human_apply_content", "열럼목적을 입력해주세요.");

			ValidationUtils.rejectPhone(result, "human_apply_phone", "휴대폰번호 형식 (01x-xxxx-xxxx) or (01x-xxx-xxxx) 입니다.");
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (humanApply.getEditMode().equals("ADD")) {
				humanApply.setAdd_id(getSessionMemberId(request));
				service.addHumanApply(humanApply);
				res.setValid(true);
				res.setMessage("신청되었습니다.");
			} else if (humanApply.getEditMode().equals("MODIFY")) {
//				humanApply.setModify_id(getSessionMemberId(request));
//				res.setValid(true);
//				res.setMessage("수정되었습니다.");
			} else if(humanApply.getEditMode().equals("APPLY_CANCEL")) {
				humanApply.setAdd_id(getSessionMemberId(request));
				service.humanApplyCancel(humanApply);
				res.setValid(true);
				res.setMessage("신청 취소되었습니다.");
			} else if(humanApply.getEditMode().equals("STATUS")) {
				humanApply.setModify_id(getSessionMemberId(request));
				service.modifyApplyStatus(humanApply);
				res.setValid(true);
				res.setMessage("신청상태 변경되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/schedule.*"}, method = RequestMethod.GET)
	public String schedule(Model model, HumanApply humanApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		humanApply.setHomepage_id(homepage.getHomepage_id());

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			humanApply.setBefore_url(String.format("/%s/module/humanBook/list.do?menu_idx=%s", homepage.getContext_path(), humanApply.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), humanApply.getMenu_idx(), humanApply.getBefore_url()), request, response);
			return null;
		}

		if ( isLogin(request) && !getSessionIsAdmin(request) ) {
			humanApply.setAdd_id(getSessionMemberId(request));
		}

		service.setPaging(model, service.getHumanBookScheduleCount(humanApply), humanApply);

		model.addAttribute("humanApply", humanApply);
		model.addAttribute("humanScheduleList", service.getHumanBookScheduleList(humanApply));

		return String.format(basePath, homepage.getFolder()) + "schedule";
	}

	@RequestMapping (value = {"/status.*"}, method = RequestMethod.GET)
	public String status(Model model, HumanApply humanApply, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		humanApply = (HumanApply) service.copyObjectPaging(humanApply, service.getHumanApplyOne(humanApply));

		model.addAttribute("humanApply", humanApply);

		return String.format(basePath, homepage.getFolder()) + "status_ajax";
	}

}
