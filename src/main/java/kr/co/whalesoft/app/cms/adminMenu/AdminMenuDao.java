package kr.co.whalesoft.app.cms.adminMenu;

import java.util.List;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuth;

public interface AdminMenuDao {

	public List<AdminMenu> getAdminMenuTreeList();
	
	public List<AdminMenu> getAdminMenuList(AdminMenu adminMenu);
	
	public AdminMenu getAdminMenuOneByIdx(AdminMenu adminMenu);
	
	public AdminMenu getAdminMenuOneByUrl(AdminMenu adminMenu);
	
	public AdminMenu getParentAdminMenuOne(AdminMenu adminMenu);
	
	public int addAdminMenu(AdminMenu adminMenu);
	
	public int modifyAdminMenu(AdminMenu adminMenu);
	
	public int modifyParentAdminMenu(AdminMenu adminMenu);
	
	public int deleteAdminMenu(AdminMenu adminMenu);

	public int addAdminMenuAuth(AdminMenu adminMenu);
	
	public int deleteAdminMenuAuth(AdminMenu adminMenu);
	
	public String[] getAdminMenuAuthByUrl(AdminMenu adminMenu);

	public int getNextPrintSeq(AdminMenu adminMenu);
	
	public List<AdminMenu> getLastChildMenuList(AdminMenu adminMenu);

	public String[] getAdminMenuAuth(AdminMenu adminMenu);

	public List<AdminMenu> getAdminMenuListNew(AdminMenu adminMenu);

	public List<AdminMenu> getAdminMenuTreeListWithAuth(MemberGroupAuth memberGroupAuth);
}