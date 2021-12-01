package kr.go.gbelib.app.cms.module.elib.best;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.config.Config;
import kr.go.gbelib.app.cms.module.elib.config.ConfigService;

@Service
public class BestService extends BaseService {

	@Autowired
	private BestDao dao;

	@Autowired
	private ConfigService configService;

	public List<BestBook> getMainBestBookList(Book book) {
		return dao.getMainBestBookList(book);
	}

	public List<BestBook> getBestBookListCms(BestBook bestBook) {
		return dao.getBestBookListCms(bestBook);
	}

	@Transactional
	public int addBestBook(Book book) {
		return dao.addBestBook(book);
	}

	@Transactional
	public int deleteBestBook(Book book) {
		return dao.deleteBestBook(book);
	}

	public int getBestBookListCnt(Book book) {
		return dao.getBestBookListCnt(book);
	}

	public Book getCategoryBestBook(Book book) {
		return dao.getCategoryBestBook(book);
	}

	@Transactional
	public int addCategoryBestBook(Book book) {
		if(dao.getCategoryBestBookDupCnt(book) > 0) {
			return -1;
		}

		return dao.addCategoryBestBook(book);
	}

	@Transactional
	public int deleteCategoryBestBook(Book book) {
		return dao.deleteCategoryBestBook(book);
	}

	public List<Book> getCategoryBestBookList(Book book) {
		return dao.getCategoryBestBookList(book);
	}

	@Transactional
	public int raiseBestBook(Book book) {
		Book higher = dao.getHigherBestBook(book);

		if(higher == null) {
			return 0;
		} else {
			swapBestBook(higher, book);
			return 1;
		}
	}

	@Transactional
	public int lowerBestBook(Book book) {
		Book lower = dao.getLowerBestBook(book);

		if(lower == null) {
			return 0;
		} else {
			swapBestBook(lower, book);
			return 1;
		}

	}

	private void swapBestBook(Book book1, Book book2) {
		int tmp = book1.getBook_idx();
		book1.setBook_idx(book2.getBook_idx());
		dao.modifyBestBookBookIdx(book1);
		book2.setBook_idx(tmp);
		dao.modifyBestBookBookIdx(book2);
	}

	@Transactional
	public int raiseCategoryBestBook(Book book) {
		Book higher = dao.getHigherCategoryBestBook(book);

		if(higher == null) {
			return 0;
		} else if(higher.getPrint_seq() == book.getPrint_seq() - 1) {
			swapCategoryBestBook(higher, book);
			return 1;
		} else {
			book.setPrint_seq(higher.getPrint_seq() + 1);
			swapCategoryBestBook(higher, book);
			return 2;
		}
	}

	@Transactional
	public int lowerCategoryBestBook(Book book) {
		Book lower = dao.getLowerCategoryBestBook(book);

		if(lower == null) {
			return 0;
		} else if(lower.getPrint_seq() == book.getPrint_seq() + 1) {
			swapCategoryBestBook(lower, book);
			return 1;
		} else {
			lower.setPrint_seq(book.getPrint_seq() + 1);
			swapCategoryBestBook(lower, book);
			return 2;
		}

	}

	private void swapCategoryBestBook(Book book1, Book book2) {
		int tmp = book1.getPrint_seq();
		book1.setPrint_seq(book2.getPrint_seq());
		dao.modifyCategoryBestBookPrintSeq(book1);
		book2.setPrint_seq(tmp);
		dao.modifyCategoryBestBookPrintSeq(book2);
	}

	public List<Book> getNewBookList(Book book) {
		return dao.getNewBookList(book);
	}

	public int getNewBookListCnt(Book book) {
		return dao.getNewBookListCnt(book);
	}

	public int getBookListCnt(Book book) {
		return dao.getBookListCnt(book);
	}

	public List<BestBook> getBookList(Book book) {
		return dao.getBookList(book);
	}

	@Transactional
	public int modifyConfig(BestBook bestBook) {
		int result = 0;
		Config config = new Config("auto_update_yn", bestBook.getAuto_update_yn());
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result = configService.setConfigPair(config);

		config = new Config("types", bestBook.getTypes());
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result = configService.setConfigPair(config);

		config = new Config("date_range", String.valueOf(bestBook.getDate_range()));
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result += configService.setConfigPair(config);

		config = new Config("lend_weight", String.valueOf(bestBook.getLend_weight()));
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result += configService.setConfigPair(config);

		config = new Config("reserve_weight", String.valueOf(bestBook.getReserve_weight()));
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result += configService.setConfigPair(config);

		config = new Config("comment_weight", String.valueOf(bestBook.getComment_weight()));
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result += configService.setConfigPair(config);

		config = new Config("recommend_weight", String.valueOf(bestBook.getRecommend_weight()));
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result += configService.setConfigPair(config);

		config = new Config("audiobook_weight", String.valueOf(bestBook.getAudiobook_weight()));
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result += configService.setConfigPair(config);

		config = new Config("elearning_weight", String.valueOf(bestBook.getElearning_weight()));
		config.setModify_id(bestBook.getModify_id());
		config.setModify_ip(bestBook.getAdd_id());
		result += configService.setConfigPair(config);

		return result;
	}

	/**
	 * 메인화면용 신착/대출베스트 목록
	 *
	 * @author whalesoft 2019. 12. 13.
	 * @param book
	 * @return
	 */
	public List<Book> getMainBookList(Book book) {
		return dao.getMainBookList(book);
	}

}
