package kr.co.whalesoft.app.cms.menu.menuHtml;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class MenuHtmlService extends BaseService {
	
	@Autowired
	private MenuHtmlDao dao;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	@Qualifier("menuTempFileStorage")
	private FileStorage menuTempFileStorage;

	public List<MenuHtml> getMenuHtml(MenuHtml menuHtml) {
		return dao.getMenuHtml(menuHtml);
	}
	
	public String getMenuHtmlStrOne(MenuHtml menuHtml) {
		return dao.getMenuHtmlStrOne(menuHtml);
	}
	
	public MenuHtml getLastMenuHtmlOne(MenuHtml menuHtml) {
		return dao.getLastMenuHtmlOne(menuHtml);
	}
	
	public int addMenuHtml(MenuHtml menuHtml, HttpServletRequest request) {
		Member member = (Member)loginService.getSessionMember(request);
		menuHtml.setAdd_id(member.getMember_id());
		menuHtml.setAdd_ip(request.getRemoteAddr());
		return dao.addMenuHtml(menuHtml);
	}
	
	public MenuHtml getMenuTempHtml(MenuHtml menuHtml) {
		return dao.getMenuTempHtml(menuHtml);
	}
	
	@Transactional
	public int setMenuTempHtml(MenuHtml menuHtml) {
		return dao.setMenuTempHtml(menuHtml);
	}
	
	public List<MenuTempFile> getTempFileList(MenuTempFile menuTempFile) {
		return dao.getTempFileList(menuTempFile);
	}
	
	@Transactional
	public int addMenuTempFile(MenuTempFile menuTempFile, MultipartFile mfile) {
		String org_file_name = mfile.getOriginalFilename();
		String extension = "";
		int pos = org_file_name.lastIndexOf(".");
		if( pos > -1 ) {
			extension = org_file_name.substring(pos);		// .을 포함한 확장자
		}
		String filename = Long.toString((System.currentTimeMillis()));
		String dirpath = "/" + menuTempFile.getHomepage_id() + "/" + menuTempFile.getMenu_idx();
		File f = menuTempFileStorage.addFile(mfile, filename + extension, dirpath);
		String path = dirpath + "/" + f.getName();
		menuTempFile.setPath(path);
		menuTempFile.setOrg_file_name(mfile.getOriginalFilename());
		
		return dao.addMenuTempFile(menuTempFile);
	}
	
	@Transactional
	public int deleteMenuTempFile(MenuTempFile menuTempFile) {
		menuTempFile = dao.getMenuTempFile(menuTempFile);
		
		if(menuTempFile != null) {
			String path = menuTempFile.getPath();
			int i = path.lastIndexOf("/");
			String dirpath = path.substring(0, i);
			String filename = path.substring(i+1, path.length());
			
			menuTempFileStorage.deleteFile(filename, dirpath);
		}
		
		return dao.deleteMenuTempFile(menuTempFile);
	}
	
	public String getMenuTempFileStoragePath() {
		return menuTempFileStorage.getContextPath();
	}

}