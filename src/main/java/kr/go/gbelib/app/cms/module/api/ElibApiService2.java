package kr.go.gbelib.app.cms.module.api;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.api.ElibException;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.book.BookService;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;
import kr.go.gbelib.app.cms.module.elib.lending.LendingService;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;
import kr.go.gbelib.app.cms.module.elib.member.ElibMemberService;
import kr.go.gbelib.app.common.api.MemberAPI;

@Service
public class ElibApiService2 extends BaseService {

	@Autowired
	private BookService bookService;

	@Autowired
	private ApiLogService apiLogService;

	@Autowired
	private LendingService lendingService;

	@Autowired
	private ElibMemberService elibMemberService;

	public ElibXmlResult doApi(Lending lending, HttpServletRequest request, HttpServletResponse response) {
		int xmlResult = 0;
		String cmd = lending.getCmd();
		String msg = "";
		lending.setMember_id(lending.getUser_id());
		lending.setBook_code(lending.getBarcode());
		lending.setDevice("S");//공급사 앱은 스마트폰으로 취급한다.

		if(StringUtils.isEmpty(lending.getCmd())) {
			String errmsg = "잘못된 cmd 파라미터";
			apiLogService.addApiLog(new ApiLog("ELIB2", "-997", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
			return new ElibXmlResult("false", "-997", errmsg);
		} else if(StringUtils.isEmpty(lending.getUser_id())) {
			String errmsg = "잘못된 user_id 파라미터";
			apiLogService.addApiLog(new ApiLog("ELIB2", "-996", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
			return new ElibXmlResult("false", "-996", errmsg);
		} else if(StringUtils.isEmpty(lending.getBarcode())) {
			String errmsg = "잘못된 barcode 파라미터";
			apiLogService.addApiLog(new ApiLog("ELIB2", "-995", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
			return new ElibXmlResult("false", "-995", errmsg);
		} else if(StringUtils.isEmpty(lending.getLibrary_code())) {
			String errmsg = "잘못된 library_code 파라미터";
			apiLogService.addApiLog(new ApiLog("ELIB2", "-994", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
			return new ElibXmlResult("false", "-994", errmsg);
		} else if(StringUtils.isEmpty(lending.getCom_code())) {
			String errmsg = "잘못된 com_code 파라미터";
			apiLogService.addApiLog(new ApiLog("ELIB2", "-993", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
			return new ElibXmlResult("false", "-993", errmsg);
		}

		try {
			Book book = new Book(lending);
			book.setLibrary_code(lending.getLibrary_code());
			lending.setBook_idx(bookService.getBookIdx(book));

			if(lending.getBook_idx() == 0) {
				String errmsg = "해당 도서가 존재하지 않습니다.";
				apiLogService.addApiLog(new ApiLog("ELIB2", "-992", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
				return new ElibXmlResult("false", "-992", errmsg);
			}
			
			Member member = new Member(lending.getUser_id());
			List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("0", member);
			if(CollectionUtils.isEmpty(checkDupUser)) {
				String errmsg = "해당 회원이 존재하지 않습니다.";
				apiLogService.addApiLog(new ApiLog("ELIB2", "-991", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
				return new ElibXmlResult("false", "-991", errmsg);
			} else {
				Map<String, Object> userMap = checkDupUser.get(0);
				
				String member_class = String.valueOf(userMap.get("MEMBER_CLASS"));
				if(StringUtils.equals(member_class, "2")) {
					String errmsg = "이용자님은 현재 미승인 회원입니다. 소속도서관에서 정회원으로 승인 받은 후 전자도서관을 이용 바랍니다";
					apiLogService.addApiLog(new ApiLog("ELIB2", "-990", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
					return new ElibXmlResult("false", "-990", errmsg);
				}
				
				String user_class = String.valueOf(userMap.get("USER_CLASS"));
				if(StringUtils.equals(user_class, "1")) {
					String errmsg = "대출중지 상태입니다.";
					apiLogService.addApiLog(new ApiLog("ELIB2", "-989", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
					return new ElibXmlResult("false", "-989", errmsg);
				}
				
				ElibMember elibMember = new ElibMember();
				elibMember.setMember_id(lending.getMember_id());
				elibMember.setLibrary_code(lending.getLibrary_code());
				elibMember.setSeq_no(String.valueOf(userMap.get("REC_KEY")));
				
				String gpinSex = String.valueOf(userMap.get("GPIN_SEX"));
				if (StringUtils.isNotEmpty(gpinSex) && !StringUtils.equals(gpinSex, "null")) {
					elibMember.setSex(gpinSex); // 성별 (0 : 남자, 1 : 여자)
				}
				
				String brithsday = String.valueOf(userMap.get("BIRTHDAY"));
				if (StringUtils.isNotEmpty(brithsday) && !StringUtils.equals(brithsday, "null")) {
					elibMember.setBirth_day(StringUtils.defaultString(brithsday).replaceAll("[^0-9]", ""));
				}
				
				book = bookService.getBookInfo(new Book(lending.getBook_idx()));
				elibMemberService.addMemberIfNotExists(elibMember, book);
			}

			if("1".equals(cmd)) {
				// 대출
				xmlResult = lendingService.borrowProcNoApi(lending, false);
				msg = getMsg(cmd, xmlResult);
				apiLogService.addApiLog(new ApiLog("ELIB2", cmd, String.valueOf(xmlResult) + ", " + msg, makeParamUrl(lending), request.getRemoteAddr()));
				return toXml(xmlResult, msg);
			} else if("2".equals(cmd)) {
				// 반납
				xmlResult = lendingService.returnProcNoApi(lending);
				msg = getMsg(cmd, xmlResult);
				apiLogService.addApiLog(new ApiLog("ELIB2", cmd, String.valueOf(xmlResult) + ", " + msg, makeParamUrl(lending), request.getRemoteAddr()));
				return toXml(xmlResult, msg);
			} else if("3".equals(cmd)) {
				// 예약
				xmlResult = lendingService.reserveProcNoApi(lending);
				msg = getMsg(cmd, xmlResult);
				apiLogService.addApiLog(new ApiLog("ELIB2", cmd, String.valueOf(xmlResult) + ", " + msg, makeParamUrl(lending), request.getRemoteAddr()));
				return toXml(xmlResult, msg);
			} else if("4".equals(cmd)) {
				// 예약 취소
				xmlResult = lendingService.reserveCancelNoApi(lending);
				msg = getMsg(cmd, xmlResult);
				apiLogService.addApiLog(new ApiLog("ELIB2", cmd, String.valueOf(xmlResult) + ", " + msg, makeParamUrl(lending), request.getRemoteAddr()));
				return toXml(xmlResult, msg);
			} else if("5".equals(cmd)) {
				// 연장
				xmlResult = lendingService.extendProcNoApi(lending, book);
				msg = getMsg(cmd, xmlResult);
				apiLogService.addApiLog(new ApiLog("ELIB2", cmd, String.valueOf(xmlResult) + ", " + msg, makeParamUrl(lending), request.getRemoteAddr()));
				return toXml(xmlResult, msg);
			} else {
				String errmsg = "잘못된 cmd 파라미터";
				apiLogService.addApiLog(new ApiLog("ELIB2", "-998", errmsg, makeParamUrl(lending), request.getRemoteAddr()));
				return new ElibXmlResult("false", "-998", errmsg);
			}
		} catch(ElibException e) {
			e.printStackTrace();
			String errmsg = "";
			apiLogService.addApiLog(new ApiLog("ELIB2", "-991", e.getMessage(), makeParamUrl(lending), request.getRemoteAddr()));
			return new ElibXmlResult("false", "-991", e.getMessage());
		} catch(Exception e) {
			e.printStackTrace();
			String errmsg = "처리 도중 오류 발생";
			apiLogService.addApiLog(new ApiLog("ELIB2", "-999", errmsg + ": " + e.getMessage(), makeParamUrl(lending), request.getRemoteAddr()));
			return new ElibXmlResult("false", "-999", errmsg + ": " + e.getMessage());
		}
	}

	private ElibXmlResult toXml(int result, String msg) {
		if(result >= 0) {
			return new ElibXmlResult("true");
		} else {
			return new ElibXmlResult("false", String.valueOf(result), msg);
		}
	}

	private String getMsg(String cmd, int ret) {
		if("1".equals(cmd)) {
			if(ret == -10) {
				return "해당 도서가 존재하지 않습니다.";
			} else if(ret == -1) {
				return "설정에 오류가 발생했습니다.";
			} else if(ret == -6) {
				return "최대 대출 권수를 초과했습니다.";
			} else if(ret == -9) {
				return "이미 예약된 책은 대출할 수 없습니다.";
			} else if(ret == -2) {
				return "반납하지 않은 책은 대출할 수 없습니다.";
			} else if(ret == -4) {
				return "최대 예약 권수를 초과했습니다.";
			} else if(ret == 1) {
				return "최대 대출 권수가 초과된 책으로, 예약하실 수 있습니다.";
			} else if(ret == 0) {
				return "대출되었습니다.";
			} else {
				return "알 수 없는 오류가 발생했습니다.";
			}
		} else if("2".equals(cmd)) {
			if(ret == -1) {
				return "설정에 오류가 발생했습니다.";
			} else if(ret == -2) {
				return "대여 기록이 존재하지 않습니다.";
			} else if(ret == -3) {
				return "이미 반납된 도서입니다.";
			} else if(ret == -4) {
				return "해당 도서가 존재하지 않습니다.";
			} else if(ret == 0) {
				return "반납되었습니다.";
			} else {
				return "알 수 없는 오류가 발생했습니다.";
			}
		} else if("3".equals(cmd)) {
			if(ret == -1) {
				return "해당 도서가 존재하지 않습니다.";
			} else if(ret == -10) {
				return "최대 예약 권수를 초과했습니다.";
			} else if(ret == -5) {
				return "이미 예약된 책입니다.";
			} else if(ret == -9) {
				return "이미 대출된 책으로 예약할 수 없습니다.";
			} else if(ret == -11) {
				return "대출 가능한 책은 예약할 수 없습니다.";
			} else if(ret == -12) {
				return "책의 최대 예약 권수를 초과했습니다.";
			} else if(ret == 0) {
				return "예약되었습니다.";
			} else {
				return "알 수 없는 오류가 발생했습니다.";
			}
		} else if("4".equals(cmd)) {
			if(ret == -2 || ret == -3) {
				return "예약돼 있지 않습니다.";
			} else if(ret == -1) {
				return "해당 도서가 존재하지 않습니다.";
			} else if(ret == 0) {
				return "취소되었습니다.";
			} else {
				return "알 수 없는 오류가 발생했습니다.";
			}
		} else if("5".equals(cmd)) {
			if(ret == -2) {
				return "이미 반납한 상태에서 연장할 수 없습니다.";
			} else if(ret == -3) {
				return "최대 연장 횟수를 초과했습니다.";
			} else if(ret == -4 || ret == -5) {
				return "예약된 책은 연장할 수 없습니다.";
			} else if(ret == -6) {
				return "대출하지 않은 책은 연장할 수 없습니다.";
			} else if(ret == -7) {
				return "해당 도서가 존재하지 않습니다.";
			} else if(ret == 1) {
				return "연장되었습니다.";
			} else {
				return "알 수 없는 오류가 발생했습니다.";
			}
		} else {
			return "잘못된 cmd 파라미터";
		}
	}

	private String makeParamUrl(Lending lending) {
		StringBuilder sb = new StringBuilder();

		sb.append("cmd=" + lending.getCmd());
		sb.append("&barcode=" + lending.getBook_code());
		sb.append("&user_id=" + lending.getMember_id());
		sb.append("&library_code=" + lending.getLibrary_code());
		sb.append("&com_code=" + lending.getCom_code());

		return sb.toString();
	}

}
