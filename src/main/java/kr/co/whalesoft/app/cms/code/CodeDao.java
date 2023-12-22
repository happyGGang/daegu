package kr.co.whalesoft.app.cms.code;

import java.util.List;

public interface CodeDao {

	public List<Code> getCodeGroupTreeList(Code code);
	
	public List<Code> getCodeGroup(Code code);
	
	public Code getCodeGroupOne(Code code);

	public int addCodeGroup(Code code);
	
	public int modifyCodeGroup(Code code);

	public int deleteCodeGroup(Code code);
	
	public int getCodeCount(Code code);
	
	public List<Code> getCode(Code code);
	
	public List<Code> getCodeList(Code code);
	
	public Code getCodeOne(Code code);
	
	public int addCode(Code code);
	
	public int modifyCode(Code code);
	
	public int deleteCode(Code code);

	public int getNextPrintSeq(Code code);

	public String getCodeId(Code code);
	
}