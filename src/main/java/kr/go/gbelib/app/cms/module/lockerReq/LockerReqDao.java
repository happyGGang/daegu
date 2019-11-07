package kr.go.gbelib.app.cms.module.lockerReq;

import java.util.List;

public interface LockerReqDao {

	public List<LockerReq> getLockerReq(LockerReq lockerReq);
	
	public List<LockerReq> getLockerUnassignReq(LockerReq lockerReq);
	
	public List<LockerReq> getLockerReqListAll(LockerReq lockerReq);

	public int getLockerReqCount(LockerReq lockerReq);
	
	public int getBlackListCheck(LockerReq lockerReq);
	
	public int getLockerApplyCheck(LockerReq lockerReq);

	public LockerReq getLockerReqOne(LockerReq lockerReq);

	public int addLockerReq(LockerReq lockerReq);

	public int modifyLocekrReq(LockerReq lockerReq);
	
	public int assingLocker(LockerReq lockerReq);
	
	public int unassingLocker(LockerReq lockerReq);

	public int modifyLocekr(LockerReq lockerReq);

	public int clearLocker(LockerReq lockerReq);
	
	public int clearLockerReq(LockerReq lockerReq);

	public int deleteReqLocker(LockerReq lockerReq);

	public List<LockerReq> getHistoryOfLockerReq(LockerReq lockerReq);
}
