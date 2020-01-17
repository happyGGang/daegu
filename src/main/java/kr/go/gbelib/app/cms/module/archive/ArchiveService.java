package kr.go.gbelib.app.cms.module.archive;

import java.io.File;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class ArchiveService extends BaseService {

	@Autowired
	private ArchiveDao dao;
	
	@Autowired
	@Qualifier("archiveStorage")
	private FileStorage storage;
	
	public int getArchiveBookCount(Archive archive) {
		return dao.getArchiveBookCount(archive);
	}
	
	public List<Archive> getArchiveBookList(Archive archive) {
		return dao.getArchiveBookList(archive);
	}
	
	public List<Archive> getArchiveBookListCms(Archive archive) {
		return dao.getArchiveBookListCms(archive);
	}
	
	public Archive getArchiveBook(Archive archive) {
		return dao.getArchiveBook(archive);
	}
	
	public int addArchiveBook(Archive archive) {
		return dao.addArchiveBook(archive);
	}
	
	public int modArchiveBook(Archive archive) {
		return dao.modArchiveBook(archive);
	}

	@Transactional
	public int delArchiveBook(Archive archive) {
		String path = storage.getRootPath() + "/" + archive.getHomepage_id() + "/" + archive.getBook_idx();
		FileUtils.deleteQuietly(new File(path));
		dao.delArchiveBookPages(archive);
		return dao.delArchiveBook(archive);
	}
	
	public int reorderArchiveBook(Archive archive) {
		return dao.reorderArchiveBook(archive);
	}
	
	public int getArchivePageCount(Archive archive) {
		return dao.getArchivePageCount(archive);
	}
	
	public List<Archive> getArchivePageListCms(Archive archive) {
		return dao.getArchivePageListCms(archive);
	}
	
	public List<Archive> getArchivePageList(Archive archive) {
		return dao.getArchivePageList(archive);
	}
	
	public Archive getArchivePage(Archive archive) {
		return dao.getArchivePage(archive);
	}
	
	private void saveFile(Archive archive) {
		MultipartFile mFile = archive.getFile();
		
		if(mFile != null) {
			String dir = "/" + archive.getHomepage_id() + "/" + archive.getBook_idx();
			String filename = mFile.getOriginalFilename();
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String serverFilename 	= storage.generateUniqueFileName(storage.getRootPath() + dir) + "." + fileExtension;

			File f = storage.addFile(mFile, serverFilename, dir);

			archive.setOrg_file_name(filename);
			archive.setServer_file_name(serverFilename);
		}
	}
	
	private void deleteFile(Archive archive) {
		archive = dao.getArchivePage(archive);
		String path = storage.getRootPath() + "/" + archive.getHomepage_id() + "/" + archive.getBook_idx() + "/" + archive.getServer_file_name();
		FileUtils.deleteQuietly(new File(path));
	}
	
	public int addArchivePage(Archive archive) {
		saveFile(archive);
		return dao.addArchivePage(archive);
	}
	
	@Transactional
	public int modArchivePage(Archive archive) {
		if(archive.getFile() != null) {
			Archive tmp = dao.getArchivePage(archive);
			deleteFile(tmp);
			saveFile(archive);
			dao.modArchivePageFile(archive);
		}
		return dao.modArchivePage(archive);
	}
	
	@Transactional
	public int delArchivePage(Archive archive) {
		int result = 0;
		
		if("BATCH".equals(archive.getEditMode()) && archive.getPage_idx_list() != null) {
			for(String page_idx: archive.getPage_idx_list().split(",")) {
				archive.setPage_idx(Integer.parseInt(page_idx));
				delArchivePageFile(archive);
				result += dao.delArchivePage(archive);
			}
		} else {
			delArchivePageFile(archive);
			result = dao.delArchivePage(archive);
		}
		
		return result;
	}
	
	public int delArchivePageFile(Archive archive) {
		deleteFile(archive);
		archive.setServer_file_name(null);
		archive.setOrg_file_name(null);
		return dao.modArchivePageFile(archive);
	}
	
	public int moveUpArchivePage(Archive archive) {
		Archive higher = dao.getHigherArchivePage(archive);

		if(higher == null) {
			return 0;
		} else {
			swapOrder(higher, archive);
			return 1;
		}
	}

	public int moveDownArchivePage(Archive archive) {
		Archive lower = dao.getLowerArchivePage(archive);
		
		if(lower == null) {
			return 0;
		} else {
			swapOrder(lower, archive);
			return 1;
		}
	}
	
	@Transactional
	private void swapOrder(Archive archive1, Archive archive2) {
		int tmp = archive1.getCode();
		archive1.setCode(archive2.getCode());
		dao.modCode(archive1);
		archive2.setCode(tmp);
		dao.modCode(archive2);
	}
	
}
