package kr.go.gbelib.app.module.myStorage;

import java.util.List;

public interface MyStorageDao {

	public List<MyStorage> getMyStorageTreeList(MyStorage myStorage);

	public MyStorage getMyStorageOne(MyStorage myStorage);
	
	public int addMyStorage(MyStorage myStorage);
	
	public int modifyMyStorage(MyStorage myStorage);
	
	public int deleteMyStorage(MyStorage myStorage);

	public int getChildCount(MyStorage myStorage);

	public int moveMyStorage(MyStorage myStorage);
	
	public int getStorageCount(MyStorage myStorage);
}