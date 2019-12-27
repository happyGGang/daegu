package kr.go.gbelib.app.cms.module.pictureBook;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.apache.xpath.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class PictureBookService extends BaseService {
	
	@Autowired
	@Qualifier("pictureBookStorage")
	private FileStorage pictureBookStorage;
	
	@Autowired
	private PictureBookDao dao;

	public List<PictureBook> getPictureBookList(PictureBook pictureBook) {
		return dao.getPictureBookList(pictureBook);
	}
	
	public int getPictureBookCount(PictureBook pictureBook) {
		return dao.getPictureBookCount(pictureBook);
	}
	
	public PictureBook getPictureBookOne(PictureBook pictureBook) {
		return dao.getPictureBookOne(pictureBook);
	}

	public int addPictureBook(PictureBook pictureBook) {
		MultipartFile mFile = pictureBook.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/";

			File f = pictureBookStorage.addFile(mFile, realFileName, filePath);
			
			pictureBook.setOrg_file_name(fileName);
			pictureBook.setServer_file_name(realFileName);
			pictureBook.setFile_extension(fileExtension);
			pictureBook.setFile_size(f.length());
		}
		
		return dao.addPictureBook(pictureBook);
	}

	public int modifyPictureBook(PictureBook pictureBook) {
		MultipartFile mFile = pictureBook.getMfile();

		if ( mFile != null ) {
			String fileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String realFileName = Long.toString((System.currentTimeMillis()));
			String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath = "/";

			File f = pictureBookStorage.addFile(mFile, realFileName, filePath);

			pictureBook.setOrg_file_name(fileName);
			pictureBook.setServer_file_name(realFileName);
			pictureBook.setFile_extension(fileExtension);
			pictureBook.setFile_size(f.length());
		}
		
		return dao.modifyPictureBook(pictureBook);
	}

	public int deletePictureBook(PictureBook pictureBook) {
		int result = 0;
		if(dao.deletePictureBookLoanAll(pictureBook) > 0) {
			result = dao.deletePictureBook(pictureBook);
		};
		return result;
	}
	
	public Map<Integer, Boolean> getLoanableMonth(PictureBook pictureBook) {
		Map<Integer, Boolean> map = new HashMap<Integer, Boolean>();
		List<PictureBook> list = dao.getLoanableMonth(pictureBook);
		
		for (int i = 1; i < 12; i++) {
			boolean flag = false;
			for (int j = 0; j < list.size(); j++) {
				if(i == Integer.parseInt(list.get(j).getLoan_month())) {
					flag = true;
					list.remove(j);
					break;
				}
			}
			map.put(i, flag ? true : false);
		}
		
		return map;
	}
	
	public List<PictureBook> getPictureBookLoanList(PictureBook pictureBook) {
		return dao.getPictureBookLoanList(pictureBook);
	}
	
	public int getPictureBookLoanCount(PictureBook pictureBook) {
		return dao.getPictureBookLoanCount(pictureBook);
	}

	public int addPictureBookLoan(PictureBook pictureBook) {
		return dao.addPictureBookLoan(pictureBook);
	}
	
	public int deletePictureBookLoan(PictureBook pictureBook) {
		return dao.deletePictureBookLoan(pictureBook);
	}

	public int statusChangeAll(PictureBook pictureBook) {
		return dao.statusChangeAll(pictureBook);
	}


}
