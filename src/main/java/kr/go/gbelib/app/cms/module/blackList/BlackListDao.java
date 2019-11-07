package kr.go.gbelib.app.cms.module.blackList;

import java.util.List;

public interface BlackListDao {

	public List<BlackList> getBlackListList(BlackList blackList);

	public BlackList getBlackListOne(BlackList blackList);

	public BlackList checkBlackList(BlackList blackList);

	public int addBlackList(BlackList blackList);

	public int modifyBlackList(BlackList blackList);

	public int deleteBlackList(BlackList blackList);

	public int checkSaveBlackList(BlackList blackList);

	/**
	 * @author YONGJU 2018. 7. 17.
	 * @param blackList
	 * @return
	 */
	public int getBlackListCount(BlackList blackList);

}
