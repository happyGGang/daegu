package kr.go.gbelib.app.cms.module.newelib.accessIp;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper(value = "ElibAccessIpDaoNew")
public interface ElibAccessIpDao {
	
	public int getAccessIpCnt();

	public List<ElibAccessIp> getAccessIp(ElibAccessIp accessIp);
	
	public ElibAccessIp getAccessIpOne(ElibAccessIp accessIp);
	
	public int addAccessIp(ElibAccessIp accessIp);
	
	public int modifyAccessIp(ElibAccessIp accessIp);
	
	public int deleteAccessIp(ElibAccessIp accessIp);
	
	public int getBannedIpCnt(ElibAccessIp accessIp);
	
}