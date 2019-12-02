/**
 *
 */
package kr.co.whalesoft.app.cms.recommendSite;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.googlecode.ehcache.annotations.Cacheable;

import kr.co.whalesoft.framework.base.BaseService;

/**
 * @author whaleesoft YONGJU 2019. 11. 28.
 *
 */
@Service
public class RecommendSiteService extends BaseService {

	@Autowired
	private RecommendSiteDao dao;

	public List<RecommendSite> getRecommendSiteListAll(RecommendSite recommendSite) {
		return dao.getRecommendSiteListAll(recommendSite);
	}

	@Cacheable(cacheName="getRecommendSiteListCache")
	public List<RecommendSite> getRecommendSiteListCache(String homepage_id) {
		return dao.getRecommendSiteListCache(homepage_id);
	}

	public List<RecommendSite> getRecommendSiteList(RecommendSite recommendSite) {
		return dao.getRecommendSiteList(recommendSite);
	}

	public int getRecommendSiteListCount(RecommendSite recommendSite) {
		return dao.getRecommendSiteListCount(recommendSite);
	}

	public RecommendSite getRecommendSiteOne(RecommendSite recommendSite) {
		return dao.getRecommendSiteOne(recommendSite);
	}

	public int addRecommendSite(RecommendSite recommendSite) {
		/*MultipartFile mFile = site.getFile();

		if ( mFile != null ) {
			File f = siteStorage.addFile(mFile, mFile.getOriginalFilename(), site.getHomepage_id());
			site.setFile_name(f.getName());
		}*/

		return dao.addRecommendSite(recommendSite);
	}

	public int modifyRecommendSite(RecommendSite recommendSite) {
		/*MultipartFile mFile = site.getFile();

		if ( mFile != null ) {
			siteStorage.deleteFile(site.getFile_name(), site.getHomepage_id());

			File f = siteStorage.addFile(mFile, mFile.getOriginalFilename(), site.getHomepage_id());
			site.setFile_name(f.getName());
		}*/

		return dao.modifyRecommendSite(recommendSite);
	}

	public int deleteRecommendSite(RecommendSite recommendSite) {
		/*Site delSite = getRecommendSiteOne(recommendSite);
		String fileName = delSite.getFile_name();
		if ( !StringUtils.isEmpty(fileName) ) {
			siteStorage.deleteFile(fileName, site.getHomepage_id());
		}*/

		return dao.deleteRecommendSite(recommendSite);
	}
}
