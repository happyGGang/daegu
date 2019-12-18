package kr.co.whalesoft.app.cms.banner;

import java.util.List;

public interface BannerDao {

	public List<Banner> getBanner(Banner banner);
	
	public List<Banner> getBannerAll(Banner banner);

	public int getBannerCount(Banner banner);
	
	public Banner getBannerOne(Banner banner);
	
	public int addBanner(Banner banner);
	
	public int modifyBanner(Banner banner);

	public int deleteBanner(Banner banner);

	public int getNextPrintSeq(String homepage_id);
	
}