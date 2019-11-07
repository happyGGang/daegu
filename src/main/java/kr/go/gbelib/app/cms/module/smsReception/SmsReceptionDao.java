package kr.go.gbelib.app.cms.module.smsReception;

import java.util.List;

public interface SmsReceptionDao {

	public List<SmsReception> getSmsReceptionList(SmsReception smsReception);
	
	public int getSmsReceptionCount(SmsReception smsReception);
	
	public SmsReception getSmsReceptionOne(SmsReception smsReception);

	public int addSmsReception(SmsReception smsReception);

	public int modSmsReception(SmsReception smsReception);
	
	public int getWorkIdx(SmsReception smsReception);

	public int mergeReception(SmsReception smsReception);

	public List<SmsReception> getReceptionWorkList(SmsReception smsReception);

	public int receptionDel(SmsReception smsReception);

	public int receptionWorkDel(SmsReception smsReception);

	public List<SmsReception> getSmsReceptionMembers(SmsReception smsReception);

}
