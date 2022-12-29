package kr.go.gbelib.app.module.myItem;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MyItemService extends BaseService {

	@Autowired
	private MyItemDao dao;

	public List<MyItem> getMyItemList(MyItem myItem) {
		return dao.getMyItemList(myItem);
	}

	public MyItem getMyItemOne(MyItem myItem) {
		return dao.getMyItemOne(myItem);
	}

	public int addMyItem(MyItem myItem) {
		return dao.addMyItem(myItem);
	}

	public int deleteMyItem(MyItem myItem) {
		return dao.deleteMyItem(myItem);
	}

	public int moveMyItem(MyItem myItem) {
		return dao.moveMyItem(myItem);
	}

	public int getMyItemCount(MyItem myItem) {
		return dao.getMyItemCount(myItem);
	}

	public List<MyItem> excelDownLoad(MyItem myItem) {
		return dao.excelDownLoad(myItem);
	}
}