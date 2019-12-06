package kr.go.gbelib.app.cms.module.elib.api;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;

@Service
public class APIService extends BaseService {

	private static final String KYOBO = "KYOB";
	private static final String YES24 = "YESB";
	private static final String YPBOOKS = "Y2BK";
	private static final String BOOKCUBE = "FXLI";

	@Autowired
	private KyoboAPIService kyoboAPIService;

	@Autowired
	private Yes24APIService yes24APIService;

	@Autowired
	private BookcubeAPIService bookcubeAPIService;

	@Autowired
	private YPAPIService ypAPIService;

	protected Map<String, String> catchFail(String com_code, Map<String, String> map) throws ElibException {
		if(com_code == null) {
			return null;
		} else if(com_code.equals(KYOBO)) {
			String result = map.get("result");
			if(StringUtils.equals(result, "True") || StringUtils.equals(result, "Y")) {
				return map;
			} else {
				throw new ElibException("[교보문고] " + map.get("msg"), map);
			}
		} else if(com_code.equals(YES24)) {
			if(StringUtils.equals(map.get("result"), "True")) {
				return map;
			} else {
				throw new ElibException("[예스24] " + map.get("msgcode"), map);
			}
		} else if(com_code.equals(YPBOOKS)) {
			if(StringUtils.equals(map.get("result"), "YES")) {
				return map;
			} else {
				throw new ElibException("[영풍문고] " + map.get("msgcode"), map);
			}
		} else if(com_code.equals(BOOKCUBE)) {
			if(StringUtils.equals(map.get("result"), "true")) {
				return map;
			} else {
				throw new ElibException("[북큐브] " + map.get("desc"), map);
			}
		} else {
			return null;
		}
	}

	/**
	 * 대출
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> lend(Book book) throws ElibException {
		String com_code = book.getCom_code();
		Map<String, String> result = new HashMap<String, String>();

		if(com_code == null) {
			return null;
		} else if(com_code.equals(KYOBO)) {
			result = kyoboAPIService.lend(book);
			return catchFail(KYOBO, result);
		} else if(com_code.equals(YES24)) {
			result = yes24APIService.lend(book);
			return catchFail(YES24, result);
		} else if(com_code.equals(YPBOOKS)) {
			result = ypAPIService.lend(book);
			return catchFail(YPBOOKS, result);
		} else if(com_code.equals(BOOKCUBE)) {
			result = bookcubeAPIService.lend(book);
			return catchFail(BOOKCUBE, result);
		} else {
			return null;
		}
	}

	/**
	 * 반납
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> rtn(Book book) throws ElibException {
		String com_code = book.getCom_code();

		if(com_code == null) {
			return null;
		} else if(com_code.equals(KYOBO)) {
			Map<String, String> map = kyoboAPIService.rtn(book);
			String result = map.get("result");
			String msgcode = map.get("msgcode");

			if(!(StringUtils.equals(result, "True") || StringUtils.equals(result, "Y"))
					&& (StringUtils.equals(msgcode, "ERROR_NOT_EXIST_BORROW_ID") || StringUtils.equals(msgcode, "MSG_ERROR_0038"))) {
				return map;
			} else {
				return catchFail(KYOBO, map);
			}
		} else if(com_code.equals(YES24)) {
			Map<String, String> map = yes24APIService.rtn(book);
			String result = map.get("result");
			String msgcode = StringUtils.defaultString(map.get("msgcode"));

			if(StringUtils.equals(result, "False")
					&& (msgcode.indexOf("반납대기를 위한 라이센스 정보가 존재하지 않습니다") > -1
							|| msgcode.indexOf("이미 본인이 대출한 도서입니다") > -1)) {
				return map;
			} else if(StringUtils.isEmpty(result) && StringUtils.isEmpty(msgcode)) {
				return map;
			} else {
				return catchFail(YES24, map);
			}
		} else if(com_code.equals(YPBOOKS)) {
			Map<String, String> map = ypAPIService.rtn(book);
			String result = map.get("result");
			String msgcode = StringUtils.defaultString(map.get("msgcode"));

			if(StringUtils.equals(result, "NO") && StringUtils.equals(msgcode, "반납된 전자책 이거나 반납할 전자책이 없습니다.")) {
				return map;
			} else {
				return catchFail(YPBOOKS, map);
			}
		} else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.rtn(book));
		} else {
			return null;
		}
	}

	/**
	 * 연장
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> extend(Book book) throws ElibException {
		String com_code = book.getCom_code();

		if(com_code == null) {
			return null;
		} else if(com_code.equals(KYOBO)) {
			return catchFail(KYOBO, kyoboAPIService.extend(book));
		} else if(com_code.equals(YES24)) {
			return catchFail(YES24, yes24APIService.extend(book));
		} else if(com_code.equals(YPBOOKS)) {
			return catchFail(YPBOOKS, ypAPIService.extend(book));
		} else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.extend(book));
		} else {
			return null;
		}
	}

	/**
	 * 예약
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> reserve(Book book) throws ElibException {
		String com_code = book.getCom_code();

		if(com_code == null) {
			return null;
		}
//		else if(com_code.equals(KYOBO)) {
//			return catchFail(KYOBO, kyoboAPIService.reserve(book));
//		} else if(com_code.equals(YES24)) {
//			return catchFail(YES24, yes24APIService.reserve(book));
//		} else if(com_code.equals(YPBOOKS)) {
//			return catchFail(YPBOOKS, ypAPIService.reserve(book));
//		} else if(com_code.equals(BOOKCUBE)) {
//			return catchFail(BOOKCUBE, bookcubeAPIService.reserve(book));
//		}
		else {
			return null;
		}
	}


	/**
	 * 예약 취소
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> cancel(Book book) throws ElibException {
		String com_code = book.getCom_code();

		if(com_code == null) {
			return null;
		} else if(com_code.equals(KYOBO)) {
//			return catchFail(KYOBO, kyoboAPIService.cancel(book));
			kyoboAPIService.cancel(book);
			return null;
		} else if(com_code.equals(YES24)) {
//			return catchFail(YES24, yes24APIService.cancel(book));
			yes24APIService.cancel(book);
			return null;
		} else if(com_code.equals(YPBOOKS)) {
//			return catchFail(YPBOOKS, ypAPIService.cancel(book));
			ypAPIService.cancel(book);
			return null;
		} else if(com_code.equals(BOOKCUBE)) {
//			return catchFail(BOOKCUBE, bookcubeAPIService.cancel(book));
			bookcubeAPIService.cancel(book);
			return null;
		} else {
			return null;
		}
	}

	/**
	 * 회원 가입
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public void signup(ElibMember member, Book book) throws ElibException {
		String com_code = book.getCom_code();

		if(com_code == null) {
			return;
		} else if(com_code.equals(KYOBO)) {
//			catchFail(KYOBO, kyoboAPIService.signup(member, book));
			kyoboAPIService.signup(member, book);
		} else if(com_code.equals(YES24)) {
//			catchFail(YES24, yes24APIService.signup(member, book));
			yes24APIService.signup(member, book);
		} else if(com_code.equals(YPBOOKS)) {
//			catchFail(YPBOOKS, ypAPIService.signup(member, book));
			ypAPIService.signup(member, book);
		} else if(com_code.equals(BOOKCUBE)) {
//			catchFail(BOOKCUBE, bookcubeAPIService.signup(member, book));
			bookcubeAPIService.signup(member, book);
		} else {
			return;
		}
	}

	/**
	 * 회원 수정 (교보 전용)
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> edit(ElibMember member) throws ElibException {
		return catchFail(KYOBO, kyoboAPIService.edit(member));
	}

	/**
	 * 회원 탈퇴 (교보 전용)
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> delete(ElibMember member) throws ElibException {
		return catchFail(KYOBO, kyoboAPIService.delete(member));
	}

	/**
	 * 대출 정보 조회 (교보 전용)
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> view(Book book) throws ElibException {
		String com_code = book.getCom_code();

		if(com_code == null) {
			return null;
		} else if(com_code.equals(KYOBO)) {
			return catchFail(KYOBO, kyoboAPIService.view(book));
		} else {
			return null;
		}
	}

	/**
	 * 앱 호출 URL 조회
	 * @param book
	 * @return
	 * @throws ElibException
	 */
	public Map<String, String> appUrl(Book book, ElibMember member, String device) throws ElibException {
		String com_code = book.getCom_code();

		if(com_code == null) {
			return null;
		} else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.appUrl(book, member, device));
		} else if(com_code.equals(YES24)) {
			return catchFail(YES24, yes24APIService.appUrl(book, member, device));
		} else {
			return null;
		}
	}

}
