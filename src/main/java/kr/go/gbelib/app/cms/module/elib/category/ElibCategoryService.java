package kr.go.gbelib.app.cms.module.elib.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ElibCategoryService extends BaseService {
	
	@Autowired
	private ElibCategoryDao dao;
	
	public int getCategoryListCnt(ElibCategory cate) {
		return dao.getCategoryListCnt(cate);
	}
	
	public List<ElibCategory> getCategoryList(ElibCategory cate) {
		return dao.getCategoryList(cate);
	}
	
	public List<ElibCategory> getCategoryWithCntList(ElibCategory cate) {
		return dao.getCategoryWithCntList(cate);
	}
	
	public ElibCategory getCategoryInfo(ElibCategory cate) {
		return dao.getCategoryInfo(cate);
	}
	
	public List<ElibCategory> getSubcategories(ElibCategory cate) {
		return dao.getSubcategories(cate);
	}
	
	public int subCategoryCheck(ElibCategory cate) {
		return dao.subCategoryCheck(cate);
	}
	
	public int nameDupCheck(ElibCategory cate) {
		return dao.nameDupCheck(cate);
	}
	
	@Transactional
	public int addCategory(ElibCategory cate) {
		
		if(nameDupCheck(cate) > 0) {
			return 0;
		}
		
//		Integer depth = dao.getDepth(cate);
		
//		cate.setDepth(depth == null ? 0 : depth);
		cate.setDisplay_seq(dao.getMaxDisplaySeq(cate));
		
		return dao.addCategory(cate);
	}
	
	@Transactional
	public int modifyCategory(ElibCategory cate) {

		if(nameDupCheck(cate) > 0) {
			return 0;
		}
		
		return dao.modifyCategory(cate);
	}
	
	@Transactional
	public int deleteCategory(ElibCategory cate) {
		
		if(dao.subCategoryCheck(cate) > 0) {
			return 0;
		}
		
		if(getCategoryInfo(cate) ==  null) {
			return 0;
		}
		
		return dao.deleteCategory(cate);
	}
	
	@Transactional
	public int forceDeleteCategory(ElibCategory cate) {
		
		if(getCategoryInfo(cate) ==  null) {
			return 0;
		}
		
		return dao.forceDeleteCategory(cate);
	}
	
	@Transactional
	public int saveCategoryList(ElibCategory[] cateList) {
		
		int result = 0;
		
		for(ElibCategory cate: cateList) {
			if(getCategoryInfo(cate) == null) {
				throw new RuntimeException();
			}

			result += dao.modifyDisplaySeq(cate);
		}
		
		return result;
	}
	
	public ElibCategory getParentByName(ElibCategory cate) {
		return dao.getParentByName(cate);
	}
	
	public ElibCategory getChildByName(ElibCategory cate) {
		return dao.getChildByName(cate);
	}
	
	public List<ElibCategory> getStatCategoryList(ElibCategory cate) {
		return dao.getStatCategoryList(cate);
	}

}