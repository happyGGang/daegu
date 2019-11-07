package kr.co.whalesoft.app.homepage.sns;

public interface SNSAccessDao  {

	public int mergeTwitter(SNSAccess snsAccess);
	
	public int mergeFacebook(SNSAccess snsAccess);
	
	public int mergeKakaostory(SNSAccess snsAccess);
}