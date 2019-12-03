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

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping (value = {"/cms/organization"})
public class OrganizationController extends BaseController {

	private final String basePath = "/cms/organization/";

	@Autowired
	private OrganizationService service;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Organization organization, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		organization.setHomepage_id(getAsideHomepageId(request));

		// 조직
		int statusCount = service.getStatusCount(organization);
		service.setPaging(model, statusCount, organization);
		organization.setTotalDataCount(statusCount);

		model.addAttribute("divisionList", service.getChartDivisionList(organization.getHomepage_id()));
		model.addAttribute("statusList", service.getStatusList(organization.getHomepage_id()));
		model.addAttribute("totalCnt", service.getTotalCnt(organization.getHomepage_id()));
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(organization.getHomepage_id())));

		// 업무
		int count = service.getOrganizationWorkCnt(organization);
		service.setPaging(model, count, organization);

		List<Organization> workList = service.getOrganizationWorkList(organization);
		for (Organization one : workList) {
			one.setWork_info(one.getWork_info().replaceAll("\n", "<br/>"));
		}

		model.addAttribute("organization", organization);
		model.addAttribute("workList", workList);
		model.addAttribute("organizationList", service.getOrganizationList(organization));
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(organization.getHomepage_id())));

		return basePath + "index";
	}

	@RequestMapping (value = {"/divisionEdit.*"})
	public String divisionEdit(Model model, Organization organization, HttpServletRequest request) throws AuthException {
		if (organization.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
		} else {
			checkAuth("C", model, request);
		}

		model.addAttribute("organization", organization);
		model.addAttribute("statusDivisionList", service.getDivisionList(organization.getHomepage_id()));

		return basePath + "divisionEdit_ajax";
	}

	@RequestMapping (value = {"/divisionSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse divisionSave(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "division_name", "'직렬' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "division_name", 100, "직렬");

		if (!result.hasErrors()) {
			if (organization.getEditMode().equals("ADD")) {
				organization.setAdd_id(getSessionMemberId(request));
				organization.setPrint_seq(service.getDivisionNextPrintSeq(organization));
				service.addDivision(organization);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (organization.getEditMode().equals("MODIFY")) {
				organization.setModify_id(getSessionMemberId(request));
				service.modifyDivision(organization);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/devisionDelete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse devisionDelete(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			service.statusDelete(organization);
			service.deleteStatusAll(organization);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/status.*"})
	public String status(Model model, Organization organization, HttpServletRequest request) throws AuthException {
		if (organization.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			organization = (Organization) service.copyObjectPaging(organization, service.getStatusOne(organization));
		} else {
			checkAuth("C", model, request);
			organization.setPrint_seq(service.getStatusNextPrintSeq(organization));
		}

		model.addAttribute("organization", organization);
		model.addAttribute("divisionList", service.getDivisionList(organization.getHomepage_id()));

		return basePath + "status_ajax";
	}

	@RequestMapping (value = {"/statusSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse statusSave(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "rating", "급수를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "max_cnt", "정원을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "current_cnt", "현원을 입력하세요.");
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (organization.getEditMode().equals("ADD")) {
				organization.setAdd_id(getSessionMemberId(request));
				service.addStatusCnt(organization);
				service.modifyRatingCnt(organization);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (organization.getEditMode().equals("MODIFY")) {
				organization.setModify_id(getSessionMemberId(request));
				service.modifyStatusCnt(organization);
				service.modifyRatingCnt(organization);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/statusDelete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse statusDelete(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			service.statusCnt(organization);
			service.modifyRatingCnt(organization);
			res.setValid(true);
			res.setReload(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, Organization organization, HttpServletRequest request) throws AuthException {
		if (organization.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			organization = (Organization) service.copyObjectPaging(organization, service.getOrganizationWorkOne(organization));
		} else {
			checkAuth("C", model, request);
			organization.setPrint_seq(service.getNextPrintSeq(organization));
		}

		model.addAttribute("organization", organization);
		model.addAttribute("organizationList", service.getOrganizationList(organization));

		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "position", "'직위' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "position", 50, "직위");
		ValidationUtils.rejectIfEmpty(result, "worker", "'성명' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "worker", 50, "담당자");
		ValidationUtils.rejectIfEmpty(result, "phone", "'전화번호' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "phone", 13, "전화번호");
		ValidationUtils.rejectIfEmpty(result, "work_info", "'업무' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "work_info", 2000, "업무내용");
		ValidationUtils.rejectIfEmpty(result, "print_seq", "'출력순서' 필수 입력 항목입니다.");
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (organization.getEditMode().equals("ADD")) {
				organization.setAdd_id(getSessionMemberId(request));
				service.addOrganizationWork(organization);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (organization.getEditMode().equals("MODIFY")) {
				organization.setModify_id(getSessionMemberId(request));
				service.modifyOrganizationWork(organization);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			service.deleteOrganizationWork(organization);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/organizationEdit.*"})
	public String organizationEdit(Model model, Organization organization, HttpServletRequest request) throws AuthException {
		organization.setChart_yn(service.getOrganizationChartYN(organization));
		organization.setAbove_idx(-1);
		model.addAttribute("organization", organization);
		model.addAttribute("organizationList", service.getOrganizationList(organization));

		return basePath + "organizationEdit_ajax";
	}

	@RequestMapping (value = {"/organizationSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse organizationSave(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "organization_name", "'부서' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "organization_name", 100, "부서");
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (organization.getEditMode().equals("ADD")) {
				organization.setAdd_id(getSessionMemberId(request));
				organization.setPrint_seq(service.getOrganizationNextPrintSeq(organization));
				service.addOrganization(organization);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (organization.getEditMode().equals("MODIFY")) {
				organization.setModify_id(getSessionMemberId(request));
				service.modifyOrganization(organization);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/organizationDelete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse organizationDelete(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			service.deleteOrganization(organization);
			service.deleteWorkAll(organization);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/chartModify.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse chartMod(Organization organization, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			service.modifyChartYN(organization);
			res.setValid(true);
			res.setMessage("조직도 표시여부가 변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
