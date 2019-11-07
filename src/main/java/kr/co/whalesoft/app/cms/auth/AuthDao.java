package kr.co.whalesoft.app.cms.auth;

import java.util.List;

public interface AuthDao {

	public List<Auth> getAuthGroupTreeList();

	public Auth getAuthGroupOne(Auth auth);
	
	public int addAuthGroup(Auth auth);
	
	public int modifyAuthGroup(Auth auth);
	
	public int deleteAuthGroup(Auth auth);
	
	public int getAuthCount(Auth auth);
	
	public List<Auth> getAuth(String auth_group_id);
	
	public Auth getAuthOne(Auth auth);
	
	public int addAuth(Auth auth);
	
	public int modifyAuth(Auth auth);
	
	public int deleteAuth(Auth auth);
	
	public List<Auth> getMenuAuth(Auth auth);

	public int getNextPrintSeq(Auth auth);
	
}