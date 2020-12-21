package kr.go.gbelib.app.cms.module.marathonRecord;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicant;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicantService;
import kr.go.gbelib.app.cms.module.marathonRecord.marathonApplicantRecord.MarathonApplicantRecord;

@Service
public class MarathonRecordService extends BaseService{

	@Autowired
	private MarathonRecordDao dao;
	
	@Autowired
	private MarathonApplicantService marathonApplicantService;

	public int getMarathonRecordCount(MarathonRecord marathonRecord) {
		return dao.getMarathonRecordCount(marathonRecord);
	}

	public List<MarathonRecord> getMarathonRecordList(MarathonRecord marathonRecord) {
		return dao.getMarathonRecordList(marathonRecord);
	}

	public MarathonRecord getMarathonRecordOne(MarathonRecord marathonRecord) {
		return dao.getMarathonRecordOne(marathonRecord);
	}

	public int getTotalPageCount(MarathonRecord marathonRecord) {
		return dao.getTotalPageCount(marathonRecord);
	}

	@Transactional
	public int addMarathonRecord(MarathonRecord marathonRecord, MarathonApplicant marathonApplicant) {
		if(marathonApplicantService.modifyReadPageCountTotal(marathonApplicant) > 0) {
			return dao.addMarathonRecord(marathonRecord);
		}
		return 1;
	}
	@Transactional
	public int modifyMarathonRecord(MarathonRecord marathonRecord, MarathonApplicant marathonApplicant) {
		if(marathonApplicantService.modifyReadPageCountTotal(marathonApplicant) > 0) {
			return dao.modifyMarathonRecord(marathonRecord);
		}
		return 1;
	}
	@Transactional
	public int deleteMarathonRecord(MarathonRecord marathonRecord, MarathonApplicant marathonApplicant) {
		if(marathonApplicantService.modifyReadPageCountTotal(marathonApplicant) > 0) {
			return dao.deleteMarathonRecord(marathonRecord);
		}
		return 1;
	}

	public List<MarathonApplicantRecord> getMarathonApplicantRecordExcelList(MarathonRecord marathonRecord) {
		return dao.getMarathonApplicantRecordExcelList(marathonRecord);
	}

	public List<MarathonApplicantRecord> getMarathonRecordSuccessExcelList(MarathonRecord marathonRecord) {
		return dao.getMarathonRecordSuccessExcelList(marathonRecord);
	}
	
	public int modifyMarathonRecordByApplicant(MarathonRecord marathonRecord) {
		return dao.modifyMarathonRecordByApplicant(marathonRecord);
	}

	public int deleteMarathonRecordAll(MarathonRecord marathonRecord) {
		return dao.deleteMarathonRecordAll(marathonRecord);
	}
}
