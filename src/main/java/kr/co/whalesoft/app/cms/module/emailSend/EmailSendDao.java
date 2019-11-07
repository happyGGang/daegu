package kr.co.whalesoft.app.cms.module.emailSend;

import java.util.List;

public interface EmailSendDao {
	
	public List<EmailSend> getSmsSendList(EmailSend smsSend);
	
	public EmailSend getSmsSendOne(EmailSend smsSend);
	
	public int addSmsSend(EmailSend smsSend);
	
	public int modifySmsSend(EmailSend smsSend);
	
	//강좌
	public List<EmailSend> getTeachCategoryGroup(String homepage_id);
	
	public List<EmailSend> getTeachCategoryDetail(EmailSend smsSend);
	
	public List<EmailSend> getTeachList(EmailSend smsSend);
	
	public List<EmailSend> getTeachApplyList(EmailSend smsSend);
	
	public List<EmailSend> getTeacherList(EmailSend smsSend);
	
	//견학/체험 신청
	public List<EmailSend> getExcursionsList(EmailSend smsSend);
	
	public List<EmailSend> getExcursionsApplyList(EmailSend smsSend);
	
	
	//현장지원 신청
	public List<EmailSend> getSupportList(EmailSend smsSend);
	
	public List<EmailSend> getSupportApplyList(EmailSend smsSend);
	
	
	//시설물 이용신청
	public List<EmailSend> getFacilityList(EmailSend smsSend);
	
	public List<EmailSend> getFacilityApplyList(EmailSend smsSend);
	
	
	//사물함이용신청
	public List<EmailSend> getLockerPreList(EmailSend smsSend);
	
	public List<EmailSend> getLockerApplyList(EmailSend smsSend);
	
	
	//강사신청
	public List<EmailSend> getTeacherReqApplyList(EmailSend smsSend);

	
	//공통
	public List<EmailSend> getYearList(EmailSend smsSend);
	
	public List<EmailSend> getSmsBoxList(EmailSend smsSend);
	
}
