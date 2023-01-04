package kr.go.gbelib.app.cms.module.bookOfFamous;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BookOfFamousService extends BaseService {

	@Autowired
	private BookOfFamousDao dao;

	public int getBookOfFamousCount(BookOfFamous boy) {
		return dao.getBookOfFamousCount(boy);
	}

	public List<BookOfFamous> getBookOfFamousList(BookOfFamous boy) {
		return dao.getBookOfFamousList(boy);
	}

	public BookOfFamous getBookOfFamousOne(BookOfFamous boy) {
		return dao.getBookOfFamousOne(boy);
	}

	public int addBookOfFamous(BookOfFamous boy) {
		return dao.addBookOfFamous(boy);
	}

	public int modifyBookOfFamous(BookOfFamous boy) {
		return dao.modifyBookOfFamous(boy);
	}

	public int deleteBookOfFamous(BookOfFamous boy) {
		return dao.deleteBookOfFamous(boy);
	}
	
	public Map<String, Object> getBookOfFamousListApi(BookOfFamous boy) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String,Object> resultMap = new HashMap<String,Object>();
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		List<BookOfFamous> bookOfFamousList = dao.getBookOfFamousListAPi(boy);
		
		try {
			if(bookOfFamousList.size() > 0) {
				Map<String,Object> resultMapList = new HashMap<String,Object>();
				
				for(int i =0 ; i < bookOfFamousList.size(); i++) {
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getFamous_name())) {
						resultMapList.put("famous_name", bookOfFamousList.get(i).getFamous_name());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getNotice_yn())) {
						resultMapList.put("notice_yn", bookOfFamousList.get(i).getNotice_yn());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getBook_name())) {
						resultMapList.put("book_name", bookOfFamousList.get(i).getBook_name());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getBook_author())) {
						resultMapList.put("book_author", bookOfFamousList.get(i).getBook_author());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getBook_publisher())) {
						resultMapList.put("book_publisher", bookOfFamousList.get(i).getBook_publisher());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getBook_year())) {
						resultMapList.put("book_year", bookOfFamousList.get(i).getBook_year());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getBook_regno())) {
						resultMapList.put("book_regno", bookOfFamousList.get(i).getBook_regno());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getBook_isbn())) {
						resultMapList.put("book_isbn", bookOfFamousList.get(i).getBook_isbn());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getBook_img_url())) {
						resultMapList.put("book_img_url", bookOfFamousList.get(i).getBook_img_url());
					}
					if(StringUtils.isNotEmpty(bookOfFamousList.get(i).getBook_content())) {
						resultMapList.put("book_content", bookOfFamousList.get(i).getBook_content());
					}
					resultList.add(i, resultMapList);
				}
				
				resultMap.put("result-list", resultList);
				result.put("result", "success");
				result.put("count", resultList.size());
				result.put("result-data", resultMap);
			} else {
				result.put("result", "fail");
				result.put("message", "명사의 서재 데이터가 없습니다.");
			}
		}catch (Exception e) {
			result.put("result", "fail");
			result.put("message", "명사의 서재 데이터를 조회하는데 오류가 발생하셨습니다.");
		}
		
		return result;
	}
}
