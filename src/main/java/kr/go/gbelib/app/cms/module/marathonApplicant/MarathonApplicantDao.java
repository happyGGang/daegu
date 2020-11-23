package kr.go.gbelib.app.cms.module.marathonApplicant;

import java.util.List;

import kr.go.gbelib.app.cms.module.marathon.Marathon;
import kr.go.gbelib.app.cms.module.marathonType.MarathonType;

public interface MarathonApplicantDao {

	int getMarathonApplicantCount(MarathonApplicant marathonApplicant);

	List<MarathonApplicant> getMarathonApplicantList(MarathonApplicant marathonApplicant);

	MarathonApplicant getMarathonApplicantOne(MarathonApplicant marathonApplicant);

	int modifyMarathonApplicant(MarathonApplicant marathonApplicant);

	int deleteMarathonApplicant(MarathonApplicant marathonApplicant);

	int addMarathonApplicant(MarathonApplicant marathonApplicant);

	List<Marathon> getMarathonList(MarathonApplicant marathonApplicant);
	
	List<MarathonType> getMarathonTypeList(MarathonApplicant marathonApplicant);

	int getContestTypeIdx(MarathonApplicant marathonApplicant);

	int modifyMarathonApplicantStatus(MarathonApplicant marathonApplicant);

	int checkApplicantId(MarathonApplicant marathonApplicant);

	int getMarathonApplicantIdx(MarathonApplicant marathonApplicant);

	MarathonApplicant getMarathonApplicantOneById(MarathonApplicant marathonApplicant);

	String getMarathonApplicantName(MarathonApplicant marathonApplicant);

	String getMarathonApplicantId(MarathonApplicant marathonApplicant);

	int getReadPageCountTotal(MarathonApplicant marathonApplicant);

	int modifyReadPageCountTotal(MarathonApplicant marathonApplicant);

	String getContestApplicationSubject(MarathonApplicant marathonApplicant);

	String getContestType(MarathonApplicant marathonApplicant);

	List<MarathonApplicant> getMarathonApplicantExcelList(MarathonApplicant marathonApplicant);

	String getContestApplicationSubjectModify(MarathonApplicant marathonApplicant);

	int getMarathonApplicantMaxIdx(MarathonApplicant marathonApplicant);

}
