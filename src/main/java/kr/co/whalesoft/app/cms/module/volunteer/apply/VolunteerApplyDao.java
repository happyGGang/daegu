package kr.co.whalesoft.app.cms.module.volunteer.apply;

import java.util.List;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;

public interface VolunteerApplyDao {
	public List<VolunteerApply> getApply(VolunteerApply apply);
	
	public List<VolunteerApply> getApplyMonth(VolunteerApply apply);
	
	public List<VolunteerApply> getUserApply(VolunteerApply apply);
	
	public VolunteerApply getApplyOne(VolunteerApply apply);
	
	public List<VolunteerApply> getOkApply(CalendarManage calendarManage);
	
	public int addApply(VolunteerApply apply);
	
	public int addApplyDonggu(VolunteerApply apply);
	
	public int modifyApply(VolunteerApply apply);
	
	public int modifyApplyState(VolunteerApply apply);
	
	public int deleteApply(VolunteerApply apply);
	
	public int checkApply(VolunteerApply apply);

	public int deleteApplyAll(VolunteerApply apply);
	
	public int checkApplyDay(VolunteerApply apply);
	
	public int checkApplyMonth(VolunteerApply apply);
}
