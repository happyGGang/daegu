package kr.go.gbelib.app.cms.module.marathonRecord;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicant;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicantService;
import kr.go.gbelib.app.cms.module.marathonRecord.marathonApplicantRecord.MarathonApplicantRecord;
import kr.go.gbelib.app.cms.module.marathonType.MarathonType;
import kr.go.gbelib.app.cms.module.marathonType.MarathonTypeService;

@Service
public class MarathonRecordService extends BaseService {

	@Autowired
	private MarathonRecordDao dao;

	@Autowired
	private MarathonApplicantService marathonApplicantService;

	@Autowired
	private MarathonTypeService marathonTypeService;

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
		if (marathonApplicantService.modifyReadPageCountTotal(marathonApplicant) > 0) {
			int page_count = getPageCount(marathonApplicant);
			if (marathonApplicant.getRead_page_count_total() >= page_count) {
				marathonApplicant.setProcess_status(1);
				marathonApplicant.setFinish_date(new Date());
				marathonApplicantService.modifyMarathonApplicantUserStatus(marathonApplicant);
			}
			return dao.addMarathonRecord(marathonRecord);
		}
		return 1;
	}

	@Transactional
	public int modifyMarathonRecord(MarathonRecord marathonRecord, MarathonApplicant marathonApplicant) {
		if (marathonApplicantService.modifyReadPageCountTotal(marathonApplicant) > 0) {
			int page_count = getPageCount(marathonApplicant);
			
			if (marathonApplicant.getRead_page_count_total() >= page_count) {
				marathonApplicant.setProcess_status(1);
				marathonApplicant.setFinish_date(new Date());
				marathonApplicantService.modifyMarathonApplicantUserStatus(marathonApplicant);
			} else {
				marathonApplicant.setProcess_status(0);
				marathonApplicant.setFinish_date(null);
				marathonApplicantService.modifyMarathonApplicantUserStatus(marathonApplicant);
			}
			return dao.modifyMarathonRecord(marathonRecord);
		}
		return 1;
	}

	@Transactional
	public int deleteMarathonRecord(MarathonRecord marathonRecord, MarathonApplicant marathonApplicant) {
		if (marathonApplicantService.modifyReadPageCountTotal(marathonApplicant) > 0) {
			int page_count = getPageCount(marathonApplicant);
			
			if (marathonApplicant.getRead_page_count_total() < page_count) {
				marathonApplicant.setProcess_status(0);
				marathonApplicant.setFinish_date(null);
				marathonApplicantService.modifyMarathonApplicantUserStatus(marathonApplicant);
			}
			return dao.deleteMarathonRecord(marathonRecord);
		}
		return 1;
	}

	private int getPageCount(MarathonApplicant marathonApplicant) {
		MarathonType marathonType = new MarathonType();
		marathonType.setHomepage_id(marathonApplicant.getHomepage_id());
		marathonType.setContest_idx(marathonApplicant.getContest_idx());
		marathonType.setContest_type_idx(marathonApplicant.getContest_type_idx());
		marathonType = marathonTypeService.getMarathonTypeOne(marathonType);
		int page_count = marathonType.getPage_count();
		return page_count;
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

	public List<MarathonRecord> getMarathonRecordListAll(MarathonRecord marathonRecord) {
		return dao.getMarathonRecordListAll(marathonRecord);
	}

	public int deleteMarathonRecordByContestType(MarathonRecord marathonRecord) {
		return dao.deleteMarathonRecordByContestType(marathonRecord);
	}

	public int deleteMarathonRecordByContestIdx(MarathonRecord marathonRecord) {
		return dao.deleteMarathonRecordByContestIdx(marathonRecord);
	}

}
