package kr.co.whalesoft.app.cms.commonMenu;

import java.util.List;

public interface CommonMenuDao {
	
	public List<CommonMenu> getMenuTreeList();
	
	public List<CommonMenu> getMenuTreeListCache(String homepage_id);
	
	public List<CommonMenu> getMenuLeftTreeListCache(CommonMenu menu);

	public List<CommonMenu> getMenu();
	
	public CommonMenu getMenuOne(CommonMenu menu);
	
	public CommonMenu getMenuOne(int menu_idx);
	
	public CommonMenu getParentMenuOne(CommonMenu menu);
	
	public int getUseMenu(CommonMenu menu);
	
	public int addMenu(CommonMenu menu);
	
	public int modifyMenu(CommonMenu menu);
	
	public int modifyParentMenu(CommonMenu menu);
	
	public int deleteMenu(CommonMenu menu);
	
	public int getMenuChildCount(CommonMenu menu);
	
	public List<String> getMemberGroups();
	
	public List<CommonMenu> getMenuAuth();

	public List<CommonMenu> getMenuNavigator(String menu_url);
	
	public String[] getMenuAuth(CommonMenu menu);
	
	public int addMenuAuth(CommonMenu menu);
	
	public int deleteMenuAuth(CommonMenu menu);

	public int getNextPrintSeq(CommonMenu menu);
 
}