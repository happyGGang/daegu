package kr.go.gbelib.app.intro.search;

import java.util.List;
import java.util.Map;

public interface LibrarySearchDao {

	String getImageUrl(Map<String, Object> map);

	String getImageUrl(String isbn);

	List<LibrarySearch> getSmartLibPlace(LibrarySearch librarySearch);

	LibrarySearch getSmartLibPlaceOne(LibrarySearch librarySearch);

}
