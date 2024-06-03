package kr.co.whalesoft.app.cms.workingLog;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.dataSource.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.*;
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

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * @author whalesoft
	 * @date 2020.08.27
	 *
	 * @param workingLog
	 *
	 */
	public int addWorkingLog(WorkingLog workingLog) {
		String sql = "";

		if ("SELECT".equals(workingLog.getWork_command())) {
			sql = workingLog.getWork_query();

			workingLog.setWork_result(jdbcTemplate.queryForList(sql).toString());
		} else if ("UPDATE".equals(workingLog.getWork_command())) {
			sql = "SELECT * FROM CMS_MEMBER WHERE member_id = 'rudaks'";

			System.out.println(jdbcTemplate.queryForList(sql).toString());
		}

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
