package kr.co.whalesoft.app.cms.code;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class CodeService extends BaseService {

	@Autowired
	private CodeDao dao;
	
	public List<Code> getCodeGroupTreeList(Code code) {
		return dao.getCodeGroupTreeList(code);
	}
	
	public List<Code> getCodeGroup(Code code) {
		return dao.getCodeGroup(code);
	}
	
	public Code getCodeGroupOne(Code code) {
		return dao.getCodeGroupOne(code);
	}
	
	public int addCodeGroup(Code code) {
		return dao.addCodeGroup(code);
	}
	
	public int modifyCodeGroup(Code code) {
		return dao.modifyCodeGroup(code);
	}

	public int deleteCodeGroup(Code code) {
		return dao.deleteCodeGroup(code);
	}
	
	public int getCodeCount(Code code) {
		return dao.getCodeCount(code);
	}
	
	public List<Code> getCodeList(Code code) {
		return dao.getCodeList(code);
	}
	
	public List<Code> getCode(Code code) {
		return dao.getCode(code);
	}
	
	public List<Code> getCode(String homepage_id, String group_id) {
		Code code = new Code();
		code.setHomepage_id(homepage_id);
		code.setGroup_id(group_id);
		return dao.getCode(code);
	}
	
	public Code getCodeOne(Code code) {
		return dao.getCodeOne(code);
	}
	
	public Code getCodeOne(String homepage_id, String group_id, String code_id) {
		Code code = new Code();
		code.setHomepage_id(homepage_id);
		code.setGroup_id(group_id);
		code.setCode_id(code_id);
		return dao.getCodeOne(code);
	}
	
	public int addCode(Code code) {
		return dao.addCode(code);
	}
	
	public int modifyCode(Code code) {
		return dao.modifyCode(code);
	}
	
	public int deleteCode(Code code) {
		return dao.deleteCode(code);
	}

	public int getNextPrintSeq(Code code) {
		return dao.getNextPrintSeq(code);
	}
	
}