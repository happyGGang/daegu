package kr.go.gbelib.app.cms.module.culture;

import java.util.List;

public interface CultureDao {
    public List<Culture> getAreaCultureList(Culture culture);

    public Culture getCultureOne(Culture culture);

    public List<Culture> getCultureList(Culture culture);

    public int getCultureCount(Culture culture);
}
