package kr.go.gbelib.app.cms.module.relayLecture.relayLectureApply;

import java.util.List;

public interface RelayLectureApplyDao {
	
	public List<RelayLectureApply> relayLectureApplyList(RelayLectureApply relayLectureApply);
	
	public List<RelayLectureApply> relayLectureApplyListAll(RelayLectureApply relayLectureApply);
	
	public RelayLectureApply getRelayLectureApply(RelayLectureApply relayLectureApply);
	
	public int relayLectureApplyCount(RelayLectureApply relayLectureApply);
	
	public int totalRelayLectureApply(RelayLectureApply relayLectureApply);

	public int relayLectureApplyIdx(RelayLectureApply relayLectureApply);

	public int addRelayLectureApply(RelayLectureApply relayLectureApply);
	
	public int modifyRelayLectureApply(RelayLectureApply relayLectureApply);
	
	public int statusChangeRelayLectureApply(RelayLectureApply relayLectureApply);

}
