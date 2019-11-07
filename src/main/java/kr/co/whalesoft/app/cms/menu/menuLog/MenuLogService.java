package kr.co.whalesoft.app.cms.menu.menuLog;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtml;
import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MenuLogService extends BaseService {

	@Autowired
	private MenuLogDao dao;
	
	@Autowired
	private LoginService loginService;
	
	public int addMenuLog(Menu menu, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		
		MenuLog menuLog = new MenuLog();
		menuLog.setWork_type(menu.getEditMode());
		menuLog.setMember_id(member.getMember_id());
		menuLog.setWork_ip(request.getRemoteAddr());
		menuLog.setHomepage_id(menu.getHomepage_id());
		menuLog.setGroup_idx(menu.getGroup_idx());
		menuLog.setMenu_idx(menu.getMenu_idx());
		
		menuLog.setMenu_url(menu.getMenu_url());
		menuLog.setMenu_name(menu.getMenu_name());
		menuLog.setMenu_type(menu.getMenu_type());
		menuLog.setLink_url(menu.getLink_url());
		
		if ( menu.getEditMode().equals("parentMenuModify") ) {
			menuLog.setParent_menu_idx(menu.getMove_target_menu_idx());	
		}
		else {
			menuLog.setParent_menu_idx(menu.getParent_menu_idx());
		}
		return addMenuLog(menuLog);
	}
	
	public int addMenuLog(MenuHtml menuHtml, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		
		MenuLog menuLog = new MenuLog();
		menuLog.setWork_type("HTML");
		menuLog.setWork_ip(request.getRemoteAddr());
		menuLog.setMember_id(member.getMember_id());
		menuLog.setHomepage_id(menuHtml.getHomepage_id());
		menuLog.setMenu_idx(menuHtml.getMenu_idx());
		menuLog.setHtml(menuHtml.getHtml());

		return addMenuLog(menuLog);
	}
	
	public int addMenuLog(MenuLog menuLog) {
		return dao.addMenuLog(menuLog);
	}
}