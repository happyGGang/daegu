package kr.go.gbelib.app.cms.module.locker;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LockerService extends BaseService {
	
	@Autowired
	private LockerDao dao;
	
	public List<Locker> getLockerAll(Locker locker) {
		return dao.getLockerAll(locker);
	}
	
	public List<Locker> getLocker(Locker locker) {
		return dao.getLocker(locker);
	}
	
	public int getLockerCount(Locker locker) {
		return dao.getLockerCount(locker);
	}
	
	public Locker getLockerOne(Locker locker) {
		return dao.getLockerOne(locker);
	}
	
	public Locker getLockerAddFlag(Locker locker) {
		return dao.getLockerAddFlag(locker);
	}
	
	public int updateLockerStatus(Locker Locker) {
		return dao.updateLockerStatus(Locker);
	}
	
	public int addLocker(Locker locker) {
		return dao.addLocker(locker);
	}
	
	public int modifyLocekr(Locker locker) {
		return dao.modifyLocekr(locker);
	}
	
	public int deleteLocker(Locker locker) {
		return dao.deleteLocker(locker);
	}
	
	public List<Locker> getLockerAllByExcel(Locker locker) {
		return dao.getLockerAllByExcel(locker);
	}
	
	public List<CalendarStatus> getLockerStatus(CalendarStatus calendarStatus) {
		return dao.getLockerStatus(calendarStatus);
	}
	
	public int checkLockerStatus(Locker locker) {
		return dao.checkLockerStatus(locker);
	}

}
