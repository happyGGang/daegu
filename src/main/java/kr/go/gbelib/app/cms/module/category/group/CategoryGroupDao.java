package kr.go.gbelib.app.cms.module.category.group;

import java.util.List;

public interface CategoryGroupDao  {

	public List<CategoryGroup> getCategoryGroupList(CategoryGroup categoryGroup);
	
	public List<CategoryGroup> getCategoryGroupListAll(CategoryGroup categoryGroup);
	
	public int getCategoryGroupListCount(CategoryGroup categoryGroup);
	
	public CategoryGroup getCategoryGroupOne(CategoryGroup categoryGroup);

	public List<CategoryGroup> getMiddleTeachCategoryGroupByLargeIdx(CategoryGroup categoryGroup);

	public int addCategoryGroup(CategoryGroup categoryGroup);
	
	public int modifyCategoryGroup(CategoryGroup categoryGroup);
	
	public int deleteCategoryGroup(CategoryGroup categoryGroup);
	
	public int getPrintMaxValue(CategoryGroup categoryGroup);
	
	public int checkCategoryInGroup(CategoryGroup categoryGroup);

	public CategoryGroup getReqLimitTotal(CategoryGroup categoryGroup);
}