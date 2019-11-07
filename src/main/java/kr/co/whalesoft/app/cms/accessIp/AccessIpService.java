package kr.co.whalesoft.app.cms.accessIp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class AccessIpService extends BaseService {
	
	@Autowired
	private AccessIpDao dao;
	
	public List<AccessIp> getAccessIp() {
		return dao.getAccessIp();
	}
	
	public AccessIp getAccessIpOne(AccessIp accessIp) {
		return dao.getAccessIpOne(accessIp);
	}
	
	public int addAccessIp(AccessIp accessIp) {
		return dao.addAccessIp(accessIp);
	}
	
	public int modifyAccessIp(AccessIp accessIp) {
		return dao.modifyAccessIp(accessIp);
	}
	
	public int deleteAccessIp(AccessIp accessIp) {
		return dao.deleteAccessIp(accessIp);
	}
}
