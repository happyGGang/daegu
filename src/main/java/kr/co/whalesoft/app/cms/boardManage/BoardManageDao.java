package kr.co.whalesoft.app.cms.boardManage;

import java.util.List;


public interface BoardManageDao {

	public int getBoardManageCount(BoardManage boardManage);

	public List<BoardManage> getBoardManage(BoardManage boardManage);
	
	public int getBoardManageByAdminIdCount(BoardManage boardManage);
	
	public List<BoardManage> getBoardManageByAdminId(BoardManage boardManage);
	
	public BoardManage getBoardManageOne(BoardManage boardManage);
	
	public BoardManage getBoardManageOne(int manage_idx);
	
	public int addBoardManage(BoardManage boardManage);
	
	public int modifyBoardManage(BoardManage boardManage);
	
	public int modifyBoardManageByAdminId(BoardManage boardManage);
	
	public int modifyBoardAuth(BoardManage boardManage);
	
	public List<BoardManage> getBoardManageAll(BoardManage boardManage);
	
	public List<BoardManage> getBoardManageAllParam(BoardManage boardManage);
	
	public String[] getMyAdminBoardManage(String admin_id);
	
	public List<BoardManage> getThemeBookBoardManage(BoardManage boardManage);
}