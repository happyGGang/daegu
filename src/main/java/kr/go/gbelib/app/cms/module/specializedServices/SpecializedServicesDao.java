package kr.go.gbelib.app.cms.module.specializedServices;

import java.util.List;

public interface SpecializedServicesDao {

    public List<SpecializedServices> getSpecializedServicesList(SpecializedServices specializedServices);

    public int getSpecializedServicesCount(SpecializedServices specializedServices);

    public SpecializedServices getSpecializedServicesOne(SpecializedServices specializedServices);

    public int addSpecializedServices(SpecializedServices specializedServices);

    public int modifySpecializedServices(SpecializedServices specializedServices);

    public int deleteSpecializedServices(SpecializedServices specializedServices);

    public List<SpecializedServices> getSpecializedServicesMainList(SpecializedServices specializedServices);
}
