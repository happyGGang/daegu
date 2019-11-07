package kr.co.whalesoft.app.cms.authCode;

import java.util.List;

public interface AuthCodeDao {

	public List<AuthCode> getAuthGroupTreeList();

	public AuthCode getAuthGroupOne(AuthCode auth);
	
	public int addAuthGroup(AuthCode auth);
	
	public int modifyAuthGroup(AuthCode auth);
	
	public int deleteAuthGroup(AuthCode auth);
	
	public int getAuthCount(AuthCode auth);
	
	public List<AuthCode> getAuthCode(String auth_group_id);
	
	public AuthCode getAuthOne(AuthCode auth);
	
	public int addAuth(AuthCode auth);
	
	public int modifyAuth(AuthCode auth);
	
	public int deleteAuth(AuthCode auth);
	
	public List<AuthCode> getMenuAuth(AuthCode auth);

	public int getNextPrintSeq(AuthCode auth);

	public List<AuthCode> getAuthGroupList();
	
}