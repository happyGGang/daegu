package kr.go.gbelib.app.module.loginLog;

import java.util.List;

public interface LoginLogDao {

	public int getLoginLogCnt(LoginLog loginLog);
	
	public List<LoginLog> getLoginLogList(LoginLog loginLog);
	
	public int addLoginLog(LoginLog loginLog);
	
	public List<LoginLog> getLoginLogListCms(LoginLog loginLog);
	
	public int getLoginLogCntCms(LoginLog loginLog);
	
}
