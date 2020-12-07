package kr.go.gbelib.app.cms.module.expReservation;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApply;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApplyService;

@Controller
@RequestMapping(value = {"/cms/module/expReservation"})
public class ExpReservationController extends BaseController{

	private final String basePath = "/cms/module/expReservation/";
	
	@Autowired
	private ExpReservationService service;
	
	@Autowired
	private ExpReservationApplyService expReservationApplyService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ExpReservation expReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		if(expReservation.getPlan_date() == null || expReservation.getPlan_date().equals("")) {
			expReservation.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		expReservation.setHomepage_id(getAsideHomepageId(request));
		model.addAttribute("calendarList", service.getCalendar(expReservation));
		model.addAttribute("expReservation", expReservation);
		model.addAttribute("expReservationList", service.getExpReservationList(expReservation));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ExpReservation expReservation, HttpServletRequest request) throws AuthException {
		if(expReservation.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("expReservation", service.copyObjectPaging(expReservation, service.getExpReservationOne(expReservation)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("expReservation", expReservation);
		}
		
		model.addAttribute("expReservationOne", service.getExpReservationOne(expReservation));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(ExpReservation expReservation, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		if(expReservation.getEditMode().equals("ADD") || expReservation.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "program_name", "프로그램명을 입력하세요.");
			if(expReservation.getEditMode().equals("ADD")) {
				ValidationUtils.rejectIfEmpty(result, "member_yn", "비회원 신청여부를 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "reservation_type", "신청구분을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "from_date", "예약일을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "to_date", "예약일을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "weeks", "요일을 선택하세요.");
			}
			if(expReservation.getEditMode().equals("MODIFY")) {
				ValidationUtils.rejectIfEmpty(result, "reservation_date", "예약일을 선택하세요.");
				ExpReservationApply expApply = new ExpReservationApply(expReservation.getProgram_list_idx(), expReservation.getHomepage_id());
				List<ExpReservationApply> expApplyList = expReservationApplyService.getExpApplyList(expApply);
				if((!expApplyList.isEmpty() && expApplyList != null) && !expReservation.getReservation_type().equals(expReservation.getReservation_type_original()) ) {
					result.reject("신청이 되어 있어 신청구분을 변경할 수 없습니다.");
				}
			}
			ValidationUtils.rejectIfEmpty(result, "use_time", "이용시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "notice", "공지사항을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "usage_agreement", "이용동의안내를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "total_people", "총신청인원을 입력하세요.");
			if(expReservation.getReservation_type() != null) {
				if(expReservation.getReservation_type().equals("team")) {
					ValidationUtils.rejectIfEmpty(result, "enable_number_of_team", "신청가능팀수를 입력하세요.");
					ValidationUtils.rejectIfEmpty(result, "maximum_people_of_team", "팀별 최대신청 인원수를 입력하세요.");
				}
			}
			
			String pattern = "^([01][0-9]|2[0-3]):([0-5][0-9])(\\~)([01][0-9]|2[0-3]):([0-5][0-9])$";
			boolean regex = Pattern.matches(pattern, expReservation.getUse_time());
			if(regex) {
				expReservation.getUse_time();
			}else {
				result.reject("시간입력은 00:00~23:59 범위입니다.");
			}
			
		}
		
		if(!result.hasErrors()) {
			expReservation.setAdd_id(getSessionMemberId(request));
			expReservation.setHomepage_id(getAsideHomepageId(request));
			if(expReservation.getEditMode().equals("ADD")) {
				int addExp = service.addExpReservation(expReservation);
				if(addExp != 0) {
					res.setValid(true);
					res.setMessage("프로그램이 등록되었습니다.");
				}else {
					res.setValid(false);
					res.setMessage("예약 기간이 올바르지 않습니다.");
				}
			}else if(expReservation.getEditMode().equals("MODIFY")) {
				service.modifyExpReservation(expReservation);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}else if(expReservation.getEditMode().equals("DELETE")) {
				int del = service.deleteExpReservation(expReservation);
				if(del != 0) {
					res.setValid(true);
					res.setMessage("삭제되었습니다.");
				}else {
					res.setValid(false);
					res.setMessage("삭제되지 않았습니다.");
				}
			}
		}else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
}
