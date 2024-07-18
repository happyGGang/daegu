package kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@Service
public class CheckInOutSurveyQuestionService extends BaseService {

	@Autowired
	@Qualifier("checkInOutSurveyStorage")
	private FileStorage checkInOutSurveyStorage;

	@Autowired
	private CheckInOutSurveyQuestionDao checkInOutSurveyQuestionDao;
	
	public List<CheckInOutSurveyQuestion> getQuizQuestionList(CheckInOutSurveyQuestion checkInOutSurveyQuestion) {
		return checkInOutSurveyQuestionDao.getQuizQuestionList(checkInOutSurveyQuestion);
	}
	
	public int addQuizQuestion(CheckInOutSurveyQuestion checkInOutSurveyQuestion) {

		MultipartFile mFile = checkInOutSurveyQuestion.getCheckinout_survey_file();

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + checkInOutSurveyQuestion.getHomepage_id();

			File f = checkInOutSurveyStorage.addFile(mFile, realFileName, filePath);

			checkInOutSurveyQuestion.setServer_file_name(realFileName);
			checkInOutSurveyQuestion.setOrigin_file_name(fileName);
			checkInOutSurveyQuestion.setFile_extension(fileExtension);
			checkInOutSurveyQuestion.setFile_size(f.length());
		}

		return checkInOutSurveyQuestionDao.addQuizQuestion(checkInOutSurveyQuestion);
	}
	
	public int modifyQuizQuestion(CheckInOutSurveyQuestion checkInOutSurveyQuestion) {

		MultipartFile mFile = checkInOutSurveyQuestion.getCheckinout_survey_file();

		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + checkInOutSurveyQuestion.getHomepage_id();

			File f = checkInOutSurveyStorage.addFile(mFile, realFileName, filePath);

			checkInOutSurveyQuestion.setServer_file_name(realFileName);
			checkInOutSurveyQuestion.setOrigin_file_name(fileName);
			checkInOutSurveyQuestion.setFile_extension(fileExtension);
			checkInOutSurveyQuestion.setFile_size(f.length());
		}

		return checkInOutSurveyQuestionDao.modifyQuizQuestion(checkInOutSurveyQuestion);
	}
	
	public int deleteQuizQuestion(CheckInOutSurveyQuestion checkInOutSurveyQuestion) {
		return checkInOutSurveyQuestionDao.deleteQuizQuestion(checkInOutSurveyQuestion);
	}

	public int deleteFile(CheckInOutSurveyQuestion checkInOutSurveyQuestion) {
		checkInOutSurveyQuestion = checkInOutSurveyQuestionDao.getCheckInOutSurveyQuestionOne(checkInOutSurveyQuestion);

		String fileName = checkInOutSurveyQuestion.getServer_file_name();
		String filePath = checkInOutSurveyQuestion.getHomepage_id();

		checkInOutSurveyStorage.deleteFile(fileName, filePath);

		return checkInOutSurveyQuestionDao.deleteFile(checkInOutSurveyQuestion);
	}
}