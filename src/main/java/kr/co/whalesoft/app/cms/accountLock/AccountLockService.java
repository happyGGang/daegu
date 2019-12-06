package kr.co.whalesoft.app.cms.accountLock;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class AccountLockService extends BaseService {

	@Autowired
	private AccountLockDao dao;

	public int getAccountLockCount(AccountLock accountLock) {
		return dao.getAccountLockCount(accountLock);
	}

	public List<AccountLock> getAccountLockList(AccountLock accountLock) {
		return dao.getAccountLockList(accountLock);
	}

	public AccountLock getAccountLock(AccountLock accountLock) {
		return dao.getAccountLock(accountLock);
	}

	public int addAccountLock(AccountLock accountLock) {
		return dao.addAccountLock(accountLock);
	}

	public int loginFailed(AccountLock accountLock) {
		if(StringUtils.isEmpty(accountLock.getMember_id())) return 0;
		return dao.loginFailed(accountLock);
	}

	public int loginSucceeded(AccountLock accountLock) {
		if(StringUtils.isEmpty(accountLock.getMember_id())) return 0;

		return dao.loginSucceeded(accountLock);
	}

	public int lockAccount(AccountLock accountLock) {
		return dao.lockAccount(accountLock);
	}

	public int unlockAccount(AccountLock accountLock) {
		return dao.unlockAccount(accountLock);
	}

	public String isLocked(AccountLock accountLock) {
		if(StringUtils.isEmpty(accountLock.getMember_id())) return "N";

		return dao.isLocked(accountLock) > 0 ? "Y": "N";
	}

	public int deleteAccountLock(AccountLock accountLock) {
		return dao.deleteAccountLock(accountLock);
	}

	public int checkMemberId(AccountLock accountLock) {
		return dao.checkMemberId(accountLock);
	}

	public int getAttemptCount(AccountLock accountLock) {
		return dao.getAttemptCount(accountLock);
	}

}
