/**
 *
 */
package kr.go.gbelib.app.cms.module.mapExample;

import java.util.List;
import java.util.Map;
import kr.co.whalesoft.framework.base.CommonBean;
import kr.go.gbelib.app.cms.module.bookOfYear.BookOfYear;

/**
 * @author whaleesoft YONGJU 2020. 2. 12.
 *
 */
public interface MapExampleDao {

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public int getBookOfYearCount(Map boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public List<CommonBean> getBookOfYearList(Map boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public Map getBookOfYearOne(Map boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public int addBookOfYear(Map boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public int modifyBookOfYear(Map boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public int deleteBookOfYear(Map boy);

}
