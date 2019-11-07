package kr.co.whalesoft.app.cms.module.smsSend;

import java.util.List;

public interface SmsSendDao {
	
	public List<SmsSend> getSmsSendList(SmsSend smsSend);
	
	public SmsSend getSmsSendOne(SmsSend smsSend);
	
	public int addSmsSend(SmsSend smsSend);
	
	public int modifySmsSend(SmsSend smsSend);
	
	//강좌
	public List<SmsSend> getTeachCategoryGroup(String homepage_id);
	
	public List<SmsSend> getTeachCategoryDetail(SmsSend smsSend);
	
	public List<SmsSend> getTeachList(SmsSend smsSend);
	
	public List<SmsSend> getTeachApplyList(SmsSend smsSend);
	
	public List<SmsSend> getTeacherList(SmsSend smsSend);
	
	//견학/체험 신청
	public List<SmsSend> getExcursionsList(SmsSend smsSend);
	
	public List<SmsSend> getExcursionsApplyList(SmsSend smsSend);
	
	
	//현장지원 신청
	public List<SmsSend> getSupportList(SmsSend smsSend);
	
	public List<SmsSend> getSupportApplyList(SmsSend smsSend);
	
	
	//시설물 이용신청
	public List<SmsSend> getFacilityList(SmsSend smsSend);
	
	public List<SmsSend> getFacilityApplyList(SmsSend smsSend);
	
	
	//사물함이용신청
	public List<SmsSend> getLockerPreList(SmsSend smsSend);
	
	public List<SmsSend> getLockerApplyList(SmsSend smsSend);
	
	
	//강사신청
	public List<SmsSend> getTeacherReqApplyList(SmsSend smsSend);

	
	//공통
	public List<SmsSend> getYearList(SmsSend smsSend);
	
	public List<SmsSend> getSmsBoxList(SmsSend smsSend);
	
	public int getSmsBoxCnt(SmsSend smsSend);
	
}
