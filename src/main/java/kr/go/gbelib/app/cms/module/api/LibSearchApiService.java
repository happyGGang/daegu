package kr.go.gbelib.app.cms.module.api;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.intro.search.LibrarySearchDao;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LibSearchApiService extends BaseService {

	@Autowired
	private LibrarySearchDao librarySearchDao;

	public Map<String, Object> getSmartLibPlace(LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(StringUtils.isEmpty(librarySearch.getCode()) || "".equals(librarySearch.getCode())){
			result.put("result", "fail");
			result.put("message", "code 값이 없습니다.");
			
			return result;
		}
		
		result = librarySearchDao.getSmartLibPlace(librarySearch);
		if(result == null) {
			Map<String, Object> noResult = new HashMap<String, Object>();
			
			noResult.put("result", "fail");
			noResult.put("message", "해당 스마트도서관 위치 현황이 없습니다.");
			
			return noResult;
		}
		
		return result;
	}

	public Map<String, Object> getBookSearchList(LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(StringUtils.isEmpty(librarySearch.getCode()) || "".equals(librarySearch.getCode())){
			result.put("result", "fail");
			result.put("message", "code 값이 없습니다.");
			
			return result;
		}
		
		if(StringUtils.isEmpty(librarySearch.getSearch_text()) || "".equals(librarySearch.getSearch_text())){
			result.put("result", "fail");
			result.put("message", "search_text 값이 없습니다. 서명을 입력해주세요.");
			
			return result;
		}
		
		if(!(librarySearch.getViewPage() > 0)){
			result.put("result", "fail");
			result.put("message", "viewPage 값이 없습니다. 검색 시작 위치를 지정해주세요.");
			
			return result;
		}
		
		if(!(librarySearch.getRowCount() > 0)){
			result.put("result", "fail");
			result.put("message", "rowCount 값이 없습니다. 검색 결과 출력 건수를 지정해주세요.");
			
			return result;
		}
		
		LibrarySearch ls = librarySearchDao.getSmartLibPlaceOne(librarySearch);
		
		if(ls == null) {
			result.put("result", "fail");
			result.put("message", "해당 스마트도서관 자료실 코드 값이 없습니다.");
			
			return result;
		}
		
		librarySearch.setShelfCode(ls.getCode());
		librarySearch.setManageCode(ls.getManageCode());
		librarySearch.setTitle(librarySearch.getSearch_text());
		
		result = LibSearchAPI.getBookAndNonbookDetail(librarySearch);
		
		return result;
	}
	
	public Map<String, Object> getBestBookList(LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(StringUtils.isEmpty(librarySearch.getCode()) || "".equals(librarySearch.getCode())){
			result.put("result", "fail");
			result.put("message", "code 값이 없습니다.");
			
			return result;
		}
		
		LibrarySearch ls = librarySearchDao.getSmartLibPlaceOne(librarySearch);
		
		if(ls == null) {
			result.put("result", "fail");
			result.put("message", "해당 스마트도서관 자료실 코드 값이 없습니다.");
			
			return result;
		}
		
		if (StringUtils.isEmpty(librarySearch.getBooktype())) {
			librarySearch.setBooktype("0");
		}
		
		librarySearch.setManageCode(ls.getManageCode());
		librarySearch.setShelfCode(ls.getCode());
		
		result = LibSearchAPI.getBestBookList(librarySearch);
		
		return result;
	}
	
}
