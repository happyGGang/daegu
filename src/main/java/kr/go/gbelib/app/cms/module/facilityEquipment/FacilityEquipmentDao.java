package kr.go.gbelib.app.cms.module.facilityEquipment;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.go.gbelib.app.cms.module.facility.Facility;

import java.util.List;

public interface FacilityEquipmentDao {
	public int addFacilityEquipment(FacilityEquipment facilityEquipment);
	public List<FacilityEquipment> getFacilityEquipmentList(FacilityEquipment facilityEquipment);
	public FacilityEquipment getFacilityEquipmentOne(FacilityEquipment facilityEquipment);
	public int deleteFacilityEquipment(FacilityEquipment facilityEquipment);
}