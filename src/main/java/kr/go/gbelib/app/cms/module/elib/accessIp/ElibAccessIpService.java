package kr.go.gbelib.app.cms.module.elib.accessIp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ElibAccessIpService extends BaseService {
	
	@Autowired
	private ElibAccessIpDao dao;
	
	public int getAccessIpCnt() {
		return dao.getAccessIpCnt();
	}
	
	public List<ElibAccessIp> getAccessIp(ElibAccessIp accessIp) {
		return dao.getAccessIp(accessIp);
	}
	
	public ElibAccessIp getAccessIpOne(ElibAccessIp accessIp) {
		return dao.getAccessIpOne(accessIp);
	}
	
	public int addAccessIp(ElibAccessIp accessIp) {
		return dao.addAccessIp(accessIp);
	}
	
	public int modifyAccessIp(ElibAccessIp accessIp) {
		return dao.modifyAccessIp(accessIp);
	}
	
	public int deleteAccessIp(ElibAccessIp accessIp) {
		return dao.deleteAccessIp(accessIp);
	}
	
	public int getBannedIpCnt(ElibAccessIp accessIp) {
		return dao.getBannedIpCnt(accessIp);
	}
	
}
