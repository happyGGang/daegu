package kr.co.whalesoft.app.cms.boardManage;

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
import kr.co.whalesoft.app.cms.auth.AuthService;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/boardManage"})
public class BoardManageController extends BaseController {

	private final String basePath = "/cms/boardManage/";

	@Autowired
	private BoardManageService service;

	@Autowired
	private CodeService codeService;

	@Autowired
	private AuthService authService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, BoardManage boardManage, HttpServletRequest request, HttpServletResponse response) throws AuthException {
		checkAuth("R", model, request);
		boardManage.setHomepage_id(getAsideHomepageId(request));
		Homepage hp = new Homepage();
		hp.setHomepage_id(boardManage.getHomepage_id());
		hp = homepageService.getHomepageOne(hp);
		if (hp != null) {
			model.addAttribute("homepageContextPath", hp.getContext_path());
		}
		model.addAttribute("boardManage", boardManage);
		service.setPaging(model, service.getBoardManageCount(boardManage), boardManage);
		model.addAttribute("boardManageList", service.getBoardManage(boardManage));
		model.addAttribute("boardTypes", codeService.getCode(getAsideHomepageId(request), "C0000"));
		return basePath + "boardManage";
	}

	@RequestMapping(value = {"/boardManage.*"})
	public String boardManage(Model model, BoardManage boardManage, HttpServletRequest request) {

		model.addAttribute("boardManage", boardManage);

		if(boardManage.getHomepage_id() != null) {
			service.setPaging(model, service.getBoardManageCount(boardManage), boardManage);
			model.addAttribute("boardManageList", service.getBoardManage(boardManage));
		}
		return basePath + "boardManage_ajax";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, BoardManage boardManage, HttpServletRequest request) throws AuthException {
		if(boardManage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			boardManage = (BoardManage)service.copyObjectPaging(boardManage, service.getBoardManageOne(boardManage));
		} else {
			checkAuth("C", model, request);
		}

		model.addAttribute("boardManage", boardManage);
		String homepageId = String.valueOf(request.getParameter("homepage_id"));
		homepageId = StringUtils.isEmpty(homepageId) ? getAsideHomepageId(request) : homepageId;
		model.addAttribute("codeGroupList", codeService.getCodeGroup(new Code("HOMEPAGE", homepageId)));
		model.addAttribute("boardTypes", codeService.getCode(homepageId, "C0000"));
//		model.addAttribute("authListUser", authService.getAuth("AUTH002"));
//		model.addAttribute("authList", authService.getAuth("AUTH001"));
//		model.addAttribute("groupList", groupService.selectGroups());
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BoardManage boardManage, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		if(boardManage.getBoard_name()!=null) {
			ValidationUtils.rejectIfEmpty(result, "board_name", "게시판명을 입력하세요.");
		}
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			Member sessionMemberInfo = getSessionMemberInfo(request);
			if(boardManage.getEditMode().equals("MODIFY")) {
				boardManage.setModify_id(sessionMemberInfo.getMember_id());
				service.modifyBoardManage(boardManage);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(boardManage.getEditMode().equals("ADD")) {
				boardManage.setAdd_id(sessionMemberInfo.getMember_id());
				service.addBoardManage(boardManage);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/adminSearch.*"}, method = RequestMethod.GET)
	public String adminSearch(Model model, BoardManage boardManage, HttpServletRequest request) {
		Member member = new Member();
		member.setHomepage_id(getAsideHomepageId(request));
		member.setSearch_auth("8000");

		service.setPaging1(model, memberService.getMemberListInAuthCount(member), boardManage);
		model.addAttribute("memberList", memberService.getMemberListInAuth(member));
		model.addAttribute("boardManage", boardManage);

		return basePath + "adminSearch_ajax";
	}
}