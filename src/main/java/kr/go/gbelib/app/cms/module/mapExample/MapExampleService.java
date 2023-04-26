/**
 *
 */
package kr.go.gbelib.app.cms.module.mapExample;

import java.util.List;
import java.util.Map;
import kr.co.whalesoft.framework.base.CommonService;
import kr.go.gbelib.app.cms.module.bookOfYear.BookOfYear;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author whaleesoft YONGJU 2020. 2. 12.
 *
 */
@Service
public class MapExampleService extends CommonService {

	@Autowired
	private MapExampleDao dao;

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public int getBookOfYearCount(Map boy) {
		return dao.getBookOfYearCount(boy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public List<BookOfYear> getBookOfYearList(Map boy) {
		return dao.getBookOfYearList(boy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public Map getBookOfYearOne(Map boy) {
		return dao.getBookOfYearOne(boy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 */
	public int addBookOfYear(Map boy) {
//		for (int i = 3000; i < 5000; i++) {
//			boy.put("selection_year", i);
//		}
		return 	dao.addBookOfYear(boy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 */
	public int modifyBookOfYear(Map boy) {
		return dao.modifyBookOfYear(boy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 */
	public int deleteBookOfYear(Map boy) {
		return dao.deleteBookOfYear(boy);
	}
}
