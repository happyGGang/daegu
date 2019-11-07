package kr.co.whalesoft.app.cms.boardManage.fieldManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class FieldManageService extends BaseService {

	@Autowired
	private FieldManageDao dao;
	
	public List<FieldManage> getBoardColumnInfo() {
		return dao.getBoardColumnInfo();
	}
	
	public List<FieldManage> getBoardFieldManage(FieldManage fieldManage) {
		return dao.getBoardFieldManage(fieldManage);
	}
	
	public List<FieldManage> getBoardFieldManageByList(FieldManage fieldManage) {
		return dao.getBoardFieldManageByList(fieldManage);
	}
	
	public List<FieldManage> getBoardFieldManageByEdit(FieldManage fieldManage) {
		return dao.getBoardFieldManageByEdit(fieldManage);
	}
	
	public List<FieldManage> getBoardFieldManageByReply(FieldManage fieldManage) {
		return dao.getBoardFieldManageByReply(fieldManage);
	}
	
	public List<FieldManage> getBoardFieldManageByView(FieldManage fieldManage) {
		return dao.getBoardFieldManageByView(fieldManage);
	}
	
	public FieldManage getBoardFieldManageOne(FieldManage fieldManage) {
		return dao.getBoardFieldManageOne(fieldManage);
	}
	
	public int addBoardFieldManage(FieldManage fieldManage) {
		return dao.addBoardFieldManage(fieldManage);
	}
	
	public int modifyBoardFieldManage(FieldManage fieldManage) {
		return dao.modifyBoardFieldManage(fieldManage);
	}
	
	public int deleteBoardFieldManage(FieldManage fieldManage) {
		return dao.deleteBoardFieldManage(fieldManage);
	}

}