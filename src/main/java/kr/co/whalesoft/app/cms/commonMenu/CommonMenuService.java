package kr.co.whalesoft.app.cms.commonMenu;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.googlecode.ehcache.annotations.Cacheable;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class CommonMenuService extends BaseService {

	@Autowired
	private CommonMenuDao dao;
	
	@Autowired
	@Qualifier("menuStorage")
	private FileStorage menuStorage;
	
	public List<CommonMenu> getMenuTreeList() {
		return dao.getMenuTreeList();
	}
	
	/**
	 * 전체 메뉴 treeList (캐쉬 사용함)
	 * @return
	 */
	@Cacheable(cacheName="getMenuTreeListCache")
	public List<CommonMenu> getMenuTreeListCache(String homepage_id) {
		return dao.getMenuTreeListCache(homepage_id);
	}
	
	/**
	 * 왼쪽 메뉴 treeList (캐쉬 사용함)
	 * @param menu_idx
	 * @return
	 */
	@Cacheable(cacheName="getMenuLeftTreeListCache")
	public List<CommonMenu> getMenuLeftTreeListCache(String homepage_id, int group_idx) {
		CommonMenu menu = new CommonMenu();
		menu.setHomepage_id(homepage_id);
		menu.setGroup_idx(group_idx);
		return dao.getMenuLeftTreeListCache(menu);
	}
	
	public List<CommonMenu> getMenu() {
		return dao.getMenu();
	}
	
	public CommonMenu getMenuOne(CommonMenu menu) {
		return dao.getMenuOne(menu);
	}
	
	public int getNextPrintSeq(CommonMenu menu) {
		return dao.getNextPrintSeq(menu);
	}
	
	public CommonMenu getParentMenuOne(CommonMenu menu) {
		return dao.getParentMenuOne(menu);
	}
	
	public int getUseMenu(CommonMenu menu) {
		return dao.getUseMenu(menu);
	}
	
	@Transactional
	public int addMenu(MultipartFile mFile, MultipartFile mFileTopIcon, MultipartFile mFileLeftIcon, CommonMenu menu) {
		int returnCount = 0;
		
		if(mFile != null) {
			String fileName = mFile.getOriginalFilename();
			String filePath = "/";
			File f = menuStorage.addFile(mFile, fileName, filePath);
			menu.setMenu_img(f.getName());
		} else {
			menu.setMenu_img(null);
		}
		if (mFileTopIcon != null ){
			String fileName = mFileTopIcon.getOriginalFilename();
			String filePath = "/";
			File f = menuStorage.addFile(mFileTopIcon, fileName, filePath);
			menu.setMenu_top_icon(f.getName());
		} else {
			menu.setMenu_top_icon(null);
		}
		if (mFileLeftIcon != null ){
			String fileName = mFileLeftIcon.getOriginalFilename();
			String filePath = "/";
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
	public int modifyMenu(MultipartFile mFile, MultipartFile mFileTopIcon, MultipartFile mFileLeftIcon, CommonMenu menu) {
		int returnCount = 0;
		
		if(mFile != null) {
			String fileName = mFile.getOriginalFilename();
			String filePath = "/";
			File f = menuStorage.addFile(mFile, fileName, filePath);
			menu.setMenu_img(f.getName());
		} else {
			menu.setMenu_img(null);
		}
		if (mFileTopIcon != null ){
			String fileName = mFileTopIcon.getOriginalFilename();
			String filePath = "/";
			File f = menuStorage.addFile(mFileTopIcon, fileName, filePath);
			menu.setMenu_top_icon(f.getName());
		} else {
			menu.setMenu_top_icon(null);
		}
		if (mFileLeftIcon != null ){
			String fileName = mFileLeftIcon.getOriginalFilename();
			String filePath = "/";
			File f = menuStorage.addFile(mFileLeftIcon, fileName, filePath);
			menu.setMenu_left_icon(f.getName());
		} else {
			menu.setMenu_left_icon(null);
		}
		
		returnCount = dao.modifyMenu(menu);
		
		if(returnCount > 0) {
			/** 메뉴권한 처리 **/
			dao.deleteMenuAuth(menu);
			if(menu.getAuth_id_array() != null && menu.getAuth_id_array().length > 0) {
				for(String auth_id : menu.getAuth_id_array()) {
					menu.setAuth_id(auth_id);
					dao.addMenuAuth(menu);
				}
			}
		}
		
		return returnCount;
	}
	
	public int modifyParentMenu(CommonMenu menu) {
		return dao.modifyParentMenu(menu);
	}
	
	public int deleteMenu(CommonMenu menu) {
		return dao.deleteMenu(menu);
	}
	
	public int getMenuChildCount(CommonMenu menu) {
		return dao.getMenuChildCount(menu);
	}

	public List<CommonMenu> getMenuNavigator(String menu_url) {
		return dao.getMenuNavigator(menu_url);
	}

	public String[] getMenuAuth(CommonMenu menu) {
		return dao.getMenuAuth(menu);
	}
	
}