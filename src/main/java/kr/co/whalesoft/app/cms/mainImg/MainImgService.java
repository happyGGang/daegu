package kr.co.whalesoft.app.cms.mainImg;

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
public class MainImgService extends BaseService {
	
	@Autowired
	@Qualifier("mainImgStorage")
	private FileStorage mainImgStorage;
	
	@Autowired
	private MainImgDao mainImgDao;
	
	public List<MainImg> getMainImgListAll(MainImg mainImg) {
		return mainImgDao.getMainImgListAll(mainImg);
	}
	 
	public List<MainImg> getMainImgList(MainImg mainImg) {
		return mainImgDao.getMainImgList(mainImg);
	}
	
	public int getMainImgListCount(MainImg mainImg) {
		return mainImgDao.getMainImgListCount(mainImg);
	}
	
	public MainImg getMainImgOne(MainImg mainImg) {
		return mainImgDao.getMainImgOne(mainImg);
	}
	
	public int addMainImg(MainImg mainImg) {
		MultipartFile mFile = mainImg.getImg_file();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + mainImg.getHomepage_id();
			
			File f = mainImgStorage.addFile(mFile, realFileName, filePath);
			
			mainImg.setOrg_file_name(fileName);
			mainImg.setServer_file_name(f.getName());
			mainImg.setFile_extension(fileExtension);
			mainImg.setFile_size(f.length());
		}
		
		return mainImgDao.addMainImg(mainImg);
	}
	
	public int modifyMainImg(MainImg mainImg) {
		MultipartFile mFile = mainImg.getImg_file();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + mainImg.getHomepage_id();
			
			File f = mainImgStorage.addFile(mFile, realFileName, filePath);
			
			mainImg.setOrg_file_name(fileName);
			mainImg.setServer_file_name(f.getName());
			mainImg.setFile_extension(fileExtension);
			mainImg.setFile_size(f.length());
		}
		
		return mainImgDao.modifyMainImg(mainImg);
	}
	
	public int deleteMainImg(MainImg mainImg) {
		return mainImgDao.deleteMainImg(mainImg);
	}
}