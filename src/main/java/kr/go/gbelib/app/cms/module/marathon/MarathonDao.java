package kr.go.gbelib.app.cms.module.marathon;

import java.util.List;

public interface MarathonDao {

	int getMarathonContestCount(Marathon marathon);

	List<Marathon> getMarathonContestList(Marathon marathon);

	Marathon getMarathonContestOne(Marathon marathon);

	int addMarathonContest(Marathon marathon);

	int modifyMarathonContest(Marathon marathon);

	int deleteMarathonContest(Marathon marathon);

	int checkUsableContestCount(Marathon marathon);

	Marathon getMarathonUseOne(Marathon marathon);

}
