package kr.co.whalesoft.app.cms.module.showPerformance.apply;

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
public class ShowApplyService extends BaseService {
	
	@Autowired
	private ShowApplyDao Dao;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private LoginService loginService;
	
	@WorkingLogger(comment="공연신청 대관 관리 조회", type="P")
	public List<ShowApply> getApply(ShowApply apply) {
		return Dao.getApply(apply);
	}

	@WorkingLogger(comment="공연신청 관리 1달 조회", type="P")
	public List<ShowApply> getApplyMonth(ShowApply showApply) {
		return Dao.getApplyMonth(showApply);
	}	
	
	public List<ShowApply> getUserApply(ShowApply showApply) {
		return Dao.getUserApply(showApply);
	}
	public List<ShowApply> getNoMemberApply(ShowApply showApply) {
		return Dao.getNoMemberApply(showApply);
	}

	@WorkingLogger(comment="공연 신청자 관리 1건 조회", type="P")
	public ShowApply getApplyOne(ShowApply showApply) {
		ShowApply applyVO = Dao.getApplyOne(showApply);
		
		if(applyVO.getAgency_tel() != null) {
			String[] telStr = applyVO.getAgency_tel().split("-");
			
			applyVO.setAgency_tel_1(telStr[0]);
			if ( telStr.length > 1 ) {
				applyVO.setAgency_tel_2(telStr[1]);	
			}
			if ( telStr.length > 2 ) {
				applyVO.setAgency_tel_3(telStr[2]);	
			}
		}
		
		/*
		  if(applyVO.getApplicant_tel() != null) { String[] telStr =
		  applyVO.getApplicant_tel().split("-");
		  
		  applyVO.setApplicant_tel_1(telStr[0]); if ( telStr.length > 1 ) {
		  applyVO.setApplicant_tel_2(telStr[1]); } if ( telStr.length > 2 ) {
		  applyVO.setApplicant_tel_3(telStr[2]); } }
		 */

		return applyVO;
	}
	
	public List<ShowApply> getOkApply(CalendarManage calendarManage) {
		return Dao.getOkApply(calendarManage);
	}
	
	public String addApply(ShowApply showApply, HttpServletRequest request) {
		if ( showApply.getAgency_tel_1() != "" && showApply.getAgency_tel_2() != "" && showApply.getAgency_tel_3() != "" ) {
			showApply.setAgency_tel(String.format("%s-%s-%s", showApply.getAgency_tel_1(), showApply.getAgency_tel_2(), showApply.getAgency_tel_3()));
		}
		if ( showApply.getApplicant_tel_1() != "" && showApply.getApplicant_tel_2() != "" && showApply.getApplicant_tel_3() != "" ) {
			showApply.setApplicant_tel(String.format("%s-%s-%s", showApply.getApplicant_tel_1(), showApply.getApplicant_tel_2(), showApply.getApplicant_tel_3()));
		}
		
		String filterCheck = null;
		try {
			Member member = loginService.getSessionMember(request);
			filterCheck = webFilterCheck(member.getMember_name(), "", "", null, request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Dao.addApply(showApply);
		return filterCheck;
	}
	public String addNoMemberApply(ShowApply showApply, HttpServletRequest request) {
		if ( showApply.getAgency_tel_1() != "" && showApply.getAgency_tel_2() != "" && showApply.getAgency_tel_3() != "" ) {
			showApply.setAgency_tel(String.format("%s-%s-%s", showApply.getAgency_tel_1(), showApply.getAgency_tel_2(), showApply.getAgency_tel_3()));
		}
		if ( showApply.getApplicant_tel_1() != "" && showApply.getApplicant_tel_2() != "" && showApply.getApplicant_tel_3() != "" ) {
			showApply.setApplicant_tel(String.format("%s-%s-%s", showApply.getApplicant_tel_1(), showApply.getApplicant_tel_2(), showApply.getApplicant_tel_3()));
		}
		
		String filterCheck = null;
		try {
			Member member = loginService.getSessionMember(request);
			filterCheck = webFilterCheck(member.getMember_name(), "", "", null, request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Dao.addNoMemberApply(showApply);
		return filterCheck;
	}

	@WorkingLogger(comment="공연 신청자 관리 1건 수정", type="P")
	public int modifyApply(ShowApply showApply) {
		if ( showApply.getAgency_tel_1() != "" && showApply.getAgency_tel_2() != "" && showApply.getAgency_tel_3() != "" ) {
			showApply.setAgency_tel(String.format("%s-%s-%s", showApply.getAgency_tel_1(), showApply.getAgency_tel_2(), showApply.getAgency_tel_3()));
		}
		if ( showApply.getApplicant_tel_1() != "" && showApply.getApplicant_tel_2() != "" && showApply.getApplicant_tel_3() != "" ) {
			showApply.setApplicant_tel(String.format("%s-%s-%s", showApply.getApplicant_tel_1(), showApply.getApplicant_tel_2(), showApply.getApplicant_tel_3()));
		}
		return Dao.modifyApply(showApply);
	}
	
	public int modifyApplyState(ShowApply showApply) {
		int result = Dao.modifyApplyState(showApply);
		
		if(showApply.getApply_state().equals("3")) {
			
			ShowApply apply_temp = new ShowApply();
			apply_temp = getApplyOne(showApply);
			
			/**
			 * 신청자의 SMS 수신여부에 따라 발송한다.
			 */
			if (isSmsReceive("USERID", apply_temp.getApply_id())) {
				Homepage homepage = new Homepage(showApply.getHomepage_id());
				homepage = homepageService.getHomepageOne(homepage);
				/*PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, showApply.getApplicant_tel(), "["+apply_temp.getApplicant_name() + "] 도서관 견학 신청이 승인 되었습니다.", homepage.getHomepage_send_tell(), true);*/
			}
		}
		
		return result; 
	}

	@WorkingLogger(comment="공연신청 관리 1건 삭제", type="P")
	public int deleteApply(ShowApply showApply) {
		return Dao.deleteApply(showApply);
	}
	
	public int deleteApplyAll(ShowApply showApply) {
		return Dao.deleteApplyAll(showApply);
	}
	
	public int checkApply(ShowApply showApply) {
		return Dao.checkApply(showApply);
	}
	public int checkApplyDay(ShowApply showApply) {
		return Dao.checkApplyDay(showApply);
	}
	public int checkApplyMonth(ShowApply showApply) {
		return Dao.checkApplyMonth(showApply);
	}

}
