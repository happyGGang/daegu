package kr.go.gbelib.app.cms.module.elib.member;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

public interface ElibMemberDao {

	public ElibMember getMemberById(ElibMember member);
	
	public int addMember(ElibMember member);
	
	public int modifyMember(ElibMember member);
	
	public List<ElibMember> getMemberList();
	
}
