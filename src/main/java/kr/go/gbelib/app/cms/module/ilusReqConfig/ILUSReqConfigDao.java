package kr.go.gbelib.app.cms.module.ilusReqConfig;

import java.util.List;

public interface ILUSReqConfigDao {
	
	public List<ILUSReqConfig> getILUSReqConfigList(ILUSReqConfig ilusReqConfig);
	
	public List<ILUSReqConfig> getILUSReqConfigOne(ILUSReqConfig ilusReqConfig);
	
	public String getSubLacaList(ILUSReqConfig ilusReqConfig);
	
	public int duplicatecheck(ILUSReqConfig ilusReqConfig);
	
	public int addILUSReqConfig(ILUSReqConfig ilusReqConfig);

	public int modILUSReqConfig(ILUSReqConfig ilusReqConfig);
	
	public int getILUSReqIdx(ILUSReqConfig ilusReqConfig);
	
	public int mergeILUSReqConfig(ILUSReqConfig ilusReqConfig);

	public int deleteILUSReqConfig(ILUSReqConfig ilusReqConfig);

	public ILUSReqConfig getILUSReqConfigInfo(ILUSReqConfig ilusReqConfig);
	
	
	
	public List<ILUSReqConfig> getTestList(ILUSReqConfig ilusReqConfig);
	
	public ILUSReqConfig getILUSReqConfigCommon(ILUSReqConfig ilusReqConfig);
	
	public List<ILUSReqConfig> getConfigList(ILUSReqConfig ilusReqConfig);
	
	public List<String> getSubLocaCodes(ILUSReqConfig ilusReqConfig);

}
