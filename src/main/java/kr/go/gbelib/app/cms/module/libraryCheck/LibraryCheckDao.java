package kr.go.gbelib.app.cms.module.libraryCheck;

import java.util.List;

public interface LibraryCheckDao {

	public List<LibraryCheck> getLibraryCheckList(LibraryCheck libraryCheck);
	
	public int getLibraryCheckCount(LibraryCheck libraryCheck);

	public LibraryCheck getLibraryCheckOne(LibraryCheck libraryCheck);
	
	public int getLibraryCheckDupl(LibraryCheck libraryCheck);

	public int addLibraryCheck(LibraryCheck libraryCheck);

	public int modifyLibraryCheck(LibraryCheck libraryCheck);

	public int deleteLibraryCheck(LibraryCheck libraryCheck);

	public int deleteLibraryCheckAll(LibraryCheck libraryCheck);
	
	public List<LibraryCheck> getLibraryCheckLoanList(LibraryCheck libraryCheck);
	
	public int getLibraryCheckLoanCount(LibraryCheck libraryCheck);
	
	public LibraryCheck getLibraryCheckLoanOne(LibraryCheck libraryCheck);
	
	public int addLibraryCheckLoan(LibraryCheck libraryCheck);
	
	public int modifyLibraryCheckLoan(LibraryCheck libraryCheck);
	
	public int deleteLibraryCheckLoan(LibraryCheck libraryCheck);

	public String getWeekFriday(LibraryCheck libraryCheck);

	public int modifyLibraryCheckStatus(LibraryCheck libraryCheck);

	public List<LibraryCheck> getLibraryCheckLoanExcelList(LibraryCheck libraryCheck);

}
