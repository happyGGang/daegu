package kr.go.gbelib.app.cms.module.walkingThru.walkingThruRecord;

import java.util.List;

public interface WalkingThruRecordDao {

	List<WalkingThruRecord> getWalkingThruRecordList(WalkingThruRecord walkingThruRecord);

	List<WalkingThruRecord> getWalkingThruRecordListBefore(WalkingThruRecord walkingThruRecord);

	List<WalkingThruRecord> getWalkingThruRecordListAll(WalkingThruRecord walkingThruRecord);

	List<WalkingThruRecord> getWalkingThruRecordUnprocessedList(WalkingThruRecord walkingThruRecord);

	int getWalkingThruRecordListCount(WalkingThruRecord walkingThruRecord);

	int getWalkingThruRecordListBeforeCount(WalkingThruRecord walkingThruRecord);

	int getWalkingThruRecordListAllCount(WalkingThruRecord walkingThruRecord);

	int addWalkingThruRecord(WalkingThruRecord walkingThruRecord);

	WalkingThruRecord getWalkingThruRecordOne(WalkingThruRecord walkingThruRecord);

	List<WalkingThruRecord> getWaitingReservationList(WalkingThruRecord walkingThruRecord);

	int waitingReservationStep(WalkingThruRecord walkingThruRecord);

	int bookReservation(WalkingThruRecord walkingThruRecord);

	int cancelReservationStep(WalkingThruRecord walkingThruRecord);

	int checkPasswordCount(WalkingThruRecord walkingThruRecord);

	int checkNonPasswordCount(WalkingThruRecord walkingThruRecord);

	List<WalkingThruRecord> getNonPasswordList(WalkingThruRecord walkingThruRecord);

	void insertPasswordBefore(WalkingThruRecord walkingThruRecordOne);

	void insertPassword(WalkingThruRecord walkingThruRecordOne);

	List<WalkingThruRecord> getWalkingThruRecordExcelListNow(WalkingThruRecord walkingThruRecord);

	int checkPassword(WalkingThruRecord walkingThruRecord);

	int checkPasswordCountBefore(WalkingThruRecord walkingThruRecord);

	int checkNonPasswordCountBefore(WalkingThruRecord walkingThruRecord);

	List<WalkingThruRecord> getNonPasswordListBefore(WalkingThruRecord walkingThruRecord);

	int getWalkingThruRecordInfoCount(WalkingThruRecord walkingThruRecord);

	List<WalkingThruRecord> getWalkingThruRecordInfo(WalkingThruRecord walkingThruRecord);

	List<WalkingThruRecord> getReservationList(WalkingThruRecord walkingThruRecord);

	int cancelReserve(WalkingThruRecord walkingThruRecord);


}
