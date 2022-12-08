package kr.go.gbelib.app.cms.module.paymentMember;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/paymentMember"})
public class PaymentMemberController extends BaseController {

	private final String basePath = "/cms/module/paymentMember/";
	
	@Autowired
	private PaymentMemberService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, PaymentMember paymentMember, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		int count = service.getPaymentMemberCount(paymentMember);
		service.setPaging(model, count, paymentMember);
		paymentMember.setTotalDataCount(count);
		
		model.addAttribute("paymentMember", paymentMember);
		model.addAttribute("paymentMemberCount", count);
		model.addAttribute("paymentMemberList", service.getPaymentMemberList(paymentMember));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/memberEdit.*"})
	public String memberEdit(Model model, PaymentMember paymentMember, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);
		
		paymentMember.setHomepage_id(getAsideHomepageId(request));
		paymentMember.setAdd_id(member.getMember_id());
		
		model.addAttribute("paymentMember", paymentMember);
		if(paymentMember.getFamily_count() != 0) {
			model.addAttribute("familyCount", paymentMember.getFamily_count());
		}

		return basePath + "memberEdit";
	}
	
	@RequestMapping (value = {"/viewFamilyMember.*"})
	public String viewFamilyMember(Model model, PaymentMember paymentMember, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		paymentMember.setPay_family_member_idx(paymentMember.getPay_member_idx());
		List<PaymentMember> familyMemberList = service.getPaymentMemberFamilyList(paymentMember);
		
		model.addAttribute("familyMemberList", familyMemberList);
		model.addAttribute("paymentMember", paymentMember);
		
		return basePath + "view_ajax";
	}
	
	@RequestMapping (value = {"/memberModify.*"})
	public String memberModify(Model model, PaymentMember paymentMember, HttpServletRequest request) throws AuthException {
		model.addAttribute("paymentMember", paymentMember);
		if(paymentMember.getFamily_count() != 0) {
			model.addAttribute("familyCount", paymentMember.getFamily_count());
		}

		return basePath + "memberModify_ajax";
	}
	
	@RequestMapping(value = { "/modify.*" })
	public String modify(Model model, PaymentMember paymentMember, HttpServletRequest request,  HttpServletResponse response) throws Exception {
		paymentMember = service.getPaymentMemberOne(paymentMember);
		
		paymentMember.setModify_id(getSessionMemberId(request));
		paymentMember.setEditMode("MODIFY");
		
		int familyCount = service.getPaymentMemberFamilyCount(paymentMember);
		if(familyCount > 0) {
			paymentMember.setPay_family_member_idx(paymentMember.getPay_member_idx());
			List<PaymentMember> familyMemberList = service.getPaymentMemberFamilyList(paymentMember);
			model.addAttribute("familyMemberList", familyMemberList);
		}
		
		model.addAttribute("familyCount", familyCount);
		model.addAttribute("paymentMember", paymentMember);
		
		return basePath + "memberModify_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(@RequestBody PaymentMember paymentMember, BindingResult result, HttpServletRequest request) throws JsonParseException, JsonMappingException, IOException {
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "pay_member_name", "이름을 입력하세요.");
		ValidationUtils.rejectExceptNumber(result, "loan_number", "대출번호는 숫자만 가능합니다.");
		ValidationUtils.rejectIfEmpty(result, "birth", "출생연도를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "join_start_date", "가입시작일을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "join_end_date", "가입종료일을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "use_type", "이용구분을 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "sex", "성별을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "sponsorship_amount", "금액을 입력하세요.");
		
		String homepage_id = getAsideHomepageId(request);
		paymentMember.setAdd_id(getSessionMemberId(request));
		paymentMember.setHomepage_id(homepage_id);
		
		if (!result.hasErrors()) {
			service.addPaymentMember(paymentMember);
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/memberModifySave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse memberModifySave(@RequestBody PaymentMember paymentMember, BindingResult result, HttpServletRequest request) throws JsonParseException, JsonMappingException, IOException {
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "pay_member_name", "이름을 입력하세요.");
		ValidationUtils.rejectExceptNumber(result, "loan_number", "대출번호는 숫자만 가능합니다.");
		ValidationUtils.rejectIfEmpty(result, "birth", "출생연도를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "join_start_date", "가입시작일을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "join_end_date", "가입종료일을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "use_type", "이용구분을 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "sex", "성별을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "sponsorship_amount", "금액을 입력하세요.");
		
		String homepage_id = getAsideHomepageId(request);
		paymentMember.setModify_id(getSessionMemberId(request));
		paymentMember.setHomepage_id(homepage_id);
		
		if (!result.hasErrors()) {
			service.modifyPaymentMember(paymentMember);
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/changeApproveYn.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse changeApproveYn(PaymentMember paymentMember, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			service.changeApprovePaymentMember(paymentMember);
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/deleteMember.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteMember(PaymentMember paymentMember, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		paymentMember.setDelete_id(getSessionMemberId(request));
		paymentMember.setDelete_ip(request.getRemoteAddr());

		if (!result.hasErrors()) {
			service.deletePaymentMember(paymentMember);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
