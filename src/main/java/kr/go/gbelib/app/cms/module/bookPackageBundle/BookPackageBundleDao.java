package kr.go.gbelib.app.cms.module.bookPackageBundle;

import java.util.List;

public interface BookPackageBundleDao {

	int getBookPackageBundleCount(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookPackageBundleList(BookPackageBundle bookPackageBundle);

	BookPackageBundle getBookPackageBundleOne(BookPackageBundle bookPackageBundle);

	int createBookPackageBundle(BookPackageBundle bookPackageBundle);

	int deleteBookPackageBundle(BookPackageBundle bookPackageBundle);

	int modifyBookPackageBundle(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookPackage(BookPackageBundle bookPackageBundle);

	int addBookPackageBundle(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookPackageDetailList(BookPackageBundle bookPackageBundle);

	int getBookPackageDetailCount(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookPackageCategoryList(BookPackageBundle bookPackageBundle);

	int addBookPackageLoan(BookPackageBundle bookPackageBundle);

	int modifyBookPackageLoan(BookPackageBundle bookPackageBundle);

	int deleteBookPackageLoan(BookPackageBundle bookPackageBundle);

	int modifyReturnReq(BookPackageBundle bookPackageBundle);

	int statusChangeAll(BookPackageBundle bookPackageBundle);

	BookPackageBundle getBookPackageLoanOne(BookPackageBundle bookPackageBundle);

	BookPackageBundle getBookPackageOne(BookPackageBundle bookPackageBundle);

	int getBookPackageLoanCount(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookPackageLoanList(BookPackageBundle bookPackageBundle);

	BookPackageBundle getBookPackageDetailOne(BookPackageBundle bookPackageBundle);

	int modifyBookPackage(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookPackageBundleExcelList(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookPackageBundleLoanExcelList(BookPackageBundle bookPackageBundle);

	int deleteBookPackageBundleDetail(BookPackageBundle bookPackageBundle);

	int deleteBookPackageBundleDetailOne(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookPackageBundleDetailList(BookPackageBundle bookPackageBundle);

	int addBook(BookPackageBundle bookPackageBundle);

	BookPackageBundle getBookDetail(BookPackageBundle bookPackageBundle);

	int getBookPackageBundleDetailCount(BookPackageBundle bookPackageBundle);

	int modifyBook(BookPackageBundle bookPackageBundle);

	int addBookPackageDetail(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getBookDetailAll(BookPackageBundle bookPackageBundle);

	int addBookPackageDetailAll(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> getDetailList(BookPackageBundle bookPackageBundle);

	List<BookPackageBundle> bundleExcelList(BookPackageBundle bookPackageBundle);

	int deleteBook(BookPackageBundle bookPackageBundle);

	int deleteBookDetail(BookPackageBundle bookPackageBundle);

}
