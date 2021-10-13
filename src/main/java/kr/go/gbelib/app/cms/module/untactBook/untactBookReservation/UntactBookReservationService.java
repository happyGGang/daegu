package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	public int changeReservationStep(UntactBookReservation untactBookReservation) {
		return dao.changeReservationStep(untactBookReservation);
	}

	public int deleteAllReservation(UntactBookReservation untactBookReservation) {
		return dao.deleteAllReservation(untactBookReservation);
	}

	public List<UntactBookReservation> getUntactBookReservationListNow(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationListNow(untactBookReservation);
	}
	
	@Transactional
	public int passwordSetting(UntactBookReservation untactBookReservation) {
		List<UntactBookReservation> list = dao.getNonPasswordList(untactBookReservation);
		Random test = new Random();
		for(UntactBookReservation untactBookReservationOne : list) {
			int p = (int)(Math.random()*(9 - 1 + 1))+ 1;
			String a = Integer.toString(test.nextInt(10));
			String s = Integer.toString(test.nextInt(10));
			String ss = Integer.toString(test.nextInt(10));
			int pass = Integer.parseInt(p+a+s+ss);
			untactBookReservationOne.setLocker_password(pass);
			dao.insertPassword(untactBookReservationOne);
		}
		
		return 1;
	}

	public int modifyReservationStep(UntactBookReservation untactBookReservation) {
		return dao.modifyReservationStep(untactBookReservation);
	}

	public int cancelReservationStep(UntactBookReservation untactBookReservation) {
		return dao.cancelReservationStep(untactBookReservation);
	}

	public int checkPassword(UntactBookReservation untactBookReservation) {
		return dao.checkPassword(untactBookReservation);
	}

	public int checkPasswordCount(UntactBookReservation untactBookReservation) {
		return dao.checkPasswordCount(untactBookReservation);
	}

	public int checkNonPasswordCount(UntactBookReservation untactBookReservation) {
		return dao.checkNonPasswordCount(untactBookReservation);
	}

	public int reservationCount(UntactBookReservation untactBookReservation) {
		return dao.reservationCount(untactBookReservation);
	}

	public List<UntactBookReservation> getUntactBookReservationInfo(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationInfo(untactBookReservation);
	}

	public int cancelReserve(UntactBookReservation untactBookReservation) {
		return dao.cancelReserve(untactBookReservation);
	}

	public List<UntactBookReservation> getUntactBookReservationExcelList(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationExcelList(untactBookReservation);
	}

}
