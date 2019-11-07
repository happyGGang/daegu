package kr.co.whalesoft.app.cms.accountLock;

import java.util.List;

import kr.co.whalesoft.app.cms.accountLock.AccountLock;

public interface AccountLockDao {

	public List<AccountLock> getAccountLockList(AccountLock accountLock);
	
	public AccountLock getAccountLock(AccountLock accountLock);

	public int getAccountLockCount(AccountLock accountLock);
	
	public int addAccountLock(AccountLock accountLock);

	public int loginFailed(AccountLock accountLock);

	public int loginSucceeded(AccountLock accountLock);
	
	public int lockAccount(AccountLock accountLock);
	
	public int unlockAccount(AccountLock accountLock);
	
	public int isLocked(AccountLock accountLock);
	
	public int deleteAccountLock(AccountLock accountLock);

	public int checkMemberId(AccountLock accountLock);
	
	public int getAttemptCount(AccountLock accountLock);
	
}