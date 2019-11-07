package kr.go.gbelib.app.module.myStorage;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MyStorageService extends BaseService {

	@Autowired
	private MyStorageDao dao;

	public List<MyStorage> getMyStorageTreeList(MyStorage myStorage) {
		return dao.getMyStorageTreeList(myStorage);
	}

	public MyStorage getMyStorageOne(MyStorage myStorage) {
		return dao.getMyStorageOne(myStorage);
	}

	public int addMyStorage(MyStorage myStorage) {
		return dao.addMyStorage(myStorage);
	}

	public int modifyMyStorage(MyStorage myStorage) {
		return dao.modifyMyStorage(myStorage);
	}

	public int deleteMyStorage(MyStorage myStorage) {
		return dao.deleteMyStorage(myStorage);
	}

	public int getChildCount(MyStorage myStorage) {
		return dao.getChildCount(myStorage);
	}

	public int moveMyStorage(MyStorage myStorage) {
		return dao.moveMyStorage(myStorage);
	}

	public int getStorageCount(MyStorage myStorage) {
		return dao.getStorageCount(myStorage);
	}
}