package kr.co.whalesoft.app.homepage.sns;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class SNSAccessService extends BaseService {
	
	@Autowired
	private SNSAccessDao dao;
	
	public int mergeTwitter(SNSAccess snsAccess) {
		return dao.mergeTwitter(snsAccess);
	}
	
	public int mergeFacebook(SNSAccess snsAccess) {
		return dao.mergeFacebook(snsAccess);
	}
	
	public int mergeKakaostory(SNSAccess snsAccess) {
		return dao.mergeKakaostory(snsAccess);
	}
	
}