package kr.co.whalesoft.app.cms.menu.menuAccess;

import java.util.List;

public interface MenuAccessDao {

	public void updateMenuAccess(MenuAccess menuAccess);
	
	public List<MenuAccess> getMenuAccessCount(MenuAccess menuAccess);
	
}