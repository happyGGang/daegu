package kr.co.whalesoft.app.cms.limitedIp;

import java.util.List;

public interface LimitedIpDao {

	public List<LimitedIp> getLimitedIp();
	
	public LimitedIp getLimitedIpOne(LimitedIp limitedIp);
	
	public int addLimitedIp(LimitedIp limitedIp);
	
	public int modifyLimitedIp(LimitedIp limitedIp);
	
	public int deleteLimitedIp(LimitedIp limitedIp);

	public List<LimitedIp> getLimitedIpList();
	
}