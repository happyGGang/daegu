package kr.go.gbelib.app.cms.module.bringInLog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BringInLogService extends BaseService {

	@Autowired
	private BringInLogDao dao;

	public int addLog(Member member) {
		return dao.addLog(member);
	}
	

}
