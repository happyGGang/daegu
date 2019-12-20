package kr.go.gbelib.app.cms.module.bookPackage;

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
public class BookPackageService extends BaseService {
	
	@Autowired
	@Qualifier("bookPackageStorage")
	private FileStorage bookPackageStorage;
	
	@Autowired
	private BookPackageDao dao;
	
	public List<BookPackage> getBookPackageList(BookPackage bookPackage) {
		return dao.getBookPackageList(bookPackage);
	}
	
	public BookPackage getBookPackageOne(BookPackage bookPackage) {
		return dao.getBookPackageOne(bookPackage);
	}
	
	public int addBookPackage(BookPackage bookPackage) {
		MultipartFile mFile = bookPackage.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/" + bookPackage.getHomepage_id();

			File f = bookPackageStorage.addFile(mFile, realFileName, filePath);

			bookPackage.setOrg_file_name(fileName);
			bookPackage.setServer_file_name(realFileName);
			bookPackage.setFile_extension(fileExtension);
			bookPackage.setFile_size(f.length());
		}
		
		return dao.addBookPackage(bookPackage);
	}

	public int modifyBookPackage(BookPackage bookPackage) {
		return dao.modifyBookPackage(bookPackage);
	}

	public int deleteBookPackage(BookPackage bookPackage) {
		return dao.deleteBookPackage(bookPackage);
	}


}
