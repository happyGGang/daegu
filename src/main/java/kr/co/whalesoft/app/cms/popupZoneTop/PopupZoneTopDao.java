package kr.co.whalesoft.app.cms.popupZoneTop;

import java.util.List;

public interface PopupZoneTopDao {

	public List<PopupZoneTop> getPopupZoneTop(PopupZoneTop popupZone);
	
	public List<PopupZoneTop> getPopupZoneTopAll(PopupZoneTop popupZone);

	public int getPopupZoneTopCount(PopupZoneTop popupZone);
	
	public PopupZoneTop getPopupZoneTopOne(PopupZoneTop popupZone);
	
	public int addPopupZoneTop(PopupZoneTop popupZone);
	
	public int modifyPopupZoneTop(PopupZoneTop popupZone);

	public int deletePopupZoneTop(PopupZoneTop popupZone);

	public int getNextPrintSeq(String homepage_id);
	
}