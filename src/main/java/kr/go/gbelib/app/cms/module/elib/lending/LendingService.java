package kr.go.gbelib.app.cms.module.elib.lending;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ch.qos.logback.classic.Logger;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.api.APIService;
import kr.go.gbelib.app.cms.module.elib.api.ElibException;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.book.BookService;
import kr.go.gbelib.app.cms.module.elib.config.Config;
import kr.go.gbelib.app.cms.module.elib.config.ConfigService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Service
public class LendingService extends BaseService {

	@Autowired
	private LendingDao dao;

	@Autowired
	private ConfigService configService;

	@Autowired
	private BookService bookService;

	@Autowired
	private APIService apiService;

	public List<Lending> getLendMemberList(Lending lending) {
		return dao.getLendMemberList(lending);
	}

	public int getLendMemberListCnt(Lending lending) {
		return dao.getLendMemberListCnt(lending);
	}

	public List<Lending> getAudioMemberList(Lending lending) {
		return dao.getAudioMemberList(lending);
	}

	public int getAudioMemberListCnt(Lending lending) {
		return dao.getAudioMemberListCnt(lending);
	}

	public List<Lending> getReserveMemberList(Lending lending) {
		return dao.getReserveMemberList(lending);
	}

	public int getReserveMemberListCnt(Lending lending) {
		return dao.getReserveMemberListCnt(lending);
	}

	public List<Lending> getLendMemberListAll(Lending lending) {
		return dao.getLendMemberListAll(lending);
	}

	public List<Lending> getReserveMemberListAll(Lending lending) {
		return dao.getReserveMemberListAll(lending);
	}

	public void updateDateAndCnt(Lending lending) throws ElibException {
		dao.updateLendReserveCnt(lending);
	}

	/**
	 * 대여 가능 여부 체크
	 * @param lending
	 * @param isFromReturn
	 * @return
	 */
	private int checkBorrow(Lending lending, boolean isFromReturn) {
		// 환경변수
		Config config = configService.getConfig();
		if(config == null) 	return -1;

		// 최대 사용자 대출 권수를 초과할 경우 대여 불가
		int user_max_lend = config.getUser_max_lend();
		int borrow_cnt = dao.getUserBorrowCnt(lending);
		if(borrow_cnt >= user_max_lend) return -6;

		// 책정보
		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));
		if(book == null) return -10;

		// 환경변수보다 개별 책의 최대 대출권수가 우선
		int book_max_lend = config.getBook_max_lend();
		int book_max_lend_book = book.getMax_lend();
		if(book_max_lend_book > 0) book_max_lend = book_max_lend_book;

		// 대출 권수 가져오기
		int book_lend_cnt = dao.getBookLendCnt(lending);

		if(!isFromReturn) {
			// 이미 예약된 책은 대여 불가
			int dup_cnt = dao.getDupReserveCnt(lending);
			if(dup_cnt > 0) return -9;
		}

		// 반납하지 않은 책은 대여 불가
		int not_returned_cnt = dao.getNotReturnedCnt(lending);
		if(not_returned_cnt > 0) return -2;

		// 최대 책 대여 건 수 초과일 경우
		int book_reserve_cnt = book.getBook_reserve();

		if(book_lend_cnt >= book_max_lend) {
			int max_reserve = config.getMax_reserve();
			if(max_reserve == 0 || book_reserve_cnt >= max_reserve) {
				// 최대 예약 건 수 초과일 경우 대여 불가
				return -4;
			} else {
				// 예약으로 전환
				return 1;
			}
		}

		// 나머지는 대여 가능
		return 0;
	}

	private String koreanDateFormat(String date) {
		SimpleDateFormat parse = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat format = new SimpleDateFormat("yyyy'.' M'.' d'.' '('EE')'",  Locale.KOREA);
		try {
			return format.format(parse.parse(date));
		} catch (ParseException e) {
			return date;
		}
	}

	/**
	 * 대여
	 * @param lending
	 * @param isFromReturn
	 * @return
	 * @throws ElibException
	 */
	public int borrowProc(Lending lending, boolean isFromReturn, Object... args) throws ElibException {
		return _borrowProc(lending, isFromReturn, true, args);
	}

	public int borrowProcNoApi(Lending lending, boolean isFromReturn, Object... args) throws ElibException {
		return _borrowProc(lending, isFromReturn, false, args);
	}

	@Transactional
	private int _borrowProc(Lending lending, boolean isFromReturn, boolean useApi, Object[] args) throws ElibException {
		int result = checkBorrow(lending, isFromReturn);
		if(result < 0) return result;

		if(result == 0) {
			// 대출
			Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));

			book.setMember_id(lending.getMember_id());
			if(useApi) apiService.lend(book);

			lending.setCom_code(book.getCom_code());
			lending.setExtention_count(0);
			if (StringUtils.isEmpty(lending.getDevice())) {
				lending.setDevice("P");
			}

			result = dao.addLending(lending);

			updateDateAndCnt(lending);

			if(args != null && args.length > 0 && args[0] instanceof Homepage) {
				lending = getLending(lending);
			}

			return 0;
		} else if(result == 1) {
			return 1;
		}

		return 0;
	}

	/**
	 * 반납
	 * @param lending
	 * @return
	 * @throws ElibException
	 */
	public int returnProc(Lending lending, Object... args) throws ElibException {
		return _returnProc(lending, true, args);
	}

	public int returnProcNoApi(Lending lending, Object... args) throws ElibException {
		return _returnProc(lending, false, args);
	}

	@Transactional
	private int _returnProc(Lending lending, boolean useApi, Object[] args) throws ElibException {
		Config config = configService.getConfig();
 		if(config == null) 	return -1;

		lending = dao.getLending(lending);
		if(lending == null) return -2;

		if(!StringUtils.isEmpty(lending.getReturn_dt())) return -3;

		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));
		if(book == null) return -4;

		book.setMember_id(lending.getMember_id());
		if(useApi) apiService.rtn(book);

		dao.returnLending(lending);

		updateDateAndCnt(lending);

		// 예약데이터 중 첫 번째 예약을 자동 대여로 처리
		List<Lending> reserveList = dao.getBookReserveList(lending);
		for(Lending reserve: reserveList) {
			int result = -4;

			if(args != null && args.length > 0 && args[0] instanceof Homepage) {
				result = _borrowProc(reserve, true, useApi, args);
			} else {
				result = _borrowProc(reserve, true, useApi, null);
			}

			if(result == 0) {
				Book book1 = new Book(reserve);
				book1.setBook_code(book.getBook_code());
				if(useApi && !book1.getCom_code().equals("YESB") && !book1.getCom_code().equals("FXLI")) apiService.cancel(book1);
				result = dao.reserveToLending(reserve);
				try {
					LibrarySearch librarySearch = new LibrarySearch();
					librarySearch.setMember_id(reserve.getMember_id());
					
					String userKey = LibSearchAPI.getUserkey(librarySearch);
					librarySearch.setUserkey(userKey);
					librarySearch.setManageCode("AD");
					
					lending.setBook_idx(reserve.getBook_idx());
					String book_name = dao.getBookName(lending);
					String ip = "100.31.35.29";
					
					String mes = "전자도서관에 예약하신 도서[" + book_name + "]가 대출되었습니다.";
	                LibSearchAPI.sendSms(librarySearch, mes, ip);
				} catch (Exception e) {
					e.printStackTrace();
				}
//				dao.setMsgConfirmN(reserve);
				break;
			}
		}

		updateDateAndCnt(lending);

		return 0;
	}

//	private String printDates(Date[] Dates) {
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		StringBuilder sb = new StringBuilder();
//
//		for(Date date: Dates) {
//			sb.append(sdf.format(date) + " ");
//		}
//
//		return sb.toString();
//	}
//

	/**
	 * 예약 취소
	 * @param lending
	 * @return
	 * @throws ElibException
	 */
	public int reserveCancel(Lending lending) throws ElibException {
		return _reserveCancel(lending, true);
	}

	public int reserveCancelNoApi(Lending lending) throws ElibException {
		return _reserveCancel(lending, false);
	}

	@Transactional
	private int _reserveCancel(Lending lending, boolean useApi) throws ElibException {

		// 예약 정보가 있는지 검사
		int cnt = dao.getReserveCnt(lending);
		if(cnt != 1) return -2;

		Lending reserve = dao.getReserve(lending);
		if(reserve == null) return -3;

		// 책정보
		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));
		if(book == null) return -1;

		book.setMember_id(lending.getMember_id());
		if(useApi) apiService.cancel(book);

		dao.deleteReserve(lending);

		updateDateAndCnt(lending);

		return 0;
	}

	public int getBookLendCnt(Lending lending) {
		return dao.getBookLendCnt(lending);
	}

	public int getBookReserveCnt(Lending lending) {
		return dao.getBookReserveCnt(lending);
	}

	public int getNotReturnedCnt(Lending lending) {
		return dao.getNotReturnedCnt(lending);
	}

	public int getDupReserveCnt(Lending lending) {
		return dao.getDupReserveCnt(lending);
	}

	/**
	 * 예약
	 * @param lending
	 * @return
	 * @throws ElibException
	 */
	public int reserveProc(Lending lending) throws ElibException {
		return _reserveProc(lending, true);
	}

	public int reserveProcNoApi(Lending lending) throws ElibException {
		return _reserveProc(lending, false);
	}

	@Transactional
	private int _reserveProc(Lending lending, boolean useApi) throws ElibException {
		Config config = configService.getConfig();
		if(config == null) return -1;

		// 도서가 존재하는지 체크
		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));
		if(book == null) return -1;

		// 대출 가능한 책은 예약 불가
		if(book.getMax_lend() != book.getBook_lend()) return -11;

		// 개인 최대 예약 여부 체크
		int max_reserve = config.getMax_reserve();
		int member_reserve_cnt = dao.getMemberReserveCnt(lending);
		if(member_reserve_cnt >= max_reserve) return -10;

		// 중복 예약 체크
		int dup_reserve_cnt = dao.getDupReserveCnt(lending);
		if(dup_reserve_cnt > 0) return -5;

		// 대출 여부 체크
		int dup_cnt = dao.getDupLendingCnt(lending);
		if(dup_cnt > 0) return -9;

		// int reserve_cnt = dao.getBookReserveCnt(lending);

		// 개별 책 최대 예약 수 체크
		int book_max_reserve = config.getBook_max_reserve();
		int book_reserve = book.getBook_reserve();
		if(book_reserve >= book_max_reserve) return -12;

		book.setMember_id(lending.getMember_id());
		if(useApi) apiService.reserve(book);

		dao.addReserve(lending);

		updateDateAndCnt(lending);

		return 0;
	}

	public int getFavoritesListCnt(Lending lending) {
		return dao.getFavoritesListCnt(lending);
	}

	public List<Lending> getFavoritesList(Lending lending) {
		return dao.getFavoritesList(lending);
	}

	@Transactional
	public int addFavorite(Lending lending) {

		if(dao.getDupFavoritesCnt(lending) > 0) return -1;

		return dao.addFavorite(lending);
	}

	public int deleteFavorite(Lending lending) {
		return dao.deleteFavorite(lending);
	}

	public int checkExtend(Lending lending) {
		Config config = configService.getConfig();
 		if(config == null) 	return -1;

 		// 도서가 존재하는지 체크
		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));
		if(book == null) return -7;

 		// 대출 기록이 있나 체크
		lending = dao.getLending(lending);
		if(lending == null) return -6;

		// 이미 반납했으면 연장 불가
		if(lending.getReturn_dt() != null) return -2;

		// 연장 횟수 초과면 연장 불가
		if(lending.getExtention_count() >= config.getMax_extention()) return -3;

		// 대출한 책이 예약에 묶여 있이다면 연장 불가
		if("Y".equals(lending.getReserve_yn())) return -4;

		// 예약이 돼 있으면 연장 불가
		int reserveCnt = dao.getBookReserveCnt(lending);
		if(reserveCnt > 0) return -5;

		return 0;
	}

	/**
	 * 연장
	 * @param lending
	 * @return
	 * @throws ElibException
	 */
	public int extendProc(Lending lending, Book book) throws ElibException {
		return _extendProc(lending, book, true);
	}

	public int extendProcNoApi(Lending lending, Book book) throws ElibException {
		return _extendProc(lending, book, false);
	}

	@Transactional
	private int _extendProc(Lending lending, Book book, boolean useApi) throws ElibException {
		int result = checkExtend(lending);
		if(result < 0) return result;

		book.setMember_id(lending.getMember_id());

		if(useApi) apiService.extend(book);

		return dao.extendLending(lending);
	}

	public Lending getLending(Lending lending) {
		return dao.getLending(lending);
	}

	public int returnLending(Lending lending) {
		return dao.returnLending(lending);
	}

	/**
	 * API 통신 없이 대출 후 즉시 반납 (교보문고 - 키즈북)
	 * @param lending
	 * @param b
	 * @param homepage
	 * @return
	 */
	public int borrowImmedReturnProc(Lending lending) {

		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));

		book.setMember_id(lending.getMember_id());

		lending.setCom_code(book.getCom_code());
		lending.setExtention_count(0);
		if (StringUtils.isEmpty(lending.getDevice())) {
			lending.setDevice("P");
		}

//		return dao.addLendingWithReturn(lending);
		return dao.addAutdioBookStat(lending);
	};

	/**
	 * 자동반납
	 * @param lending
	 * @return
	 * @throws ElibApiCallFailException
	 */
	public int autoReturnProc(Lending lending, Object... args) throws ElibException {
		return _autoReturnProc(lending, true, args);
	}

	public int autoReturnProcNoApi(Lending lending, Object... args) throws ElibException {
		return _autoReturnProc(lending, false, args);
	}

	@Transactional
	private int _autoReturnProc(Lending lending, boolean useApi, Object[] args) throws ElibException {
		Config config = configService.getConfig();
		if(config == null) 	return -1;

		lending = dao.getLendingByLendIdx(lending);
		if(lending == null) return -2;

		System.out.println(String.format("@@@@@@@@@@ _autoReturnProc useApi: %s, member_id: %s, com_code: %s, lend_idx: %s, book_idx: %s, lend_dt: %s, return_due_dt: %s",
				useApi, lending.getMember_id(), lending.getCom_code(), lending.getLend_idx(), lending.getBook_idx(), lending.getLend_dt(), lending.getReturn_due_dt()));

		if(!StringUtils.isEmpty(lending.getReturn_dt())) return -3;

		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));

		book.setMember_id(lending.getMember_id());
		try {
			if(useApi) apiService.rtn(book);
		} catch ( ElibException e ) {
			System.out.println("@@@@@@@@@@@@@@@@ autoReturnFail, COM_CODE="+book.getCom_code()+" : " + e.getMessage());
			throw e;
		}

		dao.returnLending(lending);

		updateDateAndCnt(lending);

		// 예약데이터 중 첫 번째 예약을 자동 대여로 처리
		List<Lending> reserveList = dao.getBookReserveList(lending);
		for(Lending reserve: reserveList) {
			int result = -4;

			if(args != null && args.length > 0 && args[0] instanceof Homepage) {
				result = _borrowProc(reserve, true, useApi, args);
			} else {
				result = _borrowProc(reserve, true, useApi, null);
			}

			if(result == 0) {
				Book book1 = new Book(reserve);
				book1.setBook_code(book.getBook_code());
				if(useApi && !book1.getCom_code().equals("YESB") && !book1.getCom_code().equals("FXLI")) apiService.cancel(book1);
				result = dao.reserveToLending(reserve);
				try {
					LibrarySearch librarySearch = new LibrarySearch();
					librarySearch.setMember_id(reserve.getMember_id());
					
					String userKey = LibSearchAPI.getUserkey(librarySearch);
					librarySearch.setUserkey(userKey);
					librarySearch.setManageCode("AD");
					
					lending.setBook_idx(reserve.getBook_idx());
					String book_name = dao.getBookName(lending);
					String ip = "100.31.35.29";
					
					String mes = "전자도서관에 예약하신 도서[" + book_name + "]가 대출되었습니다.";
	                LibSearchAPI.sendSms(librarySearch, mes, ip);
				} catch (Exception e) {
					e.printStackTrace();
				}
//				dao.setMsgConfirmN(reserve);
				break;
			}
		}

		updateDateAndCnt(lending);

		return 0;
	}

	/**
	 * 자동 예약 대출 전환
	 * @param lending
	 * @return
	 * @throws ElibApiCallFailException
	 */
	public int autoReserveToLendProc(Lending lending, Object... args) throws ElibException {
		return _autoReserveToLendProc(lending, true, args);
	}

	public int autoReserveToLendProcNoApi(Lending lending, Object... args) throws ElibException {
		return _autoReserveToLendProc(lending, false, args);
	}

	@Transactional
	private int _autoReserveToLendProc(Lending lending, boolean useApi, Object[] args) throws ElibException {
		Config config = configService.getConfig();
		if(config == null) 	return -1;

		// 예약데이터 중 첫 번째 예약을 자동 대여로 처리
		List<Lending> reserveList = dao.getBookReserveList(lending);
		for(Lending reserve: reserveList) {
			int result = -4;

			if(args != null && args.length > 0 && args[0] instanceof Homepage) {
				result = _borrowProc(reserve, true, useApi, args);
			} else {
				result = _borrowProc(reserve, true, useApi, null);
			}

			if(result == 0) {
				Book book1 = new Book(reserve);
				book1.setBook_code(lending.getBook_code());
				if(useApi && !book1.getCom_code().equals("YESB") && !book1.getCom_code().equals("FXLI")) apiService.cancel(book1);
				result = dao.reserveToLending(reserve);
//				dao.setMsgConfirmN(reserve);
				
				try {
					LibrarySearch librarySearch = new LibrarySearch();
					librarySearch.setMember_id(reserve.getMember_id());
					
					String userKey = LibSearchAPI.getUserkey(librarySearch);
					librarySearch.setUserkey(userKey);
					librarySearch.setManageCode("AD");
					
					lending.setBook_idx(reserve.getBook_idx());
					String book_name = dao.getBookName(lending);
					String ip = "100.31.35.29";
					
					String mes = "전자도서관에 예약하신 도서[" + book_name + "]가 대출되었습니다.";
	                LibSearchAPI.sendSms(librarySearch, mes, ip);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				break;
			}
		}

		updateDateAndCnt(lending);

		return 0;
	}

	/**
	 * API 통신 없이 대출 후 즉시 반납 e-러닝
	 * @param lending
	 * @param b
	 * @param homepage
	 * @return
	 */
	public int borrowImmedReturnProcLearning(Lending lending) {

		Book book = bookService.getBookInfo(new Book(lending.getBook_idx()));

		book.setMember_id(lending.getMember_id());

		lending.setCom_code(book.getCom_code());
		lending.setExtention_count(0);
		if (StringUtils.isEmpty(lending.getDevice())) {
			lending.setDevice("P");
		}

//		return dao.addLendingWithReturn(lending);
//		return dao.addAutdioBookStat(lending);
		return dao.addElearnStat(lending);
	};

	public int addExtlinkStat(Book book) {
		return dao.addExtlinkStat(book);
	}

	public int getMemberReserveCnt(Lending lending) {
		return dao.getMemberReserveCnt(lending);
	}

}
