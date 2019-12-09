package kr.go.gbelib.app.cms.module.lasReqConfig;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Service
public class LasReqConfigService extends BaseService {
	
	@Autowired
	private LasReqConfigDao dao;

	public List<Map<String, Object>> getLasReqConfigList(LasReqConfig lasReqConfig) {
		
		List<String> subLocaCodes = dao.getSubLocaCodes(lasReqConfig); // DB에 있는 자료실 리스트
		List<Map<String, Object>> configList = new ArrayList<Map<String,Object>>(); // 전체 리스트
		Map<String, Object> lists = null; // 한 row에 대한 기능 리스트
		
		for(int i =0; i < subLocaCodes.size(); i++) {
			lasReqConfig.setSub_loca_code(subLocaCodes.get(i));
			List<LasReqConfig> list = dao.getConfigList(lasReqConfig);
			lists = new HashMap<String, Object>();
			
			LasReqConfig common = dao.getLasReqConfigCommon(lasReqConfig);
			lists.put("loca_name", common.getLoca_name());
			lists.put("sub_loca_code", common.getSub_loca_code());
			
			for(int j = 0; j < list.size(); j++) {
				LasReqConfig one = list.get(j);
				
				if(one.getLas_req_code().equals("0001")) {
					lists.put("reservation", one);
				} else if(one.getLas_req_code().equals("0002")) {
					lists.put("extension", one);
				} else if(one.getLas_req_code().equals("0003")) {
					lists.put("night", one);
				} else if(one.getLas_req_code().equals("0004")) {
					lists.put("unmanned", one);
				}
			}
			
			configList.add(lists);
		}
		
		return configList;
	}
	
//	public List<LasReqConfig> getLasReqConfigList(LasReqConfig lasReqConfig) {
//		return dao.getLasReqConfigList(lasReqConfig);
//	}
	
	public LasReqConfig getLasReqConfigOne(LasReqConfig lasReqConfig) {
		
		List<LasReqConfig> list = dao.getLasReqConfigOne(lasReqConfig);
		LasReqConfig common = dao.getLasReqConfigCommon(lasReqConfig);
		lasReqConfig.setLas_config_list(new ArrayList<LasReqConfig>());
		lasReqConfig.getLas_config_list().add(null);
		lasReqConfig.getLas_config_list().add(null);
		lasReqConfig.getLas_config_list().add(null);
		lasReqConfig.getLas_config_list().add(null);
		
		for(int j = 0; j < list.size(); j++) {
			LasReqConfig one = list.get(j);
			
			if(one.getLas_req_code().equals("0001")) {
				lasReqConfig.getLas_config_list().set(0, one);
			} else if(one.getLas_req_code().equals("0002")) {
				lasReqConfig.getLas_config_list().set(1, one);
			} else if(one.getLas_req_code().equals("0003")) {
				lasReqConfig.getLas_config_list().set(2, one);
			} else if(one.getLas_req_code().equals("0004")) {
				lasReqConfig.getLas_config_list().set(3, one);
			}
		}
		
		lasReqConfig.setLoca_name(common.getLoca_name());
		lasReqConfig.setLoca_code(common.getLoca_code());
		lasReqConfig.setSub_loca_code(common.getSub_loca_code());
		
		return lasReqConfig;
	}
	
	public String getSubLacaList(LasReqConfig  lasReqConfig) {
		return dao.getSubLacaList(lasReqConfig);
	}
	
	public int duplicatecheck(LasReqConfig lasReqConfig) {
		return dao.duplicatecheck(lasReqConfig);
	}
	
	public int addLasReqConfig(LasReqConfig lasReqConfig) {
		return dao.addLasReqConfig(lasReqConfig);
	}

	public int modLasReqConfig(LasReqConfig lasReqConfig) {
		return dao.modLasReqConfig(lasReqConfig);
	}
	
	public int getLasReqIdx(LasReqConfig lasReqConfig) {
		return dao.getLasReqIdx(lasReqConfig);
	}
	
	public int mergeLasReqConfig(LasReqConfig lasReqConfig) {
		return dao.mergeLasReqConfig(lasReqConfig);
	}

	public int deleteLasReqConfig(LasReqConfig lasReqConfig) {
		return dao.deleteLasReqConfig(lasReqConfig);
	}

	public LasReqConfig getLasReqConfigInfo(LibrarySearch librarySearch, String las_req_code) {
		LasReqConfig lasReqConfig = new LasReqConfig();
		lasReqConfig.setLoca_code(librarySearch.getvLoca());
		lasReqConfig.setSub_loca_code(librarySearch.getvSubLoca());
		lasReqConfig.setLas_req_code(las_req_code);
		
		return dao.getLasReqConfigInfo(lasReqConfig);
	}

}
