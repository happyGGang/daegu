package kr.co.whalesoft.app.cms.menu.menuHtml;

import java.util.List;

public interface MenuHtmlDao {

	public List<MenuHtml> getMenuHtml(MenuHtml menuHtml);
	
	public String getMenuHtmlStrOne(MenuHtml menuHtml);
	
	public MenuHtml getLastMenuHtmlOne(MenuHtml menuHtml);
	
	public int addMenuHtml(MenuHtml menuHtml);

	public MenuHtml getMenuTempHtml(MenuHtml menuHtml);

	public int setMenuTempHtml(MenuHtml menuHtml);

	public int addMenuTempFile(MenuTempFile menuTempFile);

	public int deleteMenuTempFile(MenuTempFile menuTempFile);

	public List<MenuTempFile> getTempFileList(MenuTempFile menuTempFile);

	public MenuTempFile getMenuTempFile(MenuTempFile menuTempFile);

}