package kr.co.whalesoft.app.cms.homepage;

import java.util.List;
import kr.co.whalesoft.app.cms.member.Member;

public interface HomepageDao  {

	public List<Homepage> getHomepage();
	
	public List<Homepage> getNormalHomepage();
	
	public List<Homepage> getHomepageList(Homepage homepage);
	
	public int getHomepageListCount();
	
	public String getHomepageID();
	
	public Homepage getHomepageOne(Homepage homepage);
	
	public Homepage getHomepageOneInPath(Homepage homepage);

	public int addHomepage(Homepage homepage);
	
	public int modifyHomepage(Homepage homepage);

	public int modifyHomepageApp(Homepage homepage);
	
	public int deleteHomepage(Homepage homepage);
	
	public int modifyHomepageTemp(Homepage homepage);

	public Homepage getHomepageOneByCode(Homepage homepage);

	public List<Homepage> getMySiteList(Member member);
	
}