package kr.go.gbelib.app.cms.module.archive;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.go.gbelib.app.cms.module.archive.archiveCategory.ArchiveCategory;
import kr.go.gbelib.app.cms.module.archive.archiveCategory.ArchiveCategoryService;

@Service
public class ArchiveService extends BaseService {

	@Autowired
	@Qualifier("archiveStorage")
	private FileStorage archiveStorage;

	@Autowired
	private ArchiveDao dao;
	
	@Autowired
	private ArchiveCategoryService archiveCategoryService;
	
	public int getArchiveListCmsCount(Archive archive) {
		return dao.getArchiveListCmsCount(archive);
	}

	public List<Archive> getArchiveListCms(Archive archive) {
		return dao.getArchiveListCms(archive);
	}
	
	public int getArchiveListCount(Archive archive) {
		return dao.getArchiveListCount(archive);
	}

	public Archive getArchiveOne(Archive archive) {
		return dao.getArchiveOne(archive);
	}

	public int addArchive(Archive archive) {
		MultipartFile mFile = archive.getArchive_file();

		if ( titleCntCheck(archive) > 0 ) {
			return -2;
		}
		
		if ( mFile != null ) {
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/";
			fileName = fileName + "." +fileExtension;
			if ( fileCntCheck(fileName) > 0 ) {
				return 0;
			}
			archiveStorage.addFile(mFile, fileName, filePath);

			filePath = "/data/archive/";
			archive.setFile_name(fileName);
			archive.setFile_path(filePath);
		}

		mFile = archive.getImage_archive_file();

		if ( mFile != null ) {
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/img";
			fileName = fileName + "." +fileExtension;
			if ( imageFileCntCheck(fileName) > 0 ) {
				return -1;
			}
			archiveStorage.addFile(mFile, fileName, filePath);

			filePath = "/data/archive/img/";
			archive.setImage_file_name(fileName);
			archive.setImage_file_path(filePath);
		}

		return dao.addArchive(archive);
	}

	public int fileCntCheck(String fileName) {
		return dao.fileCntCheck(fileName);
	}

	public int imageFileCntCheck(String fileName) {
		return dao.imageFileCntCheck(fileName);
	}
	
	public int titleCntCheck(Archive archive) {
		return dao.titleCntCheck(archive);
	}

	public int modifyArchive(Archive archive) {
		MultipartFile mFile = archive.getArchive_file();
		
		if ( titleCntCheck(archive) > 0 ) {
			return -2;
		}

		if ( mFile != null ) {
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/";
			fileName = fileName + "." +fileExtension;
			if ( fileCntCheck(fileName) > 0 ) {
				return 0;
			}
			archiveStorage.addFile(mFile, fileName, filePath);

			filePath = "/data/archive/";
			archive.setFile_name(fileName);
			archive.setFile_path(filePath);
		}

		mFile = archive.getImage_archive_file();

		if ( mFile != null ) {
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/img";
			fileName = fileName + "." +fileExtension;
			if ( imageFileCntCheck(fileName) > 0 ) {
				return -1;
			}
			archiveStorage.addFile(mFile, fileName, filePath);

			filePath = "/data/archive/img/";
			archive.setImage_file_name(fileName);
			archive.setImage_file_path(filePath);
		}

		return dao.modifyArchive(archive);
	}

	public int deleteArchive(Archive archive) {
		return dao.deleteArchive(archive);
	}

	public String getRootPath() {
		return archiveStorage.getRootPath();
	}

	public int deleteFile(Archive archive) {
		archive = dao.getArchiveOne(archive);
		String fileName = archive.getFile_name();
		String filePath = "";
		archiveStorage.deleteFile(fileName, filePath);
		return dao.deleteFile(archive);
	}

	public int deleteImage(Archive archive) {
		archive = dao.getArchiveOne(archive);
		String fileName = archive.getImage_file_name();
		String filePath = "img";
		archiveStorage.deleteFile(fileName, filePath);
		return dao.deleteImage(archive);
	}

	public List<Archive> getArchiveListCmsAll(Archive archive) {
		return dao.getArchiveListCmsAll(archive);
	}
	
	private String bookString(Archive archive) {
//		return String.format("1차 카테고리: %s | 2차 카테고리: %s | 3차 카테고리: %s | 제목: %s", archive.getLarge_code_name(), archive.getMid_code_name(), archive.getSmall_code_name(), archive.getTitle());
		return String.format("1차 카테고리 : %s, \"제목 : %s\"", archive.getLarge_code_name(), archive.getTitle());
	}
	
	@Transactional
	public Map<String, String> batchInsertArchiveList(List<Archive> archiveList, List<String> out, String run_mode, Member member) throws IOException {
		List<Archive> insertList = new ArrayList<Archive>();
		List<Archive> updateList = new ArrayList<Archive>();
		List<String> updateIds = new ArrayList<String>();
		int insertCount = 0;
		int updateCount = 0;
		boolean failed = false;
		Map<String, String> result = new HashMap<String, String>();
		ArchiveCategory archiveCategory = new ArchiveCategory();
		result.put("insertCount", "0");
		result.put("updateCount", "0");
		result.put("deleteCount", "0");
		result.put("approveCount", "0");
		result.put("disapproveCount", "0");
		result.put("notExistCount", "0");
		result.put("updateIds", "없음");
		result.put("deleteIds", "없음");
		result.put("notExistIds", "없음");
		
		for(Archive archive: archiveList) {
			if(dao.codeDupCheck(archive) > 0) {
				archive.setBook_idx(dao.getBookIdx(archive));
				updateList.add(archive);
			} else {
				insertList.add(archive);
			}
		}
		
		for(Archive archive : insertList) {
			//DB에는 직접 입력이 되지 않으나 bookString 메소드의 카테고리명 표시를 위한 로직
			archiveCategory = new ArchiveCategory();
			archiveCategory.setLarge_code(archive.getLarge_code());
			archive.setLarge_code_name(archiveCategoryService.getLargeCategoryCodeName(archiveCategory));
			archive.setManage_num(archive.getManage_num());
			
			if(dao.addArchive(archive) == 0) {
				out.add("삽입 실패: " + bookString(archive));
				failed = true;
				throw new RuntimeException();
//				continue;
			}
			
			
			++insertCount;
			out.add("삽입 성공: " + bookString(archive));
		}
		
		for(Archive archive: updateList) {
			//DB에는 직접 입력이 되지 않으나 bookString 메소드의 카테고리명 표시를 위한 로직
			archiveCategory = new ArchiveCategory();
			archiveCategory.setLarge_code(archive.getLarge_code());
			archive.setLarge_code_name(archiveCategoryService.getLargeCategoryCodeName(archiveCategory));
			
			archive.setModify_id(member.getMember_id());
			
			if(dao.modifyArchive(archive) == 0) {
				out.add("수정 실패: " + bookString(archive));
				failed = true;
				throw new RuntimeException();
//				continue;
			}
			
			++updateCount;
			updateIds.add(String.valueOf(archive.getBook_idx()));
			out.add("수정 성공: " + bookString(archive));
		}
		
		if(!StringUtils.equals(run_mode, "DEPLOY")) throw new RuntimeException("테스트 모드");

		if(failed) throw new RuntimeException();
		
		result.put("insertCount", String.valueOf(insertCount));
		result.put("updateCount", String.valueOf(updateCount));
		result.put("updateIds", StringUtils.join(updateIds, ", "));
		
		return result;
	}
	
	@Transactional
	public Map<String, String> batchDeleteArchiveList(List<Archive> archiveList, List<String> out, String run_mode) throws IOException {
		List<Archive> deleteList = new ArrayList<Archive>();
		List<Archive> notExistList = new ArrayList<Archive>();
		List<String> deleteIds = new ArrayList<String>();
		List<String> notExistIds = new ArrayList<String>();
		int deleteCount = 0;
		int notExistCount = 0;
		boolean failed = false;
		Map<String, String> result = new HashMap<String, String>();
		ArchiveCategory archiveCategory = new ArchiveCategory();
		result.put("insertCount", "0");
		result.put("updateCount", "0");
		result.put("deleteCount", "0");
		result.put("approveCount", "0");
		result.put("disapproveCount", "0");
		result.put("notExistCount", "0");
		result.put("updateIds", "없음");
		result.put("deleteIds", "없음");
		result.put("notExistIds", "없음");
		
		for(Archive archive: archiveList) {
			archiveCategory = new ArchiveCategory();
			archiveCategory.setLarge_code(archive.getLarge_code());
			archive.setLarge_code_name(archiveCategoryService.getLargeCategoryCodeName(archiveCategory));
			
			if(dao.codeDupCheck(archive) > 0) {
//				if("WEB".equals(book.getType())) {
//					if(dao.elearningCodeDupCheck(book) > 0) {
//						book.setBook_idx(dao.getBookIdx(book));
//						deleteList.add(book);
//					} else {
//						notExistList.add(book);
//					}
//				} else {
					archive.setBook_idx(dao.getBookIdx(archive));
					deleteList.add(archive);
//				}
			} else {
				notExistList.add(archive);
			}
		}
		
		for(Archive archive: deleteList) {
			if(dao.deleteArchive(archive) == 0) {
//				out.add("삭제 실패: " + bookString(book));
//				failed = true;
//				throw new RuntimeException();
////				continue;
			}
			
			++deleteCount;
			deleteIds.add(String.valueOf(archive.getBook_idx()));
			out.add("삭제 성공: " + bookString(archive));
		}
		
		for(Archive archive: notExistList) {
			++notExistCount;
			notExistIds.add(String.valueOf(archive.getBook_idx()));
			out.add("삭제 자료 없음: " + bookString(archive));
		}
		
		if(!StringUtils.equals(run_mode, "DEPLOY")) throw new RuntimeException("테스트 모드");

		if(failed) throw new RuntimeException();
		
		result.put("deleteCount", String.valueOf(deleteCount));
		result.put("notExistCount", String.valueOf(notExistCount));
		result.put("deleteIds", StringUtils.join(deleteIds, ", "));
		result.put("notExistIds", StringUtils.join(notExistIds, ", "));
		
		return result;
	}

	public List<Archive> getMainNewArchiveList() {
		return dao.getMainNewArchiveList();
	}

	public List<Archive> getArchiveList(Archive archive) {
		return dao.getArchiveList(archive);
	}

	public int addViewCount(Archive archive) {
		return dao.addViewCount(archive);
	}

}
