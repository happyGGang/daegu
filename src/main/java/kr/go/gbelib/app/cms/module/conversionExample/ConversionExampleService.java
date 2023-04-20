package kr.go.gbelib.app.cms.module.conversionExample;

import java.util.List;
import java.util.Map;
import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConversionExampleService extends BaseService {
	@Autowired
	ConversionExampleDao dao;

	public List<Map<String, String>> getAllList() {
		return null;
	}

	public int totalCount() {
		return dao.totalCount();
	}

	public List<Map<String, Object>> commonList(Map<String, Object> commonMap) {
		return dao.commonList(commonMap);
	}

	public int totalTestCount(Map<String, Object> commonMap) {
		return dao.totalTestCount(commonMap);
	}
}
