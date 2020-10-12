package kr.go.gbelib.app.cms.module.humanBook.apply;

import java.util.List;

import kr.go.gbelib.app.cms.module.humanBook.apply.HumanApply;

public interface HumanApplyDao {

	public List<HumanApply> getHumanBookApplyList(HumanApply humanApply);
	
	public int getHumanBookApplyCount(HumanApply humanApply);
	
	public HumanApply getHumanApplyOne(HumanApply humanApply);
	
	public int addHumanApply(HumanApply humanApply);

	public int humanApplyCancel(HumanApply humanApply);

	public List<HumanApply> getHumanBookScheduleList(HumanApply humanApply);

	public int getHumanBookScheduleCount(HumanApply humanApply);

	public int modifyApplyStatus(HumanApply humanApply);

}
