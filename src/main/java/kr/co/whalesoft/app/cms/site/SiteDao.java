package kr.co.whalesoft.app.cms.site;

import java.util.List;

public interface SiteDao  {

	public List<Site> getSiteList(Site site);
	
	public List<Site> getSiteListAll(Site site);
	
	public int getSiteListCount(Site site);
	
	public Site getSiteOne(Site site);
	
	public int addSite(Site site);
	
	public int modifySite(Site site);
	
	public int deleteSite(Site site);
}