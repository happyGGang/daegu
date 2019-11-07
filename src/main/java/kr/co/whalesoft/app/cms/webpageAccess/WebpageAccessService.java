package kr.co.whalesoft.app.cms.webpageAccess;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseDao;

@Service
public class WebpageAccessService extends BaseDao {

	@Autowired
	private WebpageAccessDao webpageAccessDao;

	public int addWebpageAccess(WebpageAccess webpageAccess) {
		setDefaultSearchYear(webpageAccess);
		return webpageAccessDao.addWebpageAccess(webpageAccess);
	}

	public List<WebpageAccess> getWebpageAccessResult(WebpageAccess webpageAccess) {
		List<WebpageAccess> result = null;
		long totalCount = 0;
		long minCount = 999999999999999999L;
		long maxCount = 0;
		setDefaultSearchYear(webpageAccess);
		if ( webpageAccess.getSearch_type().equals("ALL") ) {
			result = webpageAccessDao.getWebpageAccessResultByAll(webpageAccess);
		}
		else if ( webpageAccess.getSearch_type().equals("BROWSER") ) {
			result = webpageAccessDao.getWebpageAccessResultByBrowser(webpageAccess);
		}
		else if ( webpageAccess.getSearch_type().equals("OS") ) {
			result = webpageAccessDao.getWebpageAccessResultByOS(webpageAccess);
		}
		else if ( webpageAccess.getSearch_type().equals("DEVICE") ) {
			result = webpageAccessDao.getWebpageAccessResultByDevice(webpageAccess);
		}

		if ( result != null && result.size() > 0 ) {
			for ( WebpageAccess oneInfo : result ) {
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

	public String getLastWebpageAccess(Member member) {
		return webpageAccessDao.getLastWebpageAccess(member);
	}

	private void setDefaultSearchYear(WebpageAccess webpageAccess) {
		if (StringUtils.isEmpty(webpageAccess.getSearch_year())) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy");
			Calendar c = Calendar.getInstance();
			String today = sf.format(c.getTime());
			webpageAccess.setSearch_year(today);
		}
	}
}