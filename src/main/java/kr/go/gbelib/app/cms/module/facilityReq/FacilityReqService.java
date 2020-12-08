package kr.go.gbelib.app.cms.module.facilityReq;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FacilityReqService extends BaseService {

	@Autowired
	private FacilityReqDao facilityReqDao;

	public List<FacilityReq> getFacilityReqListAll(FacilityReq facilityReq) {
		return facilityReqDao.getFacilityReqListAll(facilityReq);
	}

	@WorkingLogger(comment="시설물 신청 관리 조회", type="P")
	public List<FacilityReq> getFacilityReqList(FacilityReq facilityReq) {
		return facilityReqDao.getFacilityReqList(facilityReq);
	}
	
	@WorkingLogger(comment="시설물 신청 관리 1건 조회", type="P")
	public FacilityReq getFacilityReqOne(FacilityReq facilityReq) {
		return facilityReqDao.getFacilityReqOne(facilityReq);
	}

	public int checkFacilityReq(FacilityReq facilityReq) {
		return facilityReqDao.checkFacilityReq(facilityReq);
	}
	
	public int addFacilityReq(FacilityReq facilityReq) {
		return facilityReqDao.addFacilityReq(facilityReq);
	}

	@WorkingLogger(comment="시설물 신청 관리 1건 수정", type="P")
	public int modifyFacilityReq(FacilityReq facilityReq) {
		return facilityReqDao.modifyFacilityReq(facilityReq);
	}

	@WorkingLogger(comment="시설물 신청 관리 1건 삭제", type="P")
	public int deleteFacilityReq(FacilityReq facilityReq) {
		return facilityReqDao.deleteFacilityReq(facilityReq);
	}

	public List<FacilityReq> getFacilityReqCalendar(CalendarManage calendarManage) {
		return facilityReqDao.getFacilityReqCalendar(calendarManage);
	}

	public int changeStatus(FacilityReq facilityReq) {
		return facilityReqDao.changeStatus(facilityReq);
	}

	public List<FacilityReq> getFacilityReqListByExcel(FacilityReq facilityReq) {
		return facilityReqDao.getFacilityReqListByExcel(facilityReq);
	}

	public List<FacilityReq> getApplyList(FacilityReq facilityReq) {
		return facilityReqDao.getApplyList(facilityReq);
	}
}