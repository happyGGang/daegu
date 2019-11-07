package kr.go.gbelib.app.cms.module.schoolSupport;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class SchoolSupportService extends BaseService {
	
	@Autowired
	private SchoolSupportDao schoolSupportDao;
	
	public List<SchoolSupport> getCalendar(SchoolSupport schoolSupport) {
		return schoolSupportDao.getCalendar(schoolSupport);
	}
	
	public List<SchoolSupport> getSupportListAll(SchoolSupport schoolSupport) {
		return schoolSupportDao.getSupportListAll(schoolSupport);
	}
	
	public List<SchoolSupport> getSupportList(SchoolSupport schoolSupport) {
		return schoolSupportDao.getSupportList(schoolSupport);
	}
	
	public int getSupportListByStatusCount(SchoolSupport schoolSupport) {
		return schoolSupportDao.getSupportListByStatusCount(schoolSupport);
	}
	
	public List<SchoolSupport> getSupportListByStatus(SchoolSupport schoolSupport) {
		return schoolSupportDao.getSupportListByStatus(schoolSupport);
	}
	
	public SchoolSupport getSupportOne(SchoolSupport schoolSupport) {
		return schoolSupportDao.getSupportOne(schoolSupport);
	}
	
	public int addSupport(SchoolSupport schoolSupport) {
		return schoolSupportDao.addSupport(schoolSupport);
	}
	
	public int modifySupport(SchoolSupport schoolSupport) {
		return schoolSupportDao.modifySupport(schoolSupport);
	}
	
	public int deleteSupport(SchoolSupport schoolSupport) {
		return schoolSupportDao.deleteSupport(schoolSupport);
	}
	
	public List<SchoolSupport> getSupportListByExcel(SchoolSupport schoolSupport) {
		return schoolSupportDao.getSupportListByExcel(schoolSupport);
	}
	
	/**
	 * key = 'M-d'
	 * @param list
	 * @return Map<String, SchoolSupport>
	 * @throws ParseException 
	 */
	public Map<String, List<SchoolSupport>> makeRepo(List<SchoolSupport> list, String plan_date) {
		Map<String, List<SchoolSupport>> repo = new HashMap<String, List<SchoolSupport>>();
		for ( SchoolSupport oneInfo : list ) {
			if ( "1".equals(oneInfo.getSupport_status()) ) { // 1지망 확정
				repo = addDateList(repo, oneInfo.getFirst_start_date(), oneInfo.getFirst_end_date(), oneInfo);
			}
			else if ( "2".equals(oneInfo.getSupport_status()) ) { // 2지망 확정
				repo = addDateList(repo, oneInfo.getSecond_start_date(), oneInfo.getSecond_end_date(), oneInfo);
			}
			else if ( "3".equals(oneInfo.getSupport_status()) ) { // 1, 2지망 확정
				repo = addDateList(repo, oneInfo.getFirst_start_date(), oneInfo.getFirst_end_date(), oneInfo);
				repo = addDateList(repo, oneInfo.getSecond_start_date(), oneInfo.getSecond_end_date(), oneInfo);
			} 
		}
		return repo;
	}
	
	private Map<String, List<SchoolSupport>> addDateList(Map<String, List<SchoolSupport>> repo, String start, String end, SchoolSupport oneInfo) {
		SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date startDate 	= sf.parse(start);
			Date endDate 	= sf.parse(end);
			List<SchoolSupport> supportList = null;
			
			while ( !startDate.after(endDate) ) {
				String key = sf.format(startDate);
				if ( repo.containsKey(key) ) {
					supportList = repo.get(key);
				}
				else {
					supportList = new ArrayList<SchoolSupport>();
				}
				supportList.add(oneInfo);
				
				repo.put(key, supportList);
				
				startDate = DateUtils.addDays(startDate, 1);
			}
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		
		return repo;
	}
	
}