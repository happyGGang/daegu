package kr.go.gbelib.app.cms.module.elib.config;

public interface ConfigDao {
	
	public Config getConfig();
	
	public int setConfig(Config config);
	
	public String getConfigPair(String name);
	
	public int setConfigPair(Config config);
	
}
