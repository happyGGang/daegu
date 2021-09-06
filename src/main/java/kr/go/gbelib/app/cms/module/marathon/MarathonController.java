package kr.go.gbelib.app.cms.module.marathon;


import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
@RequestMapping(value = {"/cms/module/marathon"})
public class MarathonController extends BaseController{
	
	private final String basePath = "/cms/module/marathon/";
	
	@Autowired
	private MarathonService service;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Marathon marathon, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);
		marathon.setHomepage_id(getAsideHomepageId(request));

		service.setPaging(model, service.getMarathonContestCount(marathon), marathon);
		model.addAttribute("marathon", marathon);
		model.addAttribute("marathonContestList", service.getMarathonContestList(marathon));

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, Marathon marathon, HttpServletRequest request) throws AuthException{
		marathon.setHomepage_id(getAsideHomepageId(request));

		if(marathon.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("marathon", service.copyObjectPaging(marathon, service.getMarathonContestOne(marathon)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("marathon", marathon);
		}
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Marathon marathon, BindingResult result, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);
		marathon.setAdd_id(member.getMember_id());
		marathon.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);
		/* 유효성 검증  >>>>>>>>*/
		if(marathon.getEditMode().equals("ADD") || marathon.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "contest_name", "대회명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "application_start_day", "접수 기간 시작 일자를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "application_end_day", "접수 기간 종료 일자를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "contest_start_day", "대회 기간 시작 일자를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "contest_end_day", "대회 기간 종료 일자를 입력해 주세요.");
			ValidationUtils.rejectIfEmpty(result, "use_yn", "사용여부를 입력해 주세요.");
		}
		
		/* <<<<<<<<<<< 유효성 검증 */
		if(!result.hasErrors()) {
			if(marathon.getEditMode().equals("ADD") || marathon.getEditMode().contentEquals("MODIFY")) {
				String application_start_day = marathon.getApplication_start_day();
				String application_end_day = marathon.getApplication_end_day();
				String contest_start_day = marathon.getContest_start_day();
				String contest_end_day = marathon.getContest_end_day();
				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date application_start_date = dateFormat.parse(application_start_day);
				Date application_end_date = dateFormat.parse(application_end_day);
				Date contest_start_date = dateFormat.parse(contest_start_day);
				Date contest_end_date = dateFormat.parse(contest_end_day);
				
				if(application_start_date.compareTo(application_end_date) > 0) {
					result.reject("접수 기간 시작 일자는 접수 기간 종료 일자보다 이후일 수 없습니다.");
				}else if(contest_start_date.compareTo(contest_end_date) > 0) {
					result.reject("대회 기간 시작 일자는 대회 기간 종료 일자보다 이후일 수 없습니다.");
				}else if(application_end_date.compareTo(contest_end_date) > 0) {
					result.reject("접수 기간 종료 일자는 대회 기간 종료 일자보다 이후일 수 없습니다.");
				}
				
				if(StringUtils.isNotEmpty(marathon.getFinish_day())) {
					if(checkDate(marathon.getFinish_day()) == false) {
						result.reject("완주확정일을 날짜 형식대로 입력해 주세요.");
					}
				}
				
				
				int checkUsableContestCount = service.checkUsableContestCount(marathon);
				if(marathon.getUse_yn() == 'Y') {
					if(checkUsableContestCount > 0) {
						result.reject("이미 사용중인 대회가 있습니다.");
					}
				}
			}
		}
		
		
		if(!result.hasErrors()) {
			if(marathon.getEditMode().equals("ADD")) {
				service.addMarathonContest(marathon);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			}else if(marathon.getEditMode().equals("MODIFY")) {
				service.modifyMarathonContest(marathon);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}else if(marathon.getEditMode().equals("DELETE")) {
				service.deleteMarathonContest(marathon);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		}else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	public boolean checkDate(String checkDate) {
        try {
            SimpleDateFormat dateFormatParser = new SimpleDateFormat("yyyy-MM-dd"); //검증할 날짜 포맷 설정
            dateFormatParser.setLenient(false); //false일경우 처리시 입력한 값이 잘못된 형식일 시 오류가 발생
            dateFormatParser.parse(checkDate); //대상 값 포맷에 적용되는지 확인
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
