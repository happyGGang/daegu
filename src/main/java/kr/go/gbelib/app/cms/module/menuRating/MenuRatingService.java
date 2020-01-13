package kr.go.gbelib.app.cms.module.menuRating;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class MenuRatingService extends BaseService {
	
	@Autowired
	private MenuRatingDao dao;
	
	public List<MenuRating> getMenuRatingAverageScore(MenuRating menuRating) {
		
		Calendar cal = Calendar.getInstance();
		
		if(menuRating.equals("DAY")) {
			
		} else if(menuRating.equals("MONTH")) {
			cal.set(Calendar.YEAR, Integer.parseInt(menuRating.getSearch_start_date()));
		} else if(menuRating.equals("YEAR")) {
			
		}
		
		return dao.getMenuRatingAverageScore(menuRating);
	}
	
	public int addMenuRatingScore(MenuRating menuRating) {
		return dao.addMenuRatingScore(menuRating);
	}

}
