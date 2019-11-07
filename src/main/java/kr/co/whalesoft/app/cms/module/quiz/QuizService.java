package kr.co.whalesoft.app.cms.module.quiz;

import java.io.File;
import java.util.List;

import kr.co.whalesoft.app.cms.module.quizReq.QuizReq;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class QuizService extends BaseService {
	
	@Autowired
	private QuizDao dao;
	
	@Autowired
	@Qualifier("quizStorage")
	private FileStorage quizStorage;
	
	public List<Quiz> getQuizListAll(Quiz quiz) {
		return dao.getQuizListAll(quiz);
	}
	 
	public List<Quiz> getQuizList(Quiz quiz) {
		return dao.getQuizList(quiz);
	}
	
	public int getQuizListCount(Quiz quiz) {
		return dao.getQuizListCount(quiz);
	}
	
	public Quiz getQuizOne(Quiz quiz) {
		return dao.getQuizOne(quiz);
	}
	
	public int addQuiz(Quiz quiz) {
		MultipartFile mFile = quiz.getImg_file_tmp();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + quiz.getHomepage_id();
			
			File f = quizStorage.addFile(mFile, realFileName, filePath);
			
			quiz.setReal_file_name(realFileName);
			quiz.setImg_file_name(fileName);
			quiz.setFile_extension(fileExtension);
			quiz.setFile_size(f.length()); 
		} 
		
		return dao.addQuiz(quiz);
	}
	
	public int modifyQuiz(Quiz quiz) {
		MultipartFile mFile = quiz.getImg_file_tmp();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + quiz.getHomepage_id();
			
			File f = quizStorage.addFile(mFile, realFileName, filePath);
			
			quiz.setReal_file_name(realFileName);
			quiz.setImg_file_name(fileName);
			quiz.setFile_extension(fileExtension);
			quiz.setFile_size(f.length()); 
		}
		
		return dao.modifyQuiz(quiz);
	}
	
	public int deleteQuiz(Quiz quiz) {
		return dao.deleteQuiz(quiz);
	}
	
	public Quiz getQuizUser(Quiz quiz) {
		return dao.getQuizUser(quiz);
	}

	public int getAreadyQuizOne(Quiz quiz) {
		return dao.getAreadyQuizOne(quiz);
	}
	
	public int getQuizCntOfValidDate(QuizReq quizReq) {
		return dao.getQuizCntOfValidDate(quizReq);
	}
	
	public int increaseSelectCnt(Quiz quiz) {
		return dao.increaseSelectCnt(quiz);
	}
	
}