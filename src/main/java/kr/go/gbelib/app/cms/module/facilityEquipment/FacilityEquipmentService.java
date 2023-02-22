package kr.go.gbelib.app.cms.module.facilityEquipment;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FacilityEquipmentService extends BaseService {

	@Autowired
	private FacilityEquipmentDao facilityEquipmentDao;

	public List<FacilityEquipment> getFacilityEquipmentList(FacilityEquipment facilityEquipment) {
		return facilityEquipmentDao.getFacilityEquipmentList(facilityEquipment);
	}
	
	public FacilityEquipment getFacilityEquipmentOne(FacilityEquipment facilityEquipment) {
		return facilityEquipmentDao.getFacilityEquipmentOne(facilityEquipment);
	}

	public int addFacilityEquipment(FacilityEquipment facilityEquipment) {
		return facilityEquipmentDao.addFacilityEquipment(facilityEquipment);
	}

	public int deleteFacilityEquipment(FacilityEquipment facilityEquipment) {
		return facilityEquipmentDao.deleteFacilityEquipment(facilityEquipment);
	}
}