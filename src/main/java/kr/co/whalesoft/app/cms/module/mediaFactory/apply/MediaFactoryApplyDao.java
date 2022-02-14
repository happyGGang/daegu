package kr.co.whalesoft.app.cms.module.mediaFactory.apply;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;

public interface MediaFactoryApplyDao {
	public List<MediaFactoryApply> getApply(MediaFactoryApply apply);
	
	public List<MediaFactoryApply> getApplyMonth(MediaFactoryApply apply);
	
	public List<MediaFactoryApply> getUserApply(MediaFactoryApply apply);
	
	public MediaFactoryApply getApplyOne(MediaFactoryApply apply);
	
	public List<MediaFactoryApply> getOkApply(CalendarManage calendarManage);
	
	public int addApply(MediaFactoryApply apply);
	
	public int modifyApply(MediaFactoryApply apply);
	
	public int modifyApplyState(MediaFactoryApply apply);
	
	public int deleteApply(MediaFactoryApply apply);
	
	public int checkApply(MediaFactoryApply apply);

	public int deleteApplyAll(MediaFactoryApply apply);
}
