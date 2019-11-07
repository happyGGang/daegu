package kr.co.whalesoft.app.cms.boardManage;

import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BoardManageService extends BaseService {

	@Autowired
	private BoardManageDao dao;
	
	public int getBoardManageCount(BoardManage boardManage) {
		return dao.getBoardManageCount(boardManage);
	}
	
	public List<BoardManage> getBoardManage(BoardManage boardManage) {
		return dao.getBoardManage(boardManage);
	}
	
	public int getBoardManageByAdminIdCount(BoardManage boardManage) {
		return dao.getBoardManageByAdminIdCount(boardManage);
	}
	
	public List<BoardManage> getBoardManageByAdminId(BoardManage boardManage) {
		return dao.getBoardManageByAdminId(boardManage);
	}

	public BoardManage getBoardManageOne(BoardManage boardManage) {
		return dao.getBoardManageOne(boardManage);
	}
	
	public int addBoardManage(BoardManage boardManage) {
		return dao.addBoardManage(boardManage);
	}
	
	public int modifyBoardManage(BoardManage boardManage) {
		if (!StringUtils.equals(boardManage.getBoard_type(), "NOTICE")) {
			boardManage.setPush_send_yn("N");
		}
		return dao.modifyBoardManage(boardManage);
	}
	
	public int modifyBoardManageByAdminId(BoardManage boardManage) {
		return dao.modifyBoardManageByAdminId(boardManage);
	}
	
	@Transactional
	public int modifyBoardAuth(BoardManage boardManage) {
		if(boardManage.getView_auth()==null) {
			boardManage.setView_auth("");
		}
		if(boardManage.getEdit_auth()==null) {
			boardManage.setEdit_auth("");
		}
		if(boardManage.getDelete_auth()==null) {
			boardManage.setDelete_auth("");
		}
		if(boardManage.getAdmin_auth()==null) {
			boardManage.setAdmin_auth("");
		}
		
		return dao.modifyBoardAuth(boardManage);
	}
	
	public List<BoardManage> getBoardManageAll(BoardManage boardManage) {
		return dao.getBoardManageAll(boardManage);
	}
	
	public List<BoardManage> getBoardManageAllParam(BoardManage boardManage) {
		return dao.getBoardManageAllParam(boardManage);
	}
	
	public String[] getMyAdminBoardManage(String admin_id) {
		return dao.getMyAdminBoardManage(admin_id); 
	}
	
	public List<BoardManage> getThemeBookBoardManage(BoardManage boardManage) {
		return dao.getThemeBookBoardManage(boardManage);
	}

}