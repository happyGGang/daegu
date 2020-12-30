package kr.co.whalesoft.app.cms.popupZoneTop;

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
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class PopupZoneTopService extends BaseService {

	@Autowired
	private PopupZoneTopDao dao;

	@Autowired
	@Qualifier("popupZoneTopStorage")
	private FileStorage popupZoneTopStorage;

	public List<PopupZoneTop> getPopupZoneTop(PopupZoneTop popupZoneTop) {
		return dao.getPopupZoneTop(popupZoneTop);
	}

	public List<PopupZoneTop> getPopupZoneTopAll(PopupZoneTop popupZoneTop) {
		return dao.getPopupZoneTopAll(popupZoneTop);
	}

	public int getPopupZoneTopCount(PopupZoneTop popupZoneTop) {
		return dao.getPopupZoneTopCount(popupZoneTop);
	}

	public PopupZoneTop getPopupZoneTopOne(PopupZoneTop popupZoneTop) {
		return dao.getPopupZoneTopOne(popupZoneTop);
	}

	@Transactional
	@WorkingLogger(comment="팝업존 관리 1건 추가")
	public int addPopupZoneTop(PopupZoneTop popupZoneTop, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");

		if(mFile != null) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + popupZoneTop.getHomepage_id();

			File f = popupZoneTopStorage.addFile(mFile, realFileName, filePath);

			popupZoneTop.setOrg_file_name(fileName);
			popupZoneTop.setServer_file_name(realFileName);
			popupZoneTop.setFile_extension(fileExtension);
			popupZoneTop.setFile_size(f.length());
		} else {
			popupZoneTop.setOrg_file_name(null);
		}

		return dao.addPopupZoneTop(popupZoneTop);
	}
	
	@WorkingLogger(comment="팝업존 관리 1건 수정")
	public int modifyPopupZoneTop(PopupZoneTop popupZoneTop, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");

		if(mFile != null) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + popupZoneTop.getHomepage_id();

			File f = popupZoneTopStorage.addFile(mFile, realFileName, filePath);

			popupZoneTop.setOrg_file_name(fileName);
			popupZoneTop.setServer_file_name(realFileName);
			popupZoneTop.setFile_extension(fileExtension);
			popupZoneTop.setFile_size(f.length());
		} else {
			popupZoneTop.setOrg_file_name(null);
		}

		return dao.modifyPopupZoneTop(popupZoneTop);
	}
	
	@WorkingLogger(comment="팝업존 관리 1건 삭제")
	public int deletePopupZoneTop(PopupZoneTop popupZoneTop) {
		PopupZoneTop popupZoneTopOne = dao.getPopupZoneTopOne(popupZoneTop);
		popupZoneTopStorage.deleteFile(popupZoneTopOne.getServer_file_name(), "/" + popupZoneTop.getHomepage_id());
		return dao.deletePopupZoneTop(popupZoneTop);
	}

	public String addImgFile(String homepage_id, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
		File f 			= null;
		String filePath = "/" + homepage_id;

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			f = popupZoneTopStorage.addFile(mFile, realFileName, filePath);
		}

		return f.getName();
	}

	public int getNextPrintSeq(String homepage_id) {
		return dao.getNextPrintSeq(homepage_id);
	}
}