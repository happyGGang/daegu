package kr.go.gbelib.app.cms.module.facilityReq;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;

public interface FacilityReqDao  {

	public List<FacilityReq> getFacilityReqListAll(FacilityReq facilityReq);
	
	public List<FacilityReq> getFacilityReqList(FacilityReq facilityReq);
	
	public FacilityReq getFacilityReqOne(FacilityReq facilityReq);
	
	public int checkFacilityReq(FacilityReq facilityReq);
	
	public int addFacilityReq(FacilityReq facilityReq);
	
	public int modifyFacilityReq(FacilityReq facilityReq);
	
	public int deleteFacilityReq(FacilityReq facilityReq);

	public List<FacilityReq> getFacilityReqCalendar(CalendarManage calendarManage);

	public int changeStatus(FacilityReq facilityReq);

	public List<FacilityReq> getFacilityReqListByExcel(FacilityReq facilityReq);

	public List<FacilityReq> getApplyList(FacilityReq facilityReq);
}