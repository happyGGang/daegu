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
		
		for(int i = 0; i < result.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
    		map.put("library_check_idx", result.get(i).getLibrary_check_idx());
    		try {
    			List<LibraryCheck> libraryCheckLoanList = getLibraryCheckLoanStatus(map);
    			if(!(libraryCheckLoanList.isEmpty()) && libraryCheckLoanList != null) {
    				result.get(i).setRequest_status(libraryCheckLoanList.get(0).getRequest_status());
        			result.get(i).setLoan_start_date(libraryCheckLoanList.get(0).getLoan_start_date());
        			result.get(i).setLoan_end_date(libraryCheckLoanList.get(0).getLoan_end_date());
    			}
			} catch (Exception e) {
				System.out.print(e);
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

	public List<LibraryCheck> getLibraryCheckLoanStatus(Map<String, Object> map) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
		
		map.put("dayofWeekFriday", sdf.format(cal.getTime()));
		
		return dao.getLibraryCheckLoanStatus(map);
	}

	public List<LibraryCheck> getLibraryCheckReservedList(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckReservedList(libraryCheck);
	}

	public int getLibraryCheckLoanDupl(LibraryCheck libraryCheck) {
		return dao.getLibraryCheckLoanDupl(libraryCheck);
	}

	public int checkLoanCount(LibraryCheck libraryCheck) {
		return dao.checkLoanCount(libraryCheck);
	}

	public int checkDupLoanDateCount(LibraryCheck libraryCheck) {
		return dao.checkDupLoanDateCount(libraryCheck);
	}

	public LibraryCheck dupLoanDate(LibraryCheck libraryCheck) {
		return dao.dupLoanDate(libraryCheck);
	}

}
