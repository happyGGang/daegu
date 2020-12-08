package kr.go.gbelib.app.cms.module.libraryCheck;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
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
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class LibraryCheckService extends BaseService {
	
	@Autowired
	@Qualifier("libraryCheckStorage")
	private FileStorage libraryCheckStorage;
	
	@Autowired
	private LibraryCheckDao dao;
	
	public List<LibraryCheck> getLibraryCheckList(LibraryCheck libraryCheck) {
		
		List<LibraryCheck> result = dao.getLibraryCheckList(libraryCheck);
		
		for (LibraryCheck one : result) {
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    		String week_fri1 = "";
    		String week_fri2 = "";
    		
    		Calendar cal = Calendar.getInstance();
    		int fri_num = 6 - cal.get(Calendar.DAY_OF_WEEK);
    		cal.add(Calendar.DATE, fri_num);
    		week_fri1 = sdf.format(cal.getTime());
    		
    		cal.add(Calendar.DATE, 7);
    		week_fri2 = sdf.format(cal.getTime());
    		
    		String possible_date = "";
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("library_check_idx", one.getLibrary_check_idx());
    		map.put("loan_start_date", week_fri1);
    		if(!getPossibleDate(map)) {
    			possible_date = week_fri1;
    		}
    		map.put("loan_start_date", week_fri2);
    		if(!getPossibleDate(map)) {
    			possible_date += (possible_date.equals("") ? "" : ",")+ week_fri2;
    		}
    		
    		if(possible_date.equals("")) {
    			one.setLender_count(0);
    		} else if(possible_date.indexOf(",") > -1) {
    			one.setLender_count(2);
    			one.setLoan_start_date(week_fri2);
    			
    			cal.add(Calendar.DATE, 6);
    			String week_fri3 = sdf.format(cal.getTime());
    			one.setLoan_end_date(week_fri3);
    		} else {
    			one.setLender_count(1);
    		}
    		
		}
		
		return result;
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
	
	@WorkingLogger(comment="장서점검기 신청 리스트 관리 조회", type="P")
	public List<LibraryCheck> getLibraryCheckLoanList(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckLoanList(libraryCheck);
	}
	
	public int getLibraryCheckLoanCount(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckLoanCount(libraryCheck);
	}

	@WorkingLogger(comment="장서점검기 신청 리스트 관리 1건 조회", type="P")
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

	@WorkingLogger(comment="장서점검기 신청 리스트 관리 1건 수정", type="P")
	public int modifyLibraryCheckLoan(LibraryCheck libraryCheck) {
		return dao.modifyLibraryCheckLoan(libraryCheck);
	}

	@WorkingLogger(comment="장서점검기 신청 리스트 관리 1건 취소", type="P")
	public int deleteLibraryCheckLoan(LibraryCheck libraryCheck) {
		return dao.deleteLibraryCheckLoan(libraryCheck);
	}

	public int modifyLibraryCheckStatus(LibraryCheck libraryCheck) {
		return dao.modifyLibraryCheckStatus(libraryCheck);
	}

	@WorkingLogger(comment="장서점검기 신청 리스트 관리 엑셀 저장", type="P")
	public List<LibraryCheck> getLibraryCheckLoanExcelList(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckLoanExcelList(libraryCheck);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getMySqlList() {
		return dao.getMySqlList();
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getMySqlList2() {
		return dao.getMySqlList2();
	}

	public int addParseTibero(LibraryCheck lc) {
		return dao.addParseTibero(lc);
	}
	
	public int addParseTibero2(LibraryCheck lc) {
		return dao.addParseTibero2(lc);
	}

	public boolean getPossibleDate(Map<String, Object> map) {
		return dao.getPossibleDate(map) > 0 ? false : true;
	}

}
