package kr.co.whalesoft.app.cms.menu;

import java.io.File;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.googlecode.ehcache.annotations.Cacheable;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuth;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class MenuService extends BaseService {

	@Autowired
	private MenuDao dao;

	@Autowired
	@Qualifier("menuStorage")
	private FileStorage menuStorage;

	public List<Menu> getMenuTreeList(Menu menu) {
		return dao.getMenuTreeList(menu);
	}

	/**
	 * 전체 메뉴 treeList (캐쉬 사용함)
	 * @return
	 */
	@Cacheable(cacheName="getMenuTreeListCache")
	public List<Menu> getMenuTreeListCache(String homepage_id) {
		return dao.getMenuTreeListCache(homepage_id);
	}

	/**
	 * 왼쪽 메뉴 treeList (캐쉬 사용함)
	 * @param menu_idx
	 * @return
	 */
	@Cacheable(cacheName="getMenuLeftTreeListCache")
	public List<Menu> getMenuLeftTreeListCache(String homepage_id, int group_idx) {
		return dao.getMenuLeftTreeListCache(homepage_id, group_idx);
	}
	
	/**
	 * 왼쪽 메뉴 treeList (캐쉬 사용함)
	 * @param menu_idx
	 * @return
	 */
	@Cacheable(cacheName="getMenuLeftTreeListCache")
	public List<Menu> getMenuLeftTreeMobileListCache(String homepage_id, int group_idx) {
		return dao.getMenuLeftTreeMobileListCache(homepage_id, group_idx);
	}

	/**
	 * 전자도서관 왼쪽 메뉴 treeList (캐쉬 사용함)
	 * @param menu_idx
	 * @return
	 */
	@Cacheable(cacheName="getElibMenuLeftTreeListCache")
	public List<Menu> getElibMenuLeftTreeListCache(String homepage_id, int group_idx) {
		Menu menu = new Menu();
		menu.setHomepage_id(homepage_id);
		menu.setGroup_idx(group_idx);
		return dao.getElibMenuLeftTreeListCache(menu);
	}

	public List<Menu> getMenu() {
		return dao.getMenu();
	}

	public Menu getMenuOne(Menu menu) {
		return dao.getMenuOne(menu);
	}

	public int getNextPrintSeq(Menu menu) {
		return dao.getNextPrintSeq(menu);
	}

	public Menu getParentMenuOne(Menu menu) {
		return dao.getParentMenuOne(menu);
	}

	public int getUseMenu(Menu menu) {
		return dao.getUseMenu(menu);
	}

	@Transactional
	@WorkingLogger(comment="홈페이지 메뉴관리 1건 추가")
	public int addMenu(MultipartFile mFile, MultipartFile mFileTopIcon, MultipartFile mFileLeftIcon, Menu menu) {
		int returnCount = 0;

		if(mFile != null) {
			String fileName = Long.toString((System.currentTimeMillis()));
			String filePath = "/" + menu.getHomepage_id();
			File f = menuStorage.addFile(mFile, fileName, filePath);
			menu.setMenu_img(f.getName());
		} else {
			menu.setMenu_img(null);
		}
		if (mFileTopIcon != null ){
			String fileName = Long.toString((System.currentTimeMillis()));
			String filePath = "/" + menu.getHomepage_id();
			File f = menuStorage.addFile(mFileTopIcon, fileName, filePath);
			menu.setMenu_top_icon(f.getName());
		} else {
			menu.setMenu_top_icon(null);
		}
		if (mFileLeftIcon != null ){
			String fileName = Long.toString((System.currentTimeMillis()));
			String filePath = "/" + menu.getHomepage_id();
			File f = menuStorage.addFile(mFileLeftIcon, fileName, filePath);
			menu.setMenu_left_icon(f.getName());
		} else {
			menu.setMenu_left_icon(null);
		}

		returnCount = dao.addMenu(menu);

		if(returnCount > 0) {
			if(menu.getAuth_id_array() != null && menu.getAuth_id_array().length > 0) {
				for(String auth_id : menu.getAuth_id_array()) {
					menu.setAuth_id(auth_id);
					dao.addMenuAuth(menu);
				}
			}
		}

		return returnCount;
	}

	@Transactional
	@WorkingLogger(comment="홈페이지 메뉴관리 1건 수정")
	public int modifyMenu(MultipartFile mFile, MultipartFile mFileTopIcon, MultipartFile mFileLeftIcon, Menu menu) {
		int returnCount = 0;

		if(mFile != null) {
			String fileName = Long.toString((System.currentTimeMillis()));
			String filePath = "/" + menu.getHomepage_id();
			File f = menuStorage.addFile(mFile, fileName, filePath);
			menu.setMenu_img(f.getName());
		} else {
			menu.setMenu_img(null);
		}
		if (mFileTopIcon != null ){
			String fileName = Long.toString((System.currentTimeMillis()));
			String filePath = "/" + menu.getHomepage_id();
			File f = menuStorage.addFile(mFileTopIcon, fileName, filePath);
			menu.setMenu_top_icon(f.getName());
		} else {
			menu.setMenu_top_icon(null);
		}
		if (mFileLeftIcon != null ){
			String fileName = Long.toString((System.currentTimeMillis()));
			String filePath = "/" + menu.getHomepage_id();
			File f = menuStorage.addFile(mFileLeftIcon, fileName, filePath);
			menu.setMenu_left_icon(f.getName());
		} else {
			menu.setMenu_left_icon(null);
		}

		returnCount = dao.modifyMenu(menu);

//		if(returnCount > 0) {
//			/** 메뉴권한 처리 **/
//			dao.deleteMenuAuth(menu);
//			if(menu.getAuth_id_array() != null && menu.getAuth_id_array().length > 0) {
//				for(String auth_id : menu.getAuth_id_array()) {
//					menu.setAuth_id(auth_id);
//					dao.addMenuAuth(menu);
//				}
//			}
//		}

		return returnCount;
	}

	public int modifyParentMenu(Menu menu) {
		return dao.modifyParentMenu(menu);
	}
	
	@WorkingLogger(comment="홈페이지 메뉴관리 1건 삭제")
	public int deleteMenu(Menu menu) {
		return dao.deleteMenu(menu);
	}

	public int getMenuChildCount(Menu menu) {
		return dao.getMenuChildCount(menu);
	}

	public List<Menu> getMenuNavigator(String menu_url) {
		return dao.getMenuNavigator(menu_url);
	}

	public String[] getMenuAuth(Menu menu) {
		return dao.getMenuAuth(menu);
	}

	public int getMenuIdxByLinkUrl(Menu menu){
		return dao.getMenuIdxByLinkUrl(menu);
	}

	public int modifyChildMenu(Menu menu) {
		dao.modifyChildMenu(menu);
		dao.modifyMenuFullPathName(menu);
		return 1;
	}

	public List<Menu> getSoloMenuList(Menu menu) {
		return dao.getSoloMenuList(menu);
	}

	/**
	 * 모듈IDX로 menu_idx 가져온다.
	 * @param menu(homepage_id, program_idx)
	 * @return
	 */
	public int getMenuIdxByProgramIdx(Menu menu) {
		return dao.getMenuIdxByProgramIdx(menu);
	}

	public List<Menu> getMenuTreeListWithAuth(MemberGroupAuth memberGroupAuth) {
		List<Menu> list = dao.getMenuTreeListWithAuth(memberGroupAuth);
		return list;
	}

}