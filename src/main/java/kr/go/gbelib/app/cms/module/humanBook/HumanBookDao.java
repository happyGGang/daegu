package kr.go.gbelib.app.cms.module.humanBook;

import java.util.List;

public interface HumanBookDao {

	public List<HumanBook> getHumanBookAll(HumanBook humanBook);

	public int getHumanBookCount(HumanBook humanBook);

	public HumanBook getHumanBookOne(HumanBook humanBook);
	
	public int addHumanBook(HumanBook humanBook);

	public int modifyHumanBook(HumanBook humanBook);

	public int applyStatus(HumanBook humanBook);

	public List<HumanBook> getHumanBookList(HumanBook humanBook);

	public int getHumanBookListCount(HumanBook humanBook);

	public int deleteHumanBook(HumanBook humanBook);

}
