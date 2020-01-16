package kr.go.gbelib.app.cms.module.menuRating;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MenuRatingService extends BaseService {
	
	@Autowired
	private MenuRatingDao dao;
	
	public List<MenuRating> getMenuRatingAverageScore(MenuRating menuRating) {
//		if(menuRating.getSearch_date_type().equals("MONTH")) {
//			String year = menuRating.getSearch_start_date();
//			menuRating.setSearch_start_date(year + "-01-01");
//			menuRating.setSearch_end_date(year + "-12-31");
//		} else if(menuRating.getSearch_date_type().equals("YEAR")) {
//			String startYear = menuRating.getSearch_start_date();
//			String endYear = menuRating.getSearch_end_date();
//			menuRating.setSearch_start_date(startYear + "-01-01");
//			menuRating.setSearch_end_date(endYear + "-12-31");
//		}
		
		return dao.getMenuRatingAverageScore(menuRating);
	}
	
	public int addMenuRatingScore(MenuRating menuRating) {
		return dao.addMenuRatingScore(menuRating);
	}

}
