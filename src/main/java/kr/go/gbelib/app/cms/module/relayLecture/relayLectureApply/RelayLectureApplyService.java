package kr.go.gbelib.app.cms.module.relayLecture.relayLectureApply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class RelayLectureApplyService extends BaseService {
	
	@Autowired
	private RelayLectureApplyDao dao;
	
	public List<RelayLectureApply> relayLectureApplyList(RelayLectureApply relayLectureApply) {
		return dao.relayLectureApplyList(relayLectureApply);
	}
	
	public List<RelayLectureApply> relayLectureApplyListAll(RelayLectureApply relayLectureApply) {
		return dao.relayLectureApplyListAll(relayLectureApply);
	}
	
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
	
	public int modifyRelayLectureApply(RelayLectureApply relayLectureApply) {
		return dao.modifyRelayLectureApply(relayLectureApply);
	}

	public int deleteRelayLectureApply(RelayLectureApply relayLectureApply) {
		return dao.deleteRelayLectureApply(relayLectureApply);
	}
	
	public int statusChangeRelayLectureApply(RelayLectureApply relayLectureApply) {
		return dao.statusChangeRelayLectureApply(relayLectureApply);
	}
	
}
