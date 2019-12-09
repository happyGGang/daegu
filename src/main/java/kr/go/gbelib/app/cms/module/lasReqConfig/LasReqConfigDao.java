package kr.go.gbelib.app.cms.module.lasReqConfig;

import java.util.List;

public interface LasReqConfigDao {
	
//	public List<LasReqConfig> getLasReqConfigList(LasReqConfig lasReqConfig);
	
	public List<LasReqConfig> getLasReqConfigOne(LasReqConfig lasReqConfig);
	
	public String getSubLacaList(LasReqConfig lasReqConfig);
	
	public int duplicatecheck(LasReqConfig lasReqConfig);
	
	public int addLasReqConfig(LasReqConfig lasReqConfig);

	public int modLasReqConfig(LasReqConfig lasReqConfig);
	
	public int getLasReqIdx(LasReqConfig lasReqConfig);
	
	public int mergeLasReqConfig(LasReqConfig lasReqConfig);

	public int deleteLasReqConfig(LasReqConfig lasReqConfig);

	public LasReqConfig getLasReqConfigInfo(LasReqConfig lasReqConfig);
	
//	public List<LasReqConfig> getTestList(LasReqConfig lasReqConfig);
	
	public LasReqConfig getLasReqConfigCommon(LasReqConfig lasReqConfig);
	
	public List<LasReqConfig> getConfigList(LasReqConfig lasReqConfig);
	
	public List<String> getSubLocaCodes(LasReqConfig lasReqConfig);

}
