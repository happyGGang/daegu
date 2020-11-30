package kr.go.gbelib.app.cms.module.bestPracticesContest;

import java.io.File;
import java.util.List;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class BestPracticesContestService extends BaseService {
	
	@Autowired
	private BestPracticesContestDao dao;
	
	@Autowired
	@Qualifier("bestPracticesContestStorage")
	private FileStorage bestPracticesContestStorage;

	public List<BestPracticesContest> bestPracticesContestList(BestPracticesContest bestPracticesContest) {
		bestPracticesContest.setPassword(decBase64(bestPracticesContest.getPassword()));
		return dao.bestPracticesContestList(bestPracticesContest);
	}
	
	public List<BestPracticesContest> getExcelList(BestPracticesContest bestPracticesContest) {
		return dao.getExcelList(bestPracticesContest);
	}
	
	public BestPracticesContest getBestPracticesContest(BestPracticesContest bestPracticesContest) {
		bestPracticesContest.setPassword(decBase64(bestPracticesContest.getPassword()));
		return dao.getBestPracticesContest(bestPracticesContest);
		
	}
	
	public int bestPracticesContestCount(BestPracticesContest bestPracticesContest) {
		return dao.bestPracticesContestCount(bestPracticesContest);
		
	}

	@Transactional
	public int addBestPracticesContest(BestPracticesContest bestPracticesContest, MultipartHttpServletRequest mpRequest) {
		bestPracticesContest.setPassword(encBase64(bestPracticesContest.getPassword()));
		multipartFile(bestPracticesContest, mpRequest);
		return dao.addBestPracticesContest(bestPracticesContest);
	}

	@Transactional
	public int modifyBestPracticesContest(BestPracticesContest bestPracticesContest, MultipartHttpServletRequest mpRequest) {
		bestPracticesContest.setPassword(encBase64(bestPracticesContest.getPassword()));
		multipartFile(bestPracticesContest, mpRequest);
		return dao.modifyBestPracticesContest(bestPracticesContest);
	}

	public int deleteBestPracticesContest(BestPracticesContest bestPracticesContest) {
		return dao.deleteBestPracticesContest(bestPracticesContest);
	}
	
	public int addViewCount(BestPracticesContest bestPracticesContest) {
		return dao.addViewCount(bestPracticesContest);
	}
	
	private void multipartFile(BestPracticesContest bestPracticesContest, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");
		MultipartFile mFile2 = mpRequest.getFileMap().get("org_file_name_temp2");
		MultipartFile mFile3 = mpRequest.getFileMap().get("org_file_name_temp3");
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + bestPracticesContest.getHomepage_id();
			
			File f = bestPracticesContestStorage.addFile(mFile, realFileName, filePath);
			
			bestPracticesContest.setServer_file_name(realFileName);
			bestPracticesContest.setOrg_file_name(fileName);
			bestPracticesContest.setFile_extension(fileExtension);
			bestPracticesContest.setFile_size(f.length()); 
		} else {
			bestPracticesContest.setOrg_file_name(null);
		}
		if ( mFile2 != null ) {
			String realFileName2 	= Long.toString((System.currentTimeMillis()));
			String fileName2		= mFile2.getOriginalFilename().substring(0, mFile2.getOriginalFilename().lastIndexOf("."));
			String fileExtension2	= FilenameUtils.getExtension(mFile2.getOriginalFilename());
			String filePath2		= "/" + bestPracticesContest.getHomepage_id();
			
			File f2 = bestPracticesContestStorage.addFile(mFile2, realFileName2, filePath2);
			
			bestPracticesContest.setServer_file_name2(realFileName2);
			bestPracticesContest.setOrg_file_name2(fileName2);
			bestPracticesContest.setFile_extension2(fileExtension2);
			bestPracticesContest.setFile_size2(f2.length()); 
		} else {
			bestPracticesContest.setOrg_file_name2(null);
		}
		if ( mFile3 != null ) {
			String realFileName3 	= Long.toString((System.currentTimeMillis()));
			String fileName3		= mFile3.getOriginalFilename().substring(0, mFile3.getOriginalFilename().lastIndexOf("."));
			String fileExtension3	= FilenameUtils.getExtension(mFile3.getOriginalFilename());
			String filePath3		= "/" + bestPracticesContest.getHomepage_id();
			
			File f3 = bestPracticesContestStorage.addFile(mFile3, realFileName3, filePath3);
			
			bestPracticesContest.setServer_file_name3(realFileName3);
			bestPracticesContest.setOrg_file_name3(fileName3);
			bestPracticesContest.setFile_extension3(fileExtension3);
			bestPracticesContest.setFile_size3(f3.length()); 
		} else {
			bestPracticesContest.setOrg_file_name3(null);
		}
	}
	
	public String getRootPath() {
		return bestPracticesContestStorage.getRootPath();
	}
	
	public int deleteFile(BestPracticesContest bestPracticesContest) {
		bestPracticesContest = dao.getBestPracticesContest(bestPracticesContest);
		String fileName = bestPracticesContest.getServer_file_name();
		String filePath = bestPracticesContest.getHomepage_id();
		bestPracticesContestStorage.deleteFile(fileName, filePath);
		return dao.deleteFile(bestPracticesContest);
	}
	
	public int deleteFile2(BestPracticesContest bestPracticesContest) {
		bestPracticesContest = dao.getBestPracticesContest(bestPracticesContest);
		String fileName = bestPracticesContest.getServer_file_name2();
		String filePath = bestPracticesContest.getHomepage_id();
		bestPracticesContestStorage.deleteFile(fileName, filePath);
		return dao.deleteFile2(bestPracticesContest);
	}
	
	public int deleteFile3(BestPracticesContest bestPracticesContest) {
		bestPracticesContest = dao.getBestPracticesContest(bestPracticesContest);
		String fileName = bestPracticesContest.getServer_file_name3();
		String filePath = bestPracticesContest.getHomepage_id();
		bestPracticesContestStorage.deleteFile(fileName, filePath);
		return dao.deleteFile3(bestPracticesContest);
	}
	
	private String encBase64(String s) {
		String returnFormatter = "";
		if (StringUtils.isEmpty(s)) {
			return returnFormatter;
		}
		
		byte[] hash = Base64.encodeBase64(s.getBytes());

        returnFormatter = new String(hash);
        
        return returnFormatter;
	}
	
	private String decBase64(String s) {
		if (StringUtils.isEmpty(s)) {
			return "";
		}
		byte[] decodeBase64 = Base64.decodeBase64(s);
		return new String(decodeBase64);
		
	}
	
}
