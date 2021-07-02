package kr.co.whalesoft.app.cms.workingLog;

import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author whalesoft
 * @date 2020.08.27
 *
 */
@Service
public class WorkingLogService extends BaseService {


	@Autowired
	private WorkingLogDao dao;

	/**
	 * @author whalesoft
	 * @date 2020.08.27
	 *
	 * @param workingLog
	 *
	 */
	public int addWorkingLog(WorkingLog workingLog) {
		return dao.addWorkingLog(workingLog);
	}

	/**
	 * @author whalesoft
	 * @date 2020.08.28
	 *
	 * @param workingLog
	 *
	 */
	public int getWorkingLogCount(WorkingLog workingLog) {
		return dao.getWorkingLogCount(workingLog);
	}

	/**
	 * @author whalesoft
	 * @date 2020.08.28
	 *
	 * @param workingLog
	 * @return
	 *
	 */
	public List<WorkingLog> getWorkingLogList(WorkingLog workingLog) {
		return dao.getWorkingLogList(workingLog);
	}
	
	/**
	 * @author whalesoft
	 * @date 2020.12.14
	 *
	 * @param workingLog
	 * @return
	 *
	 */
	public List<WorkingLog> getWorkingLogExcelList(WorkingLog workingLog) {
		return dao.getWorkingLogExcelList(workingLog);
	}

	/**
	 * @author whalesoft
	 * @date 2020.08.28
	 *
	 * @param workingLog
	 * @return
	 *
	 */
	public WorkingLog getWorkingLogOne(WorkingLog workingLog) {
		return dao.getWorkingLogOne(workingLog);
	}


}
