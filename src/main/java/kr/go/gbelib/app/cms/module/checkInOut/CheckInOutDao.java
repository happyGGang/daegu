package kr.go.gbelib.app.cms.module.checkInOut;

import java.util.List;

public interface CheckInOutDao {

	public int getCheckInOutCount(CheckInOut checkInOut);

	public List<CheckInOut> getCheckInOutList(CheckInOut checkInOut);

	public int checkIn(CheckInOut checkInOut);

	public int getVisitCheck(CheckInOut checkInOut);

	public CheckInOut isCheckIn(CheckInOut checkInOut);

	public int checkOut(CheckInOut checkInOut);

	public CheckInOut getCheckOutTime(CheckInOut checkInOut);

	public List<CheckInOut> getChartData(CheckInOut checkInOut);

	public int getCheckInCount(CheckInOut checkInOut);

	public int getCheckOutCount(CheckInOut checkInOut);

	public List<CheckInOut> getCheckInOutExcelList(CheckInOut checkInOut);

	public boolean isCheckInCount(CheckInOut checkInOut);

	public boolean isCheckOutCount(CheckInOut checkInOut);

	public int checkOutAll(CheckInOut checkInOut);

	public List<CheckInOut> getUsageRankingList(CheckInOut checkInOut);

	public List<CheckInOut> getHoursOfUse(CheckInOut checkInOut);

	public int getHoursOfUseCount(CheckInOut checkInOut);

	public List<CheckInOut> getUsageExcelList(CheckInOut checkInOut);

	public List<CheckInOut> getHourOfUseExcelList(CheckInOut checkInOut);

	public List<CheckInOut> getCheckInUserAll(CheckInOut checkInOut);

	public List<CheckInOut> getCheckInUserDistinct(CheckInOut checkInOut);

	public List<CheckInOut> getCheckInUserBringIn(CheckInOut checkInOut);

}
