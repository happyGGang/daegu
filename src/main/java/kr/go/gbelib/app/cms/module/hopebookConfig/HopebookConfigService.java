package kr.go.gbelib.app.cms.module.hopebookConfig;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class HopebookConfigService extends BaseService {
	
	@Autowired
	private HopebookConfigDao dao;
	
	public List<HopebookConfig> getHopebookList(HopebookConfig hopebookConfig) {
		return dao.getHopebookList(hopebookConfig);
	}

	public int duplicatecheck(HopebookConfig hopebookConfig) {
		return dao.duplicatecheck(hopebookConfig);
	}

	public int addHopebookConfig(HopebookConfig hopebookConfig) {
		return dao.addHopebookConfig(hopebookConfig);
	}
	
	public int deleteHopebookConfig(HopebookConfig hopebookConfig) {
		return dao.deleteHopebookConfig(hopebookConfig);
	}

	public HopebookConfig getHopebookConfigOne(HopebookConfig hopebookConfig) {
		HopebookConfig result = dao.getHopebookConfigOne(hopebookConfig);
		if(result == null) {
			return hopebookConfig;
		} else {
			return result;
		}
	}
	
	public HopebookConfig getHopebookConfigInfo(String homepage_id) {
		return dao.getHopebookConfigInfo(homepage_id);
	}

}
