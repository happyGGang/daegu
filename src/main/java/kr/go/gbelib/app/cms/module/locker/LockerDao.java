package kr.go.gbelib.app.cms.module.locker;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;

public interface LockerDao {
	
	public List<Locker> getLockerAll(Locker locker);
	
	public List<Locker> getLocker(Locker locker);
	
	public int getLockerCount(Locker locker);
	
	public int getLockerPreCount(Locker locker);		
	
	public Locker getLockerOne(Locker locker);
	
	public int addLocker(Locker locker);
	
	public Locker getLockerAddFlag(Locker locker);
	
	public int updateLockerStatus(Locker locker);
	
	public int modifyLocekr(Locker locker);
	
	public int deleteLocker(Locker locker);

	public List<Locker> getLockerAllByExcel(Locker locker);
	
	public List<CalendarStatus> getLockerStatus(CalendarStatus calendarStatus);
	
	public int checkLockerStatus(Locker locker);

}
