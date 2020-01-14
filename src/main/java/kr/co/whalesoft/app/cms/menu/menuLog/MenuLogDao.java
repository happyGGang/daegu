package kr.co.whalesoft.app.cms.menu.menuLog;

import java.util.List;

public interface MenuLogDao {
	public int addMenuLog(MenuLog menu);

	/**
	 * @author whalesoft YONGJU 2020. 1. 14.
	 * @param menuLog
	 * @return
	 */
	public int getMenuLogCount(MenuLog menuLog);

	/**
	 * @author whalesoft YONGJU 2020. 1. 14.
	 * @param menuLog
	 * @return
	 */
	public List<MenuLog> getMenuLogList(MenuLog menuLog);

	/**
	 * @author whalesoft YONGJU 2020. 1. 14.
	 * @param menuLog
	 * @return
	 */
	public int recovery(MenuLog menuLog);

	/**
	 * @author whalesoft YONGJU 2020. 1. 14.
	 * @param menuLog
	 * @return
	 */
	public MenuLog getMenuLogOne(MenuLog menuLog);
}