package kr.go.gbelib.app.intro.checkInOut;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.checkInOut.CheckInOut;
import kr.go.gbelib.app.cms.module.checkInOut.CheckInOutService;
import kr.go.gbelib.app.common.api.LoginAPI;

@Controller (value = "kioskCheckInOut")
@RequestMapping (value = {"/intro/{context_path}/checkInOut"})
public class checkInOutController extends BaseController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CheckInOutService checkInOutService;

	@RequestMapping (value = {"/checkInProc.*"})
	public String checkInProc(@PathVariable String context_path, Model model, Member member, CheckInOut checkInOut, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		Homepage homepage = getSessionHomepage(request);

		String returnUrl = member.getBefore_url();
		if (StringUtils.isEmpty(returnUrl)) {
			returnUrl = context_path + "/kiosk" + "/checkInIndex.do";
		}
		
		if (homepage != null && StringUtils.isNotEmpty(homepage.getManage_code())) {
			member.setManage_code(homepage.getManage_code());
		}

		checkInOut.setHomepage_id(homepage.getHomepage_id());
		
		checkInProc(member, checkInOut);
		
		if(checkInOut.getMember_id() == null || "null".equals(checkInOut.getMember_id().toLowerCase()) || StringUtils.isEmpty(checkInOut.getMember_id())) {
			checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), "아이디가 없는 회원은 정상적으로 이용이 불가능합니다. 통합인증을 진행 후 이용 부탁드립니다.", String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		}
		
		if(!member.isLogin()) {
			checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), "체크인에 실패하였습니다.\\n해당 정보와 일치하는 이용자가 없습니다.", String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		}
		
		if(!checkGreens(member)) {
			checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), "그린즈(초5~중3 또는 해당연령대)만 입장가능합니다.", String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		}
		
		boolean isCheckIn = checkInOutService.isCheckInCount(checkInOut);
		if(isCheckIn) {
			checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), "이미 체크인 하셨습니다.\\n체크아웃 후 다시 이용해주세요.", String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		}
		
		int visitCheck = checkInOutService.getVisitCheck(checkInOut);

		if (visitCheck == 0){
			 checkInOut.setVisit_status("Y");
		}else {
			 checkInOut.setVisit_status("N");
		}

		int checkInCount = checkInOutService.checkIn(checkInOut);
		
		if(checkInCount > 0) {
			if(visitCheck > 0){
				visitCheck = visitCheck+1;
				checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), String.format(checkInOut.getMember_name() + "님! " + visitCheck + "번째 방문 환영합니다!."), String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
				session.invalidate();
				return null;
			} else {
				checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), String.format("\\'그린대로\\' 숲으로 들어오세요."), String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
				session.invalidate();
				return null;
			}
		} else {
			checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), String.format("체크인에 실패하였습니다.\\n다시 한번 카드를 인식시켜 주세요.\\n다시 체크인에 실패시 매니저에게 문의해주세요."), String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		}
	}
	
	@RequestMapping (value = {"/checkOutProc.*"})
	public String checkOutProc(@PathVariable String context_path, Model model, Member member, CheckInOut checkInOut, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		Homepage homepage = getSessionHomepage(request);

		String returnUrl = member.getBefore_url();
		if (StringUtils.isEmpty(returnUrl)) {
			returnUrl = context_path + "/kiosk" + "/checkInIndex.do";
		}
		
		if (homepage != null && StringUtils.isNotEmpty(homepage.getManage_code())) {
			member.setManage_code(homepage.getManage_code());
		}

		checkInOut.setHomepage_id(homepage.getHomepage_id());
		
		checkInProc(member, checkInOut);
		
		if(!member.isLogin()) {
			checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), "체크아웃에 실패하였습니다.\\n해당 정보와 일치하는 이용자가 없습니다.", String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		}
		
		boolean isCheckOut = checkInOutService.isCheckOutCount(checkInOut);
		
		int checkOutCount = 0;
		
		if(isCheckOut) {
			checkInOut = checkInOutService.isCheckIn(checkInOut);
			
			checkOutCount = checkInOutService.checkOut(checkInOut);
			
			if(checkOutCount > 0) {
				checkInOut = checkInOutService.getCheckOutTime(checkInOut);
				
				int time = Integer.parseInt(checkInOut.getCheckInOut_time());
				int hour = (time / 60);
				int minute = time-(hour*60);
		        
				String message = "";
				
				if(hour > 0) {
					message = "오늘도 "+hour+"시간 "+minute+"분 자신을 그려보았습니다. 또 만나요!";
				} else {
					message = "오늘도 " + minute + "분 자신을 그려보았습니다. 또 만나요!";
				}
				
				checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), message, String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
				session.invalidate();
				return null;
			} else {
				checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), "체크아웃에 실패하였습니다.\\n다시 한번 카드를 인식시켜 주세요.\\n다시 체크아웃 실패시 매니저에게 문의해주세요.", String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
				session.invalidate();
				return null;
			}
		} else {
			checkInOutService.alertMessageAndUrlKiosk(homepage.getHomepage_name(), "체크인 기록이 없습니다.\\n체크인 해주세요.", String.format("/%s/kiosk/checkInIndex.do", homepage.getContext_path()), request, response);
			session.invalidate();
			return null;
		}
	}
	
	private void checkInProc(Member member, CheckInOut checkInOut) throws Exception {
		//체크인 타입별 회원정보 가지고 오기(RFID, BARCODE, ID/PW)
		if("card".equals(member.getLoginType())) {
			try {
				Object rfidResult = LoginAPI.rfidLogin(member);
				
				if (rfidResult instanceof Member) {
					member = (Member) rfidResult;
					member.setLogin(true);
					
					checkInOut.setUser_no(member.getUser_no());
					checkInOut.setMember_id(member.getMember_id());
					checkInOut.setMember_name(member.getMember_name());
					if (member.getSex().equals("1")) {
						checkInOut.setMember_sex("여");
					} else {
						checkInOut.setMember_sex("남");
					}
					checkInOut.setMember_birth(member.getBirth_day());
					checkInOut.setMember_area(member.getAddress());
					checkInOut.setCheck_type("rfid");
				} else {
					Object barcodeResult = LoginAPI.barcodeLogin(member);
					
					if(barcodeResult instanceof Member) {
						member = (Member) barcodeResult;
						member.setLogin(true);
						
						checkInOut.setUser_no(member.getUser_no());
						checkInOut.setMember_id(member.getMember_id());
						checkInOut.setMember_name(member.getMember_name());
						if (member.getSex().equals("1")) {
							checkInOut.setMember_sex("여");
						} else {
							checkInOut.setMember_sex("남");
						}
						checkInOut.setMember_birth(member.getBirth_day());
						checkInOut.setMember_area(member.getAddress());
						checkInOut.setCheck_type("barcode");
					} else {
						member.setLogin(false);
					}
				}
			} catch (Exception e) {
				System.out.println("RFID, BARCODE 체크인 에러 : " + e);
			}
		} else {
			if (memberService.decryptMember(member) == false) {
				System.out.println("로그인 체크인 복호화 에러");
				member.setLogin(false);
			}
			try {
				Object loginResult = LoginAPI.login(member);
				
				if (loginResult instanceof Member) {
					member = (Member) loginResult;
					member.setLogin(true);
					
					checkInOut.setUser_no(member.getUser_no());
					checkInOut.setMember_id(member.getMember_id());
					checkInOut.setMember_name(member.getMember_name());
					if (member.getSex().equals("1")) {
						checkInOut.setMember_sex("여");
					} else {
						checkInOut.setMember_sex("남");
					}
					checkInOut.setMember_birth(member.getBirth_day());
					checkInOut.setMember_area(member.getAddress());
					checkInOut.setCheck_type("login");
				} else {
					member.setLogin(false);
				}
			} catch (Exception e) {
				System.out.println("로그인 체크인 에러 : " + e);
				member.setLogin(false);
			}
		}
	}
	
	private boolean checkGreens(Member member) {
		String birth = member.getBirth_day();
		birth = birth.substring(0, 4);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String format = sdf.format(new Date());
		
		//2024-2009 = 15 2024-2013 = 11
		boolean isChild = ((Integer.parseInt(format) - Integer.parseInt(birth)) <= 15 && (Integer.parseInt(format) - Integer.parseInt(birth)) >= 11);
		
		return isChild;
	}
}
