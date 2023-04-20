package kr.go.gbelib.app.cms.module.conversionExample;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class CommonBean extends PagingUtils {

    private Map<String,Object> commonMap;

    public CommonBean() {

    }
    public CommonBean(Map<String, Object> commonMap) {
        this.commonMap = commonMap;
    }

    public Map<String, Object> getCommonMap() {
        return commonMap;
    }

}
