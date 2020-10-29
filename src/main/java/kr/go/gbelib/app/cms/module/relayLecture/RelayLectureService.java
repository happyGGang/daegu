package kr.go.gbelib.app.cms.module.relayLecture;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class RelayLectureService extends BaseService {
	
	@Autowired
	private RelayLectureDao dao;
	
	@Autowired
	@Qualifier("relayLectureStorage")
	private FileStorage relayLectureStorage;
	
	public List<RelayLecture> relayLectureList(RelayLecture relayLecture) {
		return dao.relayLectureList(relayLecture);
	}
	
	public List<RelayLecture> relayLectureUserList(RelayLecture relayLecture) {
		List<RelayLecture> relayLectureList =  dao.relayLectureUserList(relayLecture);
		
		for (RelayLecture list : relayLectureList) {
			setApplyStatus(list);
		}
		
		return relayLectureList;
		
	}
	
	public RelayLecture getRelayLecture(RelayLecture relayLecture) {
		RelayLecture getRelayLecture =  dao.getRelayLecture(relayLecture);
		
		setApplyStatus(getRelayLecture);
		
		return getRelayLecture;
	}

	private void setApplyStatus(RelayLecture relayLecture) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date now = new Date();
		Date startDate;
		Date endDate;
		try {
			now = sdf.parse(sdf.format(now));
			startDate = sdf.parse(relayLecture.getApply_start_date() + " " + relayLecture.getApply_start_time());
			endDate = sdf.parse(relayLecture.getApply_end_date() + " " + relayLecture.getApply_end_time());
			
			if (startDate.compareTo(now) > 0 && endDate.compareTo(now) > 0) {
				relayLecture.setApply_status(0);	//신청대기
			} else if (startDate.compareTo(now) <= 0 && endDate.compareTo(now) > 0) {
				if (relayLecture.getApply_count() < relayLecture.getRecruitment_number()) {
					relayLecture.setApply_status(1);	//신청하기
				} else {
					relayLecture.setApply_status(2);	//접수마감
				}
			} else if (startDate.compareTo(now) < 0 && endDate.compareTo(now) < 0) {
				relayLecture.setApply_status(3);	//신청마감
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	public int relayLectureCount(RelayLecture relayLecture) {
		return dao.relayLectureCount(relayLecture);
	}
	
	public int relayLectureUserCount(RelayLecture relayLecture) {
		return dao.relayLectureUserCount(relayLecture);
	}
	
	public int relayLectureIdx(RelayLecture relayLecture) {
		return dao.relayLectureIdx(relayLecture);
	}
	
	@Transactional
	public int addRelayLecture(RelayLecture relayLecture, MultipartHttpServletRequest mpRequest) {
		relayLecture.setLecture_idx(dao.relayLectureIdx(relayLecture));
		
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + relayLecture.getHomepage_id();
			
			File f = relayLectureStorage.addFile(mFile, realFileName, filePath);
			
			relayLecture.setServer_file_name(realFileName);
			relayLecture.setOrg_file_name(fileName);
			relayLecture.setFile_extension(fileExtension);
			relayLecture.setFile_size(f.length()); 
		} else {
			relayLecture.setOrg_file_name(null);
		}
		
		return dao.addRelayLecture(relayLecture);
	}
	
	public int modifyRelayLecture(RelayLecture relayLecture, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("org_file_name_temp");
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + relayLecture.getHomepage_id();
			
			File f = relayLectureStorage.addFile(mFile, realFileName, filePath);
			
			relayLecture.setServer_file_name(realFileName);
			relayLecture.setOrg_file_name(fileName);
			relayLecture.setFile_extension(fileExtension);
			relayLecture.setFile_size(f.length()); 
		} else {
			relayLecture.setOrg_file_name(null);
		}
		
		return dao.modifyRelayLecture(relayLecture);
	}

	public int deleteRelayLecture(RelayLecture relayLecture) {
		return dao.deleteRelayLecture(relayLecture);
	}
	
	public int statusChangeRelayLecture(RelayLecture relayLecture) {
		return dao.statusChangeRelayLecture(relayLecture);
	}
	
	public int addViewCount(RelayLecture relayLecture) {
		return dao.addViewCount(relayLecture);
	}
	
}
