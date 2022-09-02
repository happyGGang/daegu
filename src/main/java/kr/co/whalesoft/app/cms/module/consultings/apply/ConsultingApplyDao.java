package kr.co.whalesoft.app.cms.module.consultings.apply;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;

public interface ConsultingApplyDao {
	public List<ConsultingApply> getApply(ConsultingApply apply);
	
	public List<ConsultingApply> getApplyMonth(ConsultingApply apply);
	
	public List<ConsultingApply> getUserApply(ConsultingApply apply);
	
	public ConsultingApply getApplyOne(ConsultingApply apply);
	
	public List<ConsultingApply> getOkApply(CalendarManage calendarManage);
	
	public int addApply(ConsultingApply apply);
	
	public int modifyApply(ConsultingApply apply);
	
	public int modifyApplyState(ConsultingApply apply);
	
	public int deleteApply(ConsultingApply apply);
	
	public int checkApply(ConsultingApply apply);

	public int deleteApplyAll(ConsultingApply apply);
}
