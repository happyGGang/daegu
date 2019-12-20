package kr.go.gbelib.app.cms.module.bookPackage;

import java.util.List;

public interface BookPackageDao {
	
	public List<BookPackage> getBookPackageList(BookPackage bookPackage);
	
	public BookPackage getBookPackageOne(BookPackage bookPackage);

	public int addBookPackage(BookPackage bookPackage);

	public int modifyBookPackage(BookPackage bookPackage);

	public int deleteBookPackage(BookPackage bookPackage);

}
