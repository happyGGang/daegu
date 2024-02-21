package kr.co.whalesoft.app.cms.module.excursions.apply;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;

public interface ApplyDao {
	public List<Apply> getApply(Apply apply);
	
	public List<Apply> getApplyMonth(Apply apply);
	
	public List<Apply> getUserApply(Apply apply);
	
	public Apply getApplyOne(Apply apply);
	
	public List<Apply> getOkApply(CalendarManage calendarManage);
	
	public int addApply(Apply apply);
	
	public int modifyApply(Apply apply);
	
	public int modifyApplyFile(Apply apply);
	
	public int modifyApplyState(Apply apply);
	
	public int deleteApply(Apply apply);
	
	public int checkApply(Apply apply);

	public int deleteApplyAll(Apply apply);
}
