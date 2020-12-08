package kr.co.whalesoft.app.cms.news;

import java.io.File;
import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class NewsService extends BaseService {
	
	@Autowired
	@Qualifier("newsStorage")
	private FileStorage newsStorage;
	
	@Autowired
	private NewsDao newsDao;
	
	public List<News> getNewsListAll(News news) {
		return newsDao.getNewsListAll(news);
	}
	 
	public List<News> getNewsList(News news) {
		return newsDao.getNewsList(news);
	}
	
	public int getNewsListCount(News news) {
		return newsDao.getNewsListCount(news);
	}
	
	public News getNewsOne(News news) {
		return newsDao.getNewsOne(news);
	}
	
	@WorkingLogger(comment="뉴스 관리 1건 추가")
	public int addNews(News news, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
		if(mFile != null) {
			String realFileName = Long.toString(System.currentTimeMillis());
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + news.getHomepage_id();
			
			File f = newsStorage.addFile(mFile, realFileName, filePath);
			
			news.setOrg_file_name(fileName);
			news.setServer_file_name(realFileName);
			news.setFile_extension(fileExtension);
			news.setFile_size(f.length());
		}
		
		return newsDao.addNews(news);
	}

	@WorkingLogger(comment="뉴스 관리 1건 수정")
	public int modifyNews(News news, MultipartHttpServletRequest mpRequest) {
		MultipartFile mFile = mpRequest.getFileMap().get("imgFile");
		if(mFile != null) {
			String realFileName = Long.toString(System.currentTimeMillis());
			String fileName 		= mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
			String fileExtension 	= FilenameUtils.getExtension(mFile.getOriginalFilename());
			String filePath 		= "/" + news.getHomepage_id();
			
			File f = newsStorage.addFile(mFile, realFileName, filePath);
			
			news.setOrg_file_name(fileName);
			news.setServer_file_name(realFileName);
			news.setFile_extension(fileExtension);
			news.setFile_size(f.length());
		}
		
		return newsDao.modifyNews(news);
	}

	@WorkingLogger(comment="뉴스 관리 1건 삭제")
	public int deleteNews(News news) {
		News delNews = getNewsOne(news);
//		String fileName = delNews.getFile_name();
		String fileName = delNews.getOrg_file_name();
		if ( !StringUtils.isEmpty(fileName) ) {
			newsStorage.deleteFile(fileName, news.getHomepage_id());	
		}
		
		return newsDao.deleteNews(news);
	}

	public int getUseCnt(News news) {
		return newsDao.getUseCnt(news);
	}

	public int getNextPrintSeq(String homepage_id) {
		return newsDao.getNextPrintSeq(homepage_id);
	}
}