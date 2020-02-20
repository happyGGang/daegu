package kr.go.gbelib.app.cms.module.facilityBook;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class FacilityBookService extends BaseService {
	
	@Autowired
	private FacilityBookDao dao;
	
	public List<FacilityBook> getCalendar(FacilityBook facilityBook) {
		return dao.getCalendar(facilityBook);
	}

	public List<FacilityBook> getApplyList(FacilityBook facilityBook) {
		return dao.getApplyList(facilityBook);
	}
	
	public int addFacilityBook(FacilityBook facilityBook) {
		return dao.addFacilityBook(facilityBook);
	}
	
	public int getFacilityBookDuplCheck(FacilityBook facilityBook) {
		return dao.getFacilityBookDuplCheck(facilityBook);
	}
	
	public int getCloseDuplCheck(FacilityBook facilityBook) {
		return dao.getCloseDuplCheck(facilityBook);
	}
	
	public Map<String, Map<String, FacilityBook>> convertToRepo(List<FacilityBook> list) {
		Map<String, Map<String, FacilityBook>> map = new HashMap<String, Map<String, FacilityBook>>();
		
		for (FacilityBook one : list) {
			String key = one.getApply_date();
			Map<String, FacilityBook> facilityBookList = null;
			if(map.containsKey(key)) {
				facilityBookList = map.get(key);
			} else {
				facilityBookList = new HashMap<String, FacilityBook>();
			}
			
			if(one.getApply_time_code().equals("0")) {
				facilityBookList.put("AM", one);
			} else if(one.getApply_time_code().equals("1")) {
				facilityBookList.put("PM", one);
			}
			
			map.put(key, facilityBookList);
		}
		
		return map;
	}
	
	public List<FacilityBook> getFacilityBookAll(FacilityBook facilityBook) {
		return dao.getFacilityBookAll(facilityBook);
	}
	
	public int getFacilityBookCount(FacilityBook facilityBook) {
		return dao.getFacilityBookCount(facilityBook);
	}
	
	public FacilityBook getFacilityBookOne(FacilityBook facilityBook) {
		return dao.getFacilityBookOne(facilityBook);
	}

	public int addFacilityBookClose(FacilityBook facilityBook) {
		return dao.addFacilityBookClose(facilityBook);
	}

	public int modifyFacilityBook(FacilityBook facilityBook) {
		return dao.modifyFacilityBook(facilityBook);
	}

	public Map<String, Map<String, FacilityBook>> getFacilityBookClose(FacilityBook facilityBook) {
		List<FacilityBook> list = dao.getFacilityBookClose(facilityBook);
		Map<String, Map<String, FacilityBook>> map = new HashMap<String, Map<String, FacilityBook>>();
		
		for (FacilityBook one : list) {
			String key = one.getClose_date();
			Map<String, FacilityBook> closeList = null;
			if(map.containsKey(key)) {
				closeList = map.get(key);
			} else {
				closeList = new HashMap<String, FacilityBook>();
			}
			
			if(one.getClose_time().equals("0")) {
				closeList.put("AM", one);
			} else if(one.getClose_time().equals("1")) {
				closeList.put("PM", one);
			}
			
			map.put(key, closeList);
		}
		
		return map;
	}

}
