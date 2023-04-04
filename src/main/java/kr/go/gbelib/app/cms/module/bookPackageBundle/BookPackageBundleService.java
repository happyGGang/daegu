package kr.go.gbelib.app.cms.module.bookPackageBundle;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;

import java.util.Optional;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class BookPackageBundleService extends BaseService {

	@Autowired
	@Qualifier("bookPackageStorage")
	private FileStorage bookPackageStorage;
	
	@Autowired
	private BookPackageBundleDao dao;

	public int getBookPackageBundleCount(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleCount(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageBundleList(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleList(bookPackageBundle);
	}

	public BookPackageBundle getBookPackageBundleOne(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleOne(bookPackageBundle);
	}

	public int createBookPackageBundle(BookPackageBundle bookPackageBundle) {
		return dao.createBookPackageBundle(bookPackageBundle);
	}

	public int deleteBookPackageBundle(BookPackageBundle bookPackageBundle) {
		return dao.deleteBookPackageBundle(bookPackageBundle);
	}

	public int modifyBookPackageBundle(BookPackageBundle bookPackageBundle) {
		return dao.modifyBookPackageBundle(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackage(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackage(bookPackageBundle);
	}

	public int addBookPackageBundle(BookPackageBundle bookPackageBundle) {
		MultipartFile docFile = bookPackageBundle.getDoc_file();
		if(docFile != null) {
			String fileName = docFile.getOriginalFilename().substring(0, docFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(docFile.getOriginalFilename());
			String filePath = "/";

			File f = bookPackageStorage.addFile(docFile, realFileName, filePath);
			
			bookPackageBundle.setDoc_org_file_name(fileName);
			bookPackageBundle.setDoc_server_file_name(realFileName);
			bookPackageBundle.setDoc_file_extension(fileExtension);
			bookPackageBundle.setDoc_file_size(f.length());
		}
		
		MultipartFile mFile = bookPackageBundle.getMfile();
		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/";

			File f = bookPackageStorage.addFile(mFile, realFileName, filePath);

			bookPackageBundle.setOrg_file_name(fileName);
			bookPackageBundle.setServer_file_name(realFileName);
			bookPackageBundle.setFile_extension(fileExtension);
			bookPackageBundle.setFile_size(f.length());
		}
		
		return dao.addBookPackageBundle(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageDetailList(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageDetailList(bookPackageBundle);
	}

	public int getBookPackageDetailCount(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageDetailCount(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageCategoryList(BookPackageBundle bookPackageBundle) {
		
		List<BookPackageBundle> getData = dao.getBookPackageCategoryList(bookPackageBundle);
		
		for (BookPackageBundle one : getData) {
			String[] a = one.getCategory().split(",");
			
			HashSet<String> set = new LinkedHashSet<String>();
			
			for (String b : a) {
				set.add(b);
			}
			
			Iterator<String> iter = set.iterator();
			
			StringBuilder sb = new StringBuilder();
			
			while(iter.hasNext()) {
				
				if (iter.hasNext() == false ) {
					sb.append(iter.next());
				} else {
					sb.append(iter.next()+ ",");
				}
			}
			one.setCategory(sb.toString());
		}
		
		return getData;
	}

	public int addBookPackageLoan(BookPackageBundle bookPackageBundle) {
		return dao.addBookPackageLoan(bookPackageBundle);
	}

	public int modifyBookPackageLoan(BookPackageBundle bookPackageBundle) {
		return dao.modifyBookPackageLoan(bookPackageBundle);
	}

	public int deleteBookPackageLoan(BookPackageBundle bookPackageBundle) {
		return dao.deleteBookPackageLoan(bookPackageBundle);
	}

	public int modifyReturnReq(BookPackageBundle bookPackageBundle) {
		return dao.modifyReturnReq(bookPackageBundle);
	}

	public int statusChangeAll(BookPackageBundle bookPackageBundle) {
		return dao.statusChangeAll(bookPackageBundle);
	}

	public BookPackageBundle getBookPackageLoanOne(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageLoanOne(bookPackageBundle);
	}

	public BookPackageBundle getBookPackageOne(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageOne(bookPackageBundle);
	}

	public int getBookPackageLoanCount(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageLoanCount(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageLoanList(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageLoanList(bookPackageBundle);
	}
	
	public List<BookPackageBundle> getBookPackageLoanCountCheck(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageLoanCountCheck(bookPackageBundle);
	}

	public BookPackageBundle getBookPackageDetailOne(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageDetailOne(bookPackageBundle);
	}

	public int modifyBookPackage(BookPackageBundle bookPackageBundle) {
		return dao.modifyBookPackage(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageBundleExcelList(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleExcelList(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageBundleLoanExcelList(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleLoanExcelList(bookPackageBundle);
	}
	public List<BookPackageBundle> getBookPackageBundleLoanExcelList2(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleLoanExcelList2(bookPackageBundle);
	}

	public int deleteBookPackageBundleDetail(BookPackageBundle bookPackageBundle) {
		return dao.deleteBookPackageBundleDetail(bookPackageBundle);
	}

	public int deleteBookPackageBundleDetailOne(BookPackageBundle bookPackageBundle) {
		return dao.deleteBookPackageBundleDetailOne(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageBundleDetailList(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleDetailList(bookPackageBundle);
	}

	public int addBook(BookPackageBundle bookPackageBundle) {
		return dao.addBook(bookPackageBundle);
	}

	public BookPackageBundle getBookDetail(BookPackageBundle bookPackageBundle) {
		return dao.getBookDetail(bookPackageBundle);
	}

	public int getBookPackageBundleDetailCount(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleDetailCount(bookPackageBundle);
	}

	public int modifyBook(BookPackageBundle bookPackageBundle) {
		return dao.modifyBook(bookPackageBundle);
	}

	public int addBookPackageDetail(BookPackageBundle bookPackageBundle) {
		return dao.addBookPackageDetail(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookDetailAll(BookPackageBundle bookPackageBundle) {
		return dao.getBookDetailAll(bookPackageBundle);
	}

	public int addBookPackageDetailAll(BookPackageBundle bookPackageBundle) {
		return dao.addBookPackageDetailAll(bookPackageBundle);
	}

	public List<BookPackageBundle> getDetailList(BookPackageBundle bookPackageBundle) {
		return dao.getDetailList(bookPackageBundle);
	}

	public List<BookPackageBundle> bundleExcelList(BookPackageBundle bookPackageBundle) {
		return dao.bundleExcelList(bookPackageBundle);
	}

	public int deleteBook(BookPackageBundle bookPackageBundle) {
		return dao.deleteBook(bookPackageBundle);
	}

	public int deleteBookDetail(BookPackageBundle bookPackageBundle) {
		return dao.deleteBookDetail(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageBundleTitleList(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageBundleTitleList(bookPackageBundle);
	}

	public List<BookPackageBundle> getBookPackageAllTitleCount(BookPackageBundle bookPackageBundle) {
		return dao.getBookPackageAllTitleCount(bookPackageBundle);
	}

	public List<BookPackageBundle> getReservationDate(BookPackageBundle bookPackageBundle) {
		return dao.getReservationDate(bookPackageBundle);
	}

	public BookPackageBundle setBookPackageDefaultDate(BookPackageBundle bookPackageBundle) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		Optional.of(bookPackageBundle)
				.filter(bundle -> bundle.getLender_count() > 0)
				.ifPresent(bundle -> bundle.setRequest_status("1"));

		LocalDate startDate = Optional.of(bookPackageBundle)
									  .filter(bundle -> "1".equals(bundle.getRequest_status()))
									  .map(bundle -> LocalDate.parse(bundle.getLoan_end_date(), formatter).plusDays(5))
									  .orElse(LocalDate.now().plusDays(5));

		bookPackageBundle.setLoan_start_date(startDate.format(formatter));

		LocalDate endDate = Optional.of(bookPackageBundle)
									.filter(bundle -> "1".equals(bundle.getRequest_status()))
									.map(bundle -> LocalDate.parse(bundle.getLoan_start_date(), formatter).plusDays(14))
									.orElse(startDate.plusDays(14));

		bookPackageBundle.setLoan_end_date(endDate.format(formatter));

		return bookPackageBundle;
	}
}
