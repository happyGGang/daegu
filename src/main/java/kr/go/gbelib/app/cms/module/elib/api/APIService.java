package kr.go.gbelib.app.cms.module.elib.api;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;

@Service
public class APIService extends BaseService {
	
	private static final String YES24 = "YESB";
	private static final String BOOKCUBE = "FXLI";
	private static final String OPMS = "OPMS";
	private static final String ECO = "ECO";
	private static final String IPAPRIKA = "ITPK";
	
	@Autowired
	private Yes24APIService yes24APIService;
	
	@Autowired
	private BookcubeAPIService bookcubeAPIService;
	
	@Autowired
	private OpmsAPIService opmsAPIService;
	
	@Autowired
	private EcoAPIService ecoAPIService;
	
	@Autowired
	private IpaprikaAPIService ipaprikaAPIService;
	
	protected Map<String, String> catchFail(String com_code, Map<String, String> map) throws ElibException {
		if(com_code == null) {
			return null;
		} else if(com_code.equals(OPMS)) {
			String result = map.get("result");
			if(StringUtils.equals(result, "Y") || StringUtils.equals(result, "True") || StringUtils.equals(result, "YES")) {
				return map;
			} else {
				throw new ElibException("[OPMS] " + map.get("message"), map);
			}
		}
		else if(com_code.equals(YES24)) {
			if(StringUtils.equals(map.get("result"), "True") || StringUtils.equals(map.get("result"), "YES")) {
				return map;
			} else {
				throw new ElibException("[예스24] " + map.get("msgcode"), map);
			}
		}
		else if(com_code.equals(ECO)) {
			if(StringUtils.equals(map.get("result"), "Y") || StringUtils.equals(map.get("result"), "True") || StringUtils.equals(map.get("result"), "YES")) {
				return map;
			} else {
				throw new ElibException("[ECO] " + map.get("msg"), map);
			}
		}
		else if(com_code.equals(IPAPRIKA)) {
			if(StringUtils.equals(map.get("result"), "0")) {
				return map;
			} else {
				throw new ElibException("[IPAPRIKA] " + map.get("msg"), map);
			}
		}
		else if(com_code.equals(BOOKCUBE)) {
			if(StringUtils.equals(map.get("result"), "true")) {
				return map;
			} else {
				throw new ElibException("[북큐브] " + map.get("desc"), map);
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
		} else if(com_code.equals(OPMS)) {
//			result = opmsAPIService.lend(book);
//			return catchFail(OPMS, result);
			return null;
		}
		else if(com_code.equals(YES24)) {
			result = yes24APIService.lend(book);
			return catchFail(YES24, result);
		}
		else if(com_code.equals(ECO)) {
//			result = ecoAPIService.lend(book);
//			return catchFail(ECO, result);
			return null;
		}
		else if(com_code.equals(IPAPRIKA)) {
			Map<String, String> map = ipaprikaAPIService.lend(book);
			String result1 = map.get("result");
			String msg = map.get("msg");
			
			if(StringUtils.equals(result1, "0") || StringUtils.equals(result1, "2097172")) {
				return map;
			} else {
				return catchFail(IPAPRIKA, map);
			}
		}
		else if(com_code.equals(BOOKCUBE)) {
			result = bookcubeAPIService.lend(book);
			return catchFail(BOOKCUBE, result);
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
		} else if(com_code.equals(OPMS)) {
//			Map<String, String> map = opmsAPIService.rtn(book);
//			String result = map.get("result");
//			String message = StringUtils.defaultString(map.get("message"));
//			
//			if(StringUtils.equals(result, "Y") && message.indexOf("반납된 컨텐츠 이거나 반납할 데이타가 없습니다.") > -1) {
//				return map;
//			} else {
//				return catchFail(OPMS, map);
//			}
			return null;
		}
		else if(com_code.equals(YES24)) {
			Map<String, String> map = yes24APIService.rtn(book);
			String result = map.get("result");
			String msgcode = StringUtils.defaultString(map.get("msgcode"));
			
			if(StringUtils.equals(result, "False") && msgcode.indexOf("반납대기를 위한 라이센스 정보가 존재하지 않습니다") > -1) {
				return map;
			} else {
				return catchFail(YES24, map);
			}
		}
		else if(com_code.equals(ECO)) {
//			Map<String, String> map = ecoAPIService.rtn(book);
//			String result = map.get("result");
//			String msgcode = map.get("msg");
//			
//			if(!(StringUtils.equals(result, "Y")) && StringUtils.contains(msgcode, "이미")) {
//				return map;
//			} else {
//				return catchFail(ECO, map);
//			}
			return null;
		}
		else if(com_code.equals(IPAPRIKA)) {
			Map<String, String> map = ipaprikaAPIService.rtn(book);
			String result = map.get("ERROR_CODE");
			String msgcode = map.get("ERROR_MSG");
			
			if(StringUtils.equals(result, "0")) {
				return map;
			} else {
				return catchFail(IPAPRIKA, map);
			}
		}
		else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.rtn(book));
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
		} else if(com_code.equals(OPMS)) {
//			return catchFail(OPMS, opmsAPIService.extend(book));
			return null;
		}
		else if(com_code.equals(YES24)) {
			return catchFail(YES24, yes24APIService.extend(book));
		}
		else if(com_code.equals(ECO)) {
//			return catchFail(ECO, ecoAPIService.extend(book));
			return null;
		}
		else if(com_code.equals(IPAPRIKA)) {
			return catchFail(IPAPRIKA, ipaprikaAPIService.extend(book));
		}
		else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.extend(book));
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
		} else if(com_code.equals(OPMS)) {
//			return catchFail(OPMS, opmsAPIService.reserve(book));
			return null;
		}
		else if(com_code.equals(YES24)) {
			return catchFail(YES24, yes24APIService.reserve(book));
		}
		else if(com_code.equals(ECO)) {
			throw new ElibException("ECO 전자책은 예약 기능을 지원하지 않습니다.");
		}
		else if(com_code.equals(IPAPRIKA)) {
			return catchFail(IPAPRIKA, ipaprikaAPIService.reserve(book));
		}
		else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.reserve(book));
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
		} else if(com_code.equals(OPMS)) {
//			return catchFail(OPMS, opmsAPIService.cancel(book));
			return null;
		}
		else if(com_code.equals(YES24)) {
			return catchFail(YES24, yes24APIService.cancel(book));
		}
		else if(com_code.equals(ECO)) {
			throw new ElibException("ECO 전자책은 예약 취소 기능을 지원하지 않습니다.");
		}
		else if(com_code.equals(IPAPRIKA)) {
			return catchFail(IPAPRIKA, ipaprikaAPIService.cancel(book));
		}
		else if(com_code.equals(BOOKCUBE)) {
			return catchFail(BOOKCUBE, bookcubeAPIService.cancel(book));
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
		} else if(com_code.equals(OPMS)) {
//			catchFail(opms, opmsAPIService.signup(member, book));
			opmsAPIService.signup(member, book);
		}
		else if(com_code.equals(YES24)) {
//			catchFail(YES24, yes24APIService.signup(member, book));
			yes24APIService.signup(member, book);
		}
		else if(com_code.equals(ECO)) {
//			catchFail(WOORIE, woorieAPIService.signup(member, book));
			ecoAPIService.signup(member, book);
		}
		else if(com_code.equals(IPAPRIKA)) {
//			catchFail(IPAPRIKA, ipaprikaAPIService.signup(member, book));
			ipaprikaAPIService.signup(member, book);
		}
		else if(com_code.equals(BOOKCUBE)) {
//			catchFail(BOOKCUBE, bookcubeAPIService.signup(member, book));
			bookcubeAPIService.signup(member, book);
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
////		return null;
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
////		return null;
//	}
	
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
		}
		else if(com_code.equals("BQ")) {
			return catchFail(BOOKCUBE, bookcubeAPIService.appUrl(book, member, device));
		}
		else if(com_code.equals("YESB")) {
			return catchFail(YES24, yes24APIService.appUrl(book, member, device));
		}
		else if(com_code.equals("FXLI")) {
			return catchFail(BOOKCUBE, bookcubeAPIService.appUrl(book, member, device));
		}
		else if(com_code.equals("ECO")) {
			return catchFail(ECO, ecoAPIService.appUrl(book, member, device));
		}
		else if(com_code.equals("OPMS")) {
			return catchFail(OPMS, opmsAPIService.appUrl(book, member, device));
		}
		else {
			return null;
		}
	}

	public Map<String, String> view(Book book) throws ElibException {
//		String com_code = book.getCom_code();
//
//		if(com_code == null) {
//			return null;
//		} else if(com_code.equals(KYOBO)) {
//			return catchFail(KYOBO, kyoboAPIService.view(book));
//		} else {
//			return null;
//		}
		return null;
	}
	
}
