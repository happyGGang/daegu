package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.util.List;

public interface UntactBookReservationDao {

	public int addUntactBookReservation(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationList(UntactBookReservation untactBookReservation);

	public int getUntactBookReservationCount(String homepage_id);

	public int getUntactBookReservationListCount(UntactBookReservation untactBookReservation);
	
	public int getUntactBookReservationLockerNumber(String homepage_id);

	public UntactBookReservation getUntactBookReservationOne(UntactBookReservation untactBookReservation);

}
