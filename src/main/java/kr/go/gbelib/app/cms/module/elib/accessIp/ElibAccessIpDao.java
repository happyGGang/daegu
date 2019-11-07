package kr.go.gbelib.app.cms.module.elib.accessIp;

import java.util.List;

public interface ElibAccessIpDao {
	
	public int getAccessIpCnt();

	public List<ElibAccessIp> getAccessIp(ElibAccessIp accessIp);
	
	public ElibAccessIp getAccessIpOne(ElibAccessIp accessIp);
	
	public int addAccessIp(ElibAccessIp accessIp);
	
	public int modifyAccessIp(ElibAccessIp accessIp);
	
	public int deleteAccessIp(ElibAccessIp accessIp);
	
	public int getBannedIpCnt(ElibAccessIp accessIp);
	
}