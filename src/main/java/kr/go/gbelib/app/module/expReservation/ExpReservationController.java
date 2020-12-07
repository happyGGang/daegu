package kr.go.gbelib.app.module.expReservation;

import java.text.SimpleDateFormat;
import java.util.Date;

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

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.expReservation.ExpReservation;
import kr.go.gbelib.app.cms.module.expReservation.ExpReservationService;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApply;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApplyService;

@Controller(value="userExpReservation")
@RequestMapping(value = {"/{homepagePath}/module/expReservation"})
public class ExpReservationController extends BaseController {
	
	private String basePath = "/homepage/%s/module/expReservation/";
	
	@Autowired
	private ExpReservationService service;

	@Autowired
	private ExpReservationApplyService expApplyService;
	

	@Autowired
	private CalendarManageService calendarManageService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ExpReservation expReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		expReservation.setHomepage_id(homepage.getHomepage_id());
		if(expReservation.getPlan_date() == null || expReservation.getPlan_date().equals("")) {
			expReservation.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		ExpReservationApply expApply = new ExpReservationApply();
		expApply.setHomepage_id(homepage.getHomepage_id());
		expApply.setExpApply_id(getSessionMemberId(request));

		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(expReservation.getPlan_date());

		model.addAttribute("calendarList", service.getCalendar(expReservation));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate(calendarManage));
		model.addAttribute("expReservation", expReservation);
		model.addAttribute("expReservationList", service.getExpReservationList(expReservation));
		if ( "ajax".equals(expReservation.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "index_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "index";
		}
			
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		Date now = new Date();//20200826174232
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
		
		ExpReservation expReservation = new ExpReservation();
		expReservation.setProgram_list_idx(expApply.getProgram_list_idx());
		expReservation = service.getExpReservationOne(expReservation);
		
		//Date parsedDate = sf.parse(expReservation.getReservation_date());//20200826000000
		
		if ( StringUtils.equals(expReservation.getMember_yn(), "N") && !isLogin(request)) {
			expApply.setBefore_url(String.format("/%s/module/expReservation/index.do?menu_idx=%s", homepage.getContext_path(), expApply.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), expApply.getMenu_idx(), expApply.getBefore_url()), request, response);
			return null;
	    }
		
		//expApply.setHomepage_id(homepage.getHomepage_id());
		if (expApply.getEditMode().equals("MODIFY")) {
			model.addAttribute("expApply", expApplyService.copyObjectPaging(expApply, expApplyService.getExpReservationOne(expApply)));
			
		} else {
			model.addAttribute("expApply", expApplyService.copyObjectPaging(expApply, expApplyService.getExpApplyOne(expApply)));
			model.addAttribute("totalPeople", expApplyService.totalExpApplyPeople(expApply));
			model.addAttribute("totalTeam", expApplyService.totalExpApply(expApply));
			if ( now.after(sf.parse(expReservation.getReservation_date())) ) {
				service.alertMessage("신청불가합니다.", request, response);
				return null;
			}
		}

		if ( "ajax".equals(expApply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "edit_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "edit";
		}
	}
	
	@RequestMapping(value = {"/apply.*"})
	public String apply(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if ( !isLogin(request)) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), expApply.getMenu_idx(), expApply.getBefore_url()), request, response);
			return null;
	    }
		
		expApply.setMember_id(getSessionMemberId(request));
		expApply.setHomepage_id(homepage.getHomepage_id());
		
		int cnt = expApplyService.expApplyListCount(expApply);
		expApplyService.setPaging(model, cnt, expApply);
		model.addAttribute("expUserApplyList", expApplyService.getExpApplyUserList(expApply));
		model.addAttribute("expApply", expApply);

		return String.format(basePath, homepage.getFolder()) + "apply";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, ExpReservationApply expApply, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		JsonResponse res = new JsonResponse(request);
		if(expApply.getEditMode().equals("ADD") || expApply.getEditMode().equals("MODIFY")) {
			if (!"Y".equals(expApply.getUsage_agreement_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}
			
			if ( !"Y".equals(expApply.getMember_yn()) && !isLogin(request)) {
				expApply.setBefore_url(String.format("/%s/module/expReservation/index.do", homepage.getContext_path()));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), expApply.getMenu_idx(), expApply.getBefore_url()), request, response);
				return null;
		    }
			ValidationUtils.rejectIfEmpty(result, "member_name", "성명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "member_phone", "연락처를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "member_email", "이메일을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "application_people", "신청인원을 입력하세요.");
		}
		
		ExpReservation expReservation = service.getExpReservationOne(new ExpReservation(expApply.getHomepage_id(), expApply.getProgram_list_idx()));
		
		Integer total = expApplyService.totalExpApplyPeople(expApply);
		Integer totalTeam = expApplyService.totalExpApply(expApply);
		if (total == null) {
			total = 0;
		}
		if (totalTeam == null) {
			totalTeam = 0;
		}

		if(!result.hasErrors()) {
			expApply.setMember_id(getSessionMemberId(request));
			if(expApply.getEditMode().equals("ADD")) {
				if(!"Y".equals(expApply.getMember_yn())) {
					if(expApply.getMember_id() != null) {
						if(expApplyService.checkExpApply(expApply) > 0) {
							res.setValid(false);
							res.setMessage("이미 신청 되었습니다.");
							return res;
						}
					}
				}
				
	            if (expReservation.getTotal_people() > 0) {
	               if (expReservation.getTotal_people() < total + expApply.getApplication_people()) {
	                  res.setValid(false);
                      res.setMessage("신청인원이 가득찼습니다.");
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
				
	            expApplyService.addExpApply(expApply);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
			else if(expApply.getEditMode().equals("MODIFY")) {
				if (expReservation.getTotal_people() > 0) {
	               if (expReservation.getTotal_people() < total + expApply.getApplication_people()) {
	                  res.setValid(false);
                      res.setMessage("신청인원이 가득찼습니다.");
                      return res;
	               }
	            }
				
				expApplyService.modifyExpApply(expApply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(expApply.getEditMode().equals("DELETE")) {
				expApplyService.deleteExpApply(expApply);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
			else if (expApply.getEditMode().equals("CANCEL")) {
				expApplyService.modifyExpApplyState(expApply);
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