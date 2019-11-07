package kr.co.whalesoft.app.cms.boardBlockIp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BoardBlockIpService extends BaseService {

	@Autowired
	private BoardBlockIpDao dao;
	
	public List<BoardBlockIp> getBoardBlockIp() {
		return dao.getBoardBlockIp();
	}
	
	public BoardBlockIp getBoardBlockIpOne(BoardBlockIp boardEditIpBlock) {
		return dao.getBoardBlockIpOne(boardEditIpBlock);
	}
	
	public int addBoardBlockIp(BoardBlockIp boardEditIpBlock) {
		return dao.addBoardBlockIp(boardEditIpBlock);
	}
	
	public int modifyBoardBlockIp(BoardBlockIp boardEditIpBlock) {
		return dao.modifyBoardBlockIp(boardEditIpBlock);
	}
	
	public int deleteBoardBlockIp(BoardBlockIp boardEditIpBlock) {
		return dao.deleteBoardBlockIp(boardEditIpBlock);
	}
	
	public int getBoardBlockIpUseCount(String userIp) {
		return dao.getBoardBlockIpUseCount(userIp);
	}
	
}