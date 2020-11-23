package kr.go.gbelib.app.cms.module.marathonRecord;

import java.util.List;

import kr.go.gbelib.app.cms.module.marathonRecord.marathonApplicantRecord.MarathonApplicantRecord;

public interface MarathonRecordDao {

	int getMarathonRecordCount(MarathonRecord marathonRecord);

	List<MarathonRecord> getMarathonRecordList(MarathonRecord marathonRecord);

	MarathonRecord getMarathonRecordOne(MarathonRecord marathonRecord);

	int getTotalPageCount(MarathonRecord marathonRecord);

	int addMarathonRecord(MarathonRecord marathonRecord);

	int modifyMarathonRecord(MarathonRecord marathonRecord);

	int deleteMarathonRecord(MarathonRecord marathonRecord);

	List<MarathonApplicantRecord> getMarathonApplicantRecordExcelList(MarathonRecord marathonRecord);

	List<MarathonApplicantRecord> getMarathonRecordSuccessExcelList(MarathonRecord marathonRecord);
	
	int modifyMarathonRecordByApplicant(MarathonRecord marathonRecord);
}
