package kr.go.gbelib.app.cms.module.smsReception;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class SmsReceptionService extends BaseService {
	
	@Autowired
	private SmsReceptionDao dao;

	public List<SmsReception> getSmsReceptionList(SmsReception smsReception) {
		return dao.getSmsReceptionList(smsReception);
	}
	
	public int getSmsReceptionCount(SmsReception smsReception) {
		return dao.getSmsReceptionCount(smsReception);
	}
	
	public SmsReception getSmsReceptionOne(SmsReception smsReception) {
		return dao.getSmsReceptionOne(smsReception);
	}

	public int addSmsReception(SmsReception smsReception) {
		return dao.addSmsReception(smsReception);
	}

	public int modSmsReception(SmsReception smsReception) {
		return dao.modSmsReception(smsReception);
	}
	
	public int getWorkIdx(SmsReception smsReception) {
		return dao.getWorkIdx(smsReception);
	}

	public int mergeReception(SmsReception smsReception) {
		return dao.mergeReception(smsReception);
	}

	public List<SmsReception> getReceptionWorkList(SmsReception smsReception) {
		return dao.getReceptionWorkList(smsReception);
	}

	public int receptionDel(SmsReception smsReception) {
		int res = dao.receptionDel(smsReception);
		if(res > 0) {
			dao.receptionWorkDel(smsReception);
		}
		return res;
	}

	public List<SmsReception> getSmsReceptionMembers(SmsReception smsReception) {
		return dao.getSmsReceptionMembers(smsReception);
	}

}
