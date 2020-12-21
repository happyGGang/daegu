package kr.go.gbelib.app.cms.module.writingContest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class WritingContestService extends BaseService {
	
	@Autowired
	private WritingContestDao dao;
	
	@WorkingLogger(comment="백일장 조회", type="P")
	public List<WritingContest> writingContestList(WritingContest writingContest) {
		return dao.writingContestList(writingContest);
	}
	
	@WorkingLogger(comment="백일장 엑셀 저장", type="P")
	public List<WritingContest> getExcelList(WritingContest writingContest) {
		return dao.getExcelList(writingContest);
	}
	
	@WorkingLogger(comment="백일장 1건 조회", type="P")
	public WritingContest getWritingContest(WritingContest writingContest) {
		return dao.getWritingContest(writingContest);
	}
	
	public int writingContestCount(WritingContest writingContest) {
		return dao.writingContestCount(writingContest);
	}

	public int addWritingContest(WritingContest writingContest) {
		return dao.addWritingContest(writingContest);
	}
	
	@WorkingLogger(comment="백일장 1건 삭제", type="P")
	public int deleteWritingContest(WritingContest writingContest) {
		return dao.deleteWritingContest(writingContest);
	}
	
	@WorkingLogger(comment="백일장 1건 상태 수정", type="P")
	public int statusChangeWritingContest(WritingContest writingContest) {
		return dao.statusChangeWritingContest(writingContest);
	}
	
}
