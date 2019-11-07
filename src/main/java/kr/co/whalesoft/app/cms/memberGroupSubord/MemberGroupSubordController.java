package kr.co.whalesoft.app.cms.memberGroupSubord;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value={"/cms/memberGroupSubord"})
public class MemberGroupSubordController extends BaseController {

private final String basePath = "/cms/memberGroupSubord/";
	
	@Autowired
	private MemberGroupSubordService service;
	
	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, MemberGroupSubord memberGroupSubord, HttpServletRequest request) {

		return basePath + "index";
	}
	
	/**
	 * 트리 리스트를 가져온다.
	 * @return
	 */
	@RequestMapping(value="/getMemberGroupSubordTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<MemberGroupSubord> getMemberGroupSubordTreeList(MemberGroupSubord memberGroupSubord, HttpServletRequest request) {
		if (!StringUtils.equals(getAsideHomepageId(request), "CMS")) {
			memberGroupSubord.setSite_id(getAsideHomepageId(request));
			memberGroupSubord.setMember_id(getSessionMemberId(request));
		}
		
		return service.getMemberGroupSubordTreeList(memberGroupSubord);
	}
	
	/**
	 * 우측창 페이지 불러오기
	 * @param model
	 * @param authority
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/memberGroupSubord.*", method=RequestMethod.GET)
	public String memberGroupSubord(Model model, MemberGroupSubord memberGroupSubord, HttpServletRequest request) {
		model.addAttribute("memberGroupSubordList", service.getMemberGroupSubordList(memberGroupSubord));
		model.addAttribute("memberGroupSubordReadyList", service.getMemberGroupSubordReadyList(memberGroupSubord));
		model.addAttribute("memberGroupSubord", service.getMemberGroupSubordOne(memberGroupSubord));
		 
		return basePath + "memberGroupSubord_ajax"; 
	}
	
	/**
	 * 우측창 페이지 불러오기
	 * @param model
	 * @param authority
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/findMember.*", method=RequestMethod.GET)
	public @ResponseBody List<MemberGroupSubord> findMember(Model model, MemberGroupSubord memberGroupSubord, HttpServletRequest request) {
		return service.getMemberGroupSubordReadyList(memberGroupSubord);
	}
	

	/**
	 * 회원 - 그룹 맵핑
	 * @param model
	 * @param authority
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, MemberGroupSubord memberGroupSubord, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
//		ValidationUtils.rejectIfEmpty(result, "memberList", "선택된 관리자가 없습니다.");
		
		if(!result.hasErrors()) {
			memberGroupSubord.setCud_id(getSessionMemberId(request));
			if (service.addMemberGroupSubord(memberGroupSubord) < 1) { 
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
