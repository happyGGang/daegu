package kr.go.gbelib.app.cms.module.bookReportClub;

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
public class BookReportClubService extends BaseService {
	
	@Autowired
	private BookReportClubDao dao;
	
	@Autowired
	@Qualifier("bookReportClubStorage")
	private FileStorage bookReportClubStorage;

	@WorkingLogger(comment="독서동아리경연대회 목록 조회", type="P")
	public List<BookReportClub> bookReportClubList(BookReportClub bookReportClub) {
		return dao.bookReportClubList(bookReportClub);
	}
	
	@WorkingLogger(comment="독서동아리경연대회 엑셀 저장", type="P")
	public List<BookReportClub> getExcelList(BookReportClub bookReportClub) {
		return dao.getExcelList(bookReportClub);
	}
	
	@WorkingLogger(comment="독서동아리경연대회 1건 조회", type="P")
	public BookReportClub getBookReportClub(BookReportClub bookReportClub) {
		return dao.getBookReportClub(bookReportClub);
		
	}
	
	public int bookReportClubCount(BookReportClub bookReportClub) {
		return dao.bookReportClubCount(bookReportClub);
		
	}

	@Transactional
	public int addBookReportClub(BookReportClub bookReportClub, MultipartHttpServletRequest mpRequest) {
		multipartFile(bookReportClub, mpRequest);
		bookReportClub.setParticipation_field("0");
		return dao.addBookReportClub(bookReportClub);
	}
	
	@WorkingLogger(comment="독서동아리경연대회 1건 삭제", type="P", tableName = "BOOK_REPORT_CLUB")
	public int deleteBookReportClub(BookReportClub bookReportClub) {
		bookReportClub.setDelete_yn("Y");
		return dao.deleteBookReportClub(bookReportClub);
	}
	
	@WorkingLogger(comment="독서동아리경연대회 1건 상태 수정", type="P", tableName = "BOOK_REPORT_CLUB")
	public int statusChangeBookReportClub(BookReportClub bookReportClub) {
		return dao.statusChangeBookReportClub(bookReportClub);
	}
	
	private void multipartFile(BookReportClub bookReportClub, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");
		MultipartFile mFile2 = mpRequest.getFileMap().get("org_file_name_temp2");
		MultipartFile mFile3 = mpRequest.getFileMap().get("org_file_name_temp3");
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + bookReportClub.getHomepage_id();
			
			File f = bookReportClubStorage.addFile(mFile, realFileName, filePath);
			
			bookReportClub.setServer_file_name(realFileName);
			bookReportClub.setOrg_file_name(fileName);
			bookReportClub.setFile_extension(fileExtension);
			bookReportClub.setFile_size(f.length()); 
		} else {
			bookReportClub.setOrg_file_name(null);
		}
		if ( mFile2 != null ) {
			String realFileName2 	= Long.toString((System.currentTimeMillis()));
			String fileName2		= mFile2.getOriginalFilename().substring(0, mFile2.getOriginalFilename().lastIndexOf("."));
			String fileExtension2	= FilenameUtils.getExtension(mFile2.getOriginalFilename());
			String filePath2		= "/" + bookReportClub.getHomepage_id();
			
			File f2 = bookReportClubStorage.addFile(mFile2, realFileName2, filePath2);
			
			bookReportClub.setServer_file_name2(realFileName2);
			bookReportClub.setOrg_file_name2(fileName2);
			bookReportClub.setFile_extension2(fileExtension2);
			bookReportClub.setFile_size2(f2.length()); 
		} else {
			bookReportClub.setOrg_file_name2(null);
		}
		if ( mFile3 != null ) {
			String realFileName3 	= Long.toString((System.currentTimeMillis()));
			String fileName3		= mFile2.getOriginalFilename().substring(0, mFile3.getOriginalFilename().lastIndexOf("."));
			String fileExtension3	= FilenameUtils.getExtension(mFile3.getOriginalFilename());
			String filePath3		= "/" + bookReportClub.getHomepage_id();
			
			File f3 = bookReportClubStorage.addFile(mFile3, realFileName3, filePath3);
			
			bookReportClub.setServer_file_name3(realFileName3);
			bookReportClub.setOrg_file_name3(fileName3);
			bookReportClub.setFile_extension3(fileExtension3);
			bookReportClub.setFile_size3(f3.length()); 
		} else {
			bookReportClub.setOrg_file_name3(null);
		}
	}
	
	public String getRootPath() {
		return bookReportClubStorage.getRootPath();
	}
	
}
