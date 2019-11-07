package kr.go.gbelib.app.cms.module.donateBook;

import java.util.List;

public interface DonateBookDao  {

	public List<DonateBook> getDonateBookList(DonateBook donateBook);
	
	public List<DonateBook> getDonateBookListAll(DonateBook donateBook);
	
	public int getDonateBookListCount(DonateBook donateBook);
	
	public DonateBook getDonateBookOne(DonateBook donateBook);
	
	public int addDonateBook(DonateBook donateBook);
	
	public int modifyDonateBook(DonateBook donateBook);
	
	public int deleteDonateBook(DonateBook donateBook);
}