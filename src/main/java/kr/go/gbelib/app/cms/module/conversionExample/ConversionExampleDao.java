package kr.go.gbelib.app.cms.module.conversionExample;

import java.util.List;
import java.util.Map;

public interface ConversionExampleDao {

    int totalCount();
    List<Map<String, Object>> commonList(Map<String, Object> commonMap);

    int totalTestCount(Map<String, Object> commonMap);
}
