package kr.co.whalesoft.app.cms.popup;

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
public class PopupService extends BaseService {

	@Autowired
	private PopupDao dao;
	
	@Autowired
	@Qualifier("popupStorage")
	private FileStorage popupStorage;
	
	public List<Popup> getPopup(Popup popup) {
		return dao.getPopup(popup);
	}

	public List<Popup> getPopupAll(Popup popup) {
		return dao.getPopupAll(popup);
	}
	
	public int getPopupCount(Popup popup) {
		return dao.getPopupCount(popup);
	}
	
	public Popup getPopupOne(Popup popup) {
		return dao.getPopupOne(popup);
	}
	
	@Transactional
	public int addPopup(Popup popup, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
		if(mFile != null && popup.getHtml_use_yn().equals("N")) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + popup.getHomepage_id();
			
			File f = popupStorage.addFile(mFile, realFileName, filePath);
			
			popup.setOrg_file_name(fileName);
			popup.setServer_file_name(realFileName);
			popup.setFile_extension(fileExtension);
			popup.setFile_size(f.length());
		} 
		
		if(popup.getHtml() != null && popup.getHtml().equals("<br>")) {
			popup.setHtml("");
		}
		
		return dao.addPopup(popup);
	}
	
	public int modifyPopup(Popup popup, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
		if(mFile != null && popup.getHtml_use_yn().equals("N")) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + popup.getHomepage_id();
			
			File f = popupStorage.addFile(mFile, realFileName, filePath);
			
			popup.setOrg_file_name(fileName);
			popup.setServer_file_name(realFileName);
			popup.setFile_extension(fileExtension);
			popup.setFile_size(f.length());
		}
		
		if(popup.getHtml() != null && popup.getHtml().equals("<br>")) {
			popup.setHtml("");
		}
		
		return dao.modifyPopup(popup);
	}
	
	public int deletePopup(Popup popup) {
		return dao.deletePopup(popup);
	}
	
	public String addImgFile(String homepage_id, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
		File f 			= null;
		String filePath = "/" + homepage_id;

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			f = popupStorage.addFile(mFile, realFileName, filePath);
		}
		
		return popupStorage.getContextPath() + filePath + "/" + f.getName();
	}
}