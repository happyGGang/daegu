package kr.go.gbelib.app.cms.module.schoolSupport;

import java.util.List;

public interface SchoolSupportDao  {

	public List<SchoolSupport> getCalendar(SchoolSupport schoolSupport);
	
	public List<SchoolSupport> getSupportListAll(SchoolSupport schoolSupport);
	
	public List<SchoolSupport> getSupportList(SchoolSupport schoolSupport);
	
	public int getSupportListByStatusCount(SchoolSupport schoolSupport);
	
	public List<SchoolSupport> getSupportListByStatus(SchoolSupport schoolSupport);
	
	public SchoolSupport getSupportOne(SchoolSupport schoolSupport);

	public int addSupport(SchoolSupport schoolSupport);

	public int modifySupport(SchoolSupport schoolSupport);

	public int deleteSupport(SchoolSupport schoolSupport);
	
	public List<SchoolSupport> getSupportListByExcel(SchoolSupport schoolSupport);
}