package kr.go.gbelib.app.cms.module.teach.teachCode2;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class TeachCode2Service extends BaseService {
	
	@Autowired
	private TeachCode2Dao dao;
	
	public int getCategoryListCnt(TeachCode2 cate) {
		return dao.getCategoryListCnt(cate);
	}
	
	public List<TeachCode2> getCategoryList(TeachCode2 cate) {
		return dao.getCategoryList(cate);
	}
	
	public List<TeachCode2> getCategoryWithCntList(TeachCode2 cate) {
		return dao.getCategoryWithCntList(cate);
	}
	
	public TeachCode2 getCategoryInfo(TeachCode2 cate) {
		return dao.getCategoryInfo(cate);
	}
	
	public List<TeachCode2> getSubcategories(TeachCode2 cate) {
		return dao.getSubcategories(cate);
	}
	
	public int subCategoryCheck(TeachCode2 cate) {
		return dao.subCategoryCheck(cate);
	}
	
	public int nameDupCheck(TeachCode2 cate) {
		return dao.nameDupCheck(cate);
	}
	
	@Transactional
	public int addCategory(TeachCode2 cate) {
		
		if(nameDupCheck(cate) > 0) {
			return 0;
		}
		
//		Integer depth = dao.getDepth(cate);
		
//		cate.setDepth(depth == null ? 0 : depth);
		cate.setDisplay_seq(dao.getMaxDisplaySeq(cate));
		
		return dao.addCategory(cate);
	}
	
	@Transactional
	public int modifyCategory(TeachCode2 cate) {

		if(nameDupCheck(cate) > 0) {
			return 0;
		}
		
		return dao.modifyCategory(cate);
	}
	
	@Transactional
	public int deleteCategory(TeachCode2 cate) {
		
		if(dao.subCategoryCheck(cate) > 0) {
			return 0;
		}
		
		if(getCategoryInfo(cate) ==  null) {
			return 0;
		}
		
		return dao.deleteCategory(cate);
	}
	
	@Transactional
	public int forceDeleteCategory(TeachCode2 cate) {
		
		if(getCategoryInfo(cate) ==  null) {
			return 0;
		}
		
		return dao.forceDeleteCategory(cate);
	}
	
	@Transactional
	public int saveCategoryList(TeachCode2[] cateList) {
		
		int result = 0;
		
		for(TeachCode2 cate: cateList) {
			if(getCategoryInfo(cate) == null) {
				throw new RuntimeException();
			}

			result += dao.modifyDisplaySeq(cate);
		}
		
		return result;
	}

	
}