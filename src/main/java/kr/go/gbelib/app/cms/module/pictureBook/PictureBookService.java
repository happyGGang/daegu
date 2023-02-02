package kr.go.gbelib.app.cms.module.pictureBook;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
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
public class PictureBookService extends BaseService {
	
	@Autowired
	@Qualifier("pictureBookStorage")
	private FileStorage pictureBookStorage;
	
	@Autowired
	private PictureBookDao dao;

	public List<PictureBook> getPictureBookList(PictureBook pictureBook) {
//		List<PictureBook> list = dao.getPictureBookList(pictureBook);
//		
//		Calendar cal = Calendar.getInstance();
//		int year = cal.get(Calendar.YEAR);
//		int month = cal.get(Calendar.MONTH)+1;
//		
//		if(month == 12) {
//			year++;
//		}
//		
//		for (PictureBook one : list) {
//			one.setLoan_year(String.valueOf(year));
//			one.setMonthList(dao.getMonthList(one));
//		}
		
		return dao.getPictureBookList(pictureBook);
	}
	
	public int getPictureBookCount(PictureBook pictureBook) {
		return dao.getPictureBookCount(pictureBook);
	}
	
	public PictureBook getPictureBookOne(PictureBook pictureBook) {
		return dao.getPictureBookOne(pictureBook);
	}

	public int addPictureBook(PictureBook pictureBook) {
		MultipartFile mFile = pictureBook.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/";

			File f = pictureBookStorage.addFile(mFile, realFileName, filePath);
			
			pictureBook.setOrg_file_name(fileName);
			pictureBook.setServer_file_name(realFileName);
			pictureBook.setFile_extension(fileExtension);
			pictureBook.setFile_size(f.length());
		}
		
		return dao.addPictureBook(pictureBook);
	}

	public int modifyPictureBook(PictureBook pictureBook) {
		MultipartFile mFile = pictureBook.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/";

			File f = pictureBookStorage.addFile(mFile, realFileName, filePath);

			pictureBook.setOrg_file_name(fileName);
			pictureBook.setServer_file_name(realFileName);
			pictureBook.setFile_extension(fileExtension);
			pictureBook.setFile_size(f.length());
		}
		
		return dao.modifyPictureBook(pictureBook);
	}

	public int deletePictureBook(PictureBook pictureBook) {
		dao.deletePictureBookLoanAll(pictureBook);
		return dao.deletePictureBook(pictureBook);
	}
	
	public Map<Integer, Map<String, Object>> getLoanableMonth(PictureBook pictureBook) {
		Map<Integer, Map<String, Object>> map = new HashMap<Integer, Map<String, Object>>();
		Map<String, Object> element = null;
		
		List<PictureBook> list = dao.getLoanableMonth(pictureBook);
		
		for (int i = 1; i <= 12; i++) {
			element = new HashMap<String, Object>();
			boolean flag = false;
			
			for (int j = 0; j < list.size(); j++) {
				if(i == Integer.parseInt(list.get(j).getLoan_month())) {
					element.put("picture_book_loan_idx", list.get(j).getPicture_book_loan_idx());
					element.put("school_name", list.get(j).getSchool_name());
					element.put("request_name", list.get(j).getRequest_name());
					
					flag = true;
					list.remove(j);
					break;
				}
			}
			
			element.put("isMonth", flag);
			map.put(i, element);
		}
		pictureBook.setMonthList(dao.getMonthList(pictureBook));
		
		return map;
	}

	@WorkingLogger(comment="그림책 원화 대출신청 리스트 관리 조회", type="P")
	public List<PictureBook> getPictureBookLoanList(PictureBook pictureBook) {
		return dao.getPictureBookLoanList(pictureBook);
	}
	
	public int getPictureBookLoanCount(PictureBook pictureBook) {
		return dao.getPictureBookLoanCount(pictureBook);
	}
	
	@WorkingLogger(comment="그림책 원화 대출신청 리스트 관리 1건 조회", type="P")
	public PictureBook getPictureBookLoanOne(PictureBook pictureBook) {
		pictureBook = dao.getPictureBookLoanOne(pictureBook);
		
		String[] phone = pictureBook.getPhone().split("-");
		pictureBook.setPhone_1(phone[0]);
		if(phone.length == 3) {
			pictureBook.setPhone_2(phone[1]);
			pictureBook.setPhone_3(phone[2]);
		} else {
			pictureBook.setPhone_2(null);
			pictureBook.setPhone_3(null);
		}
		
		String[] school_tel = pictureBook.getSchool_tel().split("-");
		pictureBook.setSchool_tel_1(school_tel[0]);
		if(school_tel.length == 3) {
			pictureBook.setSchool_tel_2(school_tel[1]);
			pictureBook.setSchool_tel_3(school_tel[2]);
		} else {
			pictureBook.setSchool_tel_2(null);
			pictureBook.setSchool_tel_3(null);
		}
		
		return pictureBook;
	}

	public int addPictureBookLoan(PictureBook pictureBook) {
		String delivery_location = pictureBook.getDelivery_location();
		if("기타".equals(delivery_location) && StringUtils.isNotEmpty(pictureBook.getDelivery_location2())) {
			pictureBook.setDelivery_location(pictureBook.getDelivery_location2());
		}
		return dao.addPictureBookLoan(pictureBook);
	}

	@WorkingLogger(comment="그림책 원화 대출신청 리스트 관리 1건 수정", type="P")
	public int modifyPictureBookLoan(PictureBook pictureBook) {
		return dao.modifyPictureBookLoan(pictureBook);
	}

	@WorkingLogger(comment="그림책 원화 대출신청 리스트 관리 1건 삭제", type="P")
	public int deletePictureBookLoan(PictureBook pictureBook) {
		return dao.deletePictureBookLoan(pictureBook);
	}

	public int statusChangeAll(PictureBook pictureBook) {
		return dao.statusChangeAll(pictureBook);
	}
	
	public int duplLoanChk(PictureBook pictureBook) {
		if(pictureBook.getLoan_month().length() == 1) {
			pictureBook.setLoan_month("0" + pictureBook.getLoan_month());
		}
		return dao.duplLoanChk(pictureBook);
	}

	@WorkingLogger(comment="그림책 원화 대출신청 리스트 관리 엑셀 저장", type="P")
	public List<PictureBook> getPictureBookLoanExcelList(PictureBook pictureBook) {
		return dao.getPictureBookLoanExcelList(pictureBook);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getMySqlList(String table_name) {
		return dao.getMySqlList(table_name);
	}
	
	public int addParseTibero(PictureBook pictureBook) {
		return dao.addParseTibero(pictureBook);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getMySqlList2(String a_num) {
		return dao.getMySqlList2(a_num);
	}
	
	public int addParseTibero2(PictureBook pictureBook) {
		return dao.addParseTibero2(pictureBook);
	}

	public int checkDupLoanDateCount(PictureBook pictureBook) {
		return dao.checkDupLoanDateCount(pictureBook);
	}

	public int getDupLoanCount(PictureBook pictureBook) {
		return dao.getDupLoanCount(pictureBook);
	}

	public PictureBook dupLoanDate(PictureBook pictureBook) {
		return dao.dupLoanDate(pictureBook);
	}

	public List<PictureBook> getReservationDate(PictureBook pictureBook) {
		return dao.getReservationDate(pictureBook);
	}
}