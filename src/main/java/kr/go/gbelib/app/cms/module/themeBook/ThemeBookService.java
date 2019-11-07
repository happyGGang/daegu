package kr.go.gbelib.app.cms.module.themeBook;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ThemeBookService extends BaseService{

	@Autowired
	private ThemeBookDao dao;
	
	public List<ThemeBook> getThemeBookList(ThemeBook themeBook) {
		return dao.getThemeBookList(themeBook);
	}
	
	public ThemeBook getThemeBookOne(ThemeBook themeBook) {
		return dao.getThemeBookOne(themeBook);
	}
	
	public int addThemeBook(ThemeBook themeBook) {
		return dao.addThemeBook(themeBook);
	}
	
	public int modifyThemeBook(ThemeBook themeBook) {
		return dao.modifyThemeBook(themeBook);
	}

	public int deleteThemeBook(ThemeBook themeBook) {
		return dao.deleteThemeBook(themeBook);
	}
}
