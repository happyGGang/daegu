package kr.co.whalesoft.app.cms.menu;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuth;

public interface MenuDao {

	public List<Menu> getMenuTreeList(Menu menu);

	public List<Menu> getMenuTreeListCache(String homepage_id);

	public List<Menu> getMenuLeftTreeListCache(@Param ("homepage_id") String homepage_id, @Param ("group_idx") int group_idx);

	public List<Menu> getElibMenuLeftTreeListCache(Menu menu);

	public List<Menu> getMenu();

	public Menu getMenuOne(Menu menu);

	public Menu getMenuOne(int menu_idx);

	public Menu getParentMenuOne(Menu menu);

	public int getUseMenu(Menu menu);

	public int addMenu(Menu menu);

	public int modifyMenu(Menu menu);

	public int modifyParentMenu(Menu menu);

	public int deleteMenu(Menu menu);

	public int getMenuChildCount(Menu menu);

	public List<String> getMemberGroups();

	public List<Menu> getMenuAuth();

	public List<Menu> getMenuNavigator(String menu_url);

	public String[] getMenuAuth(Menu menu);

	public int addMenuAuth(Menu menu);

	public int deleteMenuAuth(Menu menu);

	public int getNextPrintSeq(Menu menu);

	public int deleteMenusByHomepageId(Homepage homepage);

	public int getMenuIdxByLinkUrl(Menu menu);

	public int modifyChildMenu(Menu menu);

	public List<Menu> getSoloMenuList(Menu menu);

	public int getMenuIdxByProgramIdx(Menu menu);

	public List<Menu> getMenuTreeListWithAuth(MemberGroupAuth memberGroupAuth);

	/**
	 * @author whalesoft YONGJU 2020. 2. 18.
	 * @param menu
	 */
	public int modifyMenuFullPathName(Menu menu);
}
