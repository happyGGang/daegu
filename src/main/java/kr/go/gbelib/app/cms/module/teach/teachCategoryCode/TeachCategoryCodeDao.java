package kr.go.gbelib.app.cms.module.teach.teachCategoryCode;

import java.util.List;

public interface TeachCategoryCodeDao {
	
	/*** CODE_GROUP ***/
	public List<TeachCategoryCode> getCodeGroup();
	
	public TeachCategoryCode getCodeGroupOne(TeachCategoryCode code);
	
	public int addCodeGroup(TeachCategoryCode code);

	public int modifyCodeGroup(TeachCategoryCode code);
	
	/*** CODE ***/
	public List<TeachCategoryCode> getCodeUnion(String group_id);
	
	public List<TeachCategoryCode> getCode(String group_id);
	
	public List<TeachCategoryCode> getCode(TeachCategoryCode code);
	
	public TeachCategoryCode getCodeOne(TeachCategoryCode code);
	
	public int addCode(TeachCategoryCode code);
	
	public int modifyCode(TeachCategoryCode code);
	
	public String getCodeName(String code_id);

	public TeachCategoryCode getRootGroupOne(TeachCategoryCode code);

	public int addRootGroupCode(TeachCategoryCode code);

	public int modifyRootGroupCode(TeachCategoryCode code);

	public List<TeachCategoryCode> getRootGroup();

	public List<TeachCategoryCode> getMiddleGroup();

	public TeachCategoryCode getMiddleGroupOne(TeachCategoryCode code);

	public List<TeachCategoryCode> getCode(String group_id, String code_id);

}
