package kr.go.gbelib.app.cms.module.walkingThru.walkingThruRecord;

import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class WalkingThruRecordService extends BaseService {

	@Autowired
	WalkingThruRecordDao dao;

	public List<WalkingThruRecord> getWalkingThruRecordList(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordList(walkingThruRecord);
	}

	public List<WalkingThruRecord> getWalkingThruRecordListBefore(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordListBefore(walkingThruRecord);
	}
	
	public List<WalkingThruRecord> getWalkingThruRecordListAll(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordListAll(walkingThruRecord);
	}

	public List<WalkingThruRecord> getWalkingThruRecordUnprocessedList(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordUnprocessedList(walkingThruRecord);
	}

	public int getWalkingThruRecordListCount(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordListCount(walkingThruRecord);
	}

	public int getWalkingThruRecordListBeforeCount(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordListBeforeCount(walkingThruRecord);
	}
	
	public int getWalkingThruRecordListAllCount(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordListAllCount(walkingThruRecord);
	}

	public int addWalkingThruRecord(WalkingThruRecord walkingThruRecord) {
		return dao.addWalkingThruRecord(walkingThruRecord);
	}

	public WalkingThruRecord getWalkingThruRecordOne(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordOne(walkingThruRecord);
	}

	public List<WalkingThruRecord> getWaitingReservationList(WalkingThruRecord walkingThruRecord) {
		return dao.getWaitingReservationList(walkingThruRecord);
	}

	public int waitingReservationStep(WalkingThruRecord walkingThruRecord) {
		return dao.waitingReservationStep(walkingThruRecord);
	}

	public int bookReservation(WalkingThruRecord walkingThruRecord) {
		return dao.bookReservation(walkingThruRecord);
	}

	public int cancelReservationStep(WalkingThruRecord walkingThruRecord) {
		return dao.cancelReservationStep(walkingThruRecord);
	}

	public int checkPasswordCount(WalkingThruRecord walkingThruRecord) {
		return dao.checkPasswordCount(walkingThruRecord);
	}

	public int checkNonPasswordCount(WalkingThruRecord walkingThruRecord) {
		return dao.checkNonPasswordCount(walkingThruRecord);
	}

	@Transactional
	public int passwordSetting(WalkingThruRecord walkingThruRecord) {
		List<WalkingThruRecord> list = dao.getNonPasswordList(walkingThruRecord);
		Random test = new Random();
		test.setSeed(new Date().getTime());
		for(WalkingThruRecord walkingThruRecordOne : list) {
			int p = (int)(Math.random()*(9 - 1 + 1))+ 1;
			String a = Integer.toString(test.nextInt(10));
			String s = Integer.toString(test.nextInt(10));
			String ss = Integer.toString(test.nextInt(10));
			int pass = Integer.parseInt(p+a+s+ss);
			walkingThruRecordOne.setPassword(pass);
			dao.insertPassword(walkingThruRecordOne);
		}
		return 1;
	}

	public List<WalkingThruRecord> getWalkingThruRecordExcelListNow(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordExcelListNow(walkingThruRecord);
	}

	public int checkPassword(WalkingThruRecord walkingThruRecord) {
		return dao.checkPassword(walkingThruRecord);
	}

	public int checkPasswordCountBefore(WalkingThruRecord walkingThruRecord) {
		return dao.checkPasswordCountBefore(walkingThruRecord);
	}

	public int checkNonPasswordCountBefore(WalkingThruRecord walkingThruRecord) {
		return dao.checkNonPasswordCountBefore(walkingThruRecord);
	}
	
	@Transactional
	public int passwordSettingBefore(WalkingThruRecord walkingThruRecord) {
		List<WalkingThruRecord> list = dao.getNonPasswordListBefore(walkingThruRecord);
		Random test = new Random();
		test.setSeed(new Date().getTime());
		for(WalkingThruRecord walkingThruRecordOne : list) {
			int p = (int)(Math.random()*(9 - 1 + 1))+ 1;
			String a = Integer.toString(test.nextInt(10));
			String s = Integer.toString(test.nextInt(10));
			String ss = Integer.toString(test.nextInt(10));
			int pass = Integer.parseInt(p+a+s+ss);
			walkingThruRecordOne.setPassword(pass);
			dao.insertPasswordBefore(walkingThruRecordOne);
		}
		return 1;
	}

	public int getWalkingThruRecordInfoCount(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordInfoCount(walkingThruRecord);
	}

	public List<WalkingThruRecord> getWalkingThruRecordInfo(WalkingThruRecord walkingThruRecord) {
		return dao.getWalkingThruRecordInfo(walkingThruRecord);
	}

	public List<WalkingThruRecord> getReservationList(WalkingThruRecord walkingThruRecord) {
		return dao.getReservationList(walkingThruRecord);
	}

	public int cancelReserve(WalkingThruRecord walkingThruRecord) {
		return dao.cancelReserve(walkingThruRecord);
	}
	
}
