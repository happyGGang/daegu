package kr.go.gbelib.app.cms.module.bookDelivery;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BookDeliveryService extends BaseService {

	@Autowired
	private BookDeliveryDao dao;

	public int getBookDeliveryCount(BookDelivery bookDelivery) {
		return dao.getBookDeliveryCount(bookDelivery);
	}

	public List<BookDelivery> getBookDeliveryList(BookDelivery bookDelivery) {
		return dao.getBookDeliveryList(bookDelivery);
	}

	public int addBookDelivery(BookDelivery bookDelivery) {
		return dao.addBookDelivery(bookDelivery);
		
	}

	public int modifyBookDelivery(BookDelivery bookDelivery) {
		return dao.modifyBookDelivery(bookDelivery);
	}

	public int deleteBookDelivery(BookDelivery bookDelivery) {
		return dao.deleteBookDelivery(bookDelivery);
	}

	public int deleteCheckBookDelivery(BookDelivery bookDelivery) {
		return dao.deleteCheckBookDelivery(bookDelivery);
	}

	public Map<String, String> insertBookDeliveryList(List<BookDelivery> bookDeliveryList, List<String> out, Member member) {
		List<BookDelivery> insertList = new ArrayList<BookDelivery>();
		
		int insertCount = 0;
		boolean failed = false;
		Map<String, String> result = new HashMap<String, String>();
		
		result.put("insertCount", "0");
		result.put("notExistCount", "0");
		
		for(BookDelivery bookDelivery: bookDeliveryList) {
			insertList.add(bookDelivery);
		}
		
		for(BookDelivery bookDelivery : insertList) {
			if(dao.addBookDelivery(bookDelivery) == 0) {
				out.add("삽입 실패");
				failed = true;
				throw new RuntimeException();
			}
			
			++insertCount;
			out.add("삽입 성공");
		}
		
		if(failed) throw new RuntimeException();
		
		result.put("insertCount", String.valueOf(insertCount));
		
		return result;
	}

	public BookDelivery getBookDeliveryListDetail(BookDelivery bookDelivery) {
		return dao.getBookDeliveryListDetail(bookDelivery);
	}

	public List<BookDelivery> getBookDeliveryExcelList(BookDelivery bookDelivery) {
		return dao.getBookDeliveryExcelList(bookDelivery);
	}

	public int modifyBookDeliveryAll(BookDelivery bookDelivery) {
		return dao.modifyBookDeliveryAll(bookDelivery);
	}

}
