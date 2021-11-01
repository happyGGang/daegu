package kr.go.gbelib.app.module.bookKeyword;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BookKeywordService extends BaseService{

	@Autowired
	private BookKeywordDao dao;
	
	public List<BookKeyword> getBookKeywordList(BookKeyword bookKeyword) {
		return dao.getBookKeywordList(bookKeyword); 
	}
}
