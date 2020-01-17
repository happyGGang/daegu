package kr.go.gbelib.app.cms.module.archive;

import java.util.List;

public interface ArchiveDao {
	
	public int getArchiveBookCount(Archive archive);
	
	public List<Archive> getArchiveBookList(Archive archive);
	
	public List<Archive> getArchiveBookListCms(Archive archive);
	
	public Archive getArchiveBook(Archive archive);
	
	public int addArchiveBook(Archive archive);
	
	public int modArchiveBook(Archive archive);
	
	public int delArchiveBook(Archive archive);
	
	public int delArchiveBookPages(Archive archive);
	
	public int reorderArchiveBook(Archive archive);

	public int getArchivePageCount(Archive archive);
	
	public List<Archive> getArchivePageList(Archive archive);
	
	public List<Archive> getArchivePageListCms(Archive archive);
	
	public Archive getArchivePage(Archive archive);
	
	public int addArchivePage(Archive archive);
	
	public int modArchivePage(Archive archive);
	
	public int delArchivePage(Archive archive);
	
	public int modArchivePageFile(Archive archive);
	
	public Archive getLowerArchivePage(Archive archive);
	
	public Archive getHigherArchivePage(Archive archive);
	
	public int modCode(Archive archive);
	
}
