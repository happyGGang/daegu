package kr.go.gbelib.app.cms.module.paymentMember;

import java.io.IOException;
import java.util.List;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.PrivateMemberAPI;

@Controller
@RequestMapping(value = {"/cms/module/paymentMember"})
public class PaymentMemberController extends BaseController {

	private final String basePath = "/cms/module/paymentMember/";
	
	@Autowired
	private PaymentMemberService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, PaymentMember paymentMember, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		String homepage_id = getAsideHomepageId(request);
		
		paymentMember.setHomepage_id(homepage_id);
		
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

		if ("MODIFY".equals(paymentMember.getEditMode())) {
			model.addAttribute("paymentMember", service.copyObjectPaging(paymentMember, service.getPaymentMemberOne(paymentMember)));
			paymentMember.setPay_family_member_idx(paymentMember.getPay_member_idx());
			List<PaymentMember> familyMemberList = service.getPaymentMemberFamilyList(paymentMember);
			model.addAttribute("familyMemberList", familyMemberList);
			return  basePath + "memberEdit_ajax";
		} else {
			model.addAttribute("paymentMember", paymentMember);
			return basePath + "memberEdit";
		}
	}
	
	@RequestMapping(value = {"/getLinkMember.*"})
	public @ResponseBody JsonResponse getLinkMember(Model model, PaymentMember paymentMember, Member member, HttpServletRequest request) {
		Homepage homepage = new Homepage();
		homepage.setHomepage_id(getAsideHomepageId(request));
		JsonResponse jr = new JsonResponse();
		
		member.setMember_name(paymentMember.getPay_member_name());
		member.setUser_no(paymentMember.getLoan_number());
		
		jr.setData(PrivateMemberAPI.checkDupUser("2",member));
		
		return jr;
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
	public @ResponseBody JsonResponse save(PaymentMember paymentMember, BindingResult result, HttpServletRequest request) throws JsonParseException, JsonMappingException, IOException {
		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "pay_member_name", "이름을 입력하세요.");
		ValidationUtils.rejectOnlyEngNum(result, "loan_number", "대출번호는 영어와 숫자만 가능합니다.");
		ValidationUtils.rejectIfEmpty(result, "phone", "연락처를 입력해주세요");
		Pattern phonePattern = Pattern.compile("^01[0|1|6|7|8|9]-[\\d]{3,4}-[\\d]{4}$");
		Matcher phoneMatcher = phonePattern.matcher(paymentMember.getPhone());
		if (!phoneMatcher.matches()) {
			result.rejectValue("phone", "연락처 형식을 확인해주세요. ex) 01x-xxxx-xxxx");
		}

		if (StringUtils.isNotEmpty(paymentMember.getTel())) {
			Pattern telPattern = Pattern.compile("^[\\d]{2,3}-[\\d]{3,4}-[\\d]{4}$");
			Matcher telMatcher = telPattern.matcher(paymentMember.getTel());
			if (!telMatcher.matches()) {
				result.rejectValue("tel", "집 전화 형식을 확인해주세요. ex) xxx-xxxx-xxxx");
			}
		}

		if (StringUtils.isNotEmpty(paymentMember.getEmail1()) || StringUtils.isNotEmpty(paymentMember.getEmail2())) {
			String email = paymentMember.getEmail1()+"@"+paymentMember.getEmail2();

			Pattern emailPattern = Pattern.compile("^[_a-z0-9-]+([_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$");
			Matcher emailMatcher = emailPattern.matcher(email);

			if (!emailMatcher.matches()) {
				result.rejectValue("email1", "이메일 형식을 확인해주세요. ex) email@xxxx.com");
			}
		}
		ValidationUtils.rejectIfEmpty(result, "birth", "출생연도를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "join_start_date", "가입시작일을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "join_end_date", "가입종료일을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "use_type", "이용구분을 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "sex", "성별을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "sponsorship_amount", "금액을 입력하세요.");

		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> familyList = mapper.readValue(String.valueOf(paymentMember.getFamilyData()), List.class);

		if (familyList != null) {
			if (familyList.size() > 0) {
				for (int i = 0; i < familyList.size(); i++) {
					String family_name = (String) familyList.get(i).get("family_name");
					String family_sex = (String) familyList.get(i).get("family_sex");
					String family_phone = (String) familyList.get(i).get("family_phone");
					String family_birth = (String) familyList.get(i).get("family_birth");

					Matcher familyPhoneMatcher = phonePattern.matcher(family_phone);

					if (StringUtils.isEmpty(family_name)) {
						result.reject("가족 입력란의 "+(i+1)+"번째 이름을 입력해주세요.");
						break;
					} else if (StringUtils.isEmpty(family_sex)) {
						result.reject("가족 입력란의 "+(i+1)+"번째 성별을 선택해주세요.");
						break;
					} else if (StringUtils.isEmpty(family_phone)){
						result.reject("가족 입력란의 "+(i+1)+"번째 연락처를 입력해주세요.");
						break;
					} else if (!familyPhoneMatcher.matches()) {
						result.reject("가족 입력란의 "+(i+1)+"번째 연락처 형식을 확인해주세요. ex) 01x-xxxx-xxxx");
						break;
					} else if (StringUtils.isEmpty(family_birth)) {
						result.reject("가족 입력란의 "+(i+1)+"번째 생년월일을 입력해주세요.");
						break;
					}
				}
			}
		}

		String homepage_id = getAsideHomepageId(request);
		paymentMember.setAdd_id(getSessionMemberId(request));
		paymentMember.setHomepage_id(homepage_id);
		
		if (!result.hasErrors()) {
			paymentMember.setFamilyList(familyList);
			if ("MODIFY".equals(paymentMember.getEditMode())) {
				service.modifyPaymentMember(paymentMember);
				res.setMessage("수정되었습니다.");
				res.setValid(true);
			} else {
				service.addPaymentMember(paymentMember);
				res.setMessage("등록되었습니다.");
				res.setValid(true);
			}
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
			// service.modifyPaymentMember(paymentMember);
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
