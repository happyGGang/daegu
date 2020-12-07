package kr.go.gbelib.app.cms.module.expReservation.expReservationApply;

import java.util.List;

public interface ExpReservationApplyDao {

	public int deleteExpApply(ExpReservationApply expApply);

	public ExpReservationApply getExpReservationApplyOne(ExpReservationApply expApply);

	public ExpReservationApply getExpReservationOne(ExpReservationApply expApply);

	public List<ExpReservationApply> getExpApplyList(ExpReservationApply expApply);

	public List<ExpReservationApply> getExpApplyDownloadList(ExpReservationApply expApply);

	public List<ExpReservationApply> getExpApplyMonth(ExpReservationApply expApply);

	public List<ExpReservationApply> getExpApplyDate(ExpReservationApply expApply);

	public Integer totalExpApplyPeople(ExpReservationApply expApply);

	public int checkExpApply(ExpReservationApply expApply);

	public int addExpApply(ExpReservationApply expApply);

	public int modifyExpApply(ExpReservationApply expApply);

	public int modifyExpApplyState(ExpReservationApply expApply);

	public ExpReservationApply getExpApplyOne(ExpReservationApply expApply);

	public int expApplyListCount(ExpReservationApply expApply);

	public List<ExpReservationApply> getExpApplyUserList(ExpReservationApply expApply);

	public Integer totalExpApply(ExpReservationApply expApply);

	public int deleteExpProgram(ExpReservationApply apply);

}
