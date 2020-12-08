package kr.go.gbelib.app.cms.module.humanBook.apply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.humanBook.apply.HumanApply;

@Service
public class HumanApplyService extends BaseService {
	
	@Autowired
	private HumanApplyDao dao;

	public List<HumanApply> getHumanBookApplyList(HumanApply humanApply) {
		return dao.getHumanBookApplyList(humanApply);
	}
	
	public int getHumanBookApplyCount(HumanApply humanApply) {
		return dao.getHumanBookApplyCount(humanApply);
	}
	
	public HumanApply getHumanApplyOne(HumanApply humanApply) {
		return dao.getHumanApplyOne(humanApply);
	}
	
	public int addHumanApply(HumanApply humanApply) {
		return dao.addHumanApply(humanApply);
	}

	public int humanApplyCancel(HumanApply humanApply) {
		return dao.humanApplyCancel(humanApply);
	}

	@WorkingLogger(comment="휴먼북 신청 관리 엑셀 저장", type="P")
	public List<HumanApply> getHumanBookScheduleList(HumanApply humanApply) {
		return dao.getHumanBookScheduleList(humanApply);
	}

	public int getHumanBookScheduleCount(HumanApply humanApply) {
		return dao.getHumanBookScheduleCount(humanApply);
	}

	public int modifyApplyStatus(HumanApply humanApply) {
		return dao.modifyApplyStatus(humanApply);
	}

}
