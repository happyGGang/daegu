package kr.go.gbelib.app.cms.module.api;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationService;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookRound;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactLockerSettingService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class UntackBookApiService extends BaseService {

    @Autowired
    private UntactBookReservationService service;
    
    @Autowired
	private UntactLockerSettingService settingService;
    
    @Autowired
	private HomepageService homepageService;

    public Map<String, Object> getData(UntactBookReservation untackBookReservation, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new LinkedHashMap<String, Object>();

        String success_yn = "N"; // Y 성공 N 실패
        String msg = "";

        if(!StringUtils.isEmpty(untackBookReservation.getHomepage_id()) && untackBookReservation.getLocker_number() > 0 && untackBookReservation.getLocker_password() > 0 && !StringUtils.isEmpty(untackBookReservation.getUser_key())) {
        	UntactBookRound untactBookRound = new UntactBookRound();
        	untactBookRound.setHomepage_id(untackBookReservation.getHomepage_id());
    		String round_idx = settingService.getUntactBookRoundBefore(untactBookRound);
    		
    		if(StringUtils.isNotEmpty(round_idx)) {
    			untackBookReservation.setRound_idx(round_idx);
    			
    			if(service.getLockerPasswordCheckCount(untackBookReservation) > 0) {
    				success_yn = "Y";
    				msg = "성공";
    			} else {
    				success_yn = "N";
    				msg = "사물함 비밀번호 비교에 실패하였습니다.관리자에게 문의해주세요.";
    			}
    		}
        } else {
            success_yn = "N";
            msg = "잘못된 homepage_id,locker_number,locker_password,user_key 파라미터";
        }

        map.put("success_yn", success_yn);
        map.put("msg", msg);

        return map;
    }

	public Map<String, Object> getData2(UntactBookReservation untactBookReservation, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new LinkedHashMap<String, Object>();

		String success_yn = "N"; // Y 성공 N 실패
        String msg = "";
        
        if(!StringUtils.isEmpty(untactBookReservation.getHomepage_id()) && untactBookReservation.getLocker_number() > 0 && !StringUtils.isEmpty(untactBookReservation.getReservation_step())) {
        	if(untactBookReservation.getReservation_step().equals("3")) {
        		untactBookReservation.setReservation_step("2");
        		UntactBookReservation receiptList = service.getReceiptList(untactBookReservation);
        		
        		UntactBookRound untactBookRound = new UntactBookRound();
        		
        		LibrarySearch librarySearch = new LibrarySearch();
        		
        		if(receiptList != null) {
        			int request_number = receiptList.getRequest_number();
        			String manageCode = receiptList.getManage_code();
        			String userKey = receiptList.getUser_key();
        			String regNo = receiptList.getReg_no();
        			String member_name = receiptList.getMember_name();
        			String book_name = receiptList.getBook_name();
        			int locker_no = receiptList.getLocker_number();
        			int locker_pass = receiptList.getLocker_password();
        			String round_idx = receiptList.getRound_idx();
        			
        			untactBookRound.setRound_idx(round_idx);
        			untactBookRound.setHomepage_id(receiptList.getHomepage_id());
        			UntactBookRound roundTime = settingService.getUntactBookRoundAll(untactBookRound);
        		
        			LibrarySearch loanList = new LibrarySearch();
        			
        			loanList.setManageCode(manageCode);
					loanList.setSearch_start_date(roundTime.getRound_start_date());
					loanList.setSearch_end_date(roundTime.getRound_end_date());
					loanList.setUserkey(userKey);
					loanList.setRegNo(regNo);
					
					Map<String, Object> unmannedLoanReserveList = LibSearchAPI.getUntactBookLoanReserveList(loanList, null);
					List<Map<String, Object>> list = null;
					
					list = LibSearchAPI.getListData(unmannedLoanReserveList);
					
					if (list != null && list.size() > 0) {
						String loanKey = String.valueOf(list.get(0).get("LOAN_KEY"));
						receiptList.setLoankey(loanKey);
						
						librarySearch.setLoan_key(loanKey);
						ApiResponse apiResult = LibSearchAPI.bookreserveUpdateStatus(librarySearch);
						
						if (apiResult.getStatus()) {
							receiptList.setReservation_step("3");
							receiptList.setLoankey(loanKey);
							receiptList.setRequest_number(request_number);
							int modify_result = service.waitingReservationStep(receiptList);
							
							Homepage homepage = new Homepage();
							homepage.setHomepage_id(receiptList.getHomepage_id());
							
							homepage = homepageService.getHomepageOne(homepage);
							
							String userIp = request.getRemoteAddr();
							
							librarySearch.setManageCode(loanList.getManageCode());
							librarySearch.setUserkey(loanList.getUserkey());
							
							String loanTime = settingService.getReturnDate(untactBookRound);;
							
							String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n사물함 번호 : " + locker_no +"\n사물함 비밀번호 : " + locker_pass+"\n대출만기일은 " + loanTime + "까지 입니다."; 
							
							LibSearchAPI.sendSms(librarySearch, mes, userIp);
							
							if (modify_result < 1) {
								success_yn = "N";
				        		msg = "대기처리에 실패하였습니다.";
							}
							success_yn = "Y";
			        		msg = "성공";
						} else {
							success_yn = "N";
			        		msg = "실패";
						}
					} else {
						success_yn = "N";
		        		msg = "예약키 조회에 실패하였습니다.";
					}
					
        		} else {
        			success_yn = "N";
	        		msg = "조회되는 사물함이 없습니다.";
        		}
        	} else if (untactBookReservation.getReservation_step().equals("4")) {
        		untactBookReservation.setReservation_step("3");
        		UntactBookReservation receiptList = service.getReceiptList(untactBookReservation);
        		
        		LibrarySearch librarySearch = new LibrarySearch();
        		
        		if(receiptList != null) {
        			receiptList.setReservation_step("4");
        			System.out.println(receiptList.getRequest_number());
					librarySearch.setManageCode(receiptList.getManage_code());
					librarySearch.setUserkey(receiptList.getUser_key());
					librarySearch.setReg_no(receiptList.getReg_no());
					String ip = request.getRemoteAddr();
					ApiResponse apiResult = LibSearchAPI.unmannedloan(librarySearch, ip);
					
					if (apiResult.getStatus()) {
						int count = service.bookReservation(receiptList);
						
						if(count < 1) {
							success_yn = "N";
							msg = "대출에 실패 하였습니다. 관리자에게 문의하세요";
						}
						success_yn = "Y";
		        		msg = "성공";
					}
        		} else {
        			success_yn = "N";
        			msg = "조회되는 사물함이 없습니다.";
        		}
        		
        	} else {
        		 success_yn = "N";
        		 msg = "잘못된 reservation_step 파라미터";
        	}
        } else {
        	success_yn = "N";
            msg = "잘못된 homepage_id,locker_number,reservation_step 파라미터";
        }

        map.put("success_yn", success_yn);
        map.put("msg", msg);

        return map;
	}
}
