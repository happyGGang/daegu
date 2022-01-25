package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.util.Date;
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
	
	public int getUntactBookReservationCount(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationCount(untactBookReservation);
	}

	public int getUntactBookReservationListCount(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationListCount(untactBookReservation);
	}
	
	public int getUntactBookReservationLockerNumber(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationLockerNumber(untactBookReservation);
	}
	
	public UntactBookReservation getUntactBookReservationOne(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationOne(untactBookReservation);
	}

	public List<UntactBookReservation> getUntactBookReservationListNow(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationListNow(untactBookReservation);
	}
	
	@Transactional
	public int passwordSetting(UntactBookReservation untactBookReservation) {
		List<UntactBookReservation> list = dao.getNonPasswordList(untactBookReservation);
		Random test = new Random();
		test.setSeed(new Date().getTime());
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

	public int receiptReservationStep(UntactBookReservation untactBookReservation) {
		return dao.receiptReservationStep(untactBookReservation);
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

	public int getUntactBookReservationInfoCount(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationInfoCount(untactBookReservation);
	}

	public List<UntactBookReservation> getUntactBookReservationExcelListNow(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationExcelListNow(untactBookReservation);
	}

	public List<UntactBookReservation> smsSendALL(UntactBookReservation untactBookReservation) {
		return dao.smsSendALL(untactBookReservation);
	}

	public int getLockerPasswordCheckCount(UntactBookReservation untactBookReservation) {
		return dao.getLockerPasswordCheckCount(untactBookReservation);
	}

	public int bookReservation(UntactBookReservation untactBookReservation) {
		return dao.bookReservation(untactBookReservation);
	}

	public int waitingReservationStep(UntactBookReservation untactBookReservation) {
		return dao.waitingReservationStep(untactBookReservation);
	}

	public UntactBookReservation getReceiptList(UntactBookReservation untactBookReservation) {
		return dao.getReceiptList(untactBookReservation);
	}

	public List<UntactBookReservation> getUntactBookReservationListBefore(UntactBookReservation untactBookReservation) {
		return dao.getUntactBookReservationListBefore(untactBookReservation);
	}

	public List<UntactBookReservation> getWaitingReservationList(UntactBookReservation untactBookReservation) {
		return dao.getWaitingReservationList(untactBookReservation);
	}

	public int checkPasswordCountBefore(UntactBookReservation untactBookReservation) {
		return dao.checkPasswordCountBefore(untactBookReservation);
	}

	public int checkNonPasswordCountBefore(UntactBookReservation untactBookReservation) {
		return dao.checkNonPasswordCountBefore(untactBookReservation);
	}

	@Transactional
	public int passwordSettingBefore(UntactBookReservation untactBookReservation) {
		List<UntactBookReservation> list = dao.getNonPasswordListBefore(untactBookReservation);
		Random test = new Random();
		test.setSeed(new Date().getTime());
		for(UntactBookReservation untactBookReservationOne : list) {
			int p = (int)(Math.random()*(9 - 1 + 1))+ 1;
			String a = Integer.toString(test.nextInt(10));
			String s = Integer.toString(test.nextInt(10));
			String ss = Integer.toString(test.nextInt(10));
			int pass = Integer.parseInt(p+a+s+ss);
			untactBookReservationOne.setLocker_password(pass);
			untactBookReservationOne.setRound_idx(untactBookReservation.getRound_idx());;
			dao.insertPasswordBefore(untactBookReservationOne);
		}
		
		return 1;
	}

	public List<UntactBookReservation> getUnprocessedList(UntactBookReservation untactBookReservation) {
		return dao.getUnprocessedList(untactBookReservation);
	}

	public List<UntactBookReservation> getReservationList(UntactBookReservation untactBookReservation) {
		return dao.getReservationList(untactBookReservation);
	}

}
