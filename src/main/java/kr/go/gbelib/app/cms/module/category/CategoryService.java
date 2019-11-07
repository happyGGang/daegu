package kr.go.gbelib.app.cms.module.category;

import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class CategoryService extends BaseService {
	
	@Autowired
	private CategoryDao categoryDao;
	
	public List<Category> getCategoryListAll(Category category) {
		return categoryDao.getCategoryListAll(category);
	}
	 
	public List<Category> getCategoryList(Category category) {
		return categoryDao.getCategoryList(category);
	}
	
	public int getCategoryListCount(Category category) {
		return categoryDao.getCategoryListCount(category);
	}
	
	public Category getCategoryOne(Category category) {
		return categoryDao.getCategoryOne(category);
	}

	
	public int addCategory(Category category) {
		if (StringUtils.equals(category.getReq_limit_yn(), "N")) {
			category.setReq_limit_count(0);
			category.setReq_limit_type("1");
		}
		return categoryDao.addCategory(category);
	}
	
	public int modifyCategory(Category category) {
		if (StringUtils.equals(category.getReq_limit_yn(), "N")) {
			category.setReq_limit_count(0);
			category.setReq_limit_type("1");
		}
		return categoryDao.modifyCategory(category);
	}
	
	public int deleteCategory(Category category) {
		return categoryDao.deleteCategory(category);
	}
	
	public int getPrintMaxValue(Category category) {
		return categoryDao.getPrintMaxValue(category);
	}
	
	public int checkTeachInCategory(Category category) {
		return categoryDao.checkTeachInCategory(category);
	}

	public Category getReqLimitTotal(Category category) {
		return categoryDao.getReqLimitTotal(category);
	}
}