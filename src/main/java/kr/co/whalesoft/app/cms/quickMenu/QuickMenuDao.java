package kr.co.whalesoft.app.cms.quickMenu;

import java.util.List;

public interface QuickMenuDao  {

	public List<QuickMenu> getQuickMenuList(QuickMenu quickMenu);
	
	public List<QuickMenu> getQuickMenuListAll(QuickMenu quickMenu);
	
	public int getQuickMenuListCount(QuickMenu quickMenu);
	
	public QuickMenu getQuickMenuOne(QuickMenu quickMenu);
	
	public int addQuickMenu(QuickMenu quickMenu);
	
	public int modifyQuickMenu(QuickMenu quickMenu);
	
	public int deleteQuickMenu(QuickMenu quickMenu);
}