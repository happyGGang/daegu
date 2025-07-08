package kr.co.whalesoft.app.cms.popup;

import java.util.List;

public interface PopupDao {

	public List<Popup> getPopup(Popup popup);
	
	public List<Popup> getPopupAll(Popup popup);

	public int getPopupCount(Popup popup);
	
	public Popup getPopupOne(Popup popup);
	
	public int addPopup(Popup popup);
	
	public int modifyPopup(Popup popup);

	public int deletePopup(Popup popup);

	public int getNextPrintSeq(String homepage_id);

	List<Popup> getPopupFullLayerList(Popup popup);
}