package kr.co.whalesoft.app.cms.module.supportManage;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class SupportManageService extends BaseService {
	
	@Autowired
	private SupportManageDao dao;
	
	public List<SupportManage> getSupportManage(SupportManage supportManage) {
		return dao.getSupportManage(supportManage);
	}
	
	public int getSupportManageCount(SupportManage supportManage) {
		return dao.getSupportManageCount(supportManage);
	}
	
	public SupportManage getCheckReqCount(SupportManage supportManage) {
		return dao.getCheckReqCount(supportManage);
	}
	
	public SupportManage getSupportManageOne(SupportManage supportManage) {
		return dao.getSupportManageOne(supportManage);
	}
	
	public int addSupportManage(SupportManage supportManage) {
		return dao.addSupportManage(supportManage);
	}
	
	public int modifySupportManage(SupportManage supportManage) {
		return dao.modifySupportManage(supportManage);
	}
	
	public int deleteSupportManage(SupportManage supportManage) {
		return dao.deleteSupportManage(supportManage);
	}

	public Map<String, SupportManage> getSupportManageRepo(List<SupportManage> supportManageList) {
		Map<String, SupportManage> repo = new HashMap<String, SupportManage>();
		
		for ( SupportManage oneManage : supportManageList ) {
			String start_date = oneManage.getStart_date();
			String end_date = oneManage.getEnd_date();
			
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String[] pattern 	= {"yyyy-MM-dd"};
			Date startDate 		= null;
			Date endDate 		= null;

			try {
				startDate 	= DateUtils.parseDate(start_date, pattern);
				endDate 	= DateUtils.parseDate(end_date, pattern);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			if ( start_date != null && end_date != null ) {
				while( !DateUtils.isSameDay(startDate, endDate) ) {
					String key = sf.format(startDate);
					
					if ( !repo.containsKey(key) ) {
						repo.put(key, oneManage);
					}
					
					startDate = DateUtils.addDays(startDate, 1);
				}	
				String key = sf.format(endDate);
				
				if ( !repo.containsKey(key) ) {
					repo.put(key, oneManage);
				}
			}
		}
		return repo;
	}
}
