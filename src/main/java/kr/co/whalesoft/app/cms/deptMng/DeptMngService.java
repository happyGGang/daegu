package kr.co.whalesoft.app.cms.deptMng;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class DeptMngService extends BaseService {
	
	@Autowired
	private DeptMngDao dao;
	
	public List<DeptMng> getWorkMngAll(DeptMng deptMng) {
		return dao.getWorkMngAll(deptMng);
	}
	
	public List<DeptMng> getWorkMngList(DeptMng deptMng) {
		return dao.getWorkMngList(deptMng);
	}
	
	public DeptMng getWorkMngOne(DeptMng deptMng) {
		return dao.getWorkMngOne(deptMng);
	}
	
	public int getWorkMngCnt(DeptMng deptMng) {
		return dao.getWorkMngCnt(deptMng);
	}
	
	public List<DeptMng> getParentList(DeptMng deptMng) {
		return dao.getParentList(deptMng);
	}
	
	public int getNextPrintSeq(DeptMng deptMng) {
		return dao.getNextPrintSeq(deptMng);
	}

	public int addWorkMng(DeptMng deptMng) {
		return dao.addWorkMng(deptMng);
	}
	
	public int modifyWorkMng(DeptMng deptMng) {
		return dao.modifyWorkMng(deptMng);
	}
	
	public int deleteWorkMng(DeptMng deptMng) {
		return dao.deleteWorkMng(deptMng);
	}

	
	public List<DeptMng> getDeptList(DeptMng deptMng) {
		return dao.getDeptList(deptMng);
	}
	
	public int getDeptNextPrintSeq(DeptMng deptMng) {
		return dao.getDeptNextPrintSeq(deptMng);
	}

	public int addDeptMng(DeptMng deptMng) {
		return dao.addDeptMng(deptMng);
	}
	
	public int modifyDeptMng(DeptMng deptMng) {
		return dao.modifyDeptMng(deptMng);
	}

	public int deleteDeptMng(DeptMng deptMng) {
		return dao.deleteDeptMng(deptMng);
	}

	public int deleteWorkAll(DeptMng deptMng) {
		return dao.deleteWorkAll(deptMng);
	}

	public int modChardYN(DeptMng deptMng) {
		return dao.modChardYN(deptMng);
	}

	public char getdeptChartYN(DeptMng deptMng) {
		DeptMng result = dao.getdeptChartYN(deptMng);
		if(result != null) {
			return result.getChart_yn();
		} else {
			return 'N';
		}
	}

}
