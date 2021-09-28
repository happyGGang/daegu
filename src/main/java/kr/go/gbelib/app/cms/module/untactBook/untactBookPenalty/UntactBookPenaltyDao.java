package kr.go.gbelib.app.cms.module.untactBook.untactBookPenalty;

public interface UntactBookPenaltyDao {

	public int mergePenaltySetting(UntactBookPenalty untactBookPenalty);

	public int penaltyCount(String homepage_id);


}
