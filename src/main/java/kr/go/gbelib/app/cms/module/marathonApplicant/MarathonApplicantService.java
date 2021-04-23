package kr.go.gbelib.app.cms.module.marathonApplicant;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.marathon.Marathon;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecord;
import kr.go.gbelib.app.cms.module.marathonRecord.MarathonRecordService;
import kr.go.gbelib.app.cms.module.marathonType.MarathonType;

@Service
public class MarathonApplicantService extends BaseService{

	@Autowired
	MarathonApplicantDao dao;
	
	@Autowired
	MarathonRecordService recordService;

	public int getMarathonApplicantCount(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantCount(marathonApplicant);
	}

	public List<Marathon> getMarathonList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonList(marathonApplicant);
	}

	@WorkingLogger(comment="독서마라톤 신청자 목록 조회", type="P")
	public List<MarathonApplicant> getMarathonApplicantList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantList(marathonApplicant);
	}
	
	@WorkingLogger(comment="독서마라톤 로그인한 사용자 대회 신청 목록 조회", type="P")
	public List<MarathonApplicant> getMarathonApplicantUserList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantUserList(marathonApplicant);
	}

	@WorkingLogger(comment="독서마라톤 신청자 조회", type="P")
	public MarathonApplicant getMarathonApplicantOne(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantOne(marathonApplicant);
	}

	public List<MarathonType> getMarathonTypeList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonTypeList(marathonApplicant);
	}

	@WorkingLogger(comment="독서마라톤 신청자 수정", type="P")
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
	public int modifyMarathonApplicantWithRecord(MarathonApplicant marathonApplicant) {
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
		modifyApplicant(marathonApplicant);
		
		MarathonRecord marathonRecord = new MarathonRecord(marathonApplicant.getHomepage_id(), marathonApplicant.getContest_idx(), marathonApplicant.getContest_type_idx(), marathonApplicant.getApplicant_idx());
		marathonRecord.setContest_type_idx_modify(marathonApplicant.getContest_type_idx());
		marathonRecord.setApplicant_idx_modify(marathonApplicant.getApplicant_idx_modify());
		recordService.modifyMarathonRecordByApplicant(marathonRecord); //일지의 종목번호, 신청자 번호를 변경
		return 1;
	}

	@WorkingLogger(comment = "독서마라톤 신청자 수정", type = "P")
	private void modifyApplicant(MarathonApplicant marathonApplicant) {
		dao.modifyMarathonApplicant(marathonApplicant);
	}

	@Transactional
	public int deleteMarathonApplicant(MarathonApplicant marathonApplicant) {
		int applicant_idx_arr[] = marathonApplicant.getApplicant_idx_arr();
		int contest_type_idx_arr[] = marathonApplicant.getContest_type_idx_arr();
		int contest_idx_arr[] = marathonApplicant.getContest_idx_arr();
		for(int i = 0; i < applicant_idx_arr.length; i++) {
			marathonApplicant.setApplicant_idx(applicant_idx_arr[i]);
			marathonApplicant.setContest_type_idx(contest_type_idx_arr[i]);
			dao.deleteMarathonApplicant(marathonApplicant);
			
			MarathonRecord marathonRecord = new MarathonRecord();
			marathonRecord.setHomepage_id(marathonApplicant.getHomepage_id());
			marathonRecord.setContest_idx(contest_idx_arr[i]);
			marathonRecord.setContest_type_idx(contest_type_idx_arr[i]);
			marathonRecord.setApplicant_idx(applicant_idx_arr[i]);
			recordService.deleteMarathonRecordAll(marathonRecord);
		}
		return 1;
	}

	@WorkingLogger(comment="독서마라톤 신청자 등록", type="P")
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
	
	@WorkingLogger(comment="독서마라톤 신청자 상태 변경", type="W")
	@Transactional
	public int modifyMarathonApplicantStatus(MarathonApplicant marathonApplicant) {
		int applicant_idx_arr[] = marathonApplicant.getApplicant_idx_arr();
		int contest_type_idx_arr[] = marathonApplicant.getContest_type_idx_arr();
		for(int i = 0; i < applicant_idx_arr.length; i++) {
			marathonApplicant.setApplicant_idx(applicant_idx_arr[i]);
			marathonApplicant.setContest_type_idx(contest_type_idx_arr[i]);
			if(marathonApplicant.getProcess_status() == 1) {
				marathonApplicant.setFinish_date(new Date());
			}else {
				marathonApplicant.setFinish_date(null);
			}
			dao.modifyMarathonApplicantStatus(marathonApplicant);
		}
		return 1;
	}
	
	public int modifyMarathonApplicantUserStatus(MarathonApplicant marathonApplicant) {
		return dao.modifyMarathonApplicantStatus(marathonApplicant);
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

	@WorkingLogger(comment="독서마라톤 신청자 아이디 조회", type="P")
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

	@WorkingLogger(comment="독서마라톤 신청자 목록 조회(엑셀용)", type="P")
	public List<MarathonApplicant> getMarathonApplicantExcelList(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantExcelList(marathonApplicant);
	}

	public String getContestApplicationSubjectModify(MarathonApplicant marathonApplicant) {
		return dao.getContestApplicationSubjectModify(marathonApplicant);
	}

	public int getMarathonApplicantMaxIdx(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantMaxIdx(marathonApplicant);
	}

	public int getMarathonApplicantUserCount(MarathonApplicant marathonApplicant) {
		return dao.getMarathonApplicantUserCount(marathonApplicant);
	}

	public int modifyMarathonApplicantContestType(MarathonApplicant marathonApplicant) {
		return dao.modifyMarathonApplicantContestType(marathonApplicant);
	}

	@WorkingLogger(comment = "독서마라톤 신청자 수정", type = "P")
	public int modifyMarathonApplicantInMyInfo(MarathonApplicant marathonApplicant) {
		marathonApplicant.setTelephone(marathonApplicant.getTelephone_one() + "-" + marathonApplicant.getTelephone_two() + "-" + marathonApplicant.getTelephone_three());
		marathonApplicant.setCellphone(marathonApplicant.getCellphone_one() + "-" + marathonApplicant.getCellphone_two() + "-" + marathonApplicant.getCellphone_three());
		if(marathonApplicant.getSchool_class_one() == null) {
			marathonApplicant.setSchool_class_one("");
		}
		if(marathonApplicant.getSchool_class_two() == null) {
			marathonApplicant.setSchool_class_two("");
		}
		marathonApplicant.setSchool_class(marathonApplicant.getSchool_class_one() + "," + marathonApplicant.getSchool_class_two());
		
		return dao.modifyMarathonApplicantInMyInfo(marathonApplicant);
	}

	public int deleteMarathonApplicantByContestType(MarathonApplicant marathonApplicant) {
		return dao.deleteMarathonApplicantByContestType(marathonApplicant);
	}

	public int deleteMarathonApplicantByContestIdx(MarathonApplicant marathonApplicant) {
		return dao.deleteMarathonApplicantByContestIdx(marathonApplicant);
	}

}
