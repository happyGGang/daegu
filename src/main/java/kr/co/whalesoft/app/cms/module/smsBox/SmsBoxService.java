package kr.co.whalesoft.app.cms.module.smsBox;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SmsBoxService extends BaseService {
	
	@Autowired
	private SmsBoxDao dao;
	
	public int getSmsBoxCnt(SmsBox smsBox) {
		return dao.getSmsBoxCnt(smsBox);
	}
	
	public List<SmsBox> getSmsBoxList(SmsBox smsBox) {
		return dao.getSmsBoxList(smsBox);
	}
	
	public SmsBox getSmsBoxListOne(SmsBox smsBox) {
		return dao.getSmsBoxListOne(smsBox);
	}
	
	public int addSmsBox(SmsBox smsBox) {
		return dao.addSmsBox(smsBox);
	}
	
	public int modifySmsBox(SmsBox smsBox) {
		return dao.modifySmsBox(smsBox);
	}
	
	public int deleteSmsBox(SmsBox smsBox) {
		return dao.deleteSmsBox(smsBox);
	}

}
