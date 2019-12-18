package kr.co.whalesoft.app.cms.news;

import java.util.List;

public interface NewsDao  {

	public List<News> getNewsList(News news);
	
	public List<News> getNewsListAll(News news);
	
	public int getNewsListCount(News news);
	
	public News getNewsOne(News news);
	
	public int addNews(News news);
	
	public int modifyNews(News news);
	
	public int deleteNews(News news);

	public int getUseCnt(News news);

	public int getNextPrintSeq(String homepage_id);
}