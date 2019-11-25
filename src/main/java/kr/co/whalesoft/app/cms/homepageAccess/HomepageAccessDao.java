package kr.co.whalesoft.app.cms.homepageAccess;

import java.util.List;
import kr.co.whalesoft.app.cms.member.Member;

public interface HomepageAccessDao {
	
	public List<HomepageAccess> getHomepageStatisticsResult(HomepageAccess homepageAccess);
	
	public String getLastHomepageAccess(Member member);
	
	public int addStatisticsCount(HomepageAccess homepageAccess);
	
	public int addStatisticsCountMobile(HomepageAccess homepageAccess);
	
	public int addStatisticsCountLog(HomepageAccess homepageAccess);
	
	public int addStatisticsCountLogMobile(HomepageAccess homepageAccess);
	
	public int updateStatisticsCount(HomepageAccess homepageAccess);
	
	public int updateStatisticsCountMobile(HomepageAccess homepageAccess);
	
	public int updateStatisticsCountLog(HomepageAccess homepageAccess);
	
	public int updateStatisticsCountLogMobile(HomepageAccess homepageAccess);
	
	public List<HomepageAccess> getCmsHomepageAccess(HomepageAccess homepageAccess);

	/**
	 * @author whalesoft YONGJU 2019. 8. 20.
	 * @param homepageAccess
	 * @return
	 */
	public List<HomepageAccess> getChartData(HomepageAccess homepageAccess);

	/**
	 * @author whalesoft YONGJU 2019. 8. 20.
	 * @param homepageAccess
	 * @return
	 */
	public List<HomepageAccess> getChartViewData(HomepageAccess homepageAccess);

	/**
	 * @author whalesoft YONGJU 2019. 8. 20.
	 * @param homepageAccess
	 * @return
	 */
	public int addAccessCount(HomepageAccess homepageAccess);

	/**
	 * @author whalesoft YONGJU 2019. 8. 20.
	 * @param homepageAccess
	 * @return
	 */
	public int addViewCount(HomepageAccess homepageAccess);

	/**
	 * @author whalesoft YONGJU 2019. 8. 21.
	 * @param homepageAccess
	 * @return
	 */
	public List<HomepageAccess> getChartDivData(HomepageAccess homepageAccess);

	/**
	 * @author whalesoft YONGJU 2019. 8. 21.
	 * @param homepageAccess
	 * @return
	 */
	public List<HomepageAccess> getChartViewDivData(HomepageAccess homepageAccess);

}