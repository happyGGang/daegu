package kr.co.whalesoft.app.cms.workingLog;

import java.util.List;

/**
 * @author whalesoft
 * @date 2020.08.27
 *
 */
public interface WorkingLogDao {

	/**
	 * @author whalesoft
	 * @date 2020.08.27
	 *
	 * @param workingLog
	 * @return
	 *
	 */
	int addWorkingLog(WorkingLog workingLog);

	/**
	 * @author whalesoft
	 * @date 2020.08.28
	 *
	 * @param workingLog
	 * @return
	 *
	 */
	int getWorkingLogCount(WorkingLog workingLog);

	/**
	 * @author whalesoft
	 * @date 2020.08.28
	 *
	 * @param workingLog
	 * @return
	 *
	 */
	List<WorkingLog> getWorkingLogList(WorkingLog workingLog);

	/**
	 * @author whalesoft
	 * @date 2020.08.28
	 *
	 * @param workingLog
	 * @return
	 *
	 */
	WorkingLog getWorkingLogOne(WorkingLog workingLog);

}
