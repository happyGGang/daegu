package kr.go.gbelib.app.cms.module.libraryCheck;

import java.io.File;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class LibraryCheckService extends BaseService {
	
	@Autowired
	@Qualifier("libraryCheckStorage")
	private FileStorage libraryCheckStorage;
	
	@Autowired
	private LibraryCheckDao dao;
	
	public List<LibraryCheck> getLibraryCheckList(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckList(libraryCheck);
	}
	
	public int getLibraryCheckCount(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckCount(libraryCheck);
	}

	public LibraryCheck getLibraryCheckOne(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckOne(libraryCheck);
	}
	
	public int getLibraryCheckDupl(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckDupl(libraryCheck);
	}

	public int addLibraryCheck(LibraryCheck libraryCheck) {
		MultipartFile mFile = libraryCheck.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
//			String filePath = "/" + bookPackage.getHomepage_id();
			String filePath = "/";

			File f = libraryCheckStorage.addFile(mFile, realFileName, filePath);

			libraryCheck.setOrg_file_name(fileName);
			libraryCheck.setServer_file_name(realFileName);
			libraryCheck.setFile_extension(fileExtension);
			libraryCheck.setFile_size(f.length());
		}
		
		return dao.addLibraryCheck(libraryCheck);
	}
	
	public int modifyLibraryCheck(LibraryCheck libraryCheck) {
		MultipartFile mFile = libraryCheck.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
//			String filePath = "/" + bookPackage.getHomepage_id();
			String filePath = "/";

			File f = libraryCheckStorage.addFile(mFile, realFileName, filePath);

			libraryCheck.setOrg_file_name(fileName);
			libraryCheck.setServer_file_name(realFileName);
			libraryCheck.setFile_extension(fileExtension);
			libraryCheck.setFile_size(f.length());
		}
		
		return dao.modifyLibraryCheck(libraryCheck);
	}

	public int deleteLibraryCheck(LibraryCheck libraryCheck) {
		return dao.deleteLibraryCheck(libraryCheck);
	}

	public int deleteLibraryCheckAll(LibraryCheck libraryCheck) {
		return dao.deleteLibraryCheckAll(libraryCheck);
	}
	
	public List<LibraryCheck> getLibraryCheckLoanList(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckLoanList(libraryCheck);
	}
	
	public int getLibraryCheckLoanCount(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckLoanCount(libraryCheck);
	}
	
	public LibraryCheck getLibraryCheckLoanOne(LibraryCheck libraryCheck) {
		libraryCheck = dao.getLibraryCheckLoanOne(libraryCheck);
		
		String[] phone = libraryCheck.getPhone().split("-");
		libraryCheck.setPhone_1(phone[0]);
		libraryCheck.setPhone_2(phone[1]);
		libraryCheck.setPhone_3(phone[2]);
		
		String[] school_tel = libraryCheck.getSchool_tel().split("-");
		libraryCheck.setSchool_tel_1(school_tel[0]);
		libraryCheck.setSchool_tel_2(school_tel[1]);
		libraryCheck.setSchool_tel_3(school_tel[2]);
		
		return libraryCheck;
	}
	
	public int addLibraryCheckLoan(LibraryCheck libraryCheck) {
		return dao.addLibraryCheckLoan(libraryCheck);
	}
	
	public int modifyLibraryCheckLoan(LibraryCheck libraryCheck) {
		return dao.modifyLibraryCheckLoan(libraryCheck);
	}

	public String getWeekFriday(LibraryCheck libraryCheck) {
		return dao.getWeekFriday(libraryCheck);
	}

	public int modifyLibraryCheckStatus(LibraryCheck libraryCheck) {
		return dao.modifyLibraryCheckStatus(libraryCheck);
	}

}
