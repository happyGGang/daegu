package kr.go.gbelib.app.cms.module.bookReportContest;

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
public class BookReportContestService extends BaseService {
	
	@Autowired
	private BookReportContestDao dao;
	
	@Autowired
	@Qualifier("bookReportContestStorage")
	private FileStorage bookReportContestStorage;

	@WorkingLogger(comment="독후감 공모 목록 조회", type="P")
	public List<BookReportContest> bookReportContestList(BookReportContest bookReportContest) {
		return dao.bookReportContestList(bookReportContest);
	}
	
	@WorkingLogger(comment="독후감 공모 엑셀 저장", type="P")
	public List<BookReportContest> getExcelList(BookReportContest bookReportContest) {
		return dao.getExcelList(bookReportContest);
	}
	
	@WorkingLogger(comment="독후감 공모 1건 조회", type="P")
	public BookReportContest getBookReportContest(BookReportContest bookReportContest) {
		return dao.getBookReportContest(bookReportContest);
		
	}
	
	public int bookReportContestCount(BookReportContest bookReportContest) {
		return dao.bookReportContestCount(bookReportContest);
		
	}

	@Transactional
	public int addBookReportContest(BookReportContest bookReportContest, MultipartHttpServletRequest mpRequest) {
		multipartFile(bookReportContest, mpRequest);
		// 2021-08-31 YUNHAESU 강제 소년부 데이터값 배당
		bookReportContest.setParticipation_field("0");
		return dao.addBookReportContest(bookReportContest);
	}
	
	@WorkingLogger(comment="독후감 공모 1건 삭제", type="P")
	public int deleteBookReportContest(BookReportContest bookReportContest) {
		return dao.deleteBookReportContest(bookReportContest);
	}
	
	@WorkingLogger(comment="독후감 공모 1건 상태 수정", type="P")
	public int statusChangeBookReportContest(BookReportContest bookReportContest) {
		return dao.statusChangeBookReportContest(bookReportContest);
	}
	
	private void multipartFile(BookReportContest bookReportContest, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");
		MultipartFile mFile2 = mpRequest.getFileMap().get("org_file_name_temp2");
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + bookReportContest.getHomepage_id();
			
			File f = bookReportContestStorage.addFile(mFile, realFileName, filePath);
			
			bookReportContest.setServer_file_name(realFileName);
			bookReportContest.setOrg_file_name(fileName);
			bookReportContest.setFile_extension(fileExtension);
			bookReportContest.setFile_size(f.length()); 
		} else {
			bookReportContest.setOrg_file_name(null);
		}
		if ( mFile2 != null ) {
			String realFileName2 	= Long.toString((System.currentTimeMillis()));
			String fileName2		= mFile2.getOriginalFilename().substring(0, mFile2.getOriginalFilename().lastIndexOf("."));
			String fileExtension2	= FilenameUtils.getExtension(mFile2.getOriginalFilename());
			String filePath2		= "/" + bookReportContest.getHomepage_id();
			
			File f2 = bookReportContestStorage.addFile(mFile2, realFileName2, filePath2);
			
			bookReportContest.setServer_file_name2(realFileName2);
			bookReportContest.setOrg_file_name2(fileName2);
			bookReportContest.setFile_extension2(fileExtension2);
			bookReportContest.setFile_size2(f2.length()); 
		} else {
			bookReportContest.setOrg_file_name2(null);
		}
	}
	
	public String getRootPath() {
		return bookReportContestStorage.getRootPath();
	}
	
}
