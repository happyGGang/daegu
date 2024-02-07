package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.util.List;

public interface UntactBookReservationDao {

	public int addUntactBookReservation(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationList(UntactBookReservation untactBookReservation);

	public int getUntactBookReservationCount(UntactBookReservation untactBookReservation);

	public int getUntactBookReservationListCount(UntactBookReservation untactBookReservation);
	
	public int getUntactBookReservationLockerNumber(UntactBookReservation untactBookReservation);

	public UntactBookReservation getUntactBookReservationOne(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationListNow(UntactBookReservation untactBookReservation);

	public int getNonPasswordCount(String homepage_id);

	public int createPassword(UntactBookReservation untactBookReservation);

	public void insertPassword(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getNonPasswordList(UntactBookReservation untactBookReservation);

	public int receiptReservationStep(UntactBookReservation untactBookReservation);

	public int cancelReservationStep(UntactBookReservation untactBookReservation);

	public int checkPassword(UntactBookReservation untactBookReservation);

	public int checkPasswordCount(UntactBookReservation untactBookReservation);

	public int checkNonPasswordCount(UntactBookReservation untactBookReservation);

	public int reservationCount(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationInfo(UntactBookReservation untactBookReservation);

	public int cancelReserve(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationExcelList(UntactBookReservation untactBookReservation);

	public int getUntactBookReservationInfoCount(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationExcelListNow(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> smsSendALL(UntactBookReservation untactBookReservation);

	public int getLockerPasswordCheckCount(UntactBookReservation untactBookReservation);

	public int bookReservation(UntactBookReservation untactBookReservation);

	public int waitingReservationStep(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getReceiptList(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationListBefore(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getWaitingReservationList(UntactBookReservation untactBookReservation);

	public int checkPasswordCountBefore(UntactBookReservation untactBookReservation);

	public int checkNonPasswordCountBefore(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getNonPasswordListBefore(UntactBookReservation untactBookReservation);

	public void insertPasswordBefore(UntactBookReservation untactBookReservationOne);

	public List<UntactBookReservation> getUnprocessedList(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getReservationList(UntactBookReservation untactBookReservation);

	public int checkLockerNumber(UntactBookReservation untactBookReservation);

	public int getLockerNumber(UntactBookReservation untactBookReservation);

	public int setUntactBookReservationLockerNumber(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUnusedLockerList(UntactBookReservation untactBookReservation);

	public int changeLockerNumber(UntactBookReservation untactBookReservation);

	public int checkLockerNumberCount(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationListToday(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getNonPasswordListToday(UntactBookReservation untactBookReservation);

	public void insertPasswordToday(UntactBookReservation untactBookReservationOne);

	public UntactBookReservation getLockerPasswordCheck(UntactBookReservation untackBookReservation);

	public List<UntactBookReservation> getReceiptListToday(UntactBookReservation untactBookReservation);

	public int checkLockerNumberForChange(UntactBookReservation untactBookReservation);

	public boolean getMemberReserveYn(UntactBookReservation untactBookReservation);

	public int changeStatus(UntactBookReservation untactBookReservation);

	public int cancelReservation(UntactBookReservation untactBookReservation);

	public int deleteReservation(UntactBookReservation untactBookReservation);

}
