package kr.go.gbelib.app.cms.module.paymentMember;

import java.util.List;

public interface PaymentMemberDao {

	public int getPaymentMemberCount(PaymentMember paymentMember);
	
	public int getPaymentMemberFamilyCount(PaymentMember paymentMember);

	public List<PaymentMember> getPaymentMemberList(PaymentMember paymentMember);

	public PaymentMember getPaymentMemberOne(PaymentMember paymentMember);

	public int addPaymentMember(PaymentMember paymentMember);

	public List<PaymentMember> getPaymentMemberFamilyList(PaymentMember paymentMember);

	public int deletePaymentMember(PaymentMember paymentMember);

	public int deletePaymentFamilyMember(PaymentMember paymentMember);

	public int getFamilyIdx(PaymentMember paymentMember);

	public int addPaymentFamilyMember(PaymentFamilyMember member);

	public int getPayMemberIdx(PaymentMember paymentMember);

	public int updateFamilyMemberYn(PaymentMember paymentMember);

	public int changeApprovePaymentMember(PaymentMember paymentMember);

	public int modifyPaymentMember(PaymentMember paymentMember);

	public int modifyPaymentFamilyMember(PaymentFamilyMember familyMember);

}
