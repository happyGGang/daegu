package kr.go.gbelib.app.cms.module.category;

import java.util.List;

public interface CategoryDao  {

	public List<Category> getCategoryList(Category category);
	
	public List<Category> getCategoryListAll(Category category);
	
	public int getCategoryListCount(Category category);
	
	public Category getCategoryOne(Category category);
	
	public int addCategory(Category category);
	
	public int modifyCategory(Category category);
	
	public int deleteCategory(Category category);
	
	public List<Category> getCategoryListByType(Category category);
	
	public int getPrintMaxValue(Category category);
	
	public int checkTeachInCategory(Category category);

	public Category getReqLimitTotal(Category category);
}