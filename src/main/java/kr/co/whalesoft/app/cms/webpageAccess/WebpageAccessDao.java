package kr.co.whalesoft.app.cms.webpageAccess;

import java.util.List;
import kr.co.whalesoft.app.cms.member.Member;

public interface WebpageAccessDao {

	public int addWebpageAccess(WebpageAccess webpageAccess);

	public List<WebpageAccess> getWebpageAccessResultByAll(WebpageAccess webpageAccess);
	
	public List<WebpageAccess> getWebpageAccessResultByBrowser(WebpageAccess webpageAccess);
	
	public List<WebpageAccess> getWebpageAccessResultByOS(WebpageAccess webpageAccess);

	public List<WebpageAccess> getWebpageAccessResultByDevice(WebpageAccess webpageAccess);
	
	public String getLastWebpageAccess(Member member);
	
}