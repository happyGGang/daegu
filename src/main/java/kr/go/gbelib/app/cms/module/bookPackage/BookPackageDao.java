package kr.go.gbelib.app.cms.module.bookPackage;

import java.util.List;
import java.util.Map;

public interface BookPackageDao {
	
	public List<BookPackage> getBookPackageList(BookPackage bookPackage);
	
	public int getBookPackageCount(BookPackage bookPackage);
	
	public BookPackage getBookPackageOne(BookPackage bookPackage);

	public int addBookPackage(BookPackage bookPackage);

	public int modifyBookPackage(BookPackage bookPackage);

	public int deleteBookPackage(BookPackage bookPackage);
	
	public int deleteCheckBookPackage(BookPackage bookPackage);
	
	public List<BookPackage> getBookPackageLoanList(BookPackage bookPackage);
	
	public int getBookPackageLoanCount(BookPackage bookPackage);
	
	public BookPackage getBookPackageLoanOne(BookPackage bookPackage);

	public int addBookPackageLoan(BookPackage bookPackage);
	
	public int modifyBookPackageLoan(BookPackage bookPackage);

	public int modifyReturnReq(BookPackage bookPackage);

	public int deleteBookPackageLoan(BookPackage bookPackage);

	public List<BookPackage> getBookPackageExcelList(BookPackage bookPackage);

	public List<BookPackage> getBookPackageLoanExcelList(BookPackage bookPackage);

	public List<Map<String, Object>> getMysqlToTibero();

	public int addMysqlToTibero(BookPackage bookPackage);

	public List<Map<String, Object>> getMysqlToTibero2();

	public int addMysqlToTibero2(BookPackage bp);

}
