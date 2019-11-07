package kr.co.whalesoft.app.cms.accessIp;

import java.util.List;

public interface AccessIpDao {

	public List<AccessIp> getAccessIp();
	
	public AccessIp getAccessIpOne(AccessIp accessIp);
	
	public int addAccessIp(AccessIp accessIp);
	
	public int modifyAccessIp(AccessIp accessIp);
	
	public int deleteAccessIp(AccessIp accessIp);
	
}