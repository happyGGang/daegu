package kr.go.gbelib.app.cms.module.api;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.intro.search.LibrarySearchDao;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Service
public class LibSearchApiService extends BaseService {

	@Autowired
	private LibrarySearchDao librarySearchDao;

	public String getSmartLibPlace(LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) {
		List<LibrarySearch> smartLibPlaceList = librarySearchDao.getSmartLibPlace(librarySearch);
		
		JsonObject jsonResponse = new JsonObject();
		
		JsonObject header = new JsonObject();
		JsonObject headerItems = new JsonObject();
		
		JsonObject items = new JsonObject();
		JsonObject item = new JsonObject();
		
		String resultCode = "S001";
		String resultMsg = "조회에 성공하였습니다.";
		
		if(StringUtils.isEmpty(librarySearch.getCode()) || "".equals(librarySearch.getCode())){
			resultCode = "S003";
			resultMsg = "code 값이 없습니다.";
		}
		
		if(smartLibPlaceList.isEmpty()){
			resultCode = "S002";
			resultMsg = "해당 스마트도서관 위치 현황이 없습니다.";
		}
		
		jsonResponse.add("response", header);
		header.add("header", headerItems);
		headerItems.addProperty("resultCode", resultCode);
		headerItems.addProperty("resultMsg", resultMsg);
		
		header.add("body", items);
		items.add("items", item);
		
		JsonArray ja = new JsonArray();
		JsonObject job = new JsonObject();
		
		for(LibrarySearch l : smartLibPlaceList) {
			job.addProperty("LOCATION", l.getLocation());
			job.addProperty("CODE", l.getCode());
			job.addProperty("LONGITUDE", l.getLongitude());
			job.addProperty("LIBRARY", l.getLibrary());
			job.addProperty("MANAGECODE", l.getManageCode());
			job.addProperty("LATITUDE", l.getLatitude());
			
			ja.add(job);
		}
		
		item.add("item", ja);
		
		items.addProperty("dataType", "JSON");
		items.addProperty("pageNo", librarySearch.getViewPage());
		items.addProperty("numOfRows", librarySearch.getRowCount());
		items.addProperty("totalCount", smartLibPlaceList.size());
		
		return jsonResponse.toString();
	}

	public String getBookSearchList(LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		JsonObject jsonResponse = new JsonObject();
		
		JsonObject header = new JsonObject();
		JsonObject headerItems = new JsonObject();
		
		JsonObject items = new JsonObject();
		JsonObject item = new JsonObject();
		
		String resultCode = "S001";
		String resultMsg = "조회에 성공하였습니다.";
		
		jsonResponse.add("response", header);
		header.add("header", headerItems);
		headerItems.addProperty("resultCode", resultCode);
		headerItems.addProperty("resultMsg", resultMsg);
		
		LibrarySearch ls = librarySearchDao.getSmartLibPlaceOne(librarySearch);
		
		if(StringUtils.isEmpty(librarySearch.getCode()) || "".equals(librarySearch.getCode())) {
			resultCode = "S003";
			resultMsg = "code 값이 없습니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}
		
		if(StringUtils.isEmpty(librarySearch.getSearch_text()) || "".equals(librarySearch.getSearch_text())) {
			resultCode = "S004";
			resultMsg = "search_text 값이 없습니다. 검색어를 입력해주세요.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}

		if(StringUtils.isEmpty(librarySearch.getPageNo()) || "".equals(librarySearch.getPageNo())) {
			resultCode = "S010";
			resultMsg = "pageNo 값이 없습니다. 페이지 번호를 입력해주세요.";

			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);

			return jsonResponse.toString();
		}

		if(StringUtils.isEmpty(librarySearch.getNumOfRows()) || "".equals(librarySearch.getNumOfRows())) {
			resultCode = "S011";
			resultMsg = "numOfRows 값이 없습니다. 데이터 출력건수를 입력해주세요.";

			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);

			return jsonResponse.toString();
		}
		
		if(ls == null) {
			resultCode = "S002";
			resultMsg = "해당 스마트도서관 위치 현황이 없습니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}

		librarySearch.setShelfCode(ls.getCode());
		librarySearch.setManageCode(ls.getManageCode());
		librarySearch.setTitle(librarySearch.getSearch_text());

		if(StringUtils.isNotEmpty(librarySearch.getPageNo())){
			librarySearch.setViewPage(Integer.parseInt(librarySearch.getPageNo()));
		}

		if(StringUtils.isNotEmpty(librarySearch.getNumOfRows())){
			librarySearch.setRowCount(Integer.parseInt(librarySearch.getNumOfRows()));
		}

		result = LibSearchAPI.getBookAndNonbookDetail(librarySearch);
		
		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
			header.add("body", items);
			items.add("items", item);
			
			JsonArray ja = new JsonArray();
			
			List<Map<String, Object>> list = null;
			int count = LibSearchAPI.getSearchCount(result);
			
			if(count == 0){
				resultCode = "S005";
				resultMsg = "해당하는 검색결과 값이 없습니다.";
				
				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);
				
				return jsonResponse.toString();
			}
			
			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
				list = LibSearchAPI.getTestListData(result);
				for (Map<String, Object> map : list) {
					JsonObject job = new JsonObject();
					
					for ( String key : map.keySet() ) {
						job.addProperty(key, String.valueOf(map.get(key)));
					}
					ja.add(job);
				}
			}
			
			item.add("item", ja);
			
			items.addProperty("dataType", "JSON");
			items.addProperty("pageNo", librarySearch.getViewPage());
			items.addProperty("numOfRows", librarySearch.getRowCount());
			items.addProperty("totalCount", count);
		}
		
		return jsonResponse.toString();
	}
	
	public String getBestBookList(LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		JsonObject jsonResponse = new JsonObject();
		
		JsonObject header = new JsonObject();
		JsonObject headerItems = new JsonObject();
		
		JsonObject items = new JsonObject();
		JsonObject item = new JsonObject();
		
		String resultCode = "S001";
		String resultMsg = "조회에 성공하였습니다.";
		
		jsonResponse.add("response", header);
		header.add("header", headerItems);
		headerItems.addProperty("resultCode", resultCode);
		headerItems.addProperty("resultMsg", resultMsg);
		
		LibrarySearch ls = librarySearchDao.getSmartLibPlaceOne(librarySearch);
		
		if(StringUtils.isEmpty(librarySearch.getCode()) || "".equals(librarySearch.getCode())) {
			resultCode = "S003";
			resultMsg = "code 값이 없습니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}

		if(StringUtils.isEmpty(librarySearch.getPageNo()) || "".equals(librarySearch.getPageNo())) {
			resultCode = "S010";
			resultMsg = "pageNo 값이 없습니다. 페이지 번호를 입력해주세요.";

			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);

			return jsonResponse.toString();
		}

		if(StringUtils.isEmpty(librarySearch.getNumOfRows()) || "".equals(librarySearch.getNumOfRows())) {
			resultCode = "S011";
			resultMsg = "numOfRows 값이 없습니다. 데이터 출력건수를 입력해주세요.";

			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);

			return jsonResponse.toString();
		}
		
		if(ls == null) {
			resultCode = "S002";
			resultMsg = "해당 스마트도서관 위치 현황이 없습니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}
		
		if(librarySearch.getRowCount() > 100) {
			resultCode = "S013";
			resultMsg = "검색 결과 출력 건수 지정은 100건 이하만 가능합니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}

		if(StringUtils.isNotEmpty(librarySearch.getSearch_start_date())){
			String datePattern = "(19|20)\\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])";
			Pattern pattern = Pattern.compile(datePattern);

			String start_date = librarySearch.getSearch_start_date().replaceAll("-", "");

			if(!pattern.matcher(start_date).matches()){
				resultCode = "S006";
				resultMsg = "날짜형식(Format) 오류입니다. yyyy-MM-dd 형식으로 입력해주세요.";

				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);

				return jsonResponse.toString();
			}
		}

		if(StringUtils.isNotEmpty(librarySearch.getSearch_end_date())){
			String datePattern = "(19|20)\\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])";
			Pattern pattern = Pattern.compile(datePattern);

			String end_date = librarySearch.getSearch_end_date().replaceAll("-", "");

			if(!pattern.matcher(end_date).matches()){
				resultCode = "S006";
				resultMsg = "날짜형식(Format) 오류입니다. yyyy-MM-dd 형식으로 입력해주세요.";

				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);

				return jsonResponse.toString();
			}
		}

		if(StringUtils.isNotEmpty(librarySearch.getSearch_start_date()) && StringUtils.isNotEmpty(librarySearch.getSearch_end_date())){
			String start_date = librarySearch.getSearch_start_date().replaceAll("-", "");
			String end_date = librarySearch.getSearch_end_date().replaceAll("-", "");

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

			Date sd = null;
			Date ed = null;

			try {
				sd = sdf.parse(start_date);
				ed = sdf.parse(end_date);
			} catch (ParseException e) {
				e.printStackTrace();
				resultCode = "S006";
				resultMsg = "날짜형식(Format) 오류입니다. yyyy-MM-dd 형식으로 입력해주세요.";

				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);

				return jsonResponse.toString();
			}

			if(ed.before(sd)){
				resultCode = "S007";
				resultMsg = "날짜정보 오입력 입니다. 시작일이 종료일보다 클수 없습니다.";

				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);

				return jsonResponse.toString();
			}
		}

		if (StringUtils.isEmpty(librarySearch.getBooktype())) {
			librarySearch.setBooktype("0");
		}
		
		librarySearch.setManageCode(ls.getManageCode());
		librarySearch.setShelfCode(ls.getCode());

		if(StringUtils.isNotEmpty(librarySearch.getPageNo())){
			librarySearch.setViewPage(Integer.parseInt(librarySearch.getPageNo()));
		}

		if(StringUtils.isNotEmpty(librarySearch.getNumOfRows())){
			librarySearch.setRowCount(Integer.parseInt(librarySearch.getNumOfRows()));
		}
		
		int rowCount = librarySearch.getRowCount();
		
		//librarySearch.setRowCount(100);
		
		result = LibSearchAPI.getBestBookList(librarySearch);
		
		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
			header.add("body", items);
			items.add("items", item);
			
			JsonArray ja = new JsonArray();
			
			List<Map<String, Object>> list = null;
			
			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
				list = LibSearchAPI.getTestListData(result);
				
				if(list.size() == 0){
					resultCode = "S005";
					resultMsg = "해당하는 검색결과 값이 없습니다.";
					
					jsonResponse.add("response", header);
					header.add("header", headerItems);
					headerItems.addProperty("resultCode", resultCode);
					headerItems.addProperty("resultMsg", resultMsg);
					
					return jsonResponse.toString();
				}
				
				int loopRowCount = 0;

				int startRowNum = ( librarySearch.getViewPage() - 1 ) * rowCount + 1;
				
				for (Map<String, Object> map : list) {
					JsonObject job = new JsonObject();
					loopRowCount++;
					for ( String key : map.keySet() ) {
						job.addProperty(key, String.valueOf(map.get(key)));
					}
					
					if(librarySearch.getViewPage() > 1) {
						if(startRowNum <= loopRowCount && loopRowCount <= startRowNum+rowCount-1) {
							ja.add(job);
						}
					} else {
						if(loopRowCount <= rowCount) {
							ja.add(job);
						}
					}
				}
			}
			
			item.add("item", ja);
			
			items.addProperty("dataType", "JSON");
			items.addProperty("pageNo", librarySearch.getViewPage());
			items.addProperty("numOfRows", rowCount);
			items.addProperty("totalCount", list.size());
		} else {
			resultCode = "S012";
			resultMsg = "시간내 결과를 호출하지 못하였습니다. 검색기간은 6개월 이내를 권장합니다.";

			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);

			return jsonResponse.toString();
		}
		
		return jsonResponse.toString();
	}

	public String getNewBookList(LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		JsonObject jsonResponse = new JsonObject();
		
		JsonObject header = new JsonObject();
		JsonObject headerItems = new JsonObject();
		
		JsonObject items = new JsonObject();
		JsonObject item = new JsonObject();
		
		String resultCode = "S001";
		String resultMsg = "조회에 성공하였습니다.";
		
		jsonResponse.add("response", header);
		header.add("header", headerItems);
		headerItems.addProperty("resultCode", resultCode);
		headerItems.addProperty("resultMsg", resultMsg);
		
		LibrarySearch ls = librarySearchDao.getSmartLibPlaceOne(librarySearch);
		
		if(StringUtils.isEmpty(librarySearch.getCode()) || "".equals(librarySearch.getCode())) {
			resultCode = "S003";
			resultMsg = "code 값이 없습니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}
		
		if(StringUtils.isEmpty(librarySearch.getShelf_change_start_date()) || "".equals(librarySearch.getShelf_change_start_date())) {
			resultCode = "S008";
			resultMsg = "배가변경 검색 시작일이 없습니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}
		
		if(StringUtils.isEmpty(librarySearch.getShelf_change_end_date()) || "".equals(librarySearch.getShelf_change_end_date())) {
			resultCode = "S009";
			resultMsg = "배가변경 검색 종료일이 없습니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}

		if(StringUtils.isNotEmpty(librarySearch.getShelf_change_start_date())){
			String datePattern = "(19|20)\\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])";
			Pattern pattern = Pattern.compile(datePattern);

			String start_date = librarySearch.getShelf_change_start_date().replaceAll("-", "");

			if(!pattern.matcher(start_date).matches()){
				resultCode = "S006";
				resultMsg = "날짜형식(Format) 오류입니다. yyyy-MM-dd 형식으로 입력해주세요.";

				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);

				return jsonResponse.toString();
			}
		}

		if(StringUtils.isNotEmpty(librarySearch.getShelf_change_end_date())){
			String datePattern = "(19|20)\\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])";
			Pattern pattern = Pattern.compile(datePattern);

			String end_date = librarySearch.getShelf_change_end_date().replaceAll("-", "");

			if(!pattern.matcher(end_date).matches()){
				resultCode = "S006";
				resultMsg = "날짜형식(Format) 오류입니다. yyyy-MM-dd 형식으로 입력해주세요.";

				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);

				return jsonResponse.toString();
			}
		}

		if(StringUtils.isNotEmpty(librarySearch.getShelf_change_start_date()) && StringUtils.isNotEmpty(librarySearch.getShelf_change_end_date())){
			String start_date = librarySearch.getShelf_change_start_date().replaceAll("-", "");
			String end_date = librarySearch.getShelf_change_end_date().replaceAll("-", "");

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

			Date sd = null;
			Date ed = null;

			try {
				sd = sdf.parse(start_date);
				ed = sdf.parse(end_date);
			} catch (ParseException e) {
				e.printStackTrace();
				resultCode = "S006";
				resultMsg = "날짜형식(Format) 오류입니다. yyyy-MM-dd 형식으로 입력해주세요.";

				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);

				return jsonResponse.toString();
			}

			if(ed.before(sd)){
				resultCode = "S007";
				resultMsg = "날짜정보 오입력 입니다. 시작일이 종료일보다 클수 없습니다.";

				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);

				return jsonResponse.toString();
			}
		}

		if(StringUtils.isEmpty(librarySearch.getPageNo()) || "".equals(librarySearch.getPageNo())) {
			resultCode = "S010";
			resultMsg = "pageNo 값이 없습니다. 페이지 번호를 입력해주세요.";

			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);

			return jsonResponse.toString();
		}

		if(StringUtils.isEmpty(librarySearch.getNumOfRows()) || "".equals(librarySearch.getNumOfRows())) {
			resultCode = "S011";
			resultMsg = "numOfRows 값이 없습니다. 데이터 출력건수를 입력해주세요.";

			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);

			return jsonResponse.toString();
		}
		
		if(ls == null) {
			resultCode = "S002";
			resultMsg = "해당 스마트도서관 위치 현황이 없습니다.";
			
			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);
			
			return jsonResponse.toString();
		}
		
		librarySearch.setShelfCode(ls.getCode());
		librarySearch.setManageCode(ls.getManageCode());
		librarySearch.setSortField("SHELF_DATE");
		librarySearch.setSortType("DESC");

		if(StringUtils.isNotEmpty(librarySearch.getPageNo())){
			librarySearch.setViewPage(Integer.parseInt(librarySearch.getPageNo()));
		}

		if(StringUtils.isNotEmpty(librarySearch.getNumOfRows())){
			librarySearch.setRowCount(Integer.parseInt(librarySearch.getNumOfRows()));
		}
		
		result = LibSearchAPI.getBookAndNonbookDetail(librarySearch);
		
		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
			header.add("body", items);
			items.add("items", item);
			
			JsonArray ja = new JsonArray();
			
			List<Map<String, Object>> list = null;
			int count = LibSearchAPI.getSearchCount(result);
			
			if(count == 0){
				resultCode = "S005";
				resultMsg = "해당하는 검색결과 값이 없습니다.";
				
				jsonResponse.add("response", header);
				header.add("header", headerItems);
				headerItems.addProperty("resultCode", resultCode);
				headerItems.addProperty("resultMsg", resultMsg);
				
				return jsonResponse.toString();
			}
			
			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
				list = LibSearchAPI.getTestListData(result);
				for (Map<String, Object> map : list) {
					JsonObject job = new JsonObject();
					
					for ( String key : map.keySet() ) {
						job.addProperty(key, String.valueOf(map.get(key)));
					}
					ja.add(job);
				}
			}
			
			item.add("item", ja);
			
			items.addProperty("dataType", "JSON");
			items.addProperty("pageNo", librarySearch.getViewPage());
			items.addProperty("numOfRows", librarySearch.getRowCount());
			items.addProperty("totalCount", count);
		} else {
			resultCode = "S012";
			resultMsg = "시간내 결과를 호출하지 못하였습니다. 검색기간은 6개월 이내를 권장합니다.";

			jsonResponse.add("response", header);
			header.add("header", headerItems);
			headerItems.addProperty("resultCode", resultCode);
			headerItems.addProperty("resultMsg", resultMsg);

			return jsonResponse.toString();
		}
		
		return jsonResponse.toString();
	}
	
}
