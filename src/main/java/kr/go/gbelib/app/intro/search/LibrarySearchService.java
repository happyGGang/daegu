package kr.go.gbelib.app.intro.search;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class LibrarySearchService extends BaseService {
	
	@Autowired
	private LibrarySearchDao dao;

	public String getImageUrl(Map<String, Object> map) {
		if (map.get("LIB_NAME").equals("아트도서관") && map.get("IMAGE").toString().contains("noimg")) {
			return "/resources/homepage/libculture/img/book_noimg2.png";
		} else {
			return dao.getImageUrl(map);
		}
	}

	public String getImageUrl(String isbn) {
		return dao.getImageUrl(isbn);
	}

}
