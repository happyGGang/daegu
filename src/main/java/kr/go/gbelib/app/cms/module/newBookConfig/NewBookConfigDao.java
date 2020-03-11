package kr.go.gbelib.app.cms.module.newBookConfig;

import java.util.List;

public interface NewBookConfigDao {
	
	public List<String> getShelfCodeList(NewBookConfig newBookConfig);

	public int newBookConfigSave(NewBookConfig newBookConfig);

	public int newBookConfigDelete(NewBookConfig newBookConfig);

}
