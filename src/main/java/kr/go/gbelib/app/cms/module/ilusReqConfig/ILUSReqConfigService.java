package kr.go.gbelib.app.cms.module.ilusReqConfig;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Service
public class ILUSReqConfigService extends BaseService {
	
	@Autowired
	private ILUSReqConfigDao dao;

	public List<Map<String, Object>> getILusReqConfigList(ILUSReqConfig ilusReqConfig) {
		
		List<String> subLocaCodes = dao.getSubLocaCodes(ilusReqConfig); // DB에 있는 자료실 리스트
		List<Map<String, Object>> configList = new ArrayList<Map<String,Object>>(); // 전체 리스트
		Map<String, Object> lists = null; // 한 row에 대한 기능 리스트
		
		for(int i =0; i < subLocaCodes.size(); i++) {
			ilusReqConfig.setSub_loca_code(subLocaCodes.get(i));
			List<ILUSReqConfig> list = dao.getConfigList(ilusReqConfig);
			lists = new HashMap<String, Object>();
			
			ILUSReqConfig common = dao.getILUSReqConfigCommon(ilusReqConfig);
			lists.put("loca_name", common.getLoca_name());
			lists.put("sub_loca_code", common.getSub_loca_code());
			
			for(int j = 0; j < list.size(); j++) {
				ILUSReqConfig one = list.get(j);
				
				if(one.getIlus_req_code().equals("0001")) {
					lists.put("reservation", one);
				} else if(one.getIlus_req_code().equals("0002")) {
					lists.put("extension", one);
				} else if(one.getIlus_req_code().equals("0003")) {
					lists.put("night", one);
				}
			}
			
			configList.add(lists);
		}
		
		return configList;
	}
	
	public List<ILUSReqConfig> getILUSReqConfigList(ILUSReqConfig ilusReqConfig) {
		return dao.getILUSReqConfigList(ilusReqConfig);
	}
	
	public ILUSReqConfig getILUSReqConfigOne(ILUSReqConfig ilusReqConfig) {
		
		List<ILUSReqConfig> list = dao.getILUSReqConfigOne(ilusReqConfig);
		ILUSReqConfig common = dao.getILUSReqConfigCommon(ilusReqConfig);
		ilusReqConfig.setIlus_config_list(new ArrayList<ILUSReqConfig>());
		ilusReqConfig.getIlus_config_list().add(null);
		ilusReqConfig.getIlus_config_list().add(null);
		ilusReqConfig.getIlus_config_list().add(null);
		
		for(int j = 0; j < list.size(); j++) {
			ILUSReqConfig one = list.get(j);
			
			if(one.getIlus_req_code().equals("0001")) {
				ilusReqConfig.getIlus_config_list().set(0, one);
			} else if(one.getIlus_req_code().equals("0002")) {
				
				ilusReqConfig.getIlus_config_list().set(1, one);
			} else if(one.getIlus_req_code().equals("0003")) {
				ilusReqConfig.getIlus_config_list().set(2, one);
			}
		}
		
		ilusReqConfig.setLoca_name(common.getLoca_name());
		ilusReqConfig.setLoca_code(common.getLoca_code());
		ilusReqConfig.setSub_loca_code(common.getSub_loca_code());
		
		return ilusReqConfig;
	}
	
	public String getSubLacaList(ILUSReqConfig  ilusReqConfig) {
		return dao.getSubLacaList(ilusReqConfig);
	}
	
	public int duplicatecheck(ILUSReqConfig ilusReqConfig) {
		return dao.duplicatecheck(ilusReqConfig);
	}
	
	public int addILUSReqConfig(ILUSReqConfig ilusReqConfig) {
		return dao.addILUSReqConfig(ilusReqConfig);
	}

	public int modILUSReqConfig(ILUSReqConfig ilusReqConfig) {
		return dao.modILUSReqConfig(ilusReqConfig);
	}
	
	public int getILUSReqIdx(ILUSReqConfig ilusReqConfig) {
		return dao.getILUSReqIdx(ilusReqConfig);
	}
	
	public int mergeILUSReqConfig(ILUSReqConfig ilusReqConfig) {
		return dao.mergeILUSReqConfig(ilusReqConfig);
	}

	public int deleteILUSReqConfig(ILUSReqConfig ilusReqConfig) {
		return dao.deleteILUSReqConfig(ilusReqConfig);
	}

	public ILUSReqConfig getILUSReqConfigInfo(LibrarySearch librarySearch, String ilus_req_code) {
		ILUSReqConfig ilusReqConfig = new ILUSReqConfig();
		ilusReqConfig.setLoca_code(librarySearch.getvLoca());
		ilusReqConfig.setSub_loca_code(librarySearch.getvSubLoca());
		ilusReqConfig.setIlus_req_code(ilus_req_code);
		
		return dao.getILUSReqConfigInfo(ilusReqConfig);
	}

}
