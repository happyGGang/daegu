package kr.co.whalesoft.app.cms.module.excursions.apply;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.common.api.PushAPI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ApplyService extends BaseService {
	
	
	@Autowired
	private ApplyDao Dao;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private LoginService loginService;

	@WorkingLogger(comment="견학/체험 신청자 관리 조회", type="P")
	public List<Apply> getApply(Apply apply) {
		return Dao.getApply(apply);
	}

	@WorkingLogger(comment="견학/체험 신청자 관리 1달 조회", type="P")
	public List<Apply> getApplyMonth(Apply apply) {
		return Dao.getApplyMonth(apply);
	}	
	
	public List<Apply> getUserApply(Apply apply) {
		return Dao.getUserApply(apply);
	}

	@WorkingLogger(comment="견학/체험 신청자 관리 1건 조회", type="P")
	public Apply getApplyOne(Apply apply) {
		Apply applyVO = Dao.getApplyOne(apply);
		
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
		
		return applyVO;
	}
	
	public Apply getApplyDownOne(Apply apply) {
		Apply applyVO = Dao.getApplyOne(apply);
		return applyVO;
	}
	
	public List<Apply> getOkApply(CalendarManage calendarManage) {
		return Dao.getOkApply(calendarManage);
	}
	
	public String addApply(Apply apply, HttpServletRequest request) {
		if ( apply.getAgency_tel_1() != "" && apply.getAgency_tel_2() != "" && apply.getAgency_tel_3() != "" ) {
			apply.setAgency_tel(String.format("%s-%s-%s", apply.getAgency_tel_1(), apply.getAgency_tel_2(), apply.getAgency_tel_3()));
		}
		if ( apply.getApplicant_tel_1() != "" && apply.getApplicant_tel_2() != "" && apply.getApplicant_tel_3() != "" ) {
			apply.setApplicant_tel(String.format("%s-%s-%s", apply.getApplicant_tel_1(), apply.getApplicant_tel_2(), apply.getApplicant_tel_3()));
		}
		if ( apply.getGuide_tel_1() != "" && apply.getGuide_tel_2() != "" && apply.getGuide_tel_3() != "" ) {
			apply.setGuide_tel(String.format("%s-%s-%s", apply.getGuide_tel_1(), apply.getGuide_tel_2(), apply.getGuide_tel_3()));
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

	@WorkingLogger(comment="견학/체험 신청자 관리 1건 수정", type="P")
	public int modifyApply(Apply apply) {
		if ( apply.getAgency_tel_1() != "" && apply.getAgency_tel_2() != "" && apply.getAgency_tel_3() != "" ) {
			apply.setAgency_tel(String.format("%s-%s-%s", apply.getAgency_tel_1(), apply.getAgency_tel_2(), apply.getAgency_tel_3()));
		}
		if ( apply.getApplicant_tel_1() != "" && apply.getApplicant_tel_2() != "" && apply.getApplicant_tel_3() != "" ) {
			apply.setApplicant_tel(String.format("%s-%s-%s", apply.getApplicant_tel_1(), apply.getApplicant_tel_2(), apply.getApplicant_tel_3()));
		}
		if ( apply.getGuide_tel_1() != "" && apply.getGuide_tel_2() != "" && apply.getGuide_tel_3() != "" ) {
			apply.setGuide_tel(String.format("%s-%s-%s", apply.getGuide_tel_1(), apply.getGuide_tel_2(), apply.getGuide_tel_3()));
		}
		return Dao.modifyApply(apply);
	}
	@WorkingLogger(comment="견학/체험 신청자 관리 1건 수정", type="P")
	public int modifyApplyFile(Apply apply) {
		if ( apply.getAgency_tel_1() != "" && apply.getAgency_tel_2() != "" && apply.getAgency_tel_3() != "" ) {
			apply.setAgency_tel(String.format("%s-%s-%s", apply.getAgency_tel_1(), apply.getAgency_tel_2(), apply.getAgency_tel_3()));
		}
		if ( apply.getApplicant_tel_1() != "" && apply.getApplicant_tel_2() != "" && apply.getApplicant_tel_3() != "" ) {
			apply.setApplicant_tel(String.format("%s-%s-%s", apply.getApplicant_tel_1(), apply.getApplicant_tel_2(), apply.getApplicant_tel_3()));
		}
		if ( apply.getGuide_tel_1() != "" && apply.getGuide_tel_2() != "" && apply.getGuide_tel_3() != "" ) {
			apply.setGuide_tel(String.format("%s-%s-%s", apply.getGuide_tel_1(), apply.getGuide_tel_2(), apply.getGuide_tel_3()));
		}
		return Dao.modifyApplyFile(apply);
	}
	
	public int modifyApplyState(Apply apply) {
		int result = Dao.modifyApplyState(apply);
		
		if(apply.getApply_state().equals("3")) {
			
			Apply apply_temp = new Apply();
			apply_temp = getApplyOne(apply);
			
			/**
			 * 신청자의 SMS 수신여부에 따라 발송한다.
			 */
			if (isSmsReceive("USERID", apply_temp.getApply_id())) {
				Homepage homepage = new Homepage(apply.getHomepage_id());
				homepage = homepageService.getHomepageOne(homepage);
				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, apply.getApplicant_tel(), "["+apply_temp.getApplicant_name() + "] 도서관 견학 신청이 승인 되었습니다.", homepage.getHomepage_send_tell(), true);
			}
		}
		
		return result; 
	}

	@WorkingLogger(comment="견학/체험 신청자 관리 1건 삭제", type="P")
	public int deleteApply(Apply apply) {
		return Dao.deleteApply(apply);
	}
	
	public int deleteApplyAll(Apply apply) {
		return Dao.deleteApplyAll(apply);
	}
	
	public int checkApply(Apply apply) {
		return Dao.checkApply(apply);
	}

}
