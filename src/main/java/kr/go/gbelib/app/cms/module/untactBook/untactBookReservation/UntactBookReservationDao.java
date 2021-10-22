package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.util.List;

public interface UntactBookReservationDao {

	public int addUntactBookReservation(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationList(UntactBookReservation untactBookReservation);

	public int getUntactBookReservationCount(String homepage_id);

	public int getUntactBookReservationListCount(UntactBookReservation untactBookReservation);
	
	public int getUntactBookReservationLockerNumber(String homepage_id);

	public UntactBookReservation getUntactBookReservationOne(UntactBookReservation untactBookReservation);

	public int changeReservationStep(UntactBookReservation untactBookReservation);

	public int deleteAllReservation(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationListNow(UntactBookReservation untactBookReservation);

	public int getNonPasswordCount(String homepage_id);

	public int createPassword(UntactBookReservation untactBookReservation);

	public void insertPassword(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getNonPasswordList(UntactBookReservation untactBookReservation);

	public int modifyReservationStep(UntactBookReservation untactBookReservation);

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

}
