package kr.co.whalesoft.app.cms.popupZone;

import java.util.List;

public interface PopupZoneDao {

	public List<PopupZone> getPopupZone(PopupZone popupZone);
	
	public List<PopupZone> getPopupZoneAll(PopupZone popupZone);

	public int getPopupZoneCount(PopupZone popupZone);
	
	public PopupZone getPopupZoneOne(PopupZone popupZone);
	
	public int addPopupZone(PopupZone popupZone);
	
	public int modifyPopupZone(PopupZone popupZone);

	public int deletePopupZone(PopupZone popupZone);
	
}