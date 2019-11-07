package kr.co.whalesoft.app.cms.site;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SiteService extends BaseService {
	
	@Autowired
	private SiteDao siteDao;
	
	public List<Site> getSiteListAll(Site site) {
		return siteDao.getSiteListAll(site);
	}
	 
	public List<Site> getSiteList(Site site) {
		return siteDao.getSiteList(site);
	}
	
	public int getSiteListCount(Site site) {
		return siteDao.getSiteListCount(site);
	}
	
	public Site getSiteOne(Site site) {
		return siteDao.getSiteOne(site);
	}
	
	public int addSite(Site site) {
		/*MultipartFile mFile = site.getFile();
		
		if ( mFile != null ) {
			File f = siteStorage.addFile(mFile, mFile.getOriginalFilename(), site.getHomepage_id());
			site.setFile_name(f.getName());
		}*/
		
		return siteDao.addSite(site);
	}
	
	public int modifySite(Site site) {
		/*MultipartFile mFile = site.getFile();
		
		if ( mFile != null ) {
			siteStorage.deleteFile(site.getFile_name(), site.getHomepage_id());
			
			File f = siteStorage.addFile(mFile, mFile.getOriginalFilename(), site.getHomepage_id());
			site.setFile_name(f.getName());
		}*/
		
		return siteDao.modifySite(site);
	}
	
	public int deleteSite(Site site) {
		/*Site delSite = getSiteOne(site);
		String fileName = delSite.getFile_name();
		if ( !StringUtils.isEmpty(fileName) ) {
			siteStorage.deleteFile(fileName, site.getHomepage_id());	
		}*/
		
		return siteDao.deleteSite(site);
	}
}