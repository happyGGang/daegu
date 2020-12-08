package kr.go.gbelib.app.cms.module.relayLecture.relayLectureApply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class RelayLectureApplyService extends BaseService {
	
	@Autowired
	private RelayLectureApplyDao dao;
	
	@WorkingLogger(comment="릴레리강연 조회", type="P")
	public List<RelayLectureApply> relayLectureApplyList(RelayLectureApply relayLectureApply) {
		return dao.relayLectureApplyList(relayLectureApply);
	}
	
	@WorkingLogger(comment="릴레리강연 엑셀 저장", type="P")
	public List<RelayLectureApply> relayLectureApplyListAll(RelayLectureApply relayLectureApply) {
		return dao.relayLectureApplyListAll(relayLectureApply);
	}
	
	@WorkingLogger(comment="릴레리강연 1건 조회", type="P")
	public RelayLectureApply getRelayLectureApply(RelayLectureApply relayLectureApply) {
		return dao.getRelayLectureApply(relayLectureApply);
	}
	
	public int relayLectureApplyCount(RelayLectureApply relayLectureApply) {
		return dao.relayLectureApplyCount(relayLectureApply);
	}
	
	public int totalRelayLectureApply(RelayLectureApply relayLectureApply) {
		return dao.totalRelayLectureApply(relayLectureApply);
	}
	
	public int relayLectureApplyIdx(RelayLectureApply relayLectureApply) {
		return dao.relayLectureApplyIdx(relayLectureApply);
	}

	public int addRelayLectureApply(RelayLectureApply relayLectureApply) {		
		return dao.addRelayLectureApply(relayLectureApply);
	}
	
	@WorkingLogger(comment="릴레리강연 1건 수정", type="P")
	public int modifyRelayLectureApply(RelayLectureApply relayLectureApply) {
		return dao.modifyRelayLectureApply(relayLectureApply);
	}
	
	public int statusChangeRelayLectureApply(RelayLectureApply relayLectureApply) {
		return dao.statusChangeRelayLectureApply(relayLectureApply);
	}
	
}
