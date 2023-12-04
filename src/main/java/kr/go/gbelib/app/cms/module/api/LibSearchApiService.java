package kr.go.gbelib.app.cms.module.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.intro.search.LibrarySearchDao;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LibSearchApiService extends BaseService {

	@Autowired
	private HomepageService homepageService;
	
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
		
		Homepage homepage = new Homepage();
		
		if(StringUtils.isEmpty(librarySearch.getHomepage_id()) || "".equals(librarySearch.getHomepage_id())){
			result.put("result", "fail");
			result.put("message", "homepage_id 값이 없습니다.");
			
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
		
		librarySearch.setNotShelfCode("AB08,AB09,AB10,AB38,BW06,BW08,BW11,BW12,BW16,BW18,BW19,BW20,BW21,BW22,BW23,BW24,BW25,BW26,AH17,CB17");
		
		homepage.setHomepage_id(librarySearch.getHomepage_id());
		homepage = homepageService.getHomepageOne(homepage);

		if ( StringUtils.isEmpty(librarySearch.getManageCode()) ) {
			librarySearch.setManageCode(homepage.getManage_code());
		}
		
		if ( librarySearch.getLibraryCodes() == null ) {
			List<Homepage> normalHomepage = homepageService.getNormalHomepage();
			
			List<String> libraryCodes = new ArrayList<String>();
			if ( !StringUtils.isEmpty(homepage.getManage_code()) ) {
				libraryCodes.add(homepage.getManage_code());
			} else {
				for (Homepage home : normalHomepage) {
					libraryCodes.add(home.getManage_code());
				}
			}

			Homepage h1 = new Homepage();
			h1.setHomepage_id(homepage.getHomepage_id());
			h1.setHomepage_group(homepage.getHomepage_id());
			h1.setTemp_use_yn(null);
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h1);
			if (CollectionUtils.isNotEmpty(subHomepageList)) {
				for (Homepage homepage1 : subHomepageList) {
					if (StringUtils.isNotEmpty(homepage1.getManage_code())) {
						libraryCodes.add(homepage1.getManage_code());

					}
				}
			}

			librarySearch.setLibraryCodes(libraryCodes);
		}
		
		result = LibSearchAPI.getBookAndNonbookDetail(librarySearch);
		
		return result;
	}
	
	public Map<String, Object> getBestBookList(LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Homepage homepage = new Homepage();
		
		if(StringUtils.isEmpty(librarySearch.getHomepage_id()) || "".equals(librarySearch.getHomepage_id())){
			result.put("result", "fail");
			result.put("message", "homepage_id 값이 없습니다.");
			
			return result;
		}
		
		homepage.setHomepage_id(librarySearch.getHomepage_id());
		homepage = homepageService.getHomepageOne(homepage);

		if (StringUtils.isEmpty(librarySearch.getBooktype())) {
			librarySearch.setBooktype("0");
		}
		
		librarySearch.setManageCode(homepage.getManage_code());
		
		result = LibSearchAPI.getBestBookList(librarySearch);
		
		return result;
	}
	
}
