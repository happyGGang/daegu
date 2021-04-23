package kr.go.gbelib.app.cms.module.marathonType;

import java.util.List;

import kr.go.gbelib.app.cms.module.marathon.Marathon;


public interface MarathonTypeDao {

	int getMarathonType(MarathonType marathonType);

	int getMarathonTypeCount(MarathonType marathonType);

	List<MarathonType> getMarathonTypeList(MarathonType marathonType);

	MarathonType getMarathonTypeOne(MarathonType marathonType);

	int addMarathonType(MarathonType marathonType);

	int modifyMarathonType(MarathonType marathonType);

	int deleteMarathonType(MarathonType marathonType);

	List<Marathon> getMarathonList(MarathonType marathonType);

	int deleteMarathonTypeByContestIdx(MarathonType marathonType);

}
