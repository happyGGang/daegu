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
		return dao.getImageUrl(map);
	}

	public String getImageUrl(String isbn) {
		return dao.getImageUrl(isbn);
	}

}
