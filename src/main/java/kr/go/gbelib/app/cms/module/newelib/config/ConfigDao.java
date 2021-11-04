package kr.go.gbelib.app.cms.module.newelib.config;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper(value = "configDaoNew")
public interface ConfigDao {
	
	public Config getConfig();
	
	public int setConfig(Config config);
	
	public String getConfigPair(String name);
	
	public int setConfigPair(Config config);
	
}
