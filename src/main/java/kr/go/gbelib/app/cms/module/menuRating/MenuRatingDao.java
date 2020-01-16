package kr.go.gbelib.app.cms.module.menuRating;

import java.util.List;

public interface MenuRatingDao {
	
	public List<MenuRating> getMenuRatingAverageScore(MenuRating menuRating);
	
	public int addMenuRatingScore(MenuRating menuRating);

	

}
