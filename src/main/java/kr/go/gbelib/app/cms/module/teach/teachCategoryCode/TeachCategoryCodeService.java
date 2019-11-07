package kr.go.gbelib.app.cms.module.teach.teachCategoryCode;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class TeachCategoryCodeService extends BaseService {

	@Autowired
	private TeachCategoryCodeDao dao;
	
	/*** CODE_GROUP ***/
	public List<TeachCategoryCode> getCodeGroup() {
		return dao.getCodeGroup();
	}
	
	public TeachCategoryCode getCodeGroupOne(TeachCategoryCode code) {
		return dao.getCodeGroupOne(code);
	}
	
	public int addCodeGroup(TeachCategoryCode code) {
		return dao.addCodeGroup(code);
	}
	
	public int modifyCodeGroup(TeachCategoryCode code) {
		return dao.modifyCodeGroup(code);
	}
	
	/*** CODE ***/
	public List<TeachCategoryCode> getCodeUnion(String group_id) {
		return dao.getCodeUnion(group_id);
	}
	
	public List<TeachCategoryCode> getCode(String group_id) {
		return dao.getCode(group_id);
	}
	
	public List<TeachCategoryCode> getCode(String group_id, String code_id) {
		TeachCategoryCode code = new TeachCategoryCode();
		code.setTeach_group_id(group_id);
		code.setTeach_code_id(code_id);
		return dao.getCode(code);
	}
	
	public String getCodeToString(String group_id) {
		List<TeachCategoryCode> codeList = dao.getCode(group_id);
		StringBuffer sb = new StringBuffer("");
		for (int i = 0; i < codeList.size(); i++) {
			sb.append(codeList.get(i).getTeach_code_id());
			sb.append(":");
			sb.append(codeList.get(i).getTeach_code_name());
			if (i != codeList.size()-1) {
				sb.append(";");
			}
		}
		return sb.toString();
	}
	
	public List<TeachCategoryCode> getCode(TeachCategoryCode code) {
		return dao.getCode(code);
	}
	
	public TeachCategoryCode getCodeOne(TeachCategoryCode code) {
		return dao.getCodeOne(code);
	}
	
	@Transactional
	public int addCode(TeachCategoryCode code) {
		return dao.addCode(code);
	}
	
	@Transactional
	public int modifyCode(TeachCategoryCode code) {
		return dao.modifyCode(code);
	}
	
	public TeachCategoryCode getRootGroupOne(TeachCategoryCode code) {
		return dao.getRootGroupOne(code);
	}

	public int addRootGroupCode(TeachCategoryCode code) {
		return dao.addRootGroupCode(code);
	}

	public int modifyRootGroupCode(TeachCategoryCode code) {
		return dao.modifyRootGroupCode(code);
	}

	public List<TeachCategoryCode> getRootGroup() {
		return dao.getRootGroup();
	}

	public List<TeachCategoryCode> getMiddleGroup() {
		return dao.getMiddleGroup();
	}
	
	public TeachCategoryCode getMiddleGroupOne(TeachCategoryCode code) {
		return dao.getMiddleGroupOne(code);
	}
	
	public String getCodeName(String code_id) {
		return dao.getCodeName(code_id);
	}
}