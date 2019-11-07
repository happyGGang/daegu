package kr.go.gbelib.app.cms.module.hopebookConfig;

import java.util.List;

public interface HopebookConfigDao {
	
	public List<HopebookConfig> getHopebookList(HopebookConfig hopebookConfig);

	public int duplicatecheck(HopebookConfig hopebookConfig);

	public int addHopebookConfig(HopebookConfig hopebookConfig);
	
	public int deleteHopebookConfig(HopebookConfig hopebookConfig);

	public HopebookConfig getHopebookConfigOne(HopebookConfig hopebookConfig);
	
	public HopebookConfig getHopebookConfigInfo(String homepage_id);

}
