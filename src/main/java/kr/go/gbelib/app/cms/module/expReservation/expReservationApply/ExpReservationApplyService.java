package kr.go.gbelib.app.cms.module.expReservation.expReservationApply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class ExpReservationApplyService extends BaseService{

	@Autowired
	private ExpReservationApplyDao dao;

	public int deleteExpApply(ExpReservationApply expApply) {
		return dao.deleteExpApply(expApply);
	}

	@WorkingLogger(comment="체험예약관리 신청자 조회", type="P")
	public ExpReservationApply getExpReservationApplyOne(ExpReservationApply expApply) {
		return dao.getExpReservationApplyOne(expApply);
	}

	public ExpReservationApply getExpReservationOne(ExpReservationApply expApply) {
		return dao.getExpReservationOne(expApply);
	}

	@WorkingLogger(comment="체험예약관리 신청자 목록 조회", type="P")
	public List<ExpReservationApply> getExpApplyList(ExpReservationApply expApply) {
		return dao.getExpApplyList(expApply);
	}

	@WorkingLogger(comment="체험예약관리 신청자 목록 조회(전체 엑셀 저장)", type="P")
	public List<ExpReservationApply> getExpApplyDownloadList(ExpReservationApply expApply) {
		return dao.getExpApplyDownloadList(expApply);
	}

	@WorkingLogger(comment="체험예약관리 신청자 목록 조회(한달 엑셀 저장)", type="P")
	public List<ExpReservationApply> getExpApplyMonth(ExpReservationApply expApply) {
		return dao.getExpApplyMonth(expApply);
	}

	@WorkingLogger(comment="체험예약관리 신청자 목록 조회(하루 엑셀 저장)", type="P")
	public List<ExpReservationApply> getExpApplyDate(ExpReservationApply expApply) {
		return dao.getExpApplyDate(expApply);
	}

	public Integer totalExpApplyPeople(ExpReservationApply expApply) {
		return dao.totalExpApplyPeople(expApply);
	}
	
	public Integer totalExpApply(ExpReservationApply expApply) {
		return dao.totalExpApply(expApply);
	}

	public int checkExpApply(ExpReservationApply expApply) {
		return dao.checkExpApply(expApply);
	}

	@WorkingLogger(comment="체험예약관리 신청자 등록", type="P")
	public int addExpApply(ExpReservationApply expApply) {
		if(expApply.getMember_id() == null) {
			expApply.setMember_id("ANONYMOUS");
		}
		if(expApply.getMember_pw() != null) {
			expApply.setMember_pw(CalculateHashUtils.calculateHash(expApply.getMember_pw()));
		}
		return dao.addExpApply(expApply);
	}

	@WorkingLogger(comment="체험예약관리 신청자 수정", type="P", tableName = "EXP_RESERVATION")
	public int modifyExpApply(ExpReservationApply expApply) {
		return dao.modifyExpApply(expApply);
	}

	public int modifyExpApplyState(ExpReservationApply expApply) {
		return dao.modifyExpApplyState(expApply);
	}

	public ExpReservationApply getExpApplyOne(ExpReservationApply expApply) {
		return dao.getExpApplyOne(expApply);
	}

	public int expApplyListCount(ExpReservationApply expApply) {
		return dao.expApplyListCount(expApply);
	}

	public List<ExpReservationApply> getExpApplyUserList(ExpReservationApply expApply) {
		return dao.getExpApplyUserList(expApply);
	}
	
	public int expAnonyApplyListCount(ExpReservationApply expApply) {
		return dao.expAnonyApplyListCount(expApply);
	}

	public List<ExpReservationApply> getExpAnonyApplyUserList(ExpReservationApply expApply) {
		return dao.getExpAnonyApplyUserList(expApply);
	}

	public int deleteExpProgram(ExpReservationApply apply) {
		return dao.deleteExpProgram(apply);
	}

	public List<ExpReservationApply> getExpApplyUserCheckList(ExpReservationApply expApply) {
		return dao.getExpApplyUserCheckList(expApply);
	}

	public int modifyExpApplyUserState(ExpReservationApply expApply) {
		return dao.modifyExpApplyUserState(expApply);
	}

}
