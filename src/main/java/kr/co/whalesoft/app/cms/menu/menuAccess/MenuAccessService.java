package kr.co.whalesoft.app.cms.menu.menuAccess;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class MenuAccessService extends BaseController {
	
	@Autowired
	private MenuAccessDao dao;

	@Async
	public void updateMenuAccess(MenuAccess menuAccess) {
		dao.updateMenuAccess(menuAccess);
	}
	
	public List<MenuAccess> getMenuAccessCount(MenuAccess menuAccess) {
		List<MenuAccess> result = dao.getMenuAccessCount(menuAccess);
		long totalCount = 0;
		long minCount = 999999999999999999L;
		long maxCount = 0;
		if ( result != null && result.size() > 0) {
			for ( MenuAccess oneInfo : result ) {
				long resultCount = oneInfo.getAccess_count();
				
				if ( minCount > oneInfo.getAccess_count() ) {
					minCount = resultCount;
				}
				
				if ( maxCount < resultCount ) {
					maxCount = resultCount;
				}
				
				totalCount += resultCount;
			}
			// 첫번째 인덱스에 해당하는 객체에 TOTAL, MAX, MIN 값을 세팅 해서 넘겨준다.
			result.get(0).setTotal_count(totalCount);
			result.get(0).setMax_count(maxCount);
			result.get(0).setMin_count(minCount);
		}
		
		return result;
	}
	
}