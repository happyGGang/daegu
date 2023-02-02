package kr.co.whalesoft.app.cms.limitedIp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class LimitedIpService extends BaseService {

	@Autowired
	private LimitedIpDao dao;

	public List<LimitedIp> getLimitedIp() {
		return dao.getLimitedIp();
	}

	public LimitedIp getLimitedIpOne(LimitedIp limitedIp) {
		return dao.getLimitedIpOne(limitedIp);
	}

	public int addLimitedIp(LimitedIp limitedIp) {
		return dao.addLimitedIp(limitedIp);
	}

	public int modifyLimitedIp(LimitedIp limitedIp) {
		return dao.modifyLimitedIp(limitedIp);
	}

	public int deleteLimitedIp(LimitedIp limitedIp) {
		return dao.deleteLimitedIp(limitedIp);
	}

	public List<LimitedIp> getLimitedIpList() {
		return dao.getLimitedIpList();
	}
}
