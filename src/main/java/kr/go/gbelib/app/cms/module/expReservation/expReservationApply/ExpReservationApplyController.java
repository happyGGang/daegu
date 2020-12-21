package kr.go.gbelib.app.cms.module.expReservation.expReservationApply;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.expReservation.ExpReservation;
import kr.go.gbelib.app.cms.module.expReservation.ExpReservationService;

@Controller
@RequestMapping(value = {"/cms/module/expReservation/expReservationApply"})
public class ExpReservationApplyController extends BaseController {

	private final String basePath = "/cms/module/expReservation/expReservationApply/";
	
	@Autowired
	private ExpReservationApplyService service;
	
	@Autowired
	private ExpReservationService expReservationService;
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ExpReservationApply expApply) {
		if(expApply.getEditMode().equals("MODIFY")) {
			model.addAttribute("expApply", service.copyObjectPaging(expApply, service.getExpReservationApplyOne(expApply)));
			model.addAttribute("totalPeople", service.totalExpApplyPeople(expApply));
			model.addAttribute("totalTeam", service.totalExpApply(expApply));
		}else {
			model.addAttribute("expApply", service.getExpReservationOne(expApply));
			model.addAttribute("totalPeople", service.totalExpApplyPeople(expApply));
			model.addAttribute("totalTeam", service.totalExpApply(expApply));
		}
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/applyEdit.*"})
	public String applyEdit(Model model, ExpReservationApply expApply) {
		model.addAttribute("expApplyList", service.getExpApplyList(expApply));
		model.addAttribute("expApply", expApply);
		return basePath + "applyEdit_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public ExpReservationApplySearchView excel(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) {
		model.addAttribute("expApply", expApply);
		model.addAttribute("expUserApplyList", service.getExpApplyDownloadList(expApply));
		return new ExpReservationApplySearchView();
	}
	
	@RequestMapping(value = {"/excelDownloadMonth.*"}, method = RequestMethod.POST)
	public ExpReservationApplySearchView excelDownloadMonth(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("expApply", expApply);
		model.addAttribute("expUserApplyList", service.getExpApplyMonth(expApply));
		return new ExpReservationApplySearchView();
	}
	
	@RequestMapping(value = {"/excelDownloadDate.*"}, method = RequestMethod.POST)
	public ExpReservationApplySearchView excelDownloadDate(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("expApply", expApply);
		model.addAttribute("expUserApplyList", service.getExpApplyDate(expApply));
		return new ExpReservationApplySearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<ExpReservationApply> applyResult = service.getExpApplyDownloadList(expApply);
		new ExpReservationApplyXlsToCsv(expApply, applyResult, "프로그램신청현황 리스트.csv", request, response);
	}
	
	@RequestMapping(value = {"/csvDownloadMonth.*"}, method = RequestMethod.POST)
	public void csvDownloadMonth(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<ExpReservationApply> applyResult = service.getExpApplyMonth(expApply);
		new ExpReservationApplyXlsToCsv(expApply, applyResult, expApply.getPlan_date() + "프로그램신청현황 리스트.csv", request, response);
	}
	
	@RequestMapping(value = {"/csvDownloadDate.*"}, method = RequestMethod.POST)
	public void csvDownloadDate(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<ExpReservationApply> applyResult = service.getExpApplyDate(expApply);
		new ExpReservationApplyXlsToCsv(expApply, applyResult, "프로그램신청현황 리스트.csv", request, response);
	}
	
	@RequestMapping(value = {"/stateEdit.*"})
	public String stateEdit(Model model, ExpReservationApply expApply) {
		model.addAttribute("expApply", service.copyObjectPaging(expApply, service.getExpReservationApplyOne(expApply)));
		return basePath + "stateEdit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(ExpReservationApply expApply, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(expApply.getEditMode().equals("ADD") || expApply.getEditMode().equals("MODIFY")) {
			if (!"Y".equals(expApply.getUsage_agreement_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}
			
			ValidationUtils.rejectIfEmpty(result, "member_id", "아이디를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "member_name", "성명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "member_phone", "연락처를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "member_email", "이메일을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "application_people", "신청인원을 입력하세요.");
		}
		
		ExpReservation expReservation = expReservationService.getExpReservationOne(new ExpReservation(expApply.getHomepage_id(), expApply.getProgram_list_idx()));
		
		Integer total = service.totalExpApplyPeople(expApply);
		Integer totalTeam = service.totalExpApply(expApply);
		if (total == null) {
			total = 0;
		}
		
		if (totalTeam == null) {
			totalTeam = 0;
		}
		
		if(!result.hasErrors()) {
			if(expApply.getEditMode().equals("ADD")) {
				if(!expApply.getMember_id().equals("") || expApply.getMember_id() == null) {
					if(service.checkExpApply(expApply) > 0) {
						res.setValid(false);
						res.setMessage("이미 신청 되었습니다.");
						return res;
					}
				}
	            if (expReservation.getTotal_people() > 0) {
	               if (expReservation.getTotal_people() < total + expApply.getApplication_people()) {
	                  res.setValid(false);
                      res.setMessage("최대 가능 인원을 초과하였습니다.");
                      return res;
	               }
	            }
	            if (expReservation.getReservation_type().equals("team")) {
    	            if (expReservation.getEnable_number_of_team() > 0) {
    	            	if (expReservation.getEnable_number_of_team() < totalTeam + 1) {
    	            		res.setValid(false);
    	            		res.setMessage("신청 가능 팀수를 초과하였습니다.");
    	            		return res;
    	            	}
    	            }
    	            if (expReservation.getMaximum_people_of_team() > 0) {
    	            	if (expReservation.getMaximum_people_of_team() < expApply.getApplication_people()) {
    	            		res.setValid(false);
    	            		res.setMessage("팀별 최대신청 인원수를 초과하였습니다.");
    	            		return res;
    	            	}
    	            }
	            }

				service.addExpApply(expApply);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
			else if(expApply.getEditMode().equals("MODIFY")) {
				if(!expApply.getMember_id().equals("") || expApply.getMember_id() == null) {
					if(service.checkExpApply(expApply) > 0) {
						res.setValid(false);
						res.setMessage("이미 신청 하였습니다.");
						return res;
					}
				}
				if (expReservation.getTotal_people() > 0 ) {
	               if (expReservation.getTotal_people() < total + expApply.getApplication_people()) {
	                  res.setValid(false);
                      res.setMessage("최대 가능 인원을 초과하였습니다.");
                      return res;
	               } 
	            }
				if (expReservation.getReservation_type().equals("team")) {
    	            if (expReservation.getEnable_number_of_team() > 0) {
    	            	if (expReservation.getEnable_number_of_team() < totalTeam + 1) {
    	            		res.setValid(false);
    	            		res.setMessage("신청 가능 팀수를 초과하였습니다.");
    	            		return res;
    	            	}
    	            }
    	            if (expReservation.getMaximum_people_of_team() > 0) {
    	            	if (expReservation.getMaximum_people_of_team() < expApply.getApplication_people()) {
    	            		res.setValid(false);
    	            		res.setMessage("팀별 최대신청 인원수를 초과하였습니다.");
    	            		return res;
    	            	}
    	            }
	            }

				expApply.setModify_id(getSessionMemberId(request));
				service.modifyExpApply(expApply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(expApply.getEditMode().equals("STATEMODIFY")) {
				expApply.setModify_id(getSessionMemberId(request));
				service.modifyExpApplyState(expApply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(expApply.getEditMode().equals("DELETE")) {
				service.deleteExpApply(expApply);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
			else if (expApply.getEditMode().equals("CANCEL")) {
				service.modifyExpApplyState(expApply);
				res.setValid(true);
				res.setMessage("취소 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		
		return res;
	}
}
