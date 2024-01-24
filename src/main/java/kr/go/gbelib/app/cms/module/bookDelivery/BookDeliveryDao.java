package kr.go.gbelib.app.cms.module.bookDelivery;

import java.util.List;

public interface BookDeliveryDao {

	public int getBookDeliveryCount(BookDelivery bookDelivery);

	public List<BookDelivery> getBookDeliveryList(BookDelivery bookDelivery);

	public int addBookDelivery(BookDelivery bookDelivery);

	public int modifyBookDelivery(BookDelivery bookDelivery);

	public int deleteBookDelivery(BookDelivery bookDelivery);

	public int deleteCheckBookDelivery(BookDelivery bookDelivery);

	public BookDelivery getBookDeliveryListDetail(BookDelivery bookDelivery);

	public List<BookDelivery> getBookDeliveryExcelList(BookDelivery bookDelivery);

}
