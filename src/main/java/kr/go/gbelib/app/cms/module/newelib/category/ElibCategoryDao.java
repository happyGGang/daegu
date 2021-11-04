package kr.go.gbelib.app.cms.module.newelib.category;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper(value = "elibCategoryDaoNew")
public interface ElibCategoryDao  {

	public int getCategoryListCnt(ElibCategory cate);
	
	public List<ElibCategory> getCategoryList(ElibCategory cate);
	
	public List<ElibCategory> getCategoryWithCntList(ElibCategory cate);
	
	public ElibCategory getCategoryInfo(ElibCategory cate);
	
	public List<ElibCategory> getSubcategories(ElibCategory cate);
	
	public int subCategoryCheck(ElibCategory cate);
	
	public int nameDupCheck(ElibCategory cate);
	
	public Integer getDepth(ElibCategory cate);
	
	public int getMaxDisplaySeq(ElibCategory cate);
	
	public int addCategory(ElibCategory cate);
	
	public int modifyCategory(ElibCategory cate);
	
	public int deleteCategory(ElibCategory cate);
	
	public int forceDeleteCategory(ElibCategory cate);
	
	public int modifyDisplaySeq(ElibCategory cate);
	
	public ElibCategory getParentByName(ElibCategory cate);
	
	public ElibCategory getChildByName(ElibCategory cate);
	
	public List<ElibCategory> getStatCategoryList(ElibCategory cate);
	
}