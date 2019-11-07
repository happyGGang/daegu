package kr.go.gbelib.app.module.loginLog;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
	
public class LoginLogService extends BaseService {
	@Autowired
	private LoginLogDao dao;
	
	public int getLoginLogCnt(LoginLog loginLog) {
		return dao.getLoginLogCnt(loginLog);
	}
	
	public List<LoginLog> getLoginLogList(LoginLog loginLog) {
		return dao.getLoginLogList(loginLog);
	}
	
	public int addLoginLog(LoginLog loginLog) {
		return dao.addLoginLog(loginLog);
	}
	
	public List<LoginLog> getLoginLogListCms(LoginLog loginLog) {
		return dao.getLoginLogListCms(loginLog);
	}
	
	public int getLoginLogCntCms(LoginLog loginLog) {
		return dao.getLoginLogCntCms(loginLog);
	}
	
}
