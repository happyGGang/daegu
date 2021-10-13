package kr.go.gbelib.app.cms.module.untactBook.untactBookPenaltySetting;

import java.util.List;

/**
 * @author whalesoft BYENGHAK 2021. 09. 09.
 *
 */

public interface UntactBookPenaltySettingDao {

	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int getUntactBookPenaltySettingCount(UntactBookPenaltySetting penalty);
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public List<UntactBookPenaltySetting> getUntactBookPenaltySettingList(UntactBookPenaltySetting penalty);
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public UntactBookPenaltySetting getUntactBookPenaltySettingOne(UntactBookPenaltySetting penalty);
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int addUntactBookPenaltySetting(UntactBookPenaltySetting penalty);
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int modifyUntactBookPenaltySetting(UntactBookPenaltySetting penalty);
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int deleteUntactBookPenaltySetting(UntactBookPenaltySetting penalty);
	
	/**
	 * @author whalesoft BYENGHAK 2021. 09. 09.
	 * @param penalty
	 * @return
	 */
	public int duplicateCheck(UntactBookPenaltySetting penalty);

	public int getPenaltyCount(String homepage_id);

	public String getEndDate(String homepage_id);
}
