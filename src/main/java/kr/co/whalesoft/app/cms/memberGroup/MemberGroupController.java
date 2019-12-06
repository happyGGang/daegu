package kr.co.whalesoft.app.cms.memberGroup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuthService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

/**
 * 그룹관리 및 그룹관계 관리
 * @author YONGJU
 *
 */
@Controller
@RequestMapping(value={"/cms/memberGroup", "/wbuilder/memberGroup"})
public class MemberGroupController extends BaseController {

	private final String basePath = "/cms/memberGroup/";
	private final String wbuilderPath = "/wbuilder/memberGroup/";

	@Autowired
	private MemberGroupService service;

	@Autowired
	private MemberGroupAuthService memberGroupAuthService;

	/**
	 * 첫 페이지
	 * @param model
	 * @param request
	 * @param url
	 * @return
	 * @throws AuthException
	 */
	@RequestMapping (value = { "/index{url}.*" }, method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request, @PathVariable ("url") String url) throws AuthException {
		checkAuth("R", model, request);
		boolean isWbuilder = request.getHeader("referer").toString().contains("wbuilder");
		if (isWbuilder) {
			return wbuilderPath + "index" + url;
		} else {
			return basePath + "index" + url;
		}
	}

	/**
	 * 트리
	 * @param memberGroup.site_id
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getMemberGroupTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<MemberGroup> getMemberGroupTreeList(MemberGroup memberGroup, HttpServletRequest request) {
		if (!StringUtils.equals(getAsideHomepageId(request), "CMS") && !StringUtils.equals(getAsideHomepageId(request), "null")) {
			memberGroup.setSite_id(getAsideHomepageId(request));
		}

		return service.getMemberGroupList(memberGroup);
	}

	/**
	 * 우측 페이지 호출
	 * @param model
	 * @param memberGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/memberGroup{url}.*", method=RequestMethod.GET)
	public String memberGroup(Model model, MemberGroup memberGroup, @PathVariable ("url") String url, HttpServletRequest request) {
		model.addAttribute("memberGroupList", service.getMemberGroupList(memberGroup));
		memberGroup = service.getMemberGroupOne(memberGroup);
		model.addAttribute("memberGroup", memberGroup);
		model.addAttribute("parentMemberGroup", service.getMemberGroupOne(new MemberGroup(memberGroup.getParent_member_group_idx())));

		boolean isWbuilder = request.getHeader("referer").toString().contains("wbuilder");
		if (isWbuilder) {
			return wbuilderPath + "memberGroup" + url;
		} else {
			return basePath + "memberGroup" + url;
		}

	}

	/**
	 * 그룹 1개 가져오기
	 * @param model
	 * @param memberGroup
	 * @return
	 */
	@RequestMapping(value="/getMemberGroupOne.*", method=RequestMethod.GET)
	public @ResponseBody MemberGroup getMemberGroupOne(Model model, MemberGroup memberGroup) {
		return service.getMemberGroupOne(memberGroup);
	}

	/**
	 * 그룹 신규등록 및 수정
	 * @param model
	 * @param memberGroup
	 * @return
	 * @throws AuthException
	 */
	@RequestMapping(value="/edit{url}.*", method=RequestMethod.GET)
	public String edit(Model model, MemberGroup memberGroup, @PathVariable ("url") String url, HttpServletRequest request, HttpServletResponse response) throws AuthException {
		if(memberGroup.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			MemberGroup memberGroupOne = service.getMemberGroupOne(memberGroup);
			model.addAttribute("memberGroup", service.copyObjectPaging(memberGroup, memberGroupOne));
			model.addAttribute("parentMemberGroup", service.getMemberGroupOne(new MemberGroup(memberGroupOne.getParent_member_group_idx())));
		} else {
			checkAuth("C", model, request);
			boolean hasAuth = memberGroupAuthService.hasAuth(memberGroup.getMember_group_idx());

			if (hasAuth) {
				throw new AuthException("권한설정된 그룹에선 하위그룹을 생성할 수 없습니다");
//				try {
//					service.alertMessageAjax("권한설정된 그룹에선 하위그룹을 생성할 수 없습니다", request, response);
//					return null;
//				}
//				catch ( Exception e ) {
//				}
			}

			memberGroup = service.getMemberGroupOne(memberGroup);
			model.addAttribute("memberGroup", memberGroup);
			model.addAttribute("parentMemberGroup", service.getMemberGroupOne(new MemberGroup(memberGroup.getParent_member_group_idx())));
		}
		boolean isWbuilder = request.getHeader("referer").toString().contains("wbuilder");
		if (isWbuilder) {
			return wbuilderPath + "edit" + url;
		} else {
			return basePath + "edit" + url;
		}
	}

	/**
	 * 그룹 등록
	 * @param model
	 * @param memberGroup
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, MemberGroup memberGroup, BindingResult result, HttpServletRequest request) {
		Member member = getSessionMemberInfo(request);
		model.addAttribute("member", member);

		JsonResponse res = new JsonResponse(request);

		if(!memberGroup.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "member_group_name", "권한그룹명을 입력하세요.");
		}

		if(!result.hasErrors()) {
			memberGroup.setCud_id(getSessionMemberId(request));
			if(memberGroup.getEditMode().equals("ADD")) {
				service.addMemberGroup(memberGroup);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(memberGroup.getEditMode().equals("MODIFY")) {
				service.modifyMemberGroup(memberGroup);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(memberGroup.getEditMode().equals("DELETE")) {
				if(service.getMemberGroupCount(memberGroup) > 0) {
					res.setValid(false);
					res.setMessage("하위 데이터가 존재하여 삭제할 수 없습니다.");
				} else {
					service.deleteMemberGroup(memberGroup);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}


	/**
	 * 권한그룹의 하위그룹 설정
	 * @param model
	 * @param memberGroup
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/saveRelation.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveRelation(Model model, MemberGroup memberGroup, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "relationList", "선택된 그룹이 없습니다.");

		if(!result.hasErrors()) {
			memberGroup.setCud_id(getSessionMemberId(request));
			if (service.addMemberGroupRelation(memberGroup, request) < 1) {
				res.setValid(false);
				res.setMessage("다시 시도해주세요.");
			} else {
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
