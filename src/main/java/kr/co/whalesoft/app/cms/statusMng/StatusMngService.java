package kr.co.whalesoft.app.cms.statusMng;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class StatusMngService extends BaseService {
	
	@Autowired
	private StatusMngDao dao;
	
	public List<StatusMng> getstatusMngList(StatusMng statusMng) {
		return dao.getstatusMngList(statusMng);
	}
	
	public int getStatusMngCount(StatusMng statusMng) {
		return dao.getStatusMngCount(statusMng);
	}

	public List<StatusMng> getDivList(String homepage_id) {
		return dao.getDivList(homepage_id);
	}
	
	public List<StatusMng> getStatusList(String homepage_id) {
		return dao.getStatusList(homepage_id);
	}
	
	public StatusMng getStatusMngOne(StatusMng statusMng) {
		return dao.getStatusMngOne(statusMng);
	}
	
	public int getNextPrintSeq(StatusMng statusMng) {
		return dao.getNextPrintSeq(statusMng);
	}
	
	public int getDivNextPrintSeq(StatusMng statusMng) {
		return dao.getDivNextPrintSeq(statusMng);
	}

	public int addStatusDiv(StatusMng statusMng) {
		return dao.addStatusDiv(statusMng);
	}
	
	public int modifyStatusDiv(StatusMng statusMng) {
		return dao.modifyStatusDiv(statusMng);
	}

	public int addStatusCnt(StatusMng statusMng) {
		return dao.addStatusCnt(statusMng);
	}
	
	public int modifyStatusCnt(StatusMng statusMng) {
		return dao.modifyStatusCnt(statusMng);
	}

	public int modifyRatingCnt(StatusMng statusMng) {
		return dao.modifyRatingCnt(statusMng);
	}
	
	public int statusMngDel(StatusMng statusMng) {
		return dao.statusMngDel(statusMng);
	}
	
	public int deleteDivAll(StatusMng statusMng) {
		return dao.deleteDivAll(statusMng);
	}
	
	public List<StatusMng> getChartDivList(String homepage_id) {
		return dao.getChartDivList(homepage_id);
	}

	public int statusMngCnt(StatusMng statusMng) {
		return dao.statusMngCnt(statusMng);
	}

	public StatusMng getTotalCant(String homepage_id) {
		return dao.getTotalCant(homepage_id);
	}

}
