package kr.co.whalesoft.app.cms.statusMng;

import java.util.List;
import java.util.Map;

public interface StatusMngDao {
	
	public List<StatusMng> getstatusMngList(StatusMng statusMng);
	
	public int getStatusMngCount(StatusMng statusMng);

	public List<StatusMng> getDivList(String homepage_id);
	
	public List<StatusMng> getStatusList(String homepage_id);
	
	public StatusMng getStatusMngOne(StatusMng statusMng);
	
	public int getNextPrintSeq(StatusMng statusMng);
	
	public int getDivNextPrintSeq(StatusMng statusMng);

	public int addStatusDiv(StatusMng statusMng);
	
	public int modifyStatusDiv(StatusMng statusMng);
	
	public int addStatusCnt(StatusMng statusMng);
	
	public int modifyStatusCnt(StatusMng statusMng);

	public int modifyRatingCnt(StatusMng statusMng);

	public int statusMngDel(StatusMng statusMng);
	
	public int deleteDivAll(StatusMng statusMng);
	
	public List<StatusMng> getChartDivList(String homepage_id);
	
	public int statusMngCnt(StatusMng statusMng);

	public StatusMng getTotalCant(String homepage_id);

}
