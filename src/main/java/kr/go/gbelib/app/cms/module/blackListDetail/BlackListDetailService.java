package kr.go.gbelib.app.cms.module.blackListDetail;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BlackListDetailService extends BaseService{

	@Autowired
	private BlackListDetailDao dao;
	public int addBlackListDetail(BlackListDetail blackListDetail) {
		return dao.addBlackListDetail(blackListDetail);
	}
	public int addBlackListDetailBatch(List<BlackListDetail> blackListDetails) {
		return dao.addBlackListDetailBatch(blackListDetails);
	}
	public int deleteBlackListDetails(BlackListDetail blackListDetails) {
		return dao.deleteBlackListDetails(blackListDetails);
	}

	public BlackListDetail getTeachCodeLists(BlackListDetail blackListDetails) {
		return dao.getTeachCodeLists(blackListDetails);
	}

	public BlackListDetail checkBlackListCode(BlackListDetail blackListDetails) {
		return dao.checkBlackListCode(blackListDetails);
	}
}
