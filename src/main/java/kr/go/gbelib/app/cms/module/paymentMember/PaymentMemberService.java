package kr.go.gbelib.app.cms.module.paymentMember;

import java.util.List;

import java.util.Map;
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
		
		paymentMember.setPay_member_idx(dao.getPayMemberIdx(paymentMember)); 

		List<Map<String, Object>> familyList = paymentMember.getFamilyList();

		if (familyList.size() > 0) {
			paymentMember.setPay_family_member_idx(paymentMember.getPay_member_idx());

			for(int i = 0; i < familyList.size(); i++) {
				Map<String,Object> familyMemberMap = familyList.get(i);
				PaymentFamilyMember familyMember = new PaymentFamilyMember();

				familyMember.setFamily_name((String) familyMemberMap.get("family_name"));
				familyMember.setFamily_sex((String) familyMemberMap.get("family_sex"));
				familyMember.setFamily_phone((String) familyMemberMap.get("family_phone"));
				familyMember.setFamily_birth((String) familyMemberMap.get("family_birth"));
				familyMember.setFamily_etc((String) familyMemberMap.get("family_etc"));
				familyMember.setPay_family_member_idx(paymentMember.getPay_family_member_idx());
				familyMember.setFamily_idx(dao.getFamilyIdx(paymentMember));
				familyMember.setHomepage_id(paymentMember.getHomepage_id());

				dao.addPaymentFamilyMember(familyMember);
				paymentMember.setFamily_yn("Y");
				dao.updateFamilyMemberYn(paymentMember);
			}
		}

		paymentMember.setFamily_count(familyList.size());

		return dao.addPaymentMember(paymentMember);
	}

	@Transactional
	public int modifyPaymentMember(PaymentMember paymentMember) {
		if(StringUtils.isNotEmpty(paymentMember.getEmail1()) && StringUtils.isNotEmpty(paymentMember.getEmail2())) {
			String email = paymentMember.getEmail1() + "@" + paymentMember.getEmail2();
			paymentMember.setEmail_address(email);
		}

		List<Map<String, Object>> familyList = paymentMember.getFamilyList();

		if (familyList.size() > 0) {
			paymentMember.setPay_family_member_idx(paymentMember.getPay_member_idx());

			dao.deletePaymentFamilyMember(paymentMember);

			for(int i = 0; i < familyList.size(); i++) {
				Map<String,Object> familyMemberMap = familyList.get(i);
				PaymentFamilyMember familyMember = new PaymentFamilyMember();

				familyMember.setFamily_name((String) familyMemberMap.get("family_name"));
				familyMember.setFamily_sex((String) familyMemberMap.get("family_sex"));
				familyMember.setFamily_phone((String) familyMemberMap.get("family_phone"));
				familyMember.setFamily_birth((String) familyMemberMap.get("family_birth"));
				familyMember.setFamily_etc((String) familyMemberMap.get("family_etc"));
				familyMember.setPay_family_member_idx(paymentMember.getPay_family_member_idx());
				familyMember.setFamily_idx(dao.getFamilyIdx(paymentMember));
				familyMember.setHomepage_id(paymentMember.getHomepage_id());

				dao.addPaymentFamilyMember(familyMember);
				paymentMember.setFamily_yn("Y");
				dao.updateFamilyMemberYn(paymentMember);
			}
		}

		paymentMember.setFamily_count(familyList.size());
		
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
