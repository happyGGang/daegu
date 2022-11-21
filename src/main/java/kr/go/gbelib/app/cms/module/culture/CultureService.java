package kr.go.gbelib.app.cms.module.culture;

import java.util.List;
import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CultureService extends BaseService {

    @Autowired
    private CultureDao dao;

    public List<Culture> getAreaCultureList(Culture culture) {
        return dao.getAreaCultureList(culture);
    }
}
