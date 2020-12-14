package kr.go.gbelib.app.cms.module.marathonApplicant;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.marathon.Marathon;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecord;
import kr.go.gbelib.app.cms.module.marathonType.MarathonType;

@Service
public class MarathonApplicantService extends BaseService{

	@Autowired
	MarathonApplicantDao dao;

	public int getMarathonApplicantCount(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantCount(marathonApplicant);
	}

	public List<Marathon> getMarathonList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonList(marathonApplicant);
	}

	public List<MarathonApplicant> getMarathonApplicantList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantList(marathonApplicant);
	}

	public MarathonApplicant getMarathonApplicantOne(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantOne(marathonApplicant);
	}

	public List<MarathonType> getMarathonTypeList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonTypeList(marathonApplicant);
	}

	public int modifyMarathonApplicant(MarathonApplicant marathonApplicant) {
		marathonApplicant.setTelephone(marathonApplicant.getTelephone_one() + "-" + marathonApplicant.getTelephone_two() + "-" + marathonApplicant.getTelephone_three());
		marathonApplicant.setCellphone(marathonApplicant.getCellphone_one() + "-" + marathonApplicant.getCellphone_two() + "-" + marathonApplicant.getCellphone_three());
		marathonApplicant.setBirthday(marathonApplicant.getBirthday_year() + "-" + marathonApplicant.getBirthday_month() + "-" + marathonApplicant.getBirthday_date());
		if(marathonApplicant.getSchool_class_one() == null) {
			marathonApplicant.setSchool_class_one("");
		}
		if(marathonApplicant.getSchool_class_two() == null) {
			marathonApplicant.setSchool_class_two("");
		}
		marathonApplicant.setSchool_class(marathonApplicant.getSchool_class_one() + "," + marathonApplicant.getSchool_class_two());
		return dao.modifyMarathonApplicant(marathonApplicant);
	}
	@Transactional
	public int deleteMarathonApplicant(MarathonApplicant marathonApplicant) {
		int applicant_idx_arr[] = marathonApplicant.getApplicant_idx_arr();
		int contest_type_idx_arr[] = marathonApplicant.getContest_type_idx_arr();
		for(int i = 0; i < applicant_idx_arr.length; i++) {
			marathonApplicant.setApplicant_idx(applicant_idx_arr[i]);
			marathonApplicant.setContest_type_idx(contest_type_idx_arr[i]);
			dao.deleteMarathonApplicant(marathonApplicant);
		}
		return 1;
	}

	public int addMarathonApplicant(MarathonApplicant marathonApplicant) {
		marathonApplicant.setTelephone(marathonApplicant.getTelephone_one() + "-" + marathonApplicant.getTelephone_two() + "-" + marathonApplicant.getTelephone_three());
		marathonApplicant.setCellphone(marathonApplicant.getCellphone_one() + "-" + marathonApplicant.getCellphone_two() + "-" + marathonApplicant.getCellphone_three());
		marathonApplicant.setBirthday(marathonApplicant.getBirthday_year() + "-" + marathonApplicant.getBirthday_month() + "-" + marathonApplicant.getBirthday_date());
		if(marathonApplicant.getSchool_class_one() == null) {
			marathonApplicant.setSchool_class_one("");
		}
		if(marathonApplicant.getSchool_class_two() == null) {
			marathonApplicant.setSchool_class_two("");
		}
		marathonApplicant.setSchool_class(marathonApplicant.getSchool_class_one() + "," + marathonApplicant.getSchool_class_two());
		
		return dao.addMarathonApplicant(marathonApplicant);
	}

	public int getContestTypeIdx(MarathonApplicant marathonApplicant) {
		return dao.getContestTypeIdx(marathonApplicant);
	}
	@Transactional
	public int modifyMarathonApplicantStatus(MarathonApplicant marathonApplicant) {
		int applicant_idx_arr[] = marathonApplicant.getApplicant_idx_arr();
		int contest_type_idx_arr[] = marathonApplicant.getContest_type_idx_arr();
		for(int i = 0; i < applicant_idx_arr.length; i++) {
			marathonApplicant.setApplicant_idx(applicant_idx_arr[i]);
			marathonApplicant.setContest_type_idx(contest_type_idx_arr[i]);
			if(marathonApplicant.getRead_page_count_total_arr()[i] >= marathonApplicant.getPage_count_arr()[i] && marathonApplicant.getProcess_status() == 1) {
				marathonApplicant.setFinish_date(new Date());
			}else {
				marathonApplicant.setFinish_date(null);
			}
			dao.modifyMarathonApplicantStatus(marathonApplicant);
		}
		return 1;
	}

	public int checkApplicantId(MarathonApplicant marathonApplicant) {
		return dao.checkApplicantId(marathonApplicant);
	}

	public int getMarathonApplicantIdx(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantIdx(marathonApplicant);
	}

	public MarathonApplicant getMarathonApplicantOneById(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantOneById(marathonApplicant);
	}

	public String getMarathonApplicantName(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantName(marathonApplicant);
	}

	public String getMarathonApplicantId(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantId(marathonApplicant);
	}

	public int getReadPageCountTotal(MarathonApplicant marathonApplicant) {
		return dao.getReadPageCountTotal(marathonApplicant);
	}

	public int modifyReadPageCountTotal(MarathonApplicant marathonApplicant) {
		return dao.modifyReadPageCountTotal(marathonApplicant);
	}
	
	public String getContestApplicationSubject(MarathonApplicant marathonApplicant) {
		return dao.getContestApplicationSubject(marathonApplicant);
	}

	public String getContestType(MarathonApplicant marathonApplicant) {
		return dao.getContestType(marathonApplicant);
	}

	public List<MarathonApplicant> getMarathonApplicantExcelList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantExcelList(marathonApplicant);
	}

	public String getContestApplicationSubjectModify(MarathonApplicant marathonApplicant) {
		return dao.getContestApplicationSubjectModify(marathonApplicant);
	}

	public int getMarathonApplicantMaxIdx(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantMaxIdx(marathonApplicant);
	}

}
