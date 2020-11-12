package kr.go.gbelib.app.cms.module.marathon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MarathonService extends BaseService{

	@Autowired
	private MarathonDao dao;

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
		return dao.deleteMarathonContest(marathon);
	}

	public int checkUsableContestCount(Marathon marathon) {
		return dao.checkUsableContestCount(marathon);
	}

	public Marathon getMarathonUseOne(Marathon marathon) {
		return dao.getMarathonUseOne(marathon);
	}

}
