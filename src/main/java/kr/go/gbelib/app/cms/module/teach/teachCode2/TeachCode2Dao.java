package kr.go.gbelib.app.cms.module.teach.teachCode2;

import java.util.List;

public interface TeachCode2Dao  {

	public int getCategoryListCnt(TeachCode2 cate);
	
	public List<TeachCode2> getCategoryList(TeachCode2 cate);
	
	public List<TeachCode2> getCategoryWithCntList(TeachCode2 cate);
	
	public TeachCode2 getCategoryInfo(TeachCode2 cate);
	
	public List<TeachCode2> getSubcategories(TeachCode2 cate);
	
	public int subCategoryCheck(TeachCode2 cate);
	
	public int nameDupCheck(TeachCode2 cate);
	
	public Integer getDepth(TeachCode2 cate);
	
	public int getMaxDisplaySeq(TeachCode2 cate);
	
	public int addCategory(TeachCode2 cate);
	
	public int modifyCategory(TeachCode2 cate);
	
	public int deleteCategory(TeachCode2 cate);
	
	public int forceDeleteCategory(TeachCode2 cate);
	
	public int modifyDisplaySeq(TeachCode2 cate);
	
}