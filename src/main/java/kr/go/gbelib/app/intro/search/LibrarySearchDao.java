package kr.go.gbelib.app.intro.search;

import java.util.Map;

public interface LibrarySearchDao {

	String getImageUrl(Map<String, Object> map);

	String getImageUrl(String isbn);

	Map<String, Object> getSmartLibPlace(LibrarySearch librarySearch);

}
