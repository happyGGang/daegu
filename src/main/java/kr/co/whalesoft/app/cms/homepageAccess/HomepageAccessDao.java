package kr.co.whalesoft.app.cms.homepageAccess;

import java.util.List;
import kr.co.whalesoft.app.cms.member.Member;

public interface HomepageAccessDao {

	public int addHomepageAccess(HomepageAccess homepageAccess);

	public List<HomepageAccess> getHomepageAccessResultByAll(HomepageAccess homepageAccess);

	public List<HomepageAccess> getHomepageAccessResultByBrowser(HomepageAccess homepageAccess);

	public List<HomepageAccess> getHomepageAccessResultByOS(HomepageAccess homepageAccess);

	public List<HomepageAccess> getHomepageAccessResultByDevice(HomepageAccess homepageAccess);

	public String getLastHomepageAccess(Member member);

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