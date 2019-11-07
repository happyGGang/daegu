package kr.co.whalesoft.app.cms.quickMenu;

import java.io.File;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class QuickMenuService extends BaseService {
	
	@Autowired
	@Qualifier("quickMenuStorage")
	private FileStorage quickMenuStorage;
	
	@Autowired
	private QuickMenuDao quickMenuDao;
	
	public List<QuickMenu> getQuickMenuListAll(QuickMenu quickMenu) {
		return quickMenuDao.getQuickMenuListAll(quickMenu);
	}
	 
	public List<QuickMenu> getQuickMenuList(QuickMenu quickMenu) {
		return quickMenuDao.getQuickMenuList(quickMenu);
	}
	
	public int getQuickMenuListCount(QuickMenu quickMenu) {
		return quickMenuDao.getQuickMenuListCount(quickMenu);
	}
	
	public QuickMenu getQuickMenuOne(QuickMenu quickMenu) {
		return quickMenuDao.getQuickMenuOne(quickMenu);
	}
	
	public int addQuickMenu(QuickMenu quickMenu) {
		MultipartFile mFile = quickMenu.getIcon_file();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + quickMenu.getHomepage_id();
			
			File f = quickMenuStorage.addFile(mFile, realFileName, filePath);
			quickMenu.setIcon_file_name(fileName);
			quickMenu.setReal_file_name(realFileName);
			quickMenu.setFile_extension(fileExtension);
			quickMenu.setFile_size(f.length());
		}
		
		return quickMenuDao.addQuickMenu(quickMenu);
	}
	
	public int modifyQuickMenu(QuickMenu quickMenu) {
		MultipartFile mFile = quickMenu.getIcon_file();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + quickMenu.getHomepage_id();
			
			File f = quickMenuStorage.addFile(mFile, realFileName, filePath);
			quickMenu.setIcon_file_name(fileName);
			quickMenu.setReal_file_name(realFileName);
			quickMenu.setFile_extension(fileExtension);
			quickMenu.setFile_size(f.length());
		}
		
		return quickMenuDao.modifyQuickMenu(quickMenu);
	}
	
	public int deleteQuickMenu(QuickMenu quickMenu) {
		return quickMenuDao.deleteQuickMenu(quickMenu);
	}
}