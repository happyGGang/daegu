package kr.go.gbelib.app.cms.module.bookPackage;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.dataSource.DataSource;
import kr.co.whalesoft.framework.dataSource.DataSourceType;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.PagingUtils;

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
	
	public int getBookPackageCount(BookPackage bookPackage) {
		return dao.getBookPackageCount(bookPackage);
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
//			String filePath = "/" + bookPackage.getHomepage_id();
			String filePath = "/";

			File f = bookPackageStorage.addFile(mFile, realFileName, filePath);

			bookPackage.setOrg_file_name(fileName);
			bookPackage.setServer_file_name(realFileName);
			bookPackage.setFile_extension(fileExtension);
			bookPackage.setFile_size(f.length());
		}
		
		return dao.addBookPackage(bookPackage);
	}

	public int modifyBookPackage(BookPackage bookPackage) {
		MultipartFile mFile = bookPackage.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
//			String filePath = "/" + bookPackage.getHomepage_id();
			String filePath = "/";

			File f = bookPackageStorage.addFile(mFile, realFileName, filePath);

			bookPackage.setOrg_file_name(fileName);
			bookPackage.setServer_file_name(realFileName);
			bookPackage.setFile_extension(fileExtension);
			bookPackage.setFile_size(f.length());
		}
		
		return dao.modifyBookPackage(bookPackage);
	}

	public int deleteBookPackage(BookPackage bookPackage) {
		return dao.deleteBookPackage(bookPackage);
	}
	
	public int deleteCheckBookPackage(BookPackage bookPackage) {
		return dao.deleteCheckBookPackage(bookPackage);
	}
	
	public List<BookPackage> getBookPackageLoanList(BookPackage bookPackage) {
		return dao.getBookPackageLoanList(bookPackage);
	}
	
	public int getBookPackageLoanCount(BookPackage bookPackage) {
		return dao.getBookPackageLoanCount(bookPackage);
	}
	
	public BookPackage getBookPackageLoanOne(BookPackage bookPackage) {
		return dao.getBookPackageLoanOne(bookPackage);
	}

	public int addBookPackageLoan(BookPackage bookPackage) {
		return dao.addBookPackageLoan(bookPackage);
	}
	
	public int modifyBookPackageLoan(BookPackage bookPackage) {
		return dao.modifyBookPackageLoan(bookPackage);
	}

	public int modifyReturnReq(BookPackage bookPackage) {
		return dao.modifyReturnReq(bookPackage);
	}

	public int deleteBookPackageLoan(BookPackage bookPackage) {
		return dao.deleteBookPackageLoan(bookPackage);
	}
	
	public int statusChangeAll(BookPackage bookPackage) {
		return dao.statusChangeAll(bookPackage);
	}

	public List<BookPackage> getBookPackageExcelList(BookPackage bookPackage) {
		return dao.getBookPackageExcelList(bookPackage);
	}
	
	public List<BookPackage> getBookPackageLoanExcelList(BookPackage bookPackage) {
		return dao.getBookPackageLoanExcelList(bookPackage);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getMysqlToTibero() {
		return dao.getMysqlToTibero();
	}

	public int addMysqlToTibero(BookPackage bookPackage) {
		MultipartFile mFile = bookPackage.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/";

			File f = bookPackageStorage.addFile(mFile, realFileName, filePath);

			bookPackage.setOrg_file_name(fileName);
			bookPackage.setServer_file_name(realFileName);
			bookPackage.setFile_extension(fileExtension);
			bookPackage.setFile_size(f.length());
		}
		
		return dao.addMysqlToTibero(bookPackage);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getMysqlToTibero2() {
		return dao.getMysqlToTibero2();
	}

	public int addMysqlToTibero2(BookPackage bp) {
		return dao.addMysqlToTibero2(bp);
	}

}
