package kr.co.whalesoft.app.cms.libSvcStatistics;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class LibSvcStatisticsService extends BaseService {
	
	@Autowired
	private LibSvcStatisticsDao dao;

	public LibSvcStatistics getCategoryCnt(LibSvcStatistics libSvcStatistics) {
		return dao.getCategoryCnt(libSvcStatistics);
	}

	public List<LibSvcStatistics> getMemberCnt(LibSvcStatistics libSvcStatistics, String sum_yn) {
		libSvcStatistics.setSum_yn(sum_yn);
		return dao.getMemberCnt(libSvcStatistics);
	}
	
	

}
