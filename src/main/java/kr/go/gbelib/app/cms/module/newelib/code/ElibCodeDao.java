package kr.go.gbelib.app.cms.module.newelib.code;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper(value = "elibCodeDaoNew")
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
