package kr.go.gbelib.app.cms.module.teachBook;

import java.util.List;


public interface TeachBookDao  {

	public List<TeachBook> getTeachBookDateList(TeachBook teachBook);
	
	public List<TeachBook> getTeachBookDetailByDate(TeachBook teachBook);
	
	public int addTeachBookTime(TeachBook teachBook);
	
	public int deleteTeachBookTime(int teach_book_time_idx);
	
	public int deleteTeachBookDetail(TeachBook teachBook);
	
	public int addTeachBookDetail(TeachBook teachBook);
	
	public List<TeachBook> getTeachBookViewInfo(TeachBook teachBook);

	public List<TeachBook> getTeachBookList(TeachBook teachBook);
	
	public int addTeachBook(TeachBook teachBook);
	
	public int checkTeachBookStudentByDate(TeachBook teachBook);
	
	public int modifyTeachBook(TeachBook teachBook);
	
	public int mergeTeachBook(TeachBook teachBook);

	public int deleteTeachBook(TeachBook teachBook);

	public int modifyStudentPay(TeachBook teachBook);
}