package kr.go.gbelib.app.cms.module.category.group;

import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class CategoryGroupService extends BaseService {
	
	@Autowired
	private CategoryGroupDao categoryGroupDao;
	
	public List<CategoryGroup> getCategoryGroupListAll(CategoryGroup categoryGroup) {
		return categoryGroupDao.getCategoryGroupListAll(categoryGroup);
	}
	 
	public List<CategoryGroup> getCategoryGroupList(CategoryGroup categoryGroup) {
		return categoryGroupDao.getCategoryGroupList(categoryGroup);
	}
	
	public int getCategoryGroupListCount(CategoryGroup categoryGroup) {
		return categoryGroupDao.getCategoryGroupListCount(categoryGroup);
	}
	
	public CategoryGroup getCategoryGroupOne(CategoryGroup categoryGroup) {
		return categoryGroupDao.getCategoryGroupOne(categoryGroup);
	}

	// 중분류
	public List<CategoryGroup> getMiddleTeachCategoryGroupByLargeIdx(CategoryGroup categoryGroup) {
		return categoryGroupDao.getMiddleTeachCategoryGroupByLargeIdx(categoryGroup);
	}

	public int addCategoryGroup(CategoryGroup categoryGroup) {
		if (StringUtils.equals(categoryGroup.getReq_limit_yn(), "N")) {
			categoryGroup.setReq_limit_count(0);
			categoryGroup.setReq_limit_type("1");
		}
		return categoryGroupDao.addCategoryGroup(categoryGroup);
	}
	
	public int modifyCategoryGroup(CategoryGroup categoryGroup) {
		if (StringUtils.equals(categoryGroup.getReq_limit_yn(), "N")) {
			categoryGroup.setReq_limit_count(0);
			categoryGroup.setReq_limit_type("1");
		}
		return categoryGroupDao.modifyCategoryGroup(categoryGroup);
	}
	
	public int deleteCategoryGroup(CategoryGroup categoryGroup) {
		return categoryGroupDao.deleteCategoryGroup(categoryGroup);
	}
	
	public int getPrintMaxValue(CategoryGroup categoryGroup) {
		return categoryGroupDao.getPrintMaxValue(categoryGroup);
	}
	
	public int checkCategoryInGroup(CategoryGroup categoryGroup) {
		return categoryGroupDao.checkCategoryInGroup(categoryGroup);
	}

	public CategoryGroup getReqLimitTotal(CategoryGroup categoryGroup) {
		return categoryGroupDao.getReqLimitTotal(categoryGroup);
	}
}