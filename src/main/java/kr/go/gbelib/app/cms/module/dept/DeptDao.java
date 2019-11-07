package kr.go.gbelib.app.cms.module.dept;

import java.util.List;

public interface DeptDao {

	public List<Dept> getDept(Dept dept);

	public int getDeptCount(Dept dept);
	
	public Dept getDeptOne(Dept dept);
	
	public int addDept(Dept dept);
}
