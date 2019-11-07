package kr.co.whalesoft.app.cms.banner;

import java.io.File;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class BannerService extends BaseService {

	@Autowired
	private BannerDao dao;
	
	@Autowired
	@Qualifier("bannerStorage")
	private FileStorage bannerStorage;
	
	public List<Banner> getBanner(Banner banner) {
		return dao.getBanner(banner);
	}

	public List<Banner> getBannerAll(Banner banner) {
		return dao.getBannerAll(banner);
	}
	
	public int getBannerCount(Banner banner) {
		return dao.getBannerCount(banner);
	}
	
	public Banner getBannerOne(Banner banner) {
		return dao.getBannerOne(banner);
	}
	
	@Transactional
	public int addBanner(Banner banner, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("img_file_name_temp");
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + banner.getHomepage_id();
			
			File f = bannerStorage.addFile(mFile, realFileName, filePath);
			
			banner.setReal_file_name(realFileName);
			banner.setFile_name(fileName);
			banner.setFile_extension(fileExtension);
			banner.setFile_size(f.length()); 
		} else {
			banner.setFile_name(null);
		}
		
		return dao.addBanner(banner);
	}
	
	public int modifyBanner(Banner banner, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("img_file_name_temp");
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + banner.getHomepage_id();
			
			File f = bannerStorage.addFile(mFile, realFileName, filePath);
			
			banner.setReal_file_name(realFileName);
			banner.setFile_name(fileName);
			banner.setFile_extension(fileExtension);
			banner.setFile_size(f.length()); 
		} else {
			banner.setFile_name(null);
		}
		
		return dao.modifyBanner(banner);
	}
	
	public int deleteBanner(Banner banner) {
		return dao.deleteBanner(banner);
	}
	
	public String addImgFile(String homepage_id, MultipartHttpServletRequest mpRequest) {
		
		MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
		File f = null;
		if ( mFile != null ) {
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String filePath 		= "/" + homepage_id;
			
			f = bannerStorage.addFile(mFile, fileName, filePath);
		}
		return f.getName();
	}
	
}