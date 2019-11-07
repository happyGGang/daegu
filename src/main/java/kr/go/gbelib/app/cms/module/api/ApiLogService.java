package kr.go.gbelib.app.cms.module.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ApiLogService extends BaseService {

	@Autowired
	private ApiLogDao dao;
	
	public int addApiLog(ApiLog apiLog) {
		return dao.addApiLog(apiLog);
	}
	
}
