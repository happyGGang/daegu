package kr.go.gbelib.app.cms.module.archive;

import java.util.List;

public interface ArchiveDao {

	int getArchiveListCmsCount(Archive archive);

	List<Archive> getArchiveListCms(Archive archive);

	Archive getArchiveOne(Archive archive);

	int addArchive(Archive archive);

	int modifyArchive(Archive archive);

	int deleteArchive(Archive archive);

	int deleteFile(Archive archive);

	int deleteImage(Archive archive);

	List<Archive> getArchiveListCmsAll(Archive archive);

	int fileCntCheck(String fileName);

	int imageFileCntCheck(String fileName);

	int codeDupCheck(Archive archive);

	int getBookIdx(Archive archive);

	List<Archive> getMainNewArchiveList();

	int getArchiveListCount(Archive archive);

	List<Archive> getArchiveList(Archive archive);

	int addViewCount(Archive archive);

	int titleCntCheck(Archive archive);

}
