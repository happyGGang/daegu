package kr.go.gbelib.app.cms.module.marathonType;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.marathon.Marathon;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicant;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicantService;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecord;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecordService;

@Service
public class MarathonTypeService extends BaseService{

	@Autowired
	private MarathonTypeDao dao;

	@Autowired
	private MarathonApplicantService applicantService;
	
	@Autowired
	private MarathonRecordService recordService;

	public int getMarathonTypeCount(MarathonType marathonType) {
		return dao.getMarathonTypeCount(marathonType);
	}

	public List<MarathonType> getMarathonTypeList(MarathonType marathonType) {
		return dao.getMarathonTypeList(marathonType);
	}

	public MarathonType getMarathonTypeOne(MarathonType marathonType) {
		return dao.getMarathonTypeOne(marathonType);
	}

	@Transactional
	public int addMarathonType(MarathonType marathonType) {
		List<MarathonType> list = marathonType.getTypeList();
		
		for(int i = 0; i < list.size(); i++) {
			dao.addMarathonType(list.get(i));
		}
		return 1;
	}

	@Transactional
	public int modifyMarathonType(MarathonType marathonType) {
		MarathonApplicant marathonApplicant = new MarathonApplicant();
		marathonApplicant.setHomepage_id(marathonType.getHomepage_id());
		marathonApplicant.setContest_idx(marathonType.getContest_idx());
		marathonApplicant.setContest_type_idx(marathonType.getContest_type_idx());
		marathonApplicant.setContest_type(marathonType.getContest_type());
		applicantService.modifyMarathonApplicantContestType(marathonApplicant);

		dao.modifyMarathonType(marathonType);
		return 1;
	}

	@Transactional
	public int deleteMarathonType(MarathonType marathonType) {
		dao.deleteMarathonType(marathonType);
		
		MarathonApplicant marathonApplicant = new MarathonApplicant();
		marathonApplicant.setHomepage_id(marathonType.getHomepage_id());
		marathonApplicant.setContest_idx(marathonType.getContest_idx());
		marathonApplicant.setContest_type_idx(marathonType.getContest_type_idx());
		applicantService.deleteMarathonApplicantByContestType(marathonApplicant);
		
		MarathonRecord marathonRecord = new MarathonRecord();
		marathonRecord.setHomepage_id(marathonType.getHomepage_id());
		marathonRecord.setContest_idx(marathonType.getContest_idx());
		marathonRecord.setContest_type_idx(marathonType.getContest_type_idx());
		recordService.deleteMarathonRecordByContestType(marathonRecord);
		
		return 1;
	}

	public List<Marathon> getMarathonList(MarathonType marathonType) {
		return dao.getMarathonList(marathonType);
	}

	public int deleteMarathonTypeByContestIdx(MarathonType marathonType) {
		return dao.deleteMarathonTypeByContestIdx(marathonType);
	}

}
