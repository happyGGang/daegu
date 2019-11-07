package kr.co.whalesoft.app.cms.moduleMngt;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ModuleMngtService extends BaseService {
	
	@Autowired
	private ModuleMngtDao dao;
	
	public List<ModuleMngt> getModuleMngtListAll(ModuleMngt moduleMngt) {
		return dao.getModuleMngtListAll(moduleMngt);
	}
	
	public List<ModuleMngt> getModuleMngtListAllAuth(ModuleMngt moduleMngt) {
		List<ModuleMngt> list = dao.getModuleMngtListAll(moduleMngt);
		return list;
	}
	 
	public List<ModuleMngt> getModuleMngtList(ModuleMngt moduleMngt) {
		return dao.getModuleMngtList(moduleMngt);
	}
	
	public int getModuleMngtListCount(ModuleMngt moduleMngt) {
		return dao.getModuleMngtListCount(moduleMngt);
	}
	
	public ModuleMngt getModuleMngtOne(ModuleMngt moduleMngt) {
		return dao.getModuleMngtOne(moduleMngt);
	}
	
	@Transactional
	public int addModuleMngt(ModuleMngt moduleMngt) {
		dao.addModuleMngt(moduleMngt);
		return 1;
	}
	
	public int modifyModuleMngt(ModuleMngt moduleMngt) {
		return dao.modifyModuleMngt(moduleMngt);
	}
	
	public int deleteModuleMngt(ModuleMngt moduleMngt) {
		return dao.deleteModuleMngt(moduleMngt);
	}
	
	public int mergeModuleTerms(ModuleMngt moduleMngt) {
		return dao.mergeModuleTerms(moduleMngt);
	}

	public int addModuleTerms(ModuleMngt moduleMngt) {
		return dao.addModuleTerms(moduleMngt);
	}

	public int deleteModuleTerms(ModuleMngt moduleMngt) {
		return dao.deleteModuleTerms(moduleMngt);
	}

	/**
	 * 모듈 권한ID리스트를 가져온다.
	 * @param moduleMngt
	 * @return
	 */
	public List<String> getModuleAuthIdList(ModuleMngt moduleMngt) {
		return dao.getModuleAuthIdList(moduleMngt);
	}
}