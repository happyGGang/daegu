package kr.go.gbelib.app.cms.module.bookReview;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.PagingUtils;
import net.sf.classifier4J.util.WFMultiPartPost;

@Service
public class BookReviewService extends BaseService {
	
	@Autowired
	private BookReviewDao dao;
	
	public List<BookReview> getBookReviewLocaList(BookReview bookReview) {
		return dao.getBookReviewLocaList(bookReview);
	}
	
	public int getBookReviewLocaListCnt(BookReview bookReview) {
		return dao.getBookReviewLocaListCnt(bookReview);
	}
	
	public List<BookReview> getBookReviewList(BookReview bookReview) {
		return dao.getBookReviewList(bookReview);
	}

	public String addBookReview(BookReview bookReview) {
		String filterCheck = null;
		try {
			filterCheck = webFilterCheck(bookReview.getAdd_id(), bookReview);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (filterCheck != null) {
			return filterCheck;
		}
		
		dao.addBookReview(bookReview);
		
		return null;
	}
	
	public String modBookReview(BookReview bookReview) {
		String filterCheck = null;
		try {
			filterCheck = webFilterCheck(bookReview.getModify_id(), bookReview);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (filterCheck != null) {
			return filterCheck;
		}
		
		dao.modBookReview(bookReview);
		
		return null;
	}

	public int delBookReview(BookReview bookReview) {
		return dao.delBookReview(bookReview);
	}

	public int duplBookReviewUserCnt(BookReview bookReview) {
		return dao.duplBookReviewUserCnt(bookReview);
	}

	public List<BookReview> getBookReviewAll(BookReview bookReview) {
		return dao.getBookReviewAll(bookReview);
	}
	
	private String webFilterCheck(String writer, BookReview bookReview) throws Exception {
		WFMultiPartPost wfsend = new WFMultiPartPost("gbelib.kr", "117.111.136.240", 80);
		String wfResponse = wfsend.sendWebFilter(writer, "서평 작성", bookReview.getBook_review_content(), "");
		
		if(wfResponse.equals("Y")){
			// 차단내용 팝업창 URL 출력
//			res.setValid(true);
//			res.setUrl(wfsend.getDenyURL());
//			res.setTargetOpener(true);
			return wfsend.getDenyURL();
		} else if(wfResponse.equals("N")){

			return null;
		} else if(wfResponse.equals("B")){

			return null;
		}
		return null;
	}

	public int getbookReviewAllCnt(BookReview bookReview) {
		return dao.getbookReviewAllCnt(bookReview);
	}
	
	public List<BookReview> getBookReviewXlsAndCsv(BookReview bookReview) {
		return dao.getBookReviewXlsAndCsv(bookReview);
	}

	public BookReview getBookReviewOne(BookReview bookReview) {
		return dao.getBookReviewOne(bookReview);
	}

}
