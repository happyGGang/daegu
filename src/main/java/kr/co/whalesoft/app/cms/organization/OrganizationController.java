package kr.co.whalesoft.app.cms.organization;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.memberOrganization.MemberOrganization;
import kr.co.whalesoft.app.cms.memberOrganization.MemberOrganizationService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/organization"})
public class OrganizationController extends BaseController {

	private final String basePath = "/cms/organization/";
	
	@Autowired
	private OrganizationService service;
	
	@Autowired
	private MemberOrganizationService memberOrgaService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Organization orga, HttpServletRequest request) {
		orga.setHomepage_id(getAsideHomepageId(request));	
		
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("orga", orga);
		
		return basePath + "index";
	}
	
	@RequestMapping(value="/getOrganizationTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<Organization> getOrganizationTreeList(Organization orga) {
		return service.getOrganizationTreeList(orga);
	}
	
	@RequestMapping(value="/getOrganizationOne.*", method=RequestMethod.GET)
	public @ResponseBody Organization getOrganizationOne(Model model, Organization orga) {
		
		return service.getOrganizationOne(orga);
	}
	
	@RequestMapping(value="/edit.*", method=RequestMethod.GET)
	public String edit(Model model, Organization orga) {
		if(orga.getEditMode().equals("MODIFY")) {
			model.addAttribute("orga", service.copyObjectPaging(orga, service.getOrganizationOne(orga)));
		} else {
			model.addAttribute("orga", orga);
		}
		
		return basePath + "editOrga_ajax";
	}
	
	@RequestMapping(value="/editMemberOrga.*", method=RequestMethod.GET)
	public String editMemberOrga(Model model, MemberOrganization memberOrga) {
		model.addAttribute("memberOrga", memberOrga);
		model.addAttribute("memberList", memberOrgaService.getMemberNotInOrganization(memberOrga));
		return basePath + "editMemberOrga_ajax";
	}
	
	@RequestMapping(value="/memberOrga.*", method=RequestMethod.GET)
	public String memberOrga(Model model, MemberOrganization memberOrga) {
		model.addAttribute("memberOrga", memberOrga);
		model.addAttribute("memberList", memberOrgaService.getMemberInOrganization(memberOrga));
		return basePath + "memberOrga_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Organization orga, BindingResult result, HttpServletRequest request) {
		Member member = getSessionMemberInfo(request);
		model.addAttribute("member", member);
		
		JsonResponse res = new JsonResponse(request);
		
		if ( !orga.getEditMode().equals("DELETE") && !orga.getEditMode().equals("PARENTMOVE") ) {
			ValidationUtils.rejectIfEmpty(result, "orga_name", "조직명을 입력하세요.");
		} 

		if ( !result.hasErrors() ) {
			if ( orga.getEditMode().equals("ADD") ) {
				service.addOrganization(orga, request);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if ( orga.getEditMode().equals("MODIFY") ) {
				service.modifyOrganization(orga, request);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if ( orga.getEditMode().equals("DELETE") ) {
				if ( service.getChildCount(orga) > 0 ) {
					res.setValid(false);
					res.setMessage("하위 데이터가 존재하여 삭제할 수 없습니다.");
				} else {
					service.deleteOrganization(orga);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
			} else if ( orga.getEditMode().equals("PARENTMOVE") ) {
				service.moveOrganization(orga); 
				res.setValid(true);
				res.setMessage("이동 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/saveMemberOrga.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveMemberOrga(Model model, MemberOrganization memberOrga, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( memberOrga.getEditMode().equals("ADD") ) {
			if ( memberOrga.getMember_id_list() == null || memberOrga.getMember_id_list().size() == 0 ) {
				result.reject("사용자를 선택해주세요.");
			}	
		}

		if(!result.hasErrors()) {
			if(memberOrga.getEditMode().equals("ADD")) {
				memberOrgaService.addMemberOrganization(memberOrga);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(memberOrga.getEditMode().equals("DELETE")) {
				memberOrgaService.deleteMemberOrganization(memberOrga);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}