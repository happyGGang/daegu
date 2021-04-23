package kr.go.gbelib.app.cms.module.marathon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicant;
import kr.go.gbelib.app.cms.module.marathonApplicant.MarathonApplicantService;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecord;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecordService;
import kr.go.gbelib.app.cms.module.marathonType.MarathonType;
import kr.go.gbelib.app.cms.module.marathonType.MarathonTypeService;

@Service
public class MarathonService extends BaseService{

	@Autowired
	private MarathonDao dao;
	
	@Autowired
	private MarathonTypeService marathonTypeService;
	
	@Autowired
	private MarathonApplicantService marathonApplicantService;
	
	@Autowired
	private MarathonRecordService marathonRecordService;

	public int getMarathonContestCount(Marathon marathon) {
		return dao.getMarathonContestCount(marathon);
	}

	public List<Marathon> getMarathonContestList(Marathon marathon) {
		return dao.getMarathonContestList(marathon);
	}

	public Marathon getMarathonContestOne(Marathon marathon) {
		return dao.getMarathonContestOne(marathon);
	}

	public int addMarathonContest(Marathon marathon) {
		return dao.addMarathonContest(marathon);
	}

	public int modifyMarathonContest(Marathon marathon) {
		return dao.modifyMarathonContest(marathon);
	}

	public int deleteMarathonContest(Marathon marathon) {
		dao.deleteMarathonContest(marathon);
		
		MarathonType marathonType = new MarathonType();
		marathonType.setHomepage_id(marathon.getHomepage_id());
		marathonType.setContest_idx(marathon.getContest_idx());
		marathonTypeService.deleteMarathonTypeByContestIdx(marathonType);
		
		MarathonApplicant marathonApplicant = new MarathonApplicant();
		marathonApplicant.setHomepage_id(marathon.getHomepage_id());
		marathonApplicant.setContest_idx(marathon.getContest_idx());
		marathonApplicantService.deleteMarathonApplicantByContestIdx(marathonApplicant);
		
		MarathonRecord marathonRecord = new MarathonRecord();
		marathonRecord.setHomepage_id(marathon.getHomepage_id());
		marathonRecord.setContest_idx(marathon.getContest_idx());
		marathonRecordService.deleteMarathonRecordByContestIdx(marathonRecord);
		
		return 1;
	}

	public int checkUsableContestCount(Marathon marathon) {
		return dao.checkUsableContestCount(marathon);
	}

	public Marathon getMarathonUseOne(Marathon marathon) {
		return dao.getMarathonUseOne(marathon);
	}

}
