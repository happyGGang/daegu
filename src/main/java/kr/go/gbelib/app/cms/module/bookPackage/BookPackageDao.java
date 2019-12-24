package kr.go.gbelib.app.cms.module.bookPackage;

import java.util.List;

public interface BookPackageDao {
	
	public List<BookPackage> getBookPackageList(BookPackage bookPackage);
	
	public int getBookPackageCount(BookPackage bookPackage);
	
	public BookPackage getBookPackageOne(BookPackage bookPackage);

	public int addBookPackage(BookPackage bookPackage);

	public int modifyBookPackage(BookPackage bookPackage);

	public int deleteBookPackage(BookPackage bookPackage);
	
	public List<BookPackage> getBookPackageLoanList(BookPackage bookPackage);
	
	public int getBookPackageLoanCount(BookPackage bookPackage);
	
	public BookPackage getBookPackageLoanOne(BookPackage bookPackage);

	public int addBookPackageLoan(BookPackage bookPackage);
	
	public int modifyBookPackageLoan(BookPackage bookPackage);

	public int modifyReturnReq(BookPackage bookPackage);

	public int deleteBookPackageLoan(BookPackage bookPackage);

}
