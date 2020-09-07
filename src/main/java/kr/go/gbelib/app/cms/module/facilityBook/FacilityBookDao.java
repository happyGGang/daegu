package kr.go.gbelib.app.cms.module.facilityBook;

import java.util.List;

public interface FacilityBookDao {
	
	public List<FacilityBook> getCalendar(FacilityBook facilityBook);

	public List<FacilityBook> getApplyList(FacilityBook facilityBook);
	
	public int addFacilityBook(FacilityBook facilityBook);
	
	public int getFacilityBookDuplCheck(FacilityBook facilityBook);
	
	public int getCloseDuplCheck(FacilityBook facilityBook);
	
	public int modifyFacilityBook(FacilityBook facilityBook);
	
	public int changeStatus(FacilityBook facilityBook);
	
	public List<FacilityBook> getFacilityBookAll(FacilityBook facilityBook);
	
	public int getFacilityBookCount(FacilityBook facilityBook);
	
	public FacilityBook getFacilityBookOne(FacilityBook facilityBook);

	public int addFacilityBookClose(FacilityBook facilityBook);

	public List<FacilityBook> getFacilityBookClose(FacilityBook facilityBook);

	public int deleteFacilityBook(FacilityBook facilityBook);

	public int facilityBookCloseCancel(FacilityBook facilityBook);

}
