/**
 *
 */
package kr.go.gbelib.app.cms.module.bookOfYear;

import java.util.List;
import java.util.Map;

/**
 * @author whaleesoft YONGJU 2020. 2. 12.
 *
 */
public interface BookOfYearDao {

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
	public List<BookOfYear> getBookOfYearList(Map boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public BookOfYear getBookOfYearOne(Map boy);

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
