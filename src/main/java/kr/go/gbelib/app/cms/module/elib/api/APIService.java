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
	private static final String BOOKCUBE = "FXLI";
	private static final String ALADIN = "ALAD";

	@Autowired
	private KyoboAPIService kyoboAPIService;

	@Autowired
	private Yes24APIService yes24APIService;

	@Autowired
	private BookcubeAPIService bookcubeAPIService;

	@Autowired
	private AladinAPIService aladinAPIService;

	private String getKyoboMsg(String msgcode) {
		if("MSG_ERROR_0001".equals(msgcode)) return "지원되지 않는 서비스입니다. 확인 후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0002".equals(msgcode)) return "해당 컨텐츠가 존재하지 않습니다.";
		else if("MSG_ERROR_0004".equals(msgcode)) return "다른 회원이 먼저 해당 컨텐츠를 대출하셨습니다.";
		else if("MSG_ERROR_0003".equals(msgcode)) return "대출처리시 문제가 발생하였습니다. 잠시 후 다시 이용하여 주십시요. 라이센스 정보가 존재하지 않습니다.";
		else if("MSG_ERROR_0005".equals(msgcode)) return "현재 회원님은 대출권한이 없습니다. 도서관 관리자에게 문의하시기 바랍니다.현재 회원님은 대출정책에 속한 그룹이 없습니다.";
		else if("MSG_ERROR_0006".equals(msgcode)) return "대출권수를 초과 했습니다.";
		else if("MSG_ERROR_0007".equals(msgcode)) return "현재 회원님이 대출중인 컨텐츠 입니다.";
		else if("MSG_ERROR_0008".equals(msgcode)) return "현재 회원님이 예약중인 컨텐츠 입니다.";
		else if("MSG_ERROR_0009".equals(msgcode)) return "다른 회원이 먼저 해당 컨텐츠를 대출하셨습니다.";
		else if("MSG_ERROR_0010".equals(msgcode)) return "대출처리시 문제가 발생하였습니다. 잠시후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0011".equals(msgcode)) return "예약정보가 존재하지 않습니다. 확인 후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0012".equals(msgcode)) return "대출처리시 문제가 발생하였습니다. 잠시 후 다시 이용하여 주십시요. 일순위 대출가능 상태가 아닙니다.";
		else if("MSG_ERROR_0013".equals(msgcode)) return "현재 예약중인 회원이 대기중이여서 연장이 불가능합니다.";
		else if("MSG_ERROR_0015".equals(msgcode)) return "연장횟수가 초과하여 연장이 불가능합니다.";
		else if("MSG_ERROR_0016".equals(msgcode)) return "반납처리시 문제가 발생하였습니다. 잠시후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0017".equals(msgcode)) return "연장처리시 문제가 발생하였습니다. 잠시후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0018".equals(msgcode)) return "예약 권수를 초과 했습니다.";
		else if("MSG_ERROR_0019".equals(msgcode)) return "예약처리시 문제가 발생하였습니다. 잠시후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0020".equals(msgcode)) return "예약정보가 올바르지 않습니다. 확인 후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0021".equals(msgcode)) return "예약취소 처리시 문제가 발생하였습니다.잠시후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0022".equals(msgcode)) return "대출 일순위인 회원님은 대출정책에 속한 그룹이 없습니다.";
		else if("MSG_ERROR_0023".equals(msgcode)) return "이미 반납 처리가 되었습니다.";
		else if("MSG_ERROR_0024".equals(msgcode)) return "이미 반납된 도서입니다. 대출중인 도서만 연장이 가능합니다.";
		else if("MSG_ERROR_0025".equals(msgcode)) return "이미 반납된 도서입니다. 대출중인 도서만 다운로드가 가능합니다.";
		else if("MSG_ERROR_0026".equals(msgcode)) return "이미 예약취소 된 도서입니다.";
		else if("MSG_ERROR_0027".equals(msgcode)) return "로그인 상태가 아닙니다.";
		else if("MSG_ERROR_0028".equals(msgcode)) return "다른 컴퓨터에서 로그인 하여 현재 컴퓨터에서 로그아웃 됩니다.";
		else if("MSG_ERROR_0029".equals(msgcode)) return "이미 자동 반납 되었습니다.";
		else if("MSG_ERROR_0030".equals(msgcode)) return "이미 자동 예약취소 되었습니다.";
		else if("MSG_ERROR_0031".equals(msgcode)) return "라이센스 정보를 획득하지 못했습니다.";
		else if("MSG_ERROR_0031".equals(msgcode)) return "대출 건수와 예약 건수의 합이 라이센스 건수를 초과하였습니다.";
		else if("NO_MACHING_IF_ID".equals(msgcode)) return "일치하는 IF_ID가 존재하지 않습니다.";
		else if("NO_MATCHING_CMD".equals(msgcode)) return "일치하는 CMD가 존재하지 않습니다.";
		else if("NOT_EXIST_MEMBER_INFO".equals(msgcode)) return "해당 회원 정보가 존재하지 않습니다.";
		else if("INSERT_CONTENT_BORROW_PROLICY_ERROR".equals(msgcode)) return "회원 대출 정책 등록오류가 발생하였습니다.";
		else if("INSERT_CONTENT_BORROW_GROUP_ERROR".equals(msgcode)) return "회원 그룹 등록오류가 발생하였습니다.";
		else if("EXIST_MEMBER_INFO".equals(msgcode)) return "해당 회원 정보가 존재합니다.";
		else if("ERROR_LIBRARY_URL".equals(msgcode)) return "도서관 서비스 URL이 올바르지 않습니다.";
		else if("ERROR_NOT_EXIST_USER_ID".equals(msgcode)) return "회원정보가 존재하지 않습니다.";
		else if("ERROR_NOT_EXIST_BORROW_ID".equals(msgcode)) return "대출정보가 존재하지 않습니다.";
		else if("ERROR_NOT_EXIST_RESERVE_ID".equals(msgcode)) return "예약정보가 존재하지 않습니다.";
		else if("ERROR_ACCESS_POINT".equals(msgcode)) return "접근경로가 올바르지 않습니다.";
		else if("MSG_ERROR_0032".equals(msgcode)) return "사용이 중지된 컨텐츠 입니다.\n관리자에게 문의해주세요.";
		else if("MSG_ERROR_0033".equals(msgcode)) return "통합/연동형 통신 중 오류가 발생했습니다.";
		else if("MSG_ERROR_0034".equals(msgcode)) return "해당 콘텐츠는 회원 별 총 $1권 대출이 가능합니다.";
		else if("MSG_ERROR_0035".equals(msgcode)) return "해당 콘텐츠는 회원 별 총 $1권 예약이 가능합니다.";
		else if("MSG_ERROR_0036".equals(msgcode)) return "필수 파라미터가 누락되었습니다.";
		else if("MSG_ERROR_0037".equals(msgcode)) return "지원하지 않는 디바이스입니다.";
		else if("MSG_ERROR_0038".equals(msgcode)) return "대출정보가 존재하지 않습니다.\n\n확인 후 다시 이용하여 주십시요.";
		else if("MSG_ERROR_0039".equals(msgcode)) return "회원이 존재하지 않습니다.";
		else if("MSG_ERROR_0040".equals(msgcode)) return "예약권수를 초과하였습니다. 도서관 정책에 따라 예약 가능한 0권 중 대출도서 00권이 차감되어 예약가능 권수가 남아있지 않습니다.";
		else if("MSG_ERROR_0041".equals(msgcode)) return "해당 컨텐츠의 예약가능 권수를 초과 했습니다. 도서관 정책에 따라 예약가능한 00권 중 대출도서 00권이 차감되어 예약가능권수가 남아있지 않습니다.";
		else if("MSG_ERROR_0042".equals(msgcode)) return "이미 예약취소 처리가 되었습니다.";
		else return msgcode;
	}
	
	protected Map<String, String> catchFail(String com_code, Map<String, String> map) throws ElibException {
		if(com_code == null) {
			return null;
		}
		else if(com_code.equals(KYOBO)) {
			String result = map.get("result");
			if(StringUtils.equals(result, "True") || StringUtils.equals(result, "Y")) {
				return map;
			} else {
				throw new ElibException("[교보문고] " + getKyoboMsg(map.get("msgcode")), map);
			}
		}
		else if(com_code.equals(YES24)) {
			if(StringUtils.equals(map.get("result"), "True") || StringUtils.equals(map.get("result"), "YES")) {
				return map;
			} else {
				throw new ElibException("[예스24] " + map.get("msgcode"), map);
			}
		}
		else if(com_code.equals(BOOKCUBE)) {
			if(StringUtils.equals(map.get("result"), "true")) {
				return map;
			} else {
				throw new ElibException("[북큐브] " + map.get("desc"), map);
			}
		}
		else if(com_code.equals(ALADIN)) {
			if(StringUtils.equals(map.get("result"), "Y")) {
				return map;
			} else {
				throw new ElibException("[알라딘] " + map.get("msgcode"), map);
			}
		}
		else {
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
		}
		else if(com_code.equals(KYOBO)) {
			result = kyoboAPIService.lend(book);
			return catchFail(KYOBO, result);
		}
		else if(com_code.equals(YES24)) {
			result = yes24APIService.lend(book);
			return catchFail(YES24, result);
		}
		else if(com_code.equals(BOOKCUBE)) {
			result = bookcubeAPIService.lend(book);
			return catchFail(BOOKCUBE, result);
		}
		else if(com_code.equals(ALADIN)) {
			result = aladinAPIService.lend(book);
			return catchFail(ALADIN, result);
		}
		else {
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
		}
		else if(com_code.equals(KYOBO)) {
			Map<String, String> map = kyoboAPIService.rtn(book);
			String result = map.get("result");
			String msgcode = map.get("msgcode");

			if(!(StringUtils.equals(result, "True") || StringUtils.equals(result, "Y"))
					&& (StringUtils.equals(msgcode, "ERROR_NOT_EXIST_BORROW_ID") || StringUtils.equals(msgcode, "MSG_ERROR_0038"))) {
				return map;
			} else {
				return catchFail(KYOBO, map);
			}
		}
		else if(com_code.equals(YES24)) {
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
		}
		else if(com_code.equals(BOOKCUBE)) {
			Map<String, String> map = bookcubeAPIService.rtn(book);
			String result = map.get("result");
			String code = map.get("code");
			
			if(StringUtils.equals(result, "false") && StringUtils.equals(code, "305")) {
				return map;
			} else {
				return catchFail(BOOKCUBE, map);
			}
		}
		else if(com_code.equals(ALADIN)) {
			Map<String, String> map = aladinAPIService.rtn(book);
			String result = map.get("result");
			String msgcode = map.get("msgcode");
			
			if(StringUtils.equals(result, "N") && (StringUtils.indexOf(msgcode, "대출중인 도서가 아닙니다.") > -1)) {
				return map;
			} else {
				return catchFail(ALADIN, map);
			}
		}
		else {
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
		}
		else if(com_code.equals(KYOBO)) {
			return catchFail(KYOBO, kyoboAPIService.extend(book));
		}
		else if(com_code.equals(YES24)) {
			return catchFail(YES24, yes24APIService.extend(book));
		}
		else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.extend(book));
		}
		else if(com_code.equals(ALADIN)) {
			return catchFail(ALADIN, aladinAPIService.extend(book));
		}
		else {
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
		else if(com_code.equals(KYOBO)) {
			return catchFail(KYOBO, kyoboAPIService.reserve(book));
		}
		else if(com_code.equals(YES24)) {
			return catchFail(YES24, yes24APIService.reserve(book));
		}
		else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.reserve(book));
		}
		else if(com_code.equals(ALADIN)) {
			return catchFail(ALADIN, aladinAPIService.reserve(book));
		}
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
		}
		else if(com_code.equals(KYOBO)) {
			Map<String, String> map = kyoboAPIService.cancel(book);
			String result = map.get("result");
			String msgcode = map.get("msgcode");
			
			if(!(StringUtils.equals(result, "True") || StringUtils.equals(result, "Y"))
					&& StringUtils.equals(msgcode, "ERROR_NOT_EXIST_BORROW_ID")) {
				return map;
			} else {
				return catchFail(KYOBO, map);
			}
		}
		else if(com_code.equals(YES24)) {
			return catchFail(YES24, yes24APIService.cancel(book));
		}
		else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.cancel(book));
		}
		else if(com_code.equals(ALADIN)) {
			return catchFail(ALADIN, aladinAPIService.cancel(book));
		}
		else {
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
		}
		else if(com_code.equals(KYOBO)) {
//			catchFail(KYOBO, kyoboAPIService.signup(member, book));
			kyoboAPIService.signup(member, book);
		}
		else if(com_code.equals(YES24)) {
//			catchFail(YES24, yes24APIService.signup(member, book));
			yes24APIService.signup(member, book);
		}
		else if(com_code.equals(BOOKCUBE)) {
//			catchFail(BOOKCUBE, bookcubeAPIService.signup(member, book));
			bookcubeAPIService.signup(member, book);
		}
		else if(com_code.equals(ALADIN)) {
//			catchFail(ALADIN, aladinAPIService.signup(member, book));
			aladinAPIService.signup(member, book);
		}
		else {
			return;
		}
	}

//	/**
//	 * 회원 수정 (교보 전용)
//	 * @param book
//	 * @return
//	 * @throws ElibException
//	 */
//	public Map<String, String> edit(ElibMember member) throws ElibException {
//		return catchFail(KYOBO, kyoboAPIService.edit(member));
//	}
//
//	/**
//	 * 회원 탈퇴 (교보 전용)
//	 * @param book
//	 * @return
//	 * @throws ElibException
//	 */
//	public Map<String, String> delete(ElibMember member) throws ElibException {
//		return catchFail(KYOBO, kyoboAPIService.delete(member));
//	}

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
