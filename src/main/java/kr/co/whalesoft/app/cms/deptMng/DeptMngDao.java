package kr.co.whalesoft.app.cms.deptMng;

import java.util.List;


public interface DeptMngDao {
	
	public List<DeptMng> getWorkMngAll(DeptMng deptMng);
	
	public List<DeptMng> getWorkMngList(DeptMng deptMng);
	
	public DeptMng getWorkMngOne(DeptMng deptMng);
	
	public int getWorkMngCnt(DeptMng deptMng);

	public List<DeptMng> getParentList(DeptMng deptMng);
	
	public int getNextPrintSeq(DeptMng deptMng);
	
	public int addWorkMng(DeptMng deptMng);
	
	public int modifyWorkMng(DeptMng deptMng);
	
	public int deleteWorkMng(DeptMng deptMng);

	
	public List<DeptMng> getDeptList(DeptMng deptMng);
	
	public int getDeptNextPrintSeq(DeptMng deptMng);

	public int addDeptMng(DeptMng deptMng);
	
	public int modifyDeptMng(DeptMng deptMng);

	public int deleteDeptMng(DeptMng deptMng);

	public int deleteWorkAll(DeptMng deptMng);

	public int modChardYN(DeptMng deptMng);

	public DeptMng getdeptChartYN(DeptMng deptMng);

}
