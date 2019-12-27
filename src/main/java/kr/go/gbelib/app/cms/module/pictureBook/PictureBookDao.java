package kr.go.gbelib.app.cms.module.pictureBook;

import java.util.List;

public interface PictureBookDao {

	public List<PictureBook> getPictureBookList(PictureBook pictureBook);

	public int getPictureBookCount(PictureBook pictureBook);
	
	public PictureBook getPictureBookOne(PictureBook pictureBook);

	public int addPictureBook(PictureBook pictureBook);

	public int modifyPictureBook(PictureBook pictureBook);

	public int deletePictureBook(PictureBook pictureBook);
	
	public List<PictureBook> getPictureBookLoanList(PictureBook pictureBook);
	
	public int getPictureBookLoanCount(PictureBook pictureBook);

	public int addPictureBookLoan(PictureBook pictureBook);
	
	public int modifyPictureBookLoan(PictureBook pictureBook);
	
	public List<PictureBook> getLoanableMonth(PictureBook pictureBook);
	
	public int deletePictureBookLoan(PictureBook pictureBook);

	public int deletePictureBookLoanAll(PictureBook pictureBook);
	
	public int statusChangeAll(PictureBook pictureBook);

}
