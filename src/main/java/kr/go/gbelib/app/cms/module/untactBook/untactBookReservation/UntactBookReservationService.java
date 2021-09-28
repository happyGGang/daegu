package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class UntactBookReservationService extends BaseService {

	@Autowired
	private UntactBookReservationDao dao;
	
	public int addUntactBookReservation(UntactBookReservation untactBookReservation) {
		return dao.addUntactBookReservation(untactBookReservation);
	}
	
	public List<UntactBookReservation> getUntactBookReservationList(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationList(untactBookReservation);
	}
	
	public int getUntactBookReservationCount(String homepage_id) {
		return dao.getUntactBookReservationCount(homepage_id);
	}

	public int getUntactBookReservationListCount(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationListCount(untactBookReservation);
	}
	
	public int getUntactBookReservationLockerNumber(String homepage_id) {
		return dao.getUntactBookReservationLockerNumber(homepage_id);
	}
	
	public UntactBookReservation getUntactBookReservationOne(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationOne(untactBookReservation);
	}

}
