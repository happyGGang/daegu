package kr.go.gbelib.app.cms.module.humanBook;

import java.io.File;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.co.whalesoft.framework.utils.PagingUtils;

@Service
public class HumanBookService extends BaseService {
	
	@Autowired
	private HumanBookDao dao;
	
	@Autowired
	@Qualifier("humanBookStorage")
	private FileStorage humanBookStorage;

	public List<HumanBook> getHumanBookAll(HumanBook humanBook) {
		return dao.getHumanBookAll(humanBook);
	}

	public int getHumanBookCount(HumanBook humanBook) {
		return dao.getHumanBookCount(humanBook);
	}

	@WorkingLogger(comment="휴먼북 신청 관리 1건 조회", type="P")
	public HumanBook getHumanBookOne(HumanBook humanBook) {
		return dao.getHumanBookOne(humanBook);
	}

	public int addHumanBook(HumanBook humanBook) {
		MultipartFile mFile = humanBook.getmFile();
		
		if ( mFile != null ) {
			String serverFileName = Long.toString((System.currentTimeMillis()));
			String originFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/" + humanBook.getHomepage_id();
			
			File f = humanBookStorage.addFile(mFile, serverFileName, filePath);
			humanBook.setServer_file_name(serverFileName);
			humanBook.setOrigin_file_name(originFileName);
			humanBook.setFile_extension(fileExtension);
			humanBook.setFile_size(f.length());
		}
		
		return dao.addHumanBook(humanBook);
	}

	@WorkingLogger(comment="휴먼북 신청 관리 1건 수정", type="P", tableName = "HUMAN_BOOK")
	public int modifyHumanBook(HumanBook humanBook) {
		MultipartFile mFile = humanBook.getmFile();
		
		if ( mFile != null ) {
			String serverFileName = Long.toString((System.currentTimeMillis()));
			String originFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/" + humanBook.getHomepage_id();
			
			File f = humanBookStorage.addFile(mFile, serverFileName, filePath);
			humanBook.setServer_file_name(serverFileName);
			humanBook.setOrigin_file_name(originFileName);
			humanBook.setFile_extension(fileExtension);
			humanBook.setFile_size(f.length());
		}
		
		return dao.modifyHumanBook(humanBook);
	}

	public int applyStatus(HumanBook humanBook) {
		return dao.applyStatus(humanBook);
	}

	@WorkingLogger(comment="휴먼북 신청 관리 조회", type="P")
	public List<HumanBook> getHumanBookList(HumanBook humanBook) {
		return dao.getHumanBookList(humanBook);
	}

	public int getHumanBookListCount(HumanBook humanBook) {
		return dao.getHumanBookListCount(humanBook);
	}

	@WorkingLogger(comment="휴먼북 신청 관리 1건 삭제", type="P")
	public int deleteHumanBook(HumanBook humanBook) {
		return dao.deleteHumanBook(humanBook);
	}

}
