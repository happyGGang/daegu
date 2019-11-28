/**
 *
 */
package kr.co.whalesoft.app.cms.recommendSite;

import java.util.List;

/**
 * @author whaleesoft YONGJU 2019. 11. 28.
 *
 */
public interface RecommendSiteDao {

	public List<RecommendSite> getRecommendSiteList(RecommendSite recommendSite);

	public List<RecommendSite> getRecommendSiteListAll(RecommendSite recommendSite);

	public int getRecommendSiteListCount(RecommendSite recommendSite);

	public RecommendSite getRecommendSiteOne(RecommendSite recommendSite);

	public int addRecommendSite(RecommendSite recommendSite);

	public int modifyRecommendSite(RecommendSite recommendSite);

	public int deleteRecommendSite(RecommendSite recommendSite);
}
