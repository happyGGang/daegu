package kr.co.whalesoft.app.cms.module.smsSend;

import java.util.List;
import kr.co.whalesoft.app.cms.module.addressBook.AddressBook;
import kr.co.whalesoft.app.cms.module.addressBook.AddressBookService;
import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SmsSendService extends BaseService{

	@Autowired
	private AddressBookService addressBookService;
	
	@Autowired
	private SmsSendDao dao;
	
	public List<SmsSend> getSmsSendList(SmsSend smsSend) {
		return dao.getSmsSendList(smsSend);
	}
	
	public SmsSend getSmsSendOne(SmsSend smsSend) {
		return dao.getSmsSendOne(smsSend);
	}
	
	public int addSmsSend(SmsSend smsSend) {
		return dao.addSmsSend(smsSend);
	}
	
	public int modifySmsSend(SmsSend smsSend) {
		return dao.modifySmsSend(smsSend);
	}
	
	//강좌
	public List<SmsSend> getTeachCategoryGroup(String homepage_id) {
		return dao.getTeachCategoryGroup(homepage_id);
	}
	
	public List<SmsSend> getTeachCategoryDetail(SmsSend smsSend) {
		return dao.getTeachCategoryDetail(smsSend);
	}
	
	public List<SmsSend> getTeachList(SmsSend smsSend) {
		return dao.getTeachList(smsSend);
	}	
	
	public List<SmsSend> getTeachApplyList(SmsSend smsSend) {
		return dao.getTeachApplyList(smsSend);
	}
	
	public List<SmsSend> getTeacherList(SmsSend smsSend) {
		return dao.getTeacherList(smsSend);
	}
	
	//견학/체험 신청
	public List<SmsSend> getExcursionsList(SmsSend smsSend) {
		return dao.getExcursionsList(smsSend);
	}
	
	public List<SmsSend> getExcursionsApplyList(SmsSend smsSend) {
		return dao.getExcursionsApplyList(smsSend);
	}
	
	//현장지원 신청
	public List<SmsSend> getSupportList(SmsSend smsSend) {
		return dao.getSupportList(smsSend);
	}
	
	public List<SmsSend> getSupportApplyList(SmsSend smsSend) {
		return dao.getSupportApplyList(smsSend);
	}
	
	//시설물 이용신청
	public List<SmsSend> getFacilityList(SmsSend smsSend) {
		return dao.getFacilityList(smsSend);
	}
	
	public List<SmsSend> getFacilityApplyList(SmsSend smsSend) {
		return dao.getFacilityApplyList(smsSend);
	}
	
	//사물함 이용신청
	public List<SmsSend> getLockerPreList(SmsSend smsSend) {
		return dao.getLockerPreList(smsSend);
	}
	
	public List<SmsSend> getLockerApplyList(SmsSend smsSend) {
		return dao.getLockerApplyList(smsSend);
	}
	
	//강사신청
	public List<SmsSend> getTeacherReqApplyList(SmsSend smsSend) {
		return dao.getTeacherReqApplyList(smsSend);
	}
	
	//공통
	public List<SmsSend> getYearList(SmsSend smsSend) {
		return dao.getYearList(smsSend);
	}
	
	public List<SmsSend> getSmsBoxList (SmsSend smsSend) {
		return dao.getSmsBoxList(smsSend);
	}

	public int getSmsBoxCnt (SmsSend smsSend) {
		return dao.getSmsBoxCnt(smsSend);
	}
	
	public List<AddressBook> getExcelRows(AddressBook addressBook) throws Exception {
		return addressBookService.getExcelList(addressBook);
	}
	
}
