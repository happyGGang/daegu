package kr.co.whalesoft.app.cms.adminMenu;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuth;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngt;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngtService;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class AdminMenuService extends BaseService {

	@Autowired
	private AdminMenuDao dao;

	@Autowired
	private ModuleMngtService moduleMngtService;

	public List<AdminMenu> getAdminMenuTreeList() {
		return dao.getAdminMenuTreeList();
	}

	public List<AdminMenu> getAdminMenuList(AdminMenu adminMenu) {
		return dao.getAdminMenuList(adminMenu);
	}

	public List<AdminMenu> getAdminMenuListNew(AdminMenu adminMenu) {
		return dao.getAdminMenuListNew(adminMenu);
	}

	public AdminMenu getAdminMenuOneByIdx(AdminMenu adminMenu) {
		return dao.getAdminMenuOneByIdx(adminMenu);
	}

	public int getPrint_seq(AdminMenu adminMenu) {
		return dao.getNextPrintSeq(adminMenu);
	}

	public AdminMenu getAdminMenuOneByUrl(AdminMenu adminMenu) {
		if (StringUtils.isBlank(adminMenu.getMenu_url())) {
			return null;
		} else {
			String[] access_url = adminMenu.getMenu_url().split("\\/");
			String[] url = new String[access_url.length-1];
			for (int i = 0; i < url.length; i++) {
				url[i] = access_url[i];
			}
			adminMenu.setMenu_url(StringUtils.join(url, "/"));
		}
		return dao.getAdminMenuOneByUrl(adminMenu);
	}

	public AdminMenu getParentAdminMenuOne(AdminMenu adminMenu) {
		return dao.getParentAdminMenuOne(adminMenu);
	}

	@Transactional
	public int addAdminMenu(AdminMenu adminMenu) {
		if (StringUtils.equals(adminMenu.getMenu_type(), "module")) {
			ModuleMngt moduleMngt = new ModuleMngt();
			moduleMngt.setModule_idx(adminMenu.getModule_idx());
			moduleMngt = moduleMngtService.getModuleMngtOne(moduleMngt);
			adminMenu.setLink_url(moduleMngt.getLink_url());
			if (StringUtils.isNotEmpty(moduleMngt.getLink_param())) {
				adminMenu.setLink_url(moduleMngt.getLink_url() + "?" + moduleMngt.getLink_param());
			}
		}
		return dao.addAdminMenu(adminMenu);
	}

	@Transactional
	public int modifyAdminMenu(AdminMenu adminMenu) {
//		dao.deleteAdminMenuAuth(adminMenu);
//		if (adminMenu.getAuth_id_array() != null ) {
//			for (String oneAuthId : adminMenu.getAuth_id_array()) {
//				adminMenu.setAuth_id(oneAuthId);
//				dao.addAdminMenuAuth(adminMenu);
//			}
//		}

		return dao.modifyAdminMenu(adminMenu);
	}

	public int modifyParentAdminMenu(AdminMenu adminMenu) {
		return dao.modifyParentAdminMenu(adminMenu);
	}

	@Transactional
	public int deleteAdminMenu(AdminMenu adminMenu) {
//		dao.deleteAdminMenuAuth(adminMenu);
		return dao.deleteAdminMenu(adminMenu);
	}

	public String[] getAdminMenuAuthByUrl(AdminMenu adminMenu) {
		return dao.getAdminMenuAuthByUrl(adminMenu);
	}

	public String[] getAdminMenuAuth(AdminMenu adminMenu) {
		return dao.getAdminMenuAuth(adminMenu);
	}

	@Transactional
	public int saveAdminMenuAuth(AdminMenu adminMenu) {
		dao.deleteAdminMenuAuth(adminMenu);

		if (adminMenu.getMenu_auth_group_arr() != null && adminMenu.getMenu_auth_group_arr().length > 0) {
			for(String grp_seqno : adminMenu.getMenu_auth_group_arr()) {
				adminMenu.setGrp_seqno(grp_seqno);
				dao.addAdminMenuAuth(adminMenu);
			}
		}
		return 1;
	}

	public List<AdminMenu> getLastChildMenuList(AdminMenu adminMenu) {
		return dao.getLastChildMenuList(adminMenu);
	}

	/**
	 * 메뉴목록. 권한과 같이 가져온다.
	 * @param memberGroupAuth
	 * @return
	 */
	public List<AdminMenu> getAdminMenuTreeListWithAuth(MemberGroupAuth memberGroupAuth) {
		List<AdminMenu> list = dao.getAdminMenuTreeListWithAuth(memberGroupAuth);
		for ( AdminMenu adminMenu : list ) {
			if (adminMenu.getModule_idx() > 0 && StringUtils.equals(adminMenu.getMenu_type(), "module")) {
//				adminMenu.setModuleAuthList(moduleMngtService.getModuleAuthList(new ModuleManage(adminMenu.getModule_idx())));
			}
		}
		return list;
	}

}