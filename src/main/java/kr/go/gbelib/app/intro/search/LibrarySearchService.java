package kr.go.gbelib.app.intro.search;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.LibSearchAPI;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.googlecode.ehcache.annotations.Cacheable;

@Service
public class LibrarySearchService extends BaseService {

	@Cacheable(cacheName="getLibraryList")
	public Map<String, Object> getLibraryList() {
		return LibSearchAPI.getLibraryList();
	}
	
	@Cacheable(cacheName="searchCategory")
	public Map<String, Object> getSearchCategory() {
		return LibSearchAPI.getSearchCategory();
	}
	
}
