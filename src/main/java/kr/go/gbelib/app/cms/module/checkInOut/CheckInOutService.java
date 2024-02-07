package kr.go.gbelib.app.cms.module.checkInOut;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class CheckInOutService extends BaseService {
	
	@Autowired
	private CheckInOutDao dao;

	public int getCheckInOutCount(CheckInOut checkInOut) {
		return dao.getCheckInOutCount(checkInOut);
	}

	public List<CheckInOut> getCheckInOutList(CheckInOut checkInOut) {
		return dao.getCheckInOutList(checkInOut);
	}

	public int checkIn(CheckInOut checkInOut) {
		return dao.checkIn(checkInOut);
	}

	public int getVisitCheck(CheckInOut checkInOut) {
		return dao.getVisitCheck(checkInOut);
	}

	public CheckInOut isCheckIn(CheckInOut checkInOut) {
		return dao.isCheckIn(checkInOut);
	}
	
	public int checkOut(CheckInOut checkInOut) {
		return dao.checkOut(checkInOut);
	}

	public CheckInOut getCheckOutTime(CheckInOut checkInOut) {
		return dao.getCheckOutTime(checkInOut);
	}

	public List<CheckInOut> getChartData(CheckInOut checkInOut) {
		return dao.getChartData(checkInOut);
	}

	public int getCheckInCount(CheckInOut checkInOut) {
		return dao.getCheckInCount(checkInOut);
	}
	
	public int getCheckOutCount(CheckInOut checkInOut) {
		return dao.getCheckOutCount(checkInOut);
	}

	public List<CheckInOut> getCheckInOutExcelList(CheckInOut checkInOut) {
		return dao.getCheckInOutExcelList(checkInOut);
	}

	public boolean isCheckInCount(CheckInOut checkInOut) {
		return dao.isCheckInCount(checkInOut);
	}

	public boolean isCheckOutCount(CheckInOut checkInOut) {
		return dao.isCheckOutCount(checkInOut);
	}

	public int checkOutAll(CheckInOut checkInOut) {
		return dao.checkOutAll(checkInOut);
	}

	public List<CheckInOut> getUsageRankingList(CheckInOut checkInOut) {
		return dao.getUsageRankingList(checkInOut);
	}

	public List<CheckInOut> getHoursOfUse(CheckInOut checkInOut) {
		return dao.getHoursOfUse(checkInOut);
	}

	public int getHoursOfUseCount(CheckInOut checkInOut) {
		return dao.getHoursOfUseCount(checkInOut);
	}

	public List<CheckInOut> getUsageExcelList(CheckInOut checkInOut) {
		return dao.getUsageExcelList(checkInOut);
	}

	public List<CheckInOut> getHourOfUseExcelList(CheckInOut checkInOut) {
		return dao.getHourOfUseExcelList(checkInOut);
	}

	public List<CheckInOut> getCheckInUserAll(CheckInOut checkInOut) {
		return dao.getCheckInUserAll(checkInOut);
	}

	public List<CheckInOut> getCheckInUserDistinct(CheckInOut checkInOut) {
		return dao.getCheckInUserDistinct(checkInOut);
	}

	public List<CheckInOut> getCheckInUserBringIn(CheckInOut checkInOut) {
		return dao.getCheckInUserBringIn(checkInOut);
	}

}
