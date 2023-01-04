package kr.go.gbelib.app.cms.module.bookOfFamous;

import java.util.List;

public interface BookOfFamousDao {

	public int getBookOfFamousCount(BookOfFamous boy);

	public List<BookOfFamous> getBookOfFamousList(BookOfFamous boy);

	public BookOfFamous getBookOfFamousOne(BookOfFamous boy);

	public int addBookOfFamous(BookOfFamous boy);

	public int modifyBookOfFamous(BookOfFamous boy);

	public int deleteBookOfFamous(BookOfFamous boy);

	public List<BookOfFamous> getBookOfFamousListAPi(BookOfFamous boy);

}
