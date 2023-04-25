/**
 *
 */
package kr.go.gbelib.app.cms.module.bookOfYear;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author whaleesoft YONGJU 2020. 2. 12.
 *
 */
@Service
public class BookOfYearService extends BaseService {

	@Autowired
	private BookOfYearDao dao;

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
	public BookOfYear getBookOfYearOne(Map boy) {
		return dao.getBookOfYearOne(boy);
	}

	/**
	 * @author whalesoft YONGJU 2020. 2. 12.
	 * @param boy
	 */
	public int addBookOfYear(Map boy) {
		return dao.addBookOfYear(boy);
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
