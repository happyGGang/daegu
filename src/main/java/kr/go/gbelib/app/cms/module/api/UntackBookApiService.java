package kr.go.gbelib.app.cms.module.api;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationService;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookRound;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookSetting;
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
	private UntactLockerSettingService untactLockerSettingService;
    
    @Autowired
	private HomepageService homepageService;

    public Map<String, Object> getData(UntactBookReservation untackBookReservation, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new LinkedHashMap<String, Object>();

        String success_yn = "N"; // Y 성공 N 실패
        String msg = "";
        
        UntactBookSetting untactBookSetting = untactLockerSettingService.getUntactBookSettingOne(untackBookReservation.getHomepage_id());
        
        if(untactBookSetting.getNight_loan_yn().equals("Y")) {
        	if(!StringUtils.isEmpty(untackBookReservation.getHomepage_id()) && untackBookReservation.getLocker_number() > 0 && untackBookReservation.getLocker_password() > 0 && !StringUtils.isEmpty(untackBookReservation.getUser_key())) {
            	UntactBookRound untactBookRound = new UntactBookRound();
            	untactBookRound.setHomepage_id(untackBookReservation.getHomepage_id());
        		String round_idx = untactLockerSettingService.getUntactBookRoundToday(untactBookRound);
        		
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
        } else {
        	if(!StringUtils.isEmpty(untackBookReservation.getHomepage_id()) && untackBookReservation.getLocker_number() > 0 && untackBookReservation.getLocker_password() > 0 && !StringUtils.isEmpty(untackBookReservation.getUser_key())) {
            	UntactBookRound untactBookRound = new UntactBookRound();
            	untactBookRound.setHomepage_id(untackBookReservation.getHomepage_id());
        		String round_idx = untactLockerSettingService.getUntactBookRound(untactBookRound);
        		
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
        	
        	UntactBookSetting untactBookSetting = untactLockerSettingService.getUntactBookSettingOne(untactBookReservation.getHomepage_id());
        	
        	if(untactBookSetting.getNight_loan_yn().equals("Y")) {
        		//야간예약
        		if(untactBookReservation.getReservation_step().equals("3")) {
            		untactBookReservation.setReservation_step("2");
            		List<UntactBookReservation> receiptList = service.getReceiptListToday(untactBookReservation);
            		
            		UntactBookRound untactBookRound = new UntactBookRound();
            		
            		LibrarySearch librarySearch = new LibrarySearch();
            		
            		if(receiptList != null) {
            			for (int i = 0; i < receiptList.size(); i++) {
            				int request_number = receiptList.get(i).getRequest_number();
            				String manageCode = receiptList.get(i).getManage_code();
            				String userKey = receiptList.get(i).getUser_key();
            				String regNo = receiptList.get(i).getReg_no();
            				String member_name = receiptList.get(i).getMember_name();
            				String book_name = receiptList.get(i).getBook_name();
            				int locker_no = receiptList.get(i).getLocker_number();
            				int locker_pass = receiptList.get(i).getLocker_password();
            				String round_idx = receiptList.get(i).getRound_idx();
            				
            				untactBookRound.setRound_idx(round_idx);
            				untactBookRound.setHomepage_id(receiptList.get(i).getHomepage_id());
            				UntactBookRound roundTime = untactLockerSettingService.getUntactBookRoundAll(untactBookRound);
            				
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
            					untactBookReservation.setLoankey(loanKey);
            					
            					librarySearch.setLoan_key(loanKey);
            					ApiResponse apiResult = LibSearchAPI.bookreserveUpdateStatus(librarySearch);
            					
            					if (apiResult.getStatus()) {
            						untactBookReservation.setReservation_step("3");
            						untactBookReservation.setLoankey(loanKey);
            						untactBookReservation.setRequest_number(request_number);
            						int modify_result = service.waitingReservationStep(untactBookReservation);
            						
            						Homepage homepage = new Homepage();
            						homepage.setHomepage_id(untactBookReservation.getHomepage_id());
            						
            						homepage = homepageService.getHomepageOne(homepage);
            						
            						String userIp = request.getRemoteAddr();
            						
            						librarySearch.setManageCode(loanList.getManageCode());
            						librarySearch.setUserkey(loanList.getUserkey());
            						
            						String loanTime = untactLockerSettingService.getReturnDateToday(untactBookRound);;
            						
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
            						msg = "KLAS API오류" + apiResult.getMessage();
            					}
            				} else {
            					success_yn = "N";
            					msg = "예약키 조회에 실패하였습니다.";
            				}
            			}
            		} else {
            			success_yn = "N";
    	        		msg = "조회되는 사물함이 없습니다.";
            		}
            	} else if (untactBookReservation.getReservation_step().equals("4")) {
            		untactBookReservation.setReservation_step("3");
            		List<UntactBookReservation> receiptList = service.getReceiptListToday(untactBookReservation);
            		
            		LibrarySearch librarySearch = new LibrarySearch();
            		
            		if(receiptList != null) {
            			for(int i = 0; i < receiptList.size(); i++) {
            				untactBookReservation.setReservation_step("4");
        					librarySearch.setManageCode(receiptList.get(i).getManage_code());
        					librarySearch.setUserkey(receiptList.get(i).getUser_key());
        					librarySearch.setReg_no(receiptList.get(i).getReg_no());
        					String ip = request.getRemoteAddr();
        					ApiResponse apiResult = LibSearchAPI.unmannedloan(librarySearch, ip);
        					
        					if (apiResult.getStatus()) {
        						untactBookReservation.setRequest_number(receiptList.get(i).getRequest_number());
        						int count = service.bookReservation(untactBookReservation);
        						
        						if(count < 1) {
        							success_yn = "N";
        							msg = "대출에 실패 하였습니다. 관리자에게 문의하세요";
        						}
        						success_yn = "Y";
        		        		msg = "성공";
        					} else {
        						success_yn = "N";
        		        		msg = "KLAS API오류" + apiResult.getMessage();
        					}
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
        		if(untactBookReservation.getReservation_step().equals("3")) {
            		untactBookReservation.setReservation_step("2");
            		List<UntactBookReservation> receiptList = service.getReceiptList(untactBookReservation);
            		
            		UntactBookRound untactBookRound = new UntactBookRound();
            		
            		LibrarySearch librarySearch = new LibrarySearch();
            		
            		if(receiptList != null) {
            			for (int i = 0; i < receiptList.size(); i++) {
            				int request_number = receiptList.get(i).getRequest_number();
            				String manageCode = receiptList.get(i).getManage_code();
            				String userKey = receiptList.get(i).getUser_key();
            				String regNo = receiptList.get(i).getReg_no();
            				String member_name = receiptList.get(i).getMember_name();
            				String book_name = receiptList.get(i).getBook_name();
            				int locker_no = receiptList.get(i).getLocker_number();
            				int locker_pass = receiptList.get(i).getLocker_password();
            				String round_idx = receiptList.get(i).getRound_idx();
            				
            				untactBookRound.setRound_idx(round_idx);
            				untactBookRound.setHomepage_id(receiptList.get(i).getHomepage_id());
            				UntactBookRound roundTime = untactLockerSettingService.getUntactBookRoundAll(untactBookRound);
            				
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
            					untactBookReservation.setLoankey(loanKey);
            					
            					librarySearch.setLoan_key(loanKey);
            					ApiResponse apiResult = LibSearchAPI.bookreserveUpdateStatus(librarySearch);
            					
            					if (apiResult.getStatus()) {
            						untactBookReservation.setReservation_step("3");
            						untactBookReservation.setLoankey(loanKey);
            						untactBookReservation.setRequest_number(request_number);
            						int modify_result = service.waitingReservationStep(untactBookReservation);
            						
            						Homepage homepage = new Homepage();
            						homepage.setHomepage_id(untactBookReservation.getHomepage_id());
            						
            						homepage = homepageService.getHomepageOne(homepage);
            						
            						String userIp = request.getRemoteAddr();
            						
            						librarySearch.setManageCode(loanList.getManageCode());
            						librarySearch.setUserkey(loanList.getUserkey());
            						
            						String loanTime = untactLockerSettingService.getReturnDate(untactBookRound);;
            						
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
            						msg = "KLAS API오류" + apiResult.getMessage();
            					}
            				} else {
            					success_yn = "N";
            					msg = "예약키 조회에 실패하였습니다.";
            				}
            			}
            		} else {
            			success_yn = "N";
    	        		msg = "조회되는 사물함이 없습니다.";
            		}
            	} else if (untactBookReservation.getReservation_step().equals("4")) {
            		untactBookReservation.setReservation_step("3");
            		List<UntactBookReservation> receiptList = service.getReceiptList(untactBookReservation);
            		
            		LibrarySearch librarySearch = new LibrarySearch();
            		
            		if(receiptList != null) {
            			for(int i = 0; i < receiptList.size(); i++) {
            				receiptList.get(i).setReservation_step("4");
        					librarySearch.setManageCode(receiptList.get(i).getManage_code());
        					librarySearch.setUserkey(receiptList.get(i).getUser_key());
        					librarySearch.setReg_no(receiptList.get(i).getReg_no());
        					String ip = request.getRemoteAddr();
        					ApiResponse apiResult = LibSearchAPI.unmannedloan(librarySearch, ip);
        					
        					if (apiResult.getStatus()) {
        						untactBookReservation.setRequest_number(receiptList.get(i).getRequest_number());
        						untactBookReservation.setReservation_step("4");
        						int count = service.bookReservation(untactBookReservation);
        						
        						if(count < 1) {
        							success_yn = "N";
        							msg = "대출에 실패 하였습니다. 관리자에게 문의하세요";
        						}
        						success_yn = "Y";
        		        		msg = "성공";
        					} else {
        						success_yn = "N";
        		        		msg = "KLAS API오류" + apiResult.getMessage();
        					}
            			}
            		} else {
            			success_yn = "N";
            			msg = "조회되는 사물함이 없습니다.";
            		}
            		
            	} else {
            		 success_yn = "N";
            		 msg = "잘못된 reservation_step 파라미터";
            	}
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
