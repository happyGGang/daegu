package kr.co.whalesoft.app.cms.module.showPerformance.apply;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;

public interface ShowApplyDao {
	public List<ShowApply> getApply(ShowApply showApply);
	
	public List<ShowApply> getApplyMonth(ShowApply showApply);
	
	public List<ShowApply> getUserApply(ShowApply showApply);
	
	public ShowApply getApplyOne(ShowApply showApply);
	
	public List<ShowApply> getOkApply(CalendarManage calendarManage);
	
	public int addApply(ShowApply showApply);
	
	public int addNoMemberApply(ShowApply showApply);

	public int addApplyDonggu(ShowApply showApply);
	
	public int modifyApply(ShowApply showApply);
	
	public int modifyApplyState(ShowApply showApply);
	
	public int deleteApply(ShowApply showApply);
	
	public int checkApply(ShowApply showApply);

	public int deleteApplyAll(ShowApply showApply);
	
	public int checkApplyDay(ShowApply showApply);
	
	public int checkApplyMonth(ShowApply showApply);

	public List<ShowApply> getNoMemberApply(ShowApply showApply);

}
