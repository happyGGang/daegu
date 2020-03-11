package kr.go.gbelib.app.cms.module.newBookConfig;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NewBookConfigService {
	
	@Autowired
	private NewBookConfigDao dao;
	
	public List<String> getShelfCodeList(NewBookConfig newBookConfig) {
		return dao.getShelfCodeList(newBookConfig);
	}

	public int newBookConfigSave(NewBookConfig newBookConfig) {
		return dao.newBookConfigSave(newBookConfig);
	}
	
	public int newBookConfigDelete(NewBookConfig newBookConfig) {
		return dao.newBookConfigDelete(newBookConfig);
	}

}
