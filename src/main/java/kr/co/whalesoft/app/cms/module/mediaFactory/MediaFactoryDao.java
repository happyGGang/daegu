package kr.co.whalesoft.app.cms.module.mediaFactory;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.mediaFactory.apply.MediaFactoryApply;

public interface MediaFactoryDao {
	public List<Calendar> getCalendar(MediaFactory mediaFactory);
	
	public List<MediaFactory> getMediaFactory(MediaFactory mediaFactory);
	
	public MediaFactory getMediaFactoryOne(MediaFactory mediaFactory);
	
	public int getMediaFactoryDateCheck(MediaFactoryApply apply);
	
	public int addMediaFactory(MediaFactory mediaFactory);
	
	public int modifyMediaFactory(MediaFactory mediaFactory);
	
	public int deleteMediaFactory(MediaFactory mediaFactory);
	
	public int countMediaFactory(MediaFactory mediaFactory);
	
	public int countClosedMediaFactory(MediaFactory mediaFactory);
	
	public List<CalendarStatus> getMediaFactoryStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getMediaFactoryMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getMediaFactoryYearStatus(CalendarStatus calendarStatus);

	String getCodeName(MediaFactory mediaFactory);
}
