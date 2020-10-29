package kr.go.gbelib.app.cms.module.relayLecture;

import java.util.List;

public interface RelayLectureDao {
	
	public List<RelayLecture> relayLectureList(RelayLecture relayLecture);
	
	public List<RelayLecture> relayLectureUserList(RelayLecture relayLecture);
	
	public RelayLecture getRelayLecture(RelayLecture relayLecture);
	
	public int relayLectureCount(RelayLecture relayLecture);
	
	public int relayLectureUserCount(RelayLecture relayLecture);

	public int relayLectureIdx(RelayLecture relayLecture);

	public int addRelayLecture(RelayLecture relayLecture);
	
	public int modifyRelayLecture(RelayLecture relayLecture);

	public int deleteRelayLecture(RelayLecture relayLecture);
	
	public int statusChangeRelayLecture(RelayLecture relayLecture);
	
	public int addViewCount(RelayLecture relayLecture);

}
