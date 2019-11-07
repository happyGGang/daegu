package kr.go.gbelib.app.cms.module.elib.code;

import java.util.List;

public interface ElibCodeDao {

	public List<ElibCode> getProviders();
	
	public List<ElibCode> getCompListCms(ElibCode code);
	
	public List<ElibCode> getCompWithCntListCms(ElibCode code);
	
	public List<ElibCode> getCompList(ElibCode code);
	
	public List<ElibCode> getCompWithCntList(ElibCode code);
	
	public List<ElibCode> getLibraryList();
	
	public int addComp(ElibCode code);
	
	public int modifyComp(ElibCode code);
	
	public int deleteComp(ElibCode code);
	
	public int getCompListCnt(ElibCode code);
	
	public ElibCode getComp(ElibCode code);
	
}
