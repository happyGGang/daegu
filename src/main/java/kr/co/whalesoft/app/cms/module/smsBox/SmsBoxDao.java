package kr.co.whalesoft.app.cms.module.smsBox;

import java.util.List;

public interface SmsBoxDao {
	
	public int getSmsBoxCnt(SmsBox smsBox);
	
	public List<SmsBox> getSmsBoxList(SmsBox smsBox);
	
	public SmsBox getSmsBoxListOne(SmsBox smsBox);
	
	public int addSmsBox(SmsBox smsBox);
	
	public int modifySmsBox(SmsBox smsBox);
	
	public int deleteSmsBox(SmsBox smsBox);

}
