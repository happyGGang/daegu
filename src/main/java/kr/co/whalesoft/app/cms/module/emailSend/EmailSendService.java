package kr.co.whalesoft.app.cms.module.emailSend;

import java.util.List;

import kr.co.whalesoft.app.cms.module.addressBook.AddressBook;
import kr.co.whalesoft.app.cms.module.addressBook.AddressBookService;
import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmailSendService extends BaseService{

	@Autowired
	private EmailSendDao dao;

	@Autowired
	private AddressBookService addressBookService;

	public List<EmailSend> getSmsSendList(EmailSend smsSend) {
		return dao.getSmsSendList(smsSend);
	}

	public EmailSend getSmsSendOne(EmailSend smsSend) {
		return dao.getSmsSendOne(smsSend);
	}

	public int addSmsSend(EmailSend smsSend) {
		return dao.addSmsSend(smsSend);
	}

	public int modifySmsSend(EmailSend smsSend) {
		return dao.modifySmsSend(smsSend);
	}

	//강좌
	public List<EmailSend> getTeachCategoryGroup(String homepage_id) {
		return dao.getTeachCategoryGroup(homepage_id);
	}

	public List<EmailSend> getTeachCategoryDetail(EmailSend smsSend) {
		return dao.getTeachCategoryDetail(smsSend);
	}

	public List<EmailSend> getTeachList(EmailSend smsSend) {
		return dao.getTeachList(smsSend);
	}

	public List<EmailSend> getTeachApplyList(EmailSend smsSend) {
		return dao.getTeachApplyList(smsSend);
	}

	public List<EmailSend> getTeacherList(EmailSend smsSend) {
		return dao.getTeacherList(smsSend);
	}

	//견학/체험 신청
	public List<EmailSend> getExcursionsList(EmailSend smsSend) {
		return dao.getExcursionsList(smsSend);
	}

	public List<EmailSend> getExcursionsApplyList(EmailSend smsSend) {
		return dao.getExcursionsApplyList(smsSend);
	}

	//현장지원 신청
	public List<EmailSend> getSupportList(EmailSend smsSend) {
		return dao.getSupportList(smsSend);
	}

	public List<EmailSend> getSupportApplyList(EmailSend smsSend) {
		return dao.getSupportApplyList(smsSend);
	}

	//시설물 이용신청
	public List<EmailSend> getFacilityList(EmailSend smsSend) {
		return dao.getFacilityList(smsSend);
	}

	public List<EmailSend> getFacilityApplyList(EmailSend smsSend) {
		return dao.getFacilityApplyList(smsSend);
	}

	//사물함 이용신청
	public List<EmailSend> getLockerPreList(EmailSend smsSend) {
		return dao.getLockerPreList(smsSend);
	}

	public List<EmailSend> getLockerApplyList(EmailSend smsSend) {
		return dao.getLockerApplyList(smsSend);
	}

	//강사신청
	public List<EmailSend> getTeacherReqApplyList(EmailSend smsSend) {
		return dao.getTeacherReqApplyList(smsSend);
	}

	//공통
	public List<EmailSend> getYearList(EmailSend smsSend) {
		return dao.getYearList(smsSend);
	}

	public List<EmailSend> getSmsBoxList (EmailSend smsSend) {
		return dao.getSmsBoxList(smsSend);
	}

	public List<AddressBook> getExcelRows(AddressBook addressBook) throws Exception {
		return addressBookService.getExcelList(addressBook);
	}

}
