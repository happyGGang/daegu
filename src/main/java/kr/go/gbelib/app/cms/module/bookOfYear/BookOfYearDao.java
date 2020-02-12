/**
 *
 */
package kr.go.gbelib.app.cms.module.bookOfYear;

import java.util.List;

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
	public int getBookOfYearCount(BookOfYear boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public List<BookOfYear> getBookOfYearList(BookOfYear boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public BookOfYear getBookOfYearOne(BookOfYear boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public int addBookOfYear(BookOfYear boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public int modifyBookOfYear(BookOfYear boy);

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 * @return
	 */
	public int deleteBookOfYear(BookOfYear boy);

}
