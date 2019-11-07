package kr.go.gbelib.app.cms.module.newBookDream;

import java.util.List;
import java.util.Map;

import kr.co.whalesoft.app.homepage.module.bookDream.BookDream;

import org.apache.commons.lang.StringUtils;

public class NewBookDream extends BookDream {

	private List<Map<String, Object>> configList;
	
	public NewBookDream() {
		if (StringUtils.equals(getSortField(), "add_date")) {
			setSortField("r_created");
		}
	}

	public List<Map<String, Object>> getConfigList() {
		return configList;
	}
	public void setConfigList(List<Map<String, Object>> configList) {
		this.configList = configList;
	}
	
}
