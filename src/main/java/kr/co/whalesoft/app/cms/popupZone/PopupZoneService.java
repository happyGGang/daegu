package kr.co.whalesoft.app.cms.popupZone;

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
public class PopupZoneService extends BaseService {

	@Autowired
	private PopupZoneDao dao;

	@Autowired
	@Qualifier("popupZoneStorage")
	private FileStorage popupZoneStorage;

	public List<PopupZone> getPopupZone(PopupZone popupZone) {
		return dao.getPopupZone(popupZone);
	}

	public List<PopupZone> getPopupZoneAll(PopupZone popupZone) {
		return dao.getPopupZoneAll(popupZone);
	}

	public int getPopupZoneCount(PopupZone popupZone) {
		return dao.getPopupZoneCount(popupZone);
	}

	public PopupZone getPopupZoneOne(PopupZone popupZone) {
		return dao.getPopupZoneOne(popupZone);
	}

	@Transactional
	@WorkingLogger(comment="팝업존 관리 1건 추가")
	public int addPopupZone(PopupZone popupZone, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");

		if(mFile != null) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + popupZone.getHomepage_id();

			File f = popupZoneStorage.addFile(mFile, realFileName, filePath);

			popupZone.setOrg_file_name(fileName);
			popupZone.setServer_file_name(realFileName);
			popupZone.setFile_extension(fileExtension);
			popupZone.setFile_size(f.length());
		} else {
			popupZone.setOrg_file_name(null);
		}

		return dao.addPopupZone(popupZone);
	}
	
	@WorkingLogger(comment="팝업존 관리 1건 수정")
	public int modifyPopupZone(PopupZone popupZone, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");

		if(mFile != null) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + popupZone.getHomepage_id();

			File f = popupZoneStorage.addFile(mFile, realFileName, filePath);

			popupZone.setOrg_file_name(fileName);
			popupZone.setServer_file_name(realFileName);
			popupZone.setFile_extension(fileExtension);
			popupZone.setFile_size(f.length());
		} else {
			popupZone.setOrg_file_name(null);
		}

		return dao.modifyPopupZone(popupZone);
	}
	
	public int modifyPopupZonePrintSeq(PopupZone popupZone) {
		return dao.modifyPopupZonePrintSeq(popupZone);
	}
	
	@WorkingLogger(comment="팝업존 관리 1건 삭제")
	public int deletePopupZone(PopupZone popupZone) {
		PopupZone popupZoneOne = dao.getPopupZoneOne(popupZone);
		popupZoneStorage.deleteFile(popupZoneOne.getServer_file_name(), "/" + popupZone.getHomepage_id());
		return dao.deletePopupZone(popupZone);
	}

	public String addImgFile(String homepage_id, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
		File f 			= null;
		String filePath = "/" + homepage_id;

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			f = popupZoneStorage.addFile(mFile, realFileName, filePath);
		}

		return f.getName();
	}

	public int getNextPrintSeq(String homepage_id) {
		return dao.getNextPrintSeq(homepage_id);
	}

}