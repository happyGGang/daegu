package kr.go.gbelib.app.cms.module.lockerPre;

import java.io.File;
import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class LockerPreService extends BaseService {

	@Autowired
	@Qualifier("lockerPreStorage")
	private FileStorage lockerPreStorage;
	
	@Autowired
	private LockerPreDao dao;

	public List<LockerPre> getLockerPreAll(LockerPre LockerPre) {
		return dao.getLockerPreAll(LockerPre);
	}

	public List<LockerPre> getLockerPre(LockerPre LockerPre) {
		return dao.getLockerPre(LockerPre);
	}

	public int getLockerPreCount(LockerPre lockerPre) {
		return dao.getLockerPreCount(lockerPre);
	}

	public LockerPre getLockerPreOne(LockerPre lockerPre) {
		return dao.getLockerPreOne(lockerPre);
	}

	public int addLockerPre(LockerPre lockerPre) {
		MultipartFile mFile = lockerPre.getImage_file();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + lockerPre.getHomepage_id();
			
			File f = lockerPreStorage.addFile(mFile, realFileName, filePath);
			lockerPre.setReal_file_name(realFileName);
			lockerPre.setImage_file_name(fileName);
			lockerPre.setImage_file_extension(fileExtension);
			lockerPre.setImage_file_size(f.length()); 
		}
		
		return dao.addLockerPre(lockerPre);
	}

	public int lockerPreIdx(LockerPre lockerPre) {
		return dao.lockerPreIdx(lockerPre);
	}

	public int modifyLocekrPre(LockerPre lockerPre) {
		MultipartFile mFile = lockerPre.getImage_file();

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + lockerPre.getHomepage_id();
			
			File f = lockerPreStorage.addFile(mFile, realFileName, filePath);
			lockerPre.setReal_file_name(realFileName);
			lockerPre.setImage_file_name(fileName);
			lockerPre.setImage_file_extension(fileExtension);
			lockerPre.setImage_file_size(f.length()); 
		}
		return dao.modifyLocekrPre(lockerPre);
	}

	public int deleteLockerPre(LockerPre lockerPre) {
		return dao.deleteLockerPre(lockerPre);
	}

	public int deleteAllLockerPre(LockerPre lockerPre) {
		return dao.deleteAllLockerPre(lockerPre);
	}
	
	public int deleteLockerReq(LockerPre lockerPre) {
		return dao.deleteLockerReq(lockerPre);
	}
	
	public int getMaxIdxOfLockerPre(LockerPre lockerPre) {
		return dao.getMaxIdxOfLockerPre(lockerPre);
	}

	public int deleteFile(LockerPre lockerPre) {
		lockerPre = dao.getLockerPreOne(lockerPre);
		
		lockerPreStorage.deleteFile(lockerPre.getReal_file_name(), "/" + lockerPre.getHomepage_id());
		return dao.deleteFile(lockerPre);
	}

}
