package kr.go.gbelib.app.cms.module.archive.archiveCategory;

import java.util.List;

import kr.go.gbelib.app.cms.module.archive.Archive;

public interface ArchiveCategoryDao {

	List<ArchiveCategory> getLargeCategoryList();

	List<ArchiveCategory> getMidCategoryList(ArchiveCategory archiveCategory);

	List<ArchiveCategory> getSmallCategoryList(ArchiveCategory archiveCategory);

	int getCategoryInfo(ArchiveCategory archiveCategory);

	int addArchiveCategory(ArchiveCategory archiveCategory);

	int modifyArchiveCategory(ArchiveCategory archiveCategory);

	int deleteArchiveCategory(ArchiveCategory archiveCategory);

	int modifyPrintSeq(ArchiveCategory code);

	int childCheck(ArchiveCategory one);

	int getCategoryInfoByName(ArchiveCategory archiveCategory);

	int getLargeCategoryCnt(ArchiveCategory archiveCategory);

	int getMidCategoryCnt(ArchiveCategory archiveCategory);

	int getSmallCategoryCnt(ArchiveCategory archiveCategory);

	String getLargeCategoryCodeId(ArchiveCategory archiveCategory);

	String getMidCategoryCodeId(ArchiveCategory archiveCategory);

	String getSmallCategoryCodeId(ArchiveCategory archiveCategory);

	int checkAlreadyDeleted(ArchiveCategory archiveCategory);

	int realDeleteArchiveCategory(ArchiveCategory archiveCategory);

	int archiveDataCheck(Archive archive);

	String getLargeCategoryCodeName(ArchiveCategory archiveCategory);

	String getMidCategoryCodeName(ArchiveCategory archiveCategory);

	String getSmallCategoryCodeName(ArchiveCategory archiveCategory);

}
