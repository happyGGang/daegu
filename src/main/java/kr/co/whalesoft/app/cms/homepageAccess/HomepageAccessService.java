package kr.co.whalesoft.app.cms.homepageAccess;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseDao;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;

@Service
public class HomepageAccessService extends BaseDao {

	@Autowired
	private HomepageAccessDao homepageAccessDao;

	public int addHomepageAccess(HomepageAccess homepageAccess) {
		setDefaultSearchYear(homepageAccess);
		try {
			homepageAccessDao.addHomepageAccess(homepageAccess);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 1;
	}

	public List<HomepageAccess> getHomepageAccessResult(HomepageAccess homepageAccess) {
		List<HomepageAccess> result = null;
		long totalCount = 0;
		long minCount = 999999999999999999L;
		long maxCount = 0;
		setDefaultSearchYear(homepageAccess);
		if ( homepageAccess.getSearch_type().equals("ALL") ) {
			result = homepageAccessDao.getHomepageAccessResultByAll(homepageAccess);
		}
		else if ( homepageAccess.getSearch_type().equals("BROWSER") ) {
			result = homepageAccessDao.getHomepageAccessResultByBrowser(homepageAccess);
		}
		else if ( homepageAccess.getSearch_type().equals("OS") ) {
			result = homepageAccessDao.getHomepageAccessResultByOS(homepageAccess);
		}
		else if ( homepageAccess.getSearch_type().equals("DEVICE") ) {
			result = homepageAccessDao.getHomepageAccessResultByDevice(homepageAccess);
		}

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


	private void setDefaultSearchYear(HomepageAccess homepageAccess) {
		if (StringUtils.isEmpty(homepageAccess.getSearch_year())) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy");
			Calendar c = Calendar.getInstance();
			String today = sf.format(c.getTime());
			homepageAccess.setSearch_year(today);
		}
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
	 * @author whalesoft YONGJU 2019. 8. 20.
	 * @param homepageAccess
	 */
	public int addAccessCount(HomepageAccess homepageAccess) {
		homepageAccess.setSearch_type(homepageAccess.getAccess_system().equals("PC") ? "pc_count" : "mobile_count");
		return homepageAccessDao.addAccessCount(homepageAccess);
	}

	/**
	 * @author whalesoft YONGJU 2019. 8. 20.
	 * @param homepageAccess
	 */
	public int addViewCount(HomepageAccess homepageAccess) {
		homepageAccess.setSearch_type(homepageAccess.getAccess_system().equals("PC") ? "pc_count" : "mobile_count");
		return homepageAccessDao.addViewCount(homepageAccess);
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