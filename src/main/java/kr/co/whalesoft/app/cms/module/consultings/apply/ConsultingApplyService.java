package kr.co.whalesoft.app.cms.module.consultings.apply;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConsultingApplyService extends BaseService {
	
	@Autowired
	private ConsultingApplyDao Dao;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private LoginService loginService;
	
	@WorkingLogger(comment="상담 신청자 관리 조회", type="P")
	public List<ConsultingApply> getApply(ConsultingApply apply) {
		return Dao.getApply(apply);
	}

	@WorkingLogger(comment="상담 신청자 관리 1달 조회", type="P")
	public List<ConsultingApply> getApplyMonth(ConsultingApply apply) {
		return Dao.getApplyMonth(apply);
	}	
	
	public List<ConsultingApply> getUserApply(ConsultingApply apply) {
		return Dao.getUserApply(apply);
	}
	
	@WorkingLogger(comment="상담 신청자 관리 1건 조회", type="P")
	public ConsultingApply getApplyOne(ConsultingApply apply) {
		return Dao.getApplyOne(apply);
	}

	public List<ConsultingApply> getOkApply(CalendarManage calendarManage) {
		return Dao.getOkApply(calendarManage);
	}
	
	public String addApply(ConsultingApply apply, HttpServletRequest request) {
		if ( apply.getApplicant_tel_1() != "" && apply.getApplicant_tel_2() != "" && apply.getApplicant_tel_3() != "" ) {
			apply.setApplicant_tel(String.format("%s-%s-%s", apply.getApplicant_tel_1(), apply.getApplicant_tel_2(), apply.getApplicant_tel_3()));
		}
		String filterCheck = null;
		try {
			Member member = loginService.getSessionMember(request);
			filterCheck = webFilterCheck(member.getMember_name(), "", "", null, request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Dao.addApply(apply);
		return filterCheck;
	}

	@WorkingLogger(comment="상담 신청자 관리 1건 수정", type="P")
	public int modifyApply(ConsultingApply apply) {
		if ( apply.getApplicant_tel_1() != "" && apply.getApplicant_tel_2() != "" && apply.getApplicant_tel_3() != "" ) {
			apply.setApplicant_tel(String.format("%s-%s-%s", apply.getApplicant_tel_1(), apply.getApplicant_tel_2(), apply.getApplicant_tel_3()));
		}
		return Dao.modifyApply(apply);
	}
	
	public int modifyApplyState(ConsultingApply apply) {
		int result = Dao.modifyApplyState(apply);
		
		if(apply.getApply_state().equals("3")) {
			
			ConsultingApply apply_temp = new ConsultingApply();
			apply_temp = getApplyOne(apply);
			
			/**
			 * 신청자의 SMS 수신여부에 따라 발송한다.
			 */
			if (isSmsReceive("USERID", apply_temp.getApply_id())) {
				Homepage homepage = new Homepage(apply.getHomepage_id());
				homepage = homepageService.getHomepageOne(homepage);
				/*PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, apply.getApplicant_tel(), "["+apply_temp.getApplicant_name() + "] 도서관 견학 신청이 승인 되었습니다.", homepage.getHomepage_send_tell(), true);*/
			}
		}
		
		return result; 
	}

	@WorkingLogger(comment="상담 신청자 관리 1건 삭제", type="P")
	public int deleteApply(ConsultingApply apply) {
		return Dao.deleteApply(apply);
	}
	
	public int deleteApplyAll(ConsultingApply apply) {
		return Dao.deleteApplyAll(apply);
	}
	
	public int checkApply(ConsultingApply apply) {
		return Dao.checkApply(apply);
	}

}
