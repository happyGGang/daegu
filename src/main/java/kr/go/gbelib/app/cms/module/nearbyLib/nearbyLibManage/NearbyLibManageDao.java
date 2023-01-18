package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage;

import java.util.List;

import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibStatus.NearbyLibStatus;

public interface NearbyLibManageDao {
	public List<NearbyLibManage> getCalendar(NearbyLibManage nearbyLibManage );
	
	public List<NearbyLibManage> getNearbyLibManage(NearbyLibManage nearbyLibManage);
	
	public NearbyLibManage getNearbyLibManageOne(NearbyLibManage nearbyLibManage);
	
	public List<NearbyLibManage> getClosedDate(NearbyLibManage nearbyLibManage);
	
	public List<NearbyLibManage> getNearbyLibStatus(NearbyLibStatus nearbyLibStatus);
	
	public List<NearbyLibManage> getCalendarMonthStatus(NearbyLibStatus nearbyLibStatus);
	
	public List<NearbyLibManage> getCalendarYearStatus(NearbyLibStatus nearbyLibStatus);
	
	public int closedDateCheck(NearbyLibManage nearbyLibManage);
	
	public int addNearbyLibManage(NearbyLibManage nearbyLibManage);
	
	public int modifyNearbyLibManage(NearbyLibManage nearbyLibManage);
	
	public int deleteNearbyLibManage(NearbyLibManage nearbyLibManage);

	public NearbyLibManage getClosedDate2(NearbyLibManage nearbyLibManage);
	
	public NearbyLibManage getClosedDate3(NearbyLibManage nearbyLibManage);
	
	public NearbyLibManage getClosedDate4(NearbyLibManage nearbyLibManage);
	
	public List<NearbyLibManage> getClosedDate5(NearbyLibManage nearbyLibManage);
	
	public List<NearbyLibManage> getNearbyLibManageDetail(NearbyLibManage nearbyLibManage);

	public List<NearbyLibManage> getCalendarListType(NearbyLibManage nearbyLibManage);

	public int getNextCmIdx(NearbyLibManage nearbyLibManage);

	public NearbyLibManage getNearbyLibManageOne2(NearbyLibManage nearbyLibManage);

	public int deleteNearbyLibManageGroup(NearbyLibManage nearbyLibManage);

	public int getNearbyLibManageCheckCount(NearbyLibManage nearbyLibManage);
	
	public int isTodayClosed(String homepage_id);
}
