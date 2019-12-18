package kr.co.whalesoft.app.cms.mainImg;

import java.util.List;

public interface MainImgDao  {

	public List<MainImg> getMainImgList(MainImg mainImg);
	
	public List<MainImg> getMainImgListAll(MainImg mainImg);
	
	public int getMainImgListCount(MainImg mainImg);
	
	public MainImg getMainImgOne(MainImg mainImg);
	
	public int addMainImg(MainImg mainImg);
	
	public int modifyMainImg(MainImg mainImg);
	
	public int deleteMainImg(MainImg mainImg);

	public int getNextPrintSeq(String homepage_id);
}