package kr.co.whalesoft.app.cms.boardBlockIp;

import java.util.List;

public interface BoardBlockIpDao {

	public List<BoardBlockIp> getBoardBlockIp();
	
	public BoardBlockIp getBoardBlockIpOne(BoardBlockIp boardBlockIp);
	
	public int addBoardBlockIp(BoardBlockIp boardBlockIp);
	
	public int modifyBoardBlockIp(BoardBlockIp boardBlockIp);
	
	public int deleteBoardBlockIp(BoardBlockIp boardBlockIp);
	
	public int getBoardBlockIpUseCount(String userIp);
	
}