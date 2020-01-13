package kr.co.whalesoft.app.cms.member;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.auth.AuthService;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroup;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroupService;
import kr.co.whalesoft.app.cms.memberGroupSubord.MemberGroupSubordService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping(value = {"/cms/member", "/wbuilder/member"})
public class MemberController extends BaseController {

	private final String basePath = "/cms/member/";
	private final String wbuilderPath = "/wbuilder/member/";

	@Autowired
	private AuthService authService;

	@Autowired
	private MemberService service;

	@Autowired
	private CodeService codeService;

	@Autowired
	private MemberGroupService memberGroupService;

	@Autowired
	private MemberGroupSubordService memberGroupSubordService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Member member, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		member.setHomepage_id(getAsideHomepageId(request));
		member.setAdmin(getSessionIsAdmin(request));
		member.setAuth_id(getSessionMemberInfo(request).getAuth_id());

		int count = service.getMemberManageCount(member);
		service.setPaging(model, count, member);
		model.addAttribute("memberList", service.getMemberManageList(member));
		model.addAttribute("memberListCount", count);
		return returnUrl("index", request);
	}

	@RequestMapping (value = { "/grouping{url}.*" }, method = RequestMethod.GET)
	public String grouping(Model model, Member member, HttpServletRequest request, @PathVariable("url") String url) throws AuthException {
		checkAuth("C", model, request);
		checkAuth("U", model, request);
		MemberGroup memberGroup = new MemberGroup();
		memberGroup.setSite_id(getAsideHomepageId(request));
		//내권한 사이트목록 가져와서 집어넣기.
		model.addAttribute("getMemberGroupList", memberGroupService.getMemberGroupList(memberGroup));
//		member.setAuthGroupIdxList(authGroupMemberService.getAuthGroupIdxList(member));
		member.setAuthGroupIdxList(memberGroupSubordService.getAuthGroupIdxList(member));
		model.addAttribute("member", member);
		return returnUrl("grouping" + url, request);
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Member member, HttpServletRequest request) throws AuthException {
		member.setHomepage_id(getAsideHomepageId(request));
		member.setAdmin(getSessionIsAdmin(request));
		member.setAuth_id(getSessionMemberInfo(request).getAuth_id());

		if ( member.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("member", service.copyObjectPaging(member, service.getMemberOne(member)));
		} else {
			checkAuth("C", model, request);
			MemberGroup memberGroup = new MemberGroup();
			memberGroup.setSite_id(getAsideHomepageId(request));
			//내권한 사이트목록 가져와서 집어넣기.
			model.addAttribute("getMemberGroupList", memberGroupService.getMemberGroupList(memberGroup));
			model.addAttribute("member", member);
		}

//		model.addAttribute("authList", authService.getAuth("AUTH001"));
		model.addAttribute("cellPhoneCode", codeService.getCode(member.getHomepage_id(), "C0002"));
		model.addAttribute("phoneCode", codeService.getCode(member.getHomepage_id(), "C0003"));
		return returnUrl("edit_ajax", request);
	}

	@RequestMapping(value = {"/getLinkMember.*"})
	public @ResponseBody JsonResponse getLinkMember(Model model, Member member, HttpServletRequest request) {
		JsonResponse jr = new JsonResponse();
		jr.setData(MemberAPI.checkDupUser("0",member));
		return jr;
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Member member, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if ( "ADD".equals(member.getEditMode()) ) {
			ValidationUtils.rejectIfEmpty(result, "member_id", "사용자ID를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "member_name", "사용자명을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "member_pw", "비밀번호를 입력해주세요.");
			if ( service.checkMemberId(member) > 0 ) {
				result.reject("중복된 ID가 있습니다.");
			}
		}
		else if ( "DELETE".equals(member.getEditMode()) ) {
			if ( member.getMember_id().equals(getSessionMemberId(request)) ) {
				result.reject("자신의 ID는 삭제가 불가능 합니다.");
			}
//			if ( service.checkMemberAuthInHomepage(member) < 2 ) {
//				result.reject("관리자 ID가 해당 홈페이지에 1개 이상은 존재 하여야 합니다.");
//			}
		}

		if ( !result.hasErrors() ) {
//			if (Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200) {
			res.setValid(true);
			member.setCud_id(getSessionMemberId(request));
			member.setAdd_id(getSessionMemberId(request));
			member.setAdd_ip(request.getRemoteAddr());
			res.setData(member.getPram("index"));
			res.setUrl("index.do");
			if (member.getEditMode().equals("MODIFY")) {
				service.modifyMember(member);
				res.setMessage("수정되었습니다.");
			} else if (member.getEditMode().equals("ADD")) {
				service.addMember(member);
				res.setMessage("등록되었습니다.");
			} else if (member.getEditMode().equals("DELETE")) {
				service.deleteMember(member);
				res.setMessage("삭제되었습니다.");
			}
//			}
//			else {
//				res.setValid(false);
//				res.setResult("권한이 없습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 관리자 그룹설정
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping (value = { "/saveGroup.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveGroup(Member member, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
			member.setHomepage_id(getAsideHomepageId(request));
			service.addMemberGroup(member);
			res.setValid(true);
			res.setMessage("저장되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	private String returnUrl(String url, HttpServletRequest request) {
		if (request.getHeader("referer").toString().contains("wbuilder")) {
			return wbuilderPath + url;
		} else {
			return basePath + url;
		}
	}
}