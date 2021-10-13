package kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList;

import java.util.List;

public interface UntactBookBlackListDao {

	public int grantPenalty(UntactBookBlackList untactBookBlackList);

	public int penaltyCount(UntactBookBlackList untactBookBlackList);

	public int getUntactBookBlackListCount(UntactBookBlackList untactBookBlackList);

	public List<UntactBookBlackList> getUntactBookBlackListList(UntactBookBlackList untactBookBlackList);

	public int deleteAllUntactBookBlackList(UntactBookBlackList untactBookBlackList);

	public int deleteUntactBookBlackList(UntactBookBlackList untactBookBlackList);

	public int getPenaltyCount(UntactBookBlackList untactBookBlackList);

	public List<UntactBookBlackList> getUntactBookBlackListExcelList(UntactBookBlackList untactBookBlackList);


}
