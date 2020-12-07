package kr.go.gbelib.app.cms.module.expReservation;

import java.util.Calendar;
import java.util.List;

public interface ExpReservationDao {

	public List<Calendar> getCalendar(ExpReservation expReservation);

	public List<ExpReservation> getExpReservationList(ExpReservation expReservation);

	public ExpReservation getExpReservationOne(ExpReservation expReservation);

	public int modifyExpReservation(ExpReservation expReservation);

	public int addExpReservation(ExpReservation expReservation);

	public int deleteExpReservation(ExpReservation expReservation);

}
