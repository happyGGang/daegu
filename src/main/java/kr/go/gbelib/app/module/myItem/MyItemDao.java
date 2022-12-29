package kr.go.gbelib.app.module.myItem;

import java.util.List;

public interface MyItemDao {

	public List<MyItem> getMyItemList(MyItem myItem);

	public MyItem getMyItemOne(MyItem myItem);

	public int addMyItem(MyItem myItem);

	public int deleteMyItem(MyItem myItem);

	public int moveMyItem(MyItem myItem);

	/**
	 * @author YONGJU 2017. 12. 13.
	 * @param myItem
	 * @return
	 */
	public int getMyItemCount(MyItem myItem);

	List<MyItem> excelDownLoad(MyItem myItem);
}