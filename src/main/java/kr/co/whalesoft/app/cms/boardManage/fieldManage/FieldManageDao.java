package kr.co.whalesoft.app.cms.boardManage.fieldManage;

import java.util.List;

public interface FieldManageDao {

	public List<FieldManage> getBoardColumnInfo();
	
	public List<FieldManage> getBoardFieldManage(FieldManage fieldManage);
	
	public List<FieldManage> getBoardFieldManageByList(FieldManage fieldManage);
	
	public List<FieldManage> getBoardFieldManageByEdit(FieldManage fieldManage);
	
	public List<FieldManage> getBoardFieldManageByReply(FieldManage fieldManage);
	
	public List<FieldManage> getBoardFieldManageByView(FieldManage fieldManage);
	
	public FieldManage getBoardFieldManageOne(FieldManage fieldManage);
	
	public int addBoardFieldManage(FieldManage fieldManage);
	
	public int modifyBoardFieldManage(FieldManage fieldManage);
	
	public int deleteBoardFieldManage(FieldManage fieldManage);
	
}