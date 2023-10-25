package kr.go.gbelib.app.intro.join;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Kisinfo.Check.IPIN2Client;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberDao;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PrivateMemberAPI;

@Service
public class JoinService extends BaseService {

	@Autowired
	private MemberDao dao;

	@Autowired
	private MemberService memberService;

	private String requestReplace(String paramValue, String gubun) {

        String result = "";

        if (paramValue != null) {

        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");

        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}

        	result = paramValue;

        }
        return result;
	}

	/**
	 * SMS 본인인증
	 * @param request
	 * @param member
	 * @return
	 */
	public Member smsCertProc(HttpServletRequest request, Member member) {
        HttpSession session = request.getSession();
        String sci_result = "N";

		try {
			//인증 후 결과값이 null로 나오는 부분은 관리담당자에게 문의 바랍니다.
		    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

		    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

		    String sReservedParam1  = requestReplace(request.getParameter("param_r1"), "");
			String sReservedParam2  = requestReplace(request.getParameter("param_r2"), "");
			String sReservedParam3  = requestReplace(request.getParameter("param_r3"), "");

		    final String sSiteCode = "BQ437";				// NICE로부터 부여받은 사이트 코드 - 대구시청
		    final String sSitePassword = "7fdpBlHmR0Ee";			// NICE로부터 부여받은 사이트 패스워드 - 대구시청
		    
		    String sCipherTime = "";			// 복호화한 시간
		    String sRequestNumber = "";			// 요청 번호
		    String sResponseNumber = "";		// 인증 고유번호
		    String sAuthType = "";				// 인증 수단
		    String sName = "";					// 성명
		    String sDupInfo = "";				// 중복가입 확인값 (DI_64 byte)
		    String sConnInfo = "";				// 연계정보 확인값 (CI_88 byte)
		    String sBirthDate = "";				// 생년월일(YYYYMMDD)
		    String sGender = "";				// 성별
		    String sNationalInfo = "";			// 내/외국인정보 (개발가이드 참조)
			String sMobileNo = "";				// 휴대폰번호
			String sMobileCo = "";				// 통신사
		    String sMessage = "";
		    String sPlainData = "";

		    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

		    if( iReturn == 0 )
		    {
		        sPlainData = niceCheck.getPlainData();
		        sCipherTime = niceCheck.getCipherDateTime();

		        // 데이타를 추출합니다.
		        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

		        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
		        sResponseNumber = (String)mapresult.get("RES_SEQ");
		        sAuthType		= (String)mapresult.get("AUTH_TYPE");
		        sName			= (String)mapresult.get("NAME");
//				sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
		        sBirthDate		= (String)mapresult.get("BIRTHDATE");
		        sGender			= (String)mapresult.get("GENDER");
		        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
		        sDupInfo		= (String)mapresult.get("DI");
		        sConnInfo		= (String)mapresult.get("CI");
		        sMobileNo		= (String)mapresult.get("MOBILE_NO");
		        sMobileCo		= (String)mapresult.get("MOBILE_CO");

		        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
		        if(!sRequestNumber.equals(session_sRequestNumber))
		        {
		            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
		            sResponseNumber = "";
		            sAuthType = "";
		            System.out.println("@@@@@@@@@@ smsCertProc " + sMessage);
		            System.out.println("@@@@@@@@@@ smsCertProc sAuthType: " + sAuthType);
		            System.out.println("@@@@@@@@@@ smsCertProc sName: " + sName);
		            System.out.println("@@@@@@@@@@ smsCertProc sBirthDate: " + sBirthDate);
		            System.out.println("@@@@@@@@@@ smsCertProc sConnInfo: " + sConnInfo);
		            System.out.println("@@@@@@@@@@ smsCertProc sMobileNo: " + sMobileNo);
		            member.setCertComplete(false);
		            sci_result = "N";
		            return member;
		        }

		        member.setCertComplete(true);
		        sci_result = "Y";
		    }
		    else if( iReturn == -1)
		    {
		        sMessage = "복호화 시스템 에러입니다.";
		    }
		    else if( iReturn == -4)
		    {
		        sMessage = "복호화 처리오류입니다.";
		    }
		    else if( iReturn == -5)
		    {
		        sMessage = "복호화 해쉬 오류입니다.";
		    }
		    else if( iReturn == -6)
		    {
		        sMessage = "복호화 데이터 오류입니다.";
		    }
		    else if( iReturn == -9)
		    {
		        sMessage = "입력 데이터 오류입니다.";
		    }
		    else if( iReturn == -12)
		    {
		        sMessage = "사이트 패스워드 오류입니다.";
		    }
		    else
		    {
		        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
		    }

			if (iReturn != 0) {
				System.out.println("@@@@@@@@@@ smsCertProc " + sMessage);
				System.out.println("@@@@@@@@@@ smsCertProc sAuthType: " + sAuthType);
				System.out.println("@@@@@@@@@@ smsCertProc iReturn: " + iReturn);
	            System.out.println("@@@@@@@@@@ smsCertProc sName: " + sName);
	            System.out.println("@@@@@@@@@@ smsCertProc sBirthDate: " + sBirthDate);
	            System.out.println("@@@@@@@@@@ smsCertProc sConnInfo: " + sConnInfo);
	            System.out.println("@@@@@@@@@@ smsCertProc sMobileNo: " + sMobileNo);
	            sci_result = "N";
				member.setCertComplete(false);
			}

			member.setMember_name(sName);
			member.setDi_value(sDupInfo);
			member.setCi_value(sConnInfo);
			member.setCell_phone(sMobileNo);
			member.setBirth_day(sBirthDate);
			member.setSex(sGender);
			member.setCertType(String.valueOf(request.getSession().getAttribute("certType")));
			member.setSci_result(sci_result);

			int birthYear = Integer.parseInt(sBirthDate.substring(0, 4));
			int birthMonth = Integer.parseInt(sBirthDate.substring(4, 6));
			int birthDay = Integer.parseInt(sBirthDate.substring(6));

			Calendar current = Calendar.getInstance();
			int currentYear = current.get(Calendar.YEAR);
			int currentMonth = current.get(Calendar.MONTH) + 1;
			int currentDay = current.get(Calendar.DAY_OF_MONTH);

			int age = currentYear - birthYear;
			// 생일 안 지난 경우 -1
			if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
				age--;
			}
			if (age >= 20) {
				age = 7;
			} else if (age <= 13) {
				age = 2;
			} else if (age > 13 && age < 20) {
				age = 5;
			}
			member.setAge(String.valueOf(age));


			String sci_cellNo = sMobileNo;
			if (sci_cellNo != null) {
				member.setCell_phone1(sci_cellNo.substring(0,3));
				if (sci_cellNo.length() == 10) {
					member.setCell_phone2(sci_cellNo.substring(3,6));
					member.setCell_phone3(sci_cellNo.substring(6));
				} else {
					member.setCell_phone2(sci_cellNo.substring(3,7));
					member.setCell_phone3(sci_cellNo.substring(7));
				}
			}

			session.setAttribute("certMember", member);
			session.setAttribute("certType", sAuthType);
		} catch (Exception ex) {
//			ex.printStackTrace();
			member.setCertComplete(false);
			member.setSci_result("N");
			return member;
		}

		return member;
	}
	
	/**
	 * SMS 본인인증
	 * @param request
	 * @param member
	 * @return
	 */
	public Member smsCertProc2(HttpServletRequest request, Member member) {
        HttpSession session = request.getSession();
        String sci_result = "N";

		try {
			//인증 후 결과값이 null로 나오는 부분은 관리담당자에게 문의 바랍니다.
		    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

		    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

		    String sReservedParam1  = requestReplace(request.getParameter("param_r1"), "");
			String sReservedParam2  = requestReplace(request.getParameter("param_r2"), "");
			String sReservedParam3  = requestReplace(request.getParameter("param_r3"), "");

		    final String sSiteCode = "G7048";				// 달서구립도서관
		    final String sSitePassword = "ZS6ZT29YXOFY";	// 달서구립도서관
		    
		    String sCipherTime = "";			// 복호화한 시간
		    String sRequestNumber = "";			// 요청 번호
		    String sResponseNumber = "";		// 인증 고유번호
		    String sAuthType = "";				// 인증 수단
		    String sName = "";					// 성명
		    String sDupInfo = "";				// 중복가입 확인값 (DI_64 byte)
		    String sConnInfo = "";				// 연계정보 확인값 (CI_88 byte)
		    String sBirthDate = "";				// 생년월일(YYYYMMDD)
		    String sGender = "";				// 성별
		    String sNationalInfo = "";			// 내/외국인정보 (개발가이드 참조)
			String sMobileNo = "";				// 휴대폰번호
			String sMobileCo = "";				// 통신사
		    String sMessage = "";
		    String sPlainData = "";

		    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

		    if( iReturn == 0 )
		    {
		        sPlainData = niceCheck.getPlainData();
		        sCipherTime = niceCheck.getCipherDateTime();

		        // 데이타를 추출합니다.
		        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

		        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
		        sResponseNumber = (String)mapresult.get("RES_SEQ");
		        sAuthType		= (String)mapresult.get("AUTH_TYPE");
		        sName			= (String)mapresult.get("NAME");
//				sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
		        sBirthDate		= (String)mapresult.get("BIRTHDATE");
		        sGender			= (String)mapresult.get("GENDER");
		        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
		        sDupInfo		= (String)mapresult.get("DI");
		        sConnInfo		= (String)mapresult.get("CI");
		        sMobileNo		= (String)mapresult.get("MOBILE_NO");
		        sMobileCo		= (String)mapresult.get("MOBILE_CO");

		        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
		        if(!sRequestNumber.equals(session_sRequestNumber))
		        {
		            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
		            sResponseNumber = "";
		            sAuthType = "";
		            System.out.println("@@@@@@@@@@ smsCertProc " + sMessage);
		            System.out.println("@@@@@@@@@@ smsCertProc sAuthType: " + sAuthType);
		            System.out.println("@@@@@@@@@@ smsCertProc sName: " + sName);
		            System.out.println("@@@@@@@@@@ smsCertProc sBirthDate: " + sBirthDate);
		            System.out.println("@@@@@@@@@@ smsCertProc sConnInfo: " + sConnInfo);
		            System.out.println("@@@@@@@@@@ smsCertProc sMobileNo: " + sMobileNo);
		            member.setCertComplete(false);
		            sci_result = "N";
		            return member;
		        }

		        member.setCertComplete(true);
		        sci_result = "Y";
		    }
		    else if( iReturn == -1)
		    {
		        sMessage = "복호화 시스템 에러입니다.";
		    }
		    else if( iReturn == -4)
		    {
		        sMessage = "복호화 처리오류입니다.";
		    }
		    else if( iReturn == -5)
		    {
		        sMessage = "복호화 해쉬 오류입니다.";
		    }
		    else if( iReturn == -6)
		    {
		        sMessage = "복호화 데이터 오류입니다.";
		    }
		    else if( iReturn == -9)
		    {
		        sMessage = "입력 데이터 오류입니다.";
		    }
		    else if( iReturn == -12)
		    {
		        sMessage = "사이트 패스워드 오류입니다.";
		    }
		    else
		    {
		        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
		    }

			if (iReturn != 0) {
				System.out.println("@@@@@@@@@@ smsCertProc " + sMessage);
				System.out.println("@@@@@@@@@@ smsCertProc sAuthType: " + sAuthType);
				System.out.println("@@@@@@@@@@ smsCertProc iReturn: " + iReturn);
	            System.out.println("@@@@@@@@@@ smsCertProc sName: " + sName);
	            System.out.println("@@@@@@@@@@ smsCertProc sBirthDate: " + sBirthDate);
	            System.out.println("@@@@@@@@@@ smsCertProc sConnInfo: " + sConnInfo);
	            System.out.println("@@@@@@@@@@ smsCertProc sMobileNo: " + sMobileNo);
	            sci_result = "N";
				member.setCertComplete(false);
			}

			member.setMember_name(sName);
			member.setDi_value(sDupInfo);
			member.setCi_value(sConnInfo);
			member.setCell_phone(sMobileNo);
			member.setBirth_day(sBirthDate);
			member.setSex(sGender);
			member.setCertType(String.valueOf(request.getSession().getAttribute("certType")));
			member.setSci_result(sci_result);

			int birthYear = Integer.parseInt(sBirthDate.substring(0, 4));
			int birthMonth = Integer.parseInt(sBirthDate.substring(4, 6));
			int birthDay = Integer.parseInt(sBirthDate.substring(6));

			Calendar current = Calendar.getInstance();
			int currentYear = current.get(Calendar.YEAR);
			int currentMonth = current.get(Calendar.MONTH) + 1;
			int currentDay = current.get(Calendar.DAY_OF_MONTH);

			int age = currentYear - birthYear;
			// 생일 안 지난 경우 -1
			if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
				age--;
			}
			if (age >= 20) {
				age = 7;
			} else if (age <= 13) {
				age = 2;
			} else if (age > 13 && age < 20) {
				age = 5;
			}
			member.setAge(String.valueOf(age));


			String sci_cellNo = sMobileNo;
			if (sci_cellNo != null) {
				member.setCell_phone1(sci_cellNo.substring(0,3));
				if (sci_cellNo.length() == 10) {
					member.setCell_phone2(sci_cellNo.substring(3,6));
					member.setCell_phone3(sci_cellNo.substring(6));
				} else {
					member.setCell_phone2(sci_cellNo.substring(3,7));
					member.setCell_phone3(sci_cellNo.substring(7));
				}
			}

			session.setAttribute("certMember", member);
			session.setAttribute("certType", sAuthType);
		} catch (Exception ex) {
//			ex.printStackTrace();
			member.setCertComplete(false);
			member.setSci_result("N");
			return member;
		}

		return member;
	}

	/**
	 * IPIN 본인인증
	 * @param request
	 * @param member
	 * @return
	 */
	public Member ipinCertProc(HttpServletRequest request, Member member) {
		HttpSession session = request.getSession();
		member.setCertComplete(true);

		try {
			/********************************************************************************************************************************************
			NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

			서비스명 : 가상주민번호서비스 (IPIN) 서비스
			페이지명 : 가상주민번호서비스 (IPIN) 결과 페이지
			*********************************************************************************************************************************************/

			// 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다.
		    String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");

			// ipin_main.jsp 페이지에서 설정한 데이타가 있다면, 아래와 같이 확인가능합니다.
			String sReservedParam1  = requestReplace(request.getParameter("param_r1"), "");
			String sReservedParam2  = requestReplace(request.getParameter("param_r2"), "");
			String sReservedParam3  = requestReplace(request.getParameter("param_r3"), "");

		    // CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
		    String sCPRequest = (String)session.getAttribute("CPREQUEST");

		    // 객체 생성
		    IPIN2Client pClient = new IPIN2Client();

		    // 암호화된 사용자 정보가 존재하는 경우
		    if (!sResponseData.equals("") && sResponseData != null) {
		    	/********************************************************************************************************************************************
				NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

				서비스명 : 가상주민번호서비스 (IPIN) 서비스
				페이지명 : 가상주민번호서비스 (IPIN) 결과 페이지
		    	*********************************************************************************************************************************************/

				String sSiteCode				= "EZ69";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
				String sSitePw					= "956Dp8236!@";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)

				/*
				┌ 복호화 함수 설명  ──────────────────────────────────────────────────────────
					Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.

					fnResponse 함수는 결과 데이타를 복호화 하는 함수이며,
					'sCPRequest'값을 추가로 보내시면 CP요청번호 일치여부도 확인하는 함수입니다. (세션에 넣은 sCPRequest 데이타로 검증)

					따라서 귀사에서 원하는 함수로 이용하시기 바랍니다.
				└────────────────────────────────────────────────────────────────────
				*/
				int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);
				//int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);

				String sRtnMsg				= "";							// 처리결과 메세지
				String sVNumber				= pClient.getVNumber();			// 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
				String sName				= pClient.getName();			// 이름
				String sDupInfo				= pClient.getDupInfo();			// 중복가입 확인값 (DI - 64 byte 고유값)
				String sAgeCode				= pClient.getAgeCode();			// 연령대 코드 (개발 가이드 참조)
				String sGenderCode			= pClient.getGenderCode();		// 성별 코드 (개발 가이드 참조)
				String sBirthDate			= pClient.getBirthDate();		// 생년월일 (YYYYMMDD)
				String sNationalInfo		= pClient.getNationalInfo();	// 내/외국인 정보 (개발 가이드 참조)
				String sCPRequestNum		= pClient.getCPRequestNO();		// CP 요청번호
				String sAuthInfo			= pClient.getAuthInfo();// 본인확인 수단 (개발 가이드 참조)
				String sCoInfo1				= pClient.getCoInfo1();			// 연계정보 확인값 (CI - 88 byte 고유값)
				String sCIUpdate			= pClient.getCIUpdate();		// CI 갱신정보

				// Method 결과값에 따른 처리사항
				if (iRtn == 1)
				{
					/*
					다음과 같이 사용자 정보를 추출할 수 있습니다.
					사용자에게 보여주는 정보는, '이름' 데이타만 노출 가능합니다.

					사용자 정보를 다른 페이지에서 이용하실 경우에는
					보안을 위하여 암호화 데이타(sResponseData)를 통신하여 복호화 후 이용하실것을 권장합니다. (현재 페이지와 같은 처리방식)

					만약, 복호화된 정보를 통신해야 하는 경우엔 데이타가 유출되지 않도록 주의해 주세요. (세션처리 권장)
					form 태그의 hidden 처리는 데이타 유출 위험이 높으므로 권장하지 않습니다.
					 */

					// 사용자 인증정보에 대한 변수
					member.setMember_name(sName);
					member.setDi_value(sDupInfo);
					member.setCi_value(sCoInfo1);
//				member.setCell_phone(aRetInfo[11]);
					member.setBirth_day(sBirthDate);
					member.setSex(sGenderCode);
					member.setCertType("gpin");

					int birthYear = Integer.parseInt(sBirthDate.substring(0, 4));
					int birthMonth = Integer.parseInt(sBirthDate.substring(4, 6));
					int birthDay = Integer.parseInt(sBirthDate.substring(6));

					Calendar current = Calendar.getInstance();
					int currentYear = current.get(Calendar.YEAR);
					int currentMonth = current.get(Calendar.MONTH) + 1;
					int currentDay = current.get(Calendar.DAY_OF_MONTH);

					int age = currentYear - birthYear;
					// 생일 안 지난 경우 -1
					if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
						age--;
					}
					if (age >= 20) {
						age = 7;//성인
					} else if (age <= 13) {
						age = 2;//만14세미만
					} else if (age > 13 && age < 20) {
						age = 5;//청소년
					}
					member.setAge(String.valueOf(age));

					sRtnMsg = "정상 처리되었습니다.";
				}
				else if (iRtn == -1 || iRtn == -4)
				{
					sRtnMsg =	"iRtn 값, 서버 환경정보를 정확히 확인하여 주시기 바랍니다.";
				}
				else if (iRtn == -6)
				{
					sRtnMsg =	"당사는 한글 charset 정보를 euc-kr 로 처리하고 있으니, euc-kr 에 대해서 허용해 주시기 바랍니다.<BR>" +
								"한글 charset 정보가 명확하다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
				}
				else if (iRtn == -9)
				{
					sRtnMsg = "입력값 오류 : fnResponse 함수 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
				}
				else if (iRtn == -12)
				{
					sRtnMsg = "CP 비밀번호 불일치 : IPIN 서비스 사이트 패스워드를 확인해 주시기 바랍니다.";
				}
				else if (iRtn == -13)
				{
					sRtnMsg = "CP 요청번호 불일치 : 세션에 넣은 sCPRequest 데이타를 확인해 주시기 바랍니다.";
				}
				else
				{
					sRtnMsg = "iRtn 값 확인 후, NICE평가정보 전산 담당자에게 문의해 주세요.";
				}

				session.setAttribute("certMember", member);
			} else {
				member.setCertComplete(false);
			}
		} catch (Exception e) {
			member.setCertComplete(false);
		}

		return member;
	}

	/**
	 * SMS인증시 전송할 암호화된 키
	 *
	 * @param request
	 * @return
	 */
	public Map<String, String> getSmsEncData(HttpServletRequest request, String sReturnUrl, String sErrorUrl) {
		Map<String, String> result = new HashMap<String, String>();
		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    final String sSiteCode = "BQ437";			// NICE로부터 부여받은 사이트 코드 - 대구시청핸드폰인증
	    final String sSitePassword = "7fdpBlHmR0Ee";		// NICE로부터 부여받은 사이트 패스워드 대구시청핸드폰인증

	    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
	                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
	  	HttpSession session = request.getSession();
	    session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	   	String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

	   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

		String sGender = ""; 			//없으면 기본 선택 값, 0 : 여자, 1 : 남자

	    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
//	    String sReturnUrl = "http://www.test.co.kr/checkplus_success.jsp";      // 성공시 이동될 URL
//	    String sErrorUrl = "http://www.test.co.kr/checkplus_fail.jsp";          // 실패시 이동될 URL

	    // 입력될 plain 데이타를 만든다.
	    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
	                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
	                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
	                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
	                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
	                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
	                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize +
							"6:GENDER" + sGender.getBytes().length + ":" + sGender;

	    String sMessage = "";
	    String sEncData = "";

	    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
	    if( iReturn == 0 )
	    {
	        sEncData = niceCheck.getCipherData();
	    }
	    else if( iReturn == -1)
	    {
//	        sMessage = "암호화 시스템 에러입니다.";
	        sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 000";
	    }
	    else if( iReturn == -2)
	    {
//	        sMessage = "암호화 처리오류입니다.";
	    	sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 001";
	    }
	    else if( iReturn == -3)
	    {
//	        sMessage = "암호화 데이터 오류입니다.";
	    	sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 002";
	    }
	    else if( iReturn == -9)
	    {
//	        sMessage = "입력 데이터 오류입니다.";
	    	sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 003";
	    }
	    else
	    {
//	        sMessage = "알 수 없는 에러입니다. iReturn : " + iReturn;
	    	sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 004, " + iReturn;
	    }

	    if(iReturn != 0) {
	    	System.out.println("@@@@@@@@@@ getSmsEncData iReturn: " + iReturn);
	    	System.out.println("@@@@@@@@@@ getSmsEncData sMessage: " + sMessage);
	    }

	    result.put("return", String.valueOf(iReturn));
	    result.put("message", sMessage);
	    result.put("encData", sEncData);

	    return result;
	}
	
	/**
	 * SMS인증시 전송할 암호화된 키
	 *
	 * @param request
	 * @return
	 */
	public Map<String, String> getSmsEncData2(HttpServletRequest request, String sReturnUrl, String sErrorUrl) {
		Map<String, String> result = new HashMap<String, String>();
		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    final String sSiteCode = "G7048";			// NICE로부터 부여받은 사이트 코드 - 대구시청핸드폰인증
	    final String sSitePassword = "ZS6ZT29YXOFY";		// NICE로부터 부여받은 사이트 패스워드 대구시청핸드폰인증

	    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
	                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
	  	HttpSession session = request.getSession();
	    session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	   	String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

	   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

		String sGender = ""; 			//없으면 기본 선택 값, 0 : 여자, 1 : 남자

	    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
//	    String sReturnUrl = "http://www.test.co.kr/checkplus_success.jsp";      // 성공시 이동될 URL
//	    String sErrorUrl = "http://www.test.co.kr/checkplus_fail.jsp";          // 실패시 이동될 URL

	    // 입력될 plain 데이타를 만든다.
	    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
	                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
	                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
	                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
	                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
	                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
	                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize +
							"6:GENDER" + sGender.getBytes().length + ":" + sGender;

	    String sMessage = "";
	    String sEncData = "";

	    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
	    if( iReturn == 0 )
	    {
	        sEncData = niceCheck.getCipherData();
	    }
	    else if( iReturn == -1)
	    {
//	        sMessage = "암호화 시스템 에러입니다.";
	        sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 000";
	    }
	    else if( iReturn == -2)
	    {
//	        sMessage = "암호화 처리오류입니다.";
	    	sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 001";
	    }
	    else if( iReturn == -3)
	    {
//	        sMessage = "암호화 데이터 오류입니다.";
	    	sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 002";
	    }
	    else if( iReturn == -9)
	    {
//	        sMessage = "입력 데이터 오류입니다.";
	    	sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 003";
	    }
	    else
	    {
//	        sMessage = "알 수 없는 에러입니다. iReturn : " + iReturn;
	    	sMessage = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 004, " + iReturn;
	    }

	    if(iReturn != 0) {
	    	System.out.println("@@@@@@@@@@ getSmsEncData iReturn: " + iReturn);
	    	System.out.println("@@@@@@@@@@ getSmsEncData sMessage: " + sMessage);
	    }

	    result.put("return", String.valueOf(iReturn));
	    result.put("message", sMessage);
	    result.put("encData", sEncData);

	    return result;
	}

	/**
	 * IPIN인증시 전송할 암호화된 키
	 *
	 * @param request
	 * @return
	 */
	public Map<String, String> getIpinEncData(HttpServletRequest request, String sReturnURL) {
		Map<String, String> result = new HashMap<String, String>();

		/********************************************************************************************************************************************
		NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

		서비스명 : 가상주민번호서비스 (IPIN) 서비스
		페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
		*********************************************************************************************************************************************/

		String sSiteCode				= "EZ69";			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
		String sSitePw					= "956Dp8236!@";			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)

		/*
		┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
			NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
			따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.

			* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
			* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.

			아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
			예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
		└────────────────────────────────────────────────────────────────────
		*/
		// String sReturnURL				= "";

		/*
		┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
			[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.

			CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
			데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.

			따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
		└────────────────────────────────────────────────────────────────────
		*/
		String sCPRequest				= "";

		// 객체 생성
		IPIN2Client pClient = new IPIN2Client();

		// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
		sCPRequest = pClient.getRequestNO(sSiteCode);

		// CP 요청번호를 세션에 저장합니다.
		// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
		// 필수사항은 아니며, 보안을 위한 권고사항입니다.
		HttpSession session = request.getSession();
		session.setAttribute("CPREQUEST" , sCPRequest);

		// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
		int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);

		String sRtnMsg					= "";			// 처리결과 메세지
		String sEncData					= "";			// 암호화 된 데이타

		// Method 결과값에 따른 처리사항
		if (iRtn == 0)
		{
			// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
			// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
			sEncData = pClient.getCipherData();		//암호화 된 데이타
			sRtnMsg = "정상 처리되었습니다.";
		}
		else if (iRtn == -1 || iRtn == -2)
		{
//			sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
//						"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
			sRtnMsg = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 005";
		}
		else if (iRtn == -9)
		{
//			sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
			sRtnMsg = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 006";
		}
		else
		{
//			sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
			sRtnMsg = "본인인증 과정 중에 오류가 발생했습니다. 오류코드: 007, " + iRtn;
		}

		if(iRtn != 0) {
			System.out.println("@@@@@@@@@@ getIpinEncData iRtn: " + iRtn);
			System.out.println("@@@@@@@@@@ getIpinEncData sRtnMsg: " + sRtnMsg);
		}

	    result.put("return", String.valueOf(iRtn));
	    result.put("message", sRtnMsg);
	    result.put("encData", sEncData);

		return result;
	}

	public String addMember(HttpServletRequest request, Member member) {
		String returnMsg = "0";

		HttpSession session = request.getSession();
		Member certMember = (Member)session.getAttribute("certMember");
//		String cert_type = getSessionAttrValue(session, "cert_type");
		String cert_type = member.getCertType();
		member.setMember_name(certMember.getMember_name());
		member.setSex(StringUtils.equals(certMember.getSex(), "1") ? "0" : "1");
		member.setBirth_day(certMember.getBirth_day());
		member.setIn_ip(request.getRemoteAddr());



		if (cert_type.toLowerCase().contains("gpin")) {
			//중복확인코드
			String dupInfo = certMember.getDi_value();
			//개인식별번호
			String virtualNo = certMember.getCi_value();

			if(!dupInfo.equals("") && !virtualNo.equals("")) {
				member.setDi_value(certMember.getDi_value());
				member.setCi_value(certMember.getCi_value());

				List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("1", member);

				if (CollectionUtils.isNotEmpty(checkDupUser)) {
					return "이미 가입되어 있습니다";
				}

				//일반회원가입
				Map<String, Object> addMember = MemberAPI.addMember(member);
				String result = String.valueOf(addMember.get("RESULT_INFO"));
				if (StringUtils.equals(result, "SUCCESS")) {
					/**
					 * 대구는 신규회원가입 시 무조건 책이음회원 Y
					 * 2019.12.19
					 */
					MemberAPI.agreeInfo(member.getManage_code(), String.valueOf(addMember.get("USER_KEY")), "Y");
					String sBirthDate = member.getBirth_day();
					int birthYear = Integer.parseInt(sBirthDate.substring(0, 4));
					int birthMonth = Integer.parseInt(sBirthDate.substring(4, 6));
					int birthDay = Integer.parseInt(sBirthDate.substring(6));

					Calendar current = Calendar.getInstance();
					int currentYear = current.get(Calendar.YEAR);
					int currentMonth = current.get(Calendar.MONTH) + 1;
					int currentDay = current.get(Calendar.DAY_OF_MONTH);

					int age = currentYear - birthYear;
					// 생일 안 지난 경우 -1
					if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
//						age--;
					}
					if (age >= 20) {
						age = 7;
					} else if (age <= 13) {
						age = 2;
						Member parentInfo = (Member)session.getAttribute("parentInfo");
						MemberAPI.useragentinfoinsert(String.valueOf(addMember.get("USER_KEY")), parentInfo.getMember_name(), member.getManage_code());
					} else if (age > 13 && age < 20) {
						age = 5;
					}
				} else {
					return String.valueOf(addMember.get("RESULT_MESSAGE"));
				}

			} else {
				return "인증에 실패하였습니다. 오류코드: 012";
			}
		} else if (cert_type.toLowerCase().contains("sms")) {

			String sci_result = certMember.getSci_result();
			if (sci_result.equals("N")) {
				return "인증에 실패하였습니다. 오류코드: 013";
			} else if (sci_result.equals("Y")) {
				String ci = certMember.getCi_value();
				if(ci != null && !ci.equals("")) {
					member.setMember_name(certMember.getMember_name());
					member.setBirth_day(certMember.getBirth_day());
					member.setDi_value(certMember.getDi_value());
					member.setCi_value(certMember.getCi_value());

					List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("1", member);

					if (CollectionUtils.isNotEmpty(checkDupUser)) {
						return "이미 가입되어 있습니다";
					}

					//일반회원가입
					Map<String, Object> addMember = MemberAPI.addMember(member);
					String result = String.valueOf(addMember.get("RESULT_INFO"));
					if (StringUtils.equals(result, "SUCCESS")) {
						MemberAPI.agreeInfo(member.getManage_code(), String.valueOf(addMember.get("USER_KEY")), "N");
						String sBirthDate = member.getBirth_day();
						int birthYear = Integer.parseInt(sBirthDate.substring(0, 4));
						int birthMonth = Integer.parseInt(sBirthDate.substring(4, 6));
						int birthDay = Integer.parseInt(sBirthDate.substring(6));

						Calendar current = Calendar.getInstance();
						int currentYear = current.get(Calendar.YEAR);
						int currentMonth = current.get(Calendar.MONTH) + 1;
						int currentDay = current.get(Calendar.DAY_OF_MONTH);

						int age = currentYear - birthYear;
						// 생일 안 지난 경우 -1
						if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
//							age--;
						}
						if (age >= 20) {
							age = 7;
						} else if (age <= 13) {
							age = 2;
							Member parentInfo = (Member)session.getAttribute("parentInfo");
							MemberAPI.useragentinfoinsert(String.valueOf(addMember.get("USER_KEY")), parentInfo.getMember_name(), member.getManage_code());
						} else if (age > 13 && age < 20) {
							age = 5;
						}
					} else {
						return String.valueOf(addMember.get("RESULT_MESSAGE"));
					}

				} else {
					return "인증에 실패하였습니다. 오류코드: 015";
				}

			}

		} else if (cert_type.toLowerCase().contains("dadaegu")) {
			String ci = certMember.getCi_value();
			member.setCi_value(ci);
			member.setMember_name(certMember.getMember_name());
			member.setSex(StringUtils.equals(certMember.getSex(), "1") ? "0" : "1");
			member.setBirth_day(certMember.getBirth_day());
			member.setIn_ip(request.getRemoteAddr());
			if(ci != null && !ci.equals("")) {
				List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("1", member);

				if (CollectionUtils.isNotEmpty(checkDupUser)) {
					return "이미 가입되어 있습니다";
				}

				//일반회원가입
				Map<String, Object> addMember = MemberAPI.addMember(member);
				String result = String.valueOf(addMember.get("RESULT_INFO"));
				if (StringUtils.equals(result, "SUCCESS")) {
					MemberAPI.agreeInfo(member.getManage_code(), String.valueOf(addMember.get("USER_KEY")), "N");
					String sBirthDate = member.getBirth_day();
					int birthYear = Integer.parseInt(sBirthDate.substring(0, 4));
					int birthMonth = Integer.parseInt(sBirthDate.substring(4, 6));
					int birthDay = Integer.parseInt(sBirthDate.substring(6));

					Calendar current = Calendar.getInstance();
					int currentYear = current.get(Calendar.YEAR);
					int currentMonth = current.get(Calendar.MONTH) + 1;
					int currentDay = current.get(Calendar.DAY_OF_MONTH);

					int age = currentYear - birthYear;
					// 생일 안 지난 경우 -1
					if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
//							age--;
					}
					if (age >= 20) {
						age = 7;
					} else if (age <= 13) {
						age = 2;
						Member parentInfo = (Member)session.getAttribute("parentInfo");
						MemberAPI.useragentinfoinsert(String.valueOf(addMember.get("USER_KEY")), parentInfo.getMember_name(), member.getManage_code());
					} else if (age > 13 && age < 20) {
						age = 5;
					}
				} else {
					return String.valueOf(addMember.get("RESULT_MESSAGE"));
				}

			} else {
				return "다대구 인증값 조회에 실패했습니다. 다시 시도해주세요.";
			}

		} else {
			return "잘못된 경로로 접근하였습니다.";
		}
		return returnMsg;
	}


	public int integrationMember(Member member) {
		return dao.integrationMember(member);
	}

	public String addPrivateMember(HttpServletRequest request, Member member) {
		String returnMsg = "0";

		HttpSession session = request.getSession();
		Member certMember = (Member)session.getAttribute("certMember");
		String cert_type = member.getCertType();
		member.setMember_name(certMember.getMember_name());
		member.setSex(StringUtils.equals(certMember.getSex(), "1") ? "0" : "1");
		member.setBirth_day(certMember.getBirth_day());
		member.setIn_ip(request.getRemoteAddr());

		if (cert_type.toLowerCase().contains("gpin")) {
			//중복확인코드
			String dupInfo = certMember.getDi_value();
			//개인식별번호
			String virtualNo = certMember.getCi_value();

			if(!dupInfo.equals("") && !virtualNo.equals("")) {
				member.setDi_value(certMember.getDi_value());
				member.setCi_value(certMember.getCi_value());

				List<Map<String, Object>> checkDupUser = PrivateMemberAPI.checkDupUser("1", member);

				if (CollectionUtils.isNotEmpty(checkDupUser)) {
					return "이미 가입되어 있습니다";
				}

				//일반회원가입
				Map<String, Object> addMember = PrivateMemberAPI.addMember(member);
				String result = String.valueOf(addMember.get("RESULT_INFO"));
				if (StringUtils.equals(result, "SUCCESS")) {
					/**
					 * 대구는 신규회원가입 시 무조건 책이음회원 Y
					 * 2019.12.19
					 */
					PrivateMemberAPI.agreeInfo(member.getManage_code(), String.valueOf(addMember.get("USER_KEY")), "Y");
					String sBirthDate = member.getBirth_day();
					int birthYear = Integer.parseInt(sBirthDate.substring(0, 4));
					int birthMonth = Integer.parseInt(sBirthDate.substring(4, 6));
					int birthDay = Integer.parseInt(sBirthDate.substring(6));

					Calendar current = Calendar.getInstance();
					int currentYear = current.get(Calendar.YEAR);
					int currentMonth = current.get(Calendar.MONTH) + 1;
					int currentDay = current.get(Calendar.DAY_OF_MONTH);

					int age = currentYear - birthYear;
					// 생일 안 지난 경우 -1
					if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
//						age--;
					}
					if (age >= 20) {
						age = 7;
					} else if (age <= 13) {
						age = 2;
						Member parentInfo = (Member)session.getAttribute("parentInfo");
						PrivateMemberAPI.useragentinfoinsert(String.valueOf(addMember.get("USER_KEY")), parentInfo.getMember_name(), member.getManage_code());
					} else if (age > 13 && age < 20) {
						age = 5;
					}
				} else {
					return String.valueOf(addMember.get("RESULT_MESSAGE"));
				}

			} else {
				return "인증에 실패하였습니다. 오류코드: 012";
			}
		} else if (cert_type.toLowerCase().contains("sms")) {

			String sci_result = certMember.getSci_result();
			if (sci_result.equals("N")) {
				return "인증에 실패하였습니다. 오류코드: 013";
			} else if (sci_result.equals("Y")) {
				String ci = certMember.getCi_value();
				if(ci != null && !ci.equals("")) {
					member.setMember_name(certMember.getMember_name());
					member.setBirth_day(certMember.getBirth_day());
					member.setDi_value(certMember.getDi_value());
					member.setCi_value(certMember.getCi_value());

					List<Map<String, Object>> checkDupUser = PrivateMemberAPI.checkDupUser("1", member);

					if (CollectionUtils.isNotEmpty(checkDupUser)) {
						return "이미 가입되어 있습니다";
					}

					//일반회원가입
					Map<String, Object> addMember = PrivateMemberAPI.addMember(member);
					String result = String.valueOf(addMember.get("RESULT_INFO"));
					if (StringUtils.equals(result, "SUCCESS")) {
						PrivateMemberAPI.agreeInfo(member.getManage_code(), String.valueOf(addMember.get("USER_KEY")), "N");
						String sBirthDate = member.getBirth_day();
						int birthYear = Integer.parseInt(sBirthDate.substring(0, 4));
						int birthMonth = Integer.parseInt(sBirthDate.substring(4, 6));
						int birthDay = Integer.parseInt(sBirthDate.substring(6));

						Calendar current = Calendar.getInstance();
						int currentYear = current.get(Calendar.YEAR);
						int currentMonth = current.get(Calendar.MONTH) + 1;
						int currentDay = current.get(Calendar.DAY_OF_MONTH);

						int age = currentYear - birthYear;
						// 생일 안 지난 경우 -1
						if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
//							age--;
						}
						if (age >= 20) {
							age = 7;
						} else if (age <= 13) {
							age = 2;
							Member parentInfo = (Member)session.getAttribute("parentInfo");
							PrivateMemberAPI.useragentinfoinsert(String.valueOf(addMember.get("USER_KEY")), parentInfo.getMember_name(), member.getManage_code());
						} else if (age > 13 && age < 20) {
							age = 5;
						}
					} else {
						return String.valueOf(addMember.get("RESULT_MESSAGE"));
					}

				} else {
					return "인증에 실패하였습니다. 오류코드: 015";
				}
			}

		} else {
			return "잘못된 경로로 접근하였습니다.";
		}
		return returnMsg;
	}

}
