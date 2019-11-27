package kr.co.whalesoft.app.cms.homepageAccess;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseDao;

@Service
public class HomepageAccessService extends BaseDao {

	@Autowired
	private HomepageAccessDao homepageAccessDao;

	public List<HomepageAccess> getHomepageStatisticsResult(HomepageAccess homepageAccess) {
		long totalCount = 0;
		long minCount = 999999999999999999L;
		long maxCount = 0;
		List<HomepageAccess> result = homepageAccessDao.getHomepageStatisticsResult(homepageAccess);

		if ( result != null && result.size() > 0 ) {
			for ( HomepageAccess oneInfo : result ) {
				long resultCount = oneInfo.getResult_count();

				if ( minCount > oneInfo.getResult_count() ) {
					minCount = resultCount;
				}

				if ( maxCount < resultCount ) {
					maxCount = resultCount;
				}

				totalCount += resultCount;
			}
			// 첫번째 인덱스에 해당하는 객체에 TOTAL, MAX, MIN 값을 세팅 해서 넘겨준다.
			result.get(0).setTotal_count(totalCount);
			result.get(0).setMax_count(maxCount);
			result.get(0).setMin_count(minCount);
		}

		return result;
	}

	public String getLastHomepageAccess(Member member) {
		return homepageAccessDao.getLastHomepageAccess(member);
	}
	
	@Transactional
	public int addStatisticsCount(HomepageAccess homepageAccess) {
		int result = homepageAccessDao.updateStatisticsCount(homepageAccess);
		
		if(result == 1) {
			return result;
		} else {
			return homepageAccessDao.addStatisticsCount(homepageAccess);
		}
	}
	
	@Transactional
	public int addStatisticsCountMobile(HomepageAccess homepageAccess) {
		int result = homepageAccessDao.updateStatisticsCountMobile(homepageAccess);
		
		if(result == 1) {
			return result;
		} else {
			return homepageAccessDao.addStatisticsCountMobile(homepageAccess);
		}
	}
	
	@Transactional
	public int addStatisticsCountLog(HomepageAccess homepageAccess) {
		homepageAccess.setUser_agent(StringUtils.substring(homepageAccess.getUser_agent(), 0, 1000));
		homepageAccess.setReferer_url(StringUtils.substring(homepageAccess.getReferer_url(), 0, 1000));
		
		int result = homepageAccessDao.updateStatisticsCountLog(homepageAccess);

		if(result == 1) {
			return result;
		} else {
			return homepageAccessDao.addStatisticsCountLog(homepageAccess);
		}
	}
	
	@Transactional
	public int addStatisticsCountLogMobile(HomepageAccess homepageAccess) {
		homepageAccess.setUser_agent(StringUtils.substring(homepageAccess.getUser_agent(), 0, 1000));
		homepageAccess.setReferer_url(StringUtils.substring(homepageAccess.getReferer_url(), 0, 1000));
		
		int result = homepageAccessDao.updateStatisticsCountLogMobile(homepageAccess);

		if(result == 1) {
			return result;
		} else {
			return homepageAccessDao.addStatisticsCountLogMobile(homepageAccess);
		}
	}
	
	public List<HomepageAccess> getCmsHomepageAccess(HomepageAccess homepageAccess) {
		return homepageAccessDao.getCmsHomepageAccess(homepageAccess);
	}

	/**
	 * @author whalesoft YONGJU 2019. 8. 20.
	 * @param homepageAccess
	 * @return
	 */
	public List<HomepageAccess> getChartData(HomepageAccess homepageAccess) {
		return homepageAccessDao.getChartData(homepageAccess);
	}

	/**
	 * @author whalesoft YONGJU 2019. 8. 20.
	 * @param homepageAccess
	 * @return
	 */
	public List<HomepageAccess> getChartViewData(HomepageAccess homepageAccess) {
		return homepageAccessDao.getChartViewData(homepageAccess);
	}

	/**
	 * @author whalesoft YONGJU 2019. 8. 21.
	 * @param homepageAccess
	 * @return
	 */
	public List<HomepageAccess> getChartDivData(HomepageAccess homepageAccess) {
		return homepageAccessDao.getChartDivData(homepageAccess);
	}

	/**
	 * @author whalesoft YONGJU 2019. 8. 21.
	 * @param homepageAccess
	 * @return
	 */
	public List<HomepageAccess> getChartViewDivData(HomepageAccess homepageAccess) {
		return homepageAccessDao.getChartViewDivData(homepageAccess);
	}
}