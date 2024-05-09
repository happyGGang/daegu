package kr.go.gbelib.app.cms.module.teach.teachSort;

import kr.co.whalesoft.framework.base.BaseService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TeachSortService extends BaseService {

	@Autowired
	private TeachSortDao dao;

	public List<TeachSort> getTeachSortList(TeachSort teachSort) {
		return dao.getTeachSortList(teachSort);
	}
	public List<TeachSort> getTeachSetSortList(TeachSort teachSort) {
		return dao.getTeachSetSortList(teachSort);
	}

	public List<TeachSort> getHomepageSortList(String homepage_id) {
		return dao.getHomepageSortList(homepage_id);
	}

	public int getTeachSortCheckCount(TeachSort teachSort) {
		return dao.getTeachSortCheckCount(teachSort);
	}
	public TeachSort getTeachSortOne(TeachSort teachSort) {
		return dao.getTeachSortOne(teachSort);
	}

	public int deleteTeachSort(TeachSort teachSort) {
		return dao.deleteTeachSort(teachSort);
	}	public int addTeachSort(TeachSort teachSort) {
		return dao.addTeachSort(teachSort);
	}





}
