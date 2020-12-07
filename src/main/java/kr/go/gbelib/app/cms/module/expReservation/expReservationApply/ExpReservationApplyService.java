package kr.go.gbelib.app.cms.module.expReservation.expReservationApply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class ExpReservationApplyService extends BaseService{

	@Autowired
	private ExpReservationApplyDao dao;

	public int deleteExpApply(ExpReservationApply expApply) {
		return dao.deleteExpApply(expApply);
	}

	public ExpReservationApply getExpReservationApplyOne(ExpReservationApply expApply) {
		return dao.getExpReservationApplyOne(expApply);
	}

	public ExpReservationApply getExpReservationOne(ExpReservationApply expApply) {
		return dao.getExpReservationOne(expApply);
	}

	public List<ExpReservationApply> getExpApplyList(ExpReservationApply expApply) {
		return dao.getExpApplyList(expApply);
	}

	public List<ExpReservationApply> getExpApplyDownloadList(ExpReservationApply expApply) {
		return dao.getExpApplyDownloadList(expApply);
	}

	public List<ExpReservationApply> getExpApplyMonth(ExpReservationApply expApply) {
		return dao.getExpApplyMonth(expApply);
	}

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

	public int addExpApply(ExpReservationApply expApply) {
		if(expApply.getMember_id() == null) {
			expApply.setMember_id("");
		}
		if(expApply.getMember_id().equals("")) {
			expApply.setMember_id("ANONYMOUS");
		}
		return dao.addExpApply(expApply);
	}

	public int modifyExpApply(ExpReservationApply expApply) {
		if(expApply.getMember_id() == null) {
			expApply.setMember_id("");
		}
		if(expApply.getMember_id().equals("")) {
			expApply.setMember_id("ANONYMOUS");
		}
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

	public int deleteExpProgram(ExpReservationApply apply) {
		return dao.deleteExpProgram(apply);
	}

}
