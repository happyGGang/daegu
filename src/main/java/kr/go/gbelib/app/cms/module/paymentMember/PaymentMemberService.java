package kr.go.gbelib.app.cms.module.paymentMember;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class PaymentMemberService extends BaseService {
	
	@Autowired
	private PaymentMemberDao dao;

	public int getPaymentMemberCount(PaymentMember paymentMember) {
		return dao.getPaymentMemberCount(paymentMember);
	}
	
	public int getPaymentMemberFamilyCount(PaymentMember paymentMember) {
		return dao.getPaymentMemberFamilyCount(paymentMember);
	}

	public List<PaymentMember> getPaymentMemberList(PaymentMember paymentMember) {
		return dao.getPaymentMemberList(paymentMember);
	}
	
	public PaymentMember getPaymentMemberOne(PaymentMember paymentMember) {
		return dao.getPaymentMemberOne(paymentMember);
	}

	@Transactional
	public int addPaymentMember(PaymentMember paymentMember) {
		if(StringUtils.isNotEmpty(paymentMember.getEmail1()) && StringUtils.isNotEmpty(paymentMember.getEmail2())) {
			String email = paymentMember.getEmail1() + "@" + paymentMember.getEmail2();
			paymentMember.setEmail_address(email);
		}

		if(StringUtils.isNotEmpty(paymentMember.getPhone1()) && StringUtils.isNotEmpty(paymentMember.getPhone2()) && StringUtils.isNotEmpty(paymentMember.getPhone3())) {
			String phone = paymentMember.getPhone1() + "-" + paymentMember.getPhone2()+ "-" + paymentMember.getPhone3();
			paymentMember.setPhone(phone);
		}
		
		if(StringUtils.isNotEmpty(paymentMember.getTel1()) && StringUtils.isNotEmpty(paymentMember.getTel2()) && StringUtils.isNotEmpty(paymentMember.getTel3())) {
			String tel = paymentMember.getTel1() + "-" + paymentMember.getTel2()+ "-" + paymentMember.getTel3();
			paymentMember.setTel(tel);
		}
		
		int count = paymentMember.getFamily_count();
		
		paymentMember.setPay_member_idx(dao.getPayMemberIdx(paymentMember)); 
		
		if(count > 0){
			paymentMember.setPay_family_member_idx(paymentMember.getPay_member_idx());
			
			List<PaymentFamilyMember> list = paymentMember.getPaymentFamilyMemberList();
			for(int i = 0; i < count; i++) {
				PaymentFamilyMember familyMember = list.get(i);
				
				if(StringUtils.isNotEmpty(familyMember.getFamily_phone1()) && StringUtils.isNotEmpty(familyMember.getFamily_phone2()) && StringUtils.isNotEmpty(familyMember.getFamily_phone3())) {
					String phone = familyMember.getFamily_phone1() + "-" + familyMember.getFamily_phone2()+ "-" + familyMember.getFamily_phone3();
					familyMember.setFamily_phone(phone);
				}
				
				familyMember.setPay_family_member_idx(paymentMember.getPay_family_member_idx());
				familyMember.setFamily_idx(dao.getFamilyIdx(paymentMember));
				familyMember.setHomepage_id(paymentMember.getHomepage_id());
				
				dao.addPaymentFamilyMember(familyMember);
				paymentMember.setFamily_yn("Y");
				dao.updateFamilyMemberYn(paymentMember);
			}
		}
		
		return dao.addPaymentMember(paymentMember);
	}

	@Transactional
	public int modifyPaymentMember(PaymentMember paymentMember) {
		if(StringUtils.isNotEmpty(paymentMember.getEmail1()) && StringUtils.isNotEmpty(paymentMember.getEmail2())) {
			String email = paymentMember.getEmail1() + "@" + paymentMember.getEmail2();
			paymentMember.setEmail_address(email);
		}

		if(StringUtils.isNotEmpty(paymentMember.getPhone1()) && StringUtils.isNotEmpty(paymentMember.getPhone2()) && StringUtils.isNotEmpty(paymentMember.getPhone3())) {
			String phone = paymentMember.getPhone1() + "-" + paymentMember.getPhone2()+ "-" + paymentMember.getPhone3();
			paymentMember.setPhone(phone);
		}
		
		if(StringUtils.isNotEmpty(paymentMember.getTel1()) && StringUtils.isNotEmpty(paymentMember.getTel2()) && StringUtils.isNotEmpty(paymentMember.getTel3())) {
			String tel = paymentMember.getTel1() + "-" + paymentMember.getTel2()+ "-" + paymentMember.getTel3();
			paymentMember.setTel(tel);
		}
		
		int count = paymentMember.getFamily_count();
		
		if(count > 0){
			paymentMember.setPay_family_member_idx(paymentMember.getPay_member_idx());
			
			List<PaymentFamilyMember> list = paymentMember.getPaymentFamilyMemberList();
			for(int i = 0; i < count; i++) {
				PaymentFamilyMember familyMember = list.get(i);
				
				if(StringUtils.isNotEmpty(familyMember.getFamily_phone1()) && StringUtils.isNotEmpty(familyMember.getFamily_phone2()) && StringUtils.isNotEmpty(familyMember.getFamily_phone3())) {
					String phone = familyMember.getFamily_phone1() + "-" + familyMember.getFamily_phone2()+ "-" + familyMember.getFamily_phone3();
					familyMember.setFamily_phone(phone);
				}
				
				familyMember.setPay_family_member_idx(paymentMember.getPay_family_member_idx());
				familyMember.setFamily_idx(paymentMember.getFamily_idx());
				familyMember.setHomepage_id(paymentMember.getHomepage_id());
				
				dao.modifyPaymentFamilyMember(familyMember);
			}
		}
		
		return dao.modifyPaymentMember(paymentMember);
	}

	@Transactional
	public int deletePaymentMember(PaymentMember paymentMember) {
		int count = getPaymentMemberFamilyCount(paymentMember);
		
		if(count > 0) {
			paymentMember.setPay_family_member_idx(paymentMember.getPay_member_idx());
			List<PaymentMember> familyList = getPaymentMemberFamilyList(paymentMember);
			
			for(PaymentMember familyMember : familyList) {
				familyMember.setDelete_id(paymentMember.getDelete_id());
				familyMember.setDelete_ip(paymentMember.getDelete_ip());
				familyMember.setPay_member_idx(paymentMember.getPay_member_idx());
				dao.deletePaymentFamilyMember(familyMember);
			}
		}
		
		return dao.deletePaymentMember(paymentMember);
	}

	public List<PaymentMember> getPaymentMemberFamilyList(PaymentMember paymentMember) {
		return dao.getPaymentMemberFamilyList(paymentMember);
	}

	public int changeApprovePaymentMember(PaymentMember paymentMember) {
		return dao.changeApprovePaymentMember(paymentMember);
	}

}
