package kr.go.gbelib.app.module.expReservation;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.expReservation.ExpReservation;
import kr.go.gbelib.app.cms.module.expReservation.ExpReservationService;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApply;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApplyService;
import kr.go.gbelib.app.cms.module.teach.Teach;

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
		expApply.setMember_id(getSessionMemberId(request));
		expApply.setReservation_date(expReservation.getPlan_date().replaceAll("-", ""));

		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(expReservation.getPlan_date());

		model.addAttribute("calendarList", service.getCalendar(expReservation));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate(calendarManage));
		model.addAttribute("expReservation", expReservation);
		model.addAttribute("expReservationList", service.getExpReservationList(expReservation));
		model.addAttribute("expApplyList", expApplyService.getExpApplyUserCheckList(expApply));
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
		if (expApply.getEditMode().equals("MODIFY")) { //현재는 ADD만
			//model.addAttribute("expApply", expApplyService.copyObjectPaging(expApply, expApplyService.getExpApplyOne(expApply)));
			
		} else {
			if ( now.after(sf.parse(expReservation.getReservation_date())) ) {
				service.alertMessage("신청기간이 마감되었습니다.", request, response);
				return null;
			}
			model.addAttribute("expApply", expApplyService.copyObjectPaging(expApply, expApplyService.getExpApplyOne(expApply)));
			model.addAttribute("totalPeople", expApplyService.totalExpApplyPeople(expApply));
			model.addAttribute("totalTeam", expApplyService.totalExpApply(expApply));
			
		}

		if ( "ajax".equals(expApply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "edit_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "edit";
		}
	}
	
	@RequestMapping(value = {"/applyList.*"})
	public String apply(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if ( !isLogin(request)) {
			expApply.setBefore_url(String.format("/%s/module/expReservation/index.do?menu_idx=%s", homepage.getContext_path(), expApply.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), expApply.getMenu_idx(), expApply.getBefore_url()), request, response);
			return null;
	    }
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(StringUtils.isEmpty(expApply.getSearchDateFrom())) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			expApply.setSearchDateFrom(sdf.format(cal.getTime()));
		}
		if(StringUtils.isEmpty(expApply.getSearchDateTo())) {
			expApply.setSearchDateTo(sdf.format(new Date()));
		}
		
		expApply.setMember_id(getSessionMemberId(request));
		expApply.setHomepage_id(homepage.getHomepage_id());
		
		int cnt = expApplyService.expApplyListCount(expApply);
		expApplyService.setPaging(model, cnt, expApply);
		model.addAttribute("expApplyUserList", expApplyService.getExpApplyUserList(expApply));
		model.addAttribute("expApply", expApply);

		return String.format(basePath, homepage.getFolder()) + "applyList";
	}
	
	@RequestMapping(value = {"/anonyApplyCheck.*"}, method = RequestMethod.GET)
	public String annoyApplyCheck(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		int menu_idx = expApply.getMenu_idx();
		
		ExpReservationApply expApplyReset = new ExpReservationApply(); //초기화
		expApplyReset.setHomepage_id(homepage.getHomepage_id());
		expApplyReset.setMenu_idx(menu_idx);
		model.addAttribute("expApply", expApplyReset);
		return String.format(basePath, homepage.getFolder()) + "anonyApplyCheck";
	}
	
	@RequestMapping(value = {"/anonyApplyList.*"}, method = RequestMethod.POST)
	public String anonyApplyList(Model model, ExpReservationApply expApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("expApplyCert") != null) { //세션이 있으면
			if ( ( StringUtils.isEmpty(  expApply.getMember_name()) || StringUtils.isEmpty(expApply.getMember_pw()) ) && request.getParameter("searchCheck") == null) { //새로 입력된 이름과 비밀번호 빈값체크 혹은 기간에 따른 검색일 땐 통과
				session.removeAttribute("expApplyCert");
				service.alertMessage("신청인 성명과 비밀번호를 입력해 주세요.", request, response);
				return null;
			}else {
				String member_pw = "";
				String searchDateFrom = "";
				String searchDateTo = "";
				if(expApply.getSearchDateFrom() != null) {
					searchDateFrom = expApply.getSearchDateFrom();
				}
				if(expApply.getSearchDateTo() != null) {
					searchDateTo = expApply.getSearchDateTo();
				}
				if(expApply.getMember_pw() != null) {
					member_pw = CalculateHashUtils.calculateHash(expApply.getMember_pw());
				}
				String member_name = expApply.getMember_name();
				
				expApply = (ExpReservationApply)session.getAttribute("expApplyCert");
				String member_pw_cert = expApply.getMember_pw();
				String member_name_cert = expApply.getMember_name();
				if( (member_pw.equals(member_pw_cert) && member_name.equals(member_name_cert)) || request.getParameter("searchCheck") != null) { //세션값과 새로 입력된 값 비교 (같으면)
					setExpApply(expApply, homepage, searchDateFrom, searchDateTo);
					
					expApplyService.setPaging(model, expApplyService.expAnonyApplyListCount(expApply), expApply);
					model.addAttribute("expAnonyApplyUserList", expApplyService.getExpAnonyApplyUserList(expApply));
					model.addAttribute("expApply", expApply);
					session.setAttribute("expApplyCert", expApply); //기존 신청자 세션 저장
				}else { //세션값과 새로 입력된 값 다르면
					expApply.setMember_pw(member_pw);
					expApply.setMember_name(member_name);
					
					setExpApply(expApply, homepage, searchDateFrom, searchDateTo);
					
					int cnt = expApplyService.expAnonyApplyListCount(expApply);
					if(cnt > 0) {
						expApplyService.setPaging(model, cnt, expApply);
						model.addAttribute("expAnonyApplyUserList", expApplyService.getExpAnonyApplyUserList(expApply));
						model.addAttribute("expApply", expApply);
						session.setAttribute("expApplyCert", expApply); //새로운 신청자 세션 저장
					}else {
						session.removeAttribute("expApplyCert");
						service.alertMessage("신청건이 없습니다.", request, response);
						return null;
					}
										
				}
			}
    		
		}else { //세션 저장된 값 없으면
			if (StringUtils.isNotEmpty(expApply.getMember_name()) && StringUtils.isNotEmpty(expApply.getMember_pw())) {
				String searchDateFrom = "";
				String searchDateTo = "";
				setExpApply(expApply, homepage, searchDateFrom, searchDateTo);
				expApply.setMember_pw(CalculateHashUtils.calculateHash(expApply.getMember_pw()));
	    		
	    		int cnt = expApplyService.expAnonyApplyListCount(expApply);
	    		if(cnt > 0) {
	    			expApplyService.setPaging(model, cnt, expApply);
	    			model.addAttribute("expAnonyApplyUserList", expApplyService.getExpAnonyApplyUserList(expApply));
	    			model.addAttribute("expApply", expApply);
	    			session.setAttribute("expApplyCert", expApply);
	    		}else {
	    			service.alertMessage("신청건이 없습니다.", request, response);
	    			return null;
	    		}
	    	} else {
	    		service.alertMessage("신청인 성명과 비밀번호를 입력해 주세요.", request, response);
	    		return null;
	    	}
		}

		return String.format(basePath, homepage.getFolder()) + "anonyApplyList";
	}

	private void setExpApply(ExpReservationApply expApply, Homepage homepage, String searchDateFrom, String searchDateTo) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(StringUtils.isEmpty(expApply.getSearchDateFrom()) ) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			expApply.setSearchDateFrom(sdf.format(cal.getTime()));
		}else if(!expApply.getSearchDateFrom().equals(searchDateFrom)) {
			if(searchDateFrom.equals("")) {
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.MONTH, -1);
				expApply.setSearchDateFrom(sdf.format(cal.getTime()));
			}else {
				expApply.setSearchDateFrom(searchDateFrom);
			}
		}

		if(StringUtils.isEmpty(expApply.getSearchDateTo())) {
			expApply.setSearchDateTo(sdf.format(new Date()));
		}else if(!expApply.getSearchDateTo().equals(searchDateTo)) {
			if(searchDateTo.equals("")) {
				expApply.setSearchDateTo(sdf.format(new Date()));
			}else {
				expApply.setSearchDateTo(searchDateTo);
			}
		}
		expApply.setHomepage_id(homepage.getHomepage_id());
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
			if("Y".equals(expApply.getMember_yn()) && !isLogin(request)) {
				ValidationUtils.rejectIfEmpty(result, "member_pw", "비밀번호를 입력하세요.");
			}
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
							res.setMessage("이미 신청 하였습니다.");
							return res;
						}
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
				
	            expApplyService.addExpApply(expApply);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
			else if(expApply.getEditMode().equals("MODIFY")) {
				if (expReservation.getTotal_people() > 0) {
	               if (expReservation.getTotal_people() < total + expApply.getApplication_people()) {
	                  res.setValid(false);
                      res.setMessage("최대 가능 인원을 초과하였습니다.");
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
				expApplyService.modifyExpApplyUserState(expApply);
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