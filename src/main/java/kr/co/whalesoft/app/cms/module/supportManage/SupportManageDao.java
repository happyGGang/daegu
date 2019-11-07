package kr.co.whalesoft.app.cms.module.supportManage;

import java.util.List;

public interface SupportManageDao {
	
	public List<SupportManage> getSupportManage(SupportManage supportManage);
	
	public int getSupportManageCount(SupportManage supportManage);

	public SupportManage getCheckReqCount(SupportManage supportManage);
	
	public SupportManage getSupportManageOne(SupportManage supportManage);
	
	public int addSupportManage(SupportManage supportManage);
	
	public int modifySupportManage(SupportManage supportManage);
	
	public int deleteSupportManage(SupportManage supportManage);

}
