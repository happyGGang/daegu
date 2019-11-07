package kr.go.gbelib.app.cms.module.elib.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ConfigService extends BaseService {
	
	@Autowired
	private ConfigDao dao;
	
	public Config getConfig() {
		return dao.getConfig();
	}
	
	public int setConfig(Config config) {
		return dao.setConfig(config);
	}
	
	public String getConfigPair(String name) {
		return dao.getConfigPair(name);
	}

	public int setConfigPair(Config config) {
		return dao.setConfigPair(config);
	}
	
}
