package kr.go.gbelib.app.cms.module.teach.teachCode;

import java.util.List;

public interface TeachCodeDao {

	public List<TeachCode> getLargeCodeList();

	public List<TeachCode> getMidCodeList(TeachCode teachCode);

	public List<TeachCode> getSmallCodeList(TeachCode teachCode);

	public int addTeachCode(TeachCode teachCode);

	public int modifyTeachCode(TeachCode teachCode);

	public int deleteTeachCode(TeachCode teachCode);

	public int modifyPrintSeq(TeachCode code);

	public int getCodeInfo(TeachCode teachCode);
	
}
