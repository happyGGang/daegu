package kr.co.whalesoft.app.cms.moduleMngt;

import java.util.List;

public interface ModuleMngtDao  {

	public List<ModuleMngt> getModuleMngtList(ModuleMngt moduleMngt);
	
	public List<ModuleMngt> getModuleMngtListAll(ModuleMngt moduleMngt);
	
	public int getModuleMngtListCount(ModuleMngt moduleMngt);
	
	public ModuleMngt getModuleMngtOne(ModuleMngt moduleMngt);
	
	public int addModuleMngt(ModuleMngt moduleMngt);
	
	public int modifyModuleMngt(ModuleMngt moduleMngt);
	
	public int deleteModuleMngt(ModuleMngt moduleMngt);
	
	public int mergeModuleTerms(ModuleMngt moduleMngt);

	public int addModuleTerms(ModuleMngt moduleMngt);

	public int deleteModuleTerms(ModuleMngt moduleMngt);

	public List<String> getModuleAuthIdList(ModuleMngt moduleMngt);
}