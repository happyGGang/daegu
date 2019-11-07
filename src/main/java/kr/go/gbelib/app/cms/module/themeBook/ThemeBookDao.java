package kr.go.gbelib.app.cms.module.themeBook;

import java.util.List;

public interface ThemeBookDao {
	
	public List<ThemeBook> getThemeBookList(ThemeBook themeBook);
	
	public ThemeBook getThemeBookOne(ThemeBook themeBook);
	
	public int addThemeBook(ThemeBook themeBook);
	
	public int modifyThemeBook(ThemeBook themeBook);

	public int deleteThemeBook(ThemeBook themeBook);
	
}
