package kr.go.gbelib.app.cms.module.dept;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class DeptService extends BaseService {
	
	@Autowired
	private DeptDao dao;
	
	public List<Dept> getDept(Dept dept) {
		return dao.getDept(dept);
	}
	
	public int getDeptCount(Dept dept) {
		return dao.getDeptCount(dept);
	}
	
	public Dept getDeptOne(Dept dept) {
		return dao.getDeptOne(dept);
	}
	
	public int addDept(Dept dept) {
		return dao.addDept(dept);
	}
}
