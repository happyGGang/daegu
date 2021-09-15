package kr.go.gbelib.app.cms.module.untactBook.untactBookPenaltySetting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.bookOfYear.BookOfYear;

@Service
public class UntactBookPenaltySettingService extends BaseService{

	
	
	@Autowired
	private UntactBookPenaltySettingDao dao;
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int getUntactBookPenaltySettingCount(UntactBookPenaltySetting penalty) {
		return dao.getUntactBookPenaltySettingCount(penalty);
	}
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public List<UntactBookPenaltySetting> getUntactBookPenaltySettingList(UntactBookPenaltySetting penalty){
		return dao.getUntactBookPenaltySettingList(penalty);
	}
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public UntactBookPenaltySetting getUntactBookPenaltySettingOne(UntactBookPenaltySetting penalty) {
		return dao.getUntactBookPenaltySettingOne(penalty);
	}
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int addUntactBookPenaltySetting(UntactBookPenaltySetting penalty) {
		return dao.addUntactBookPenaltySetting(penalty);
	}
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int modifyUntactBookPenaltySetting(UntactBookPenaltySetting penalty) {
		return dao.modifyUntactBookPenaltySetting(penalty);
	}
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int deleteUntactBookPenaltySetting(UntactBookPenaltySetting penalty) {
		return dao.deleteUntactBookPenaltySetting(penalty);
	}

}
