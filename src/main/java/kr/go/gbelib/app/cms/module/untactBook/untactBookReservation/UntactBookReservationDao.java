package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.util.List;

public interface UntactBookReservationDao {

	public int addUntactBookReservation(UntactBookReservation untactBookReservation);

	public List<UntactBookReservation> getUntactBookReservationList(String homepage_id);

	public int getUntactBookReservationCount(String homepage_id);

}
