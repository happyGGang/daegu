package kr.go.gbelib.app.cms.module.teach.teachSort;

import java.util.List;

public interface TeachSortDao {

	public List<TeachSort> getTeachSortList(TeachSort teachSort);
	public List<TeachSort> getTeachSetSortList(TeachSort teachSort);
	public List<TeachSort> getHomepageSortList(String homepage_id);
	public TeachSort getTeachSortOne(TeachSort teachSort);
	public int getTeachSortCheckCount(TeachSort teachSort);
	public int deleteTeachSort(TeachSort teachSort);
	public int addTeachSort(TeachSort teachSort);

	
}
