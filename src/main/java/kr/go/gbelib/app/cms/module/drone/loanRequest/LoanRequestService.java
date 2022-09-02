package kr.go.gbelib.app.cms.module.drone.loanRequest;

import java.util.List;
import java.util.Map;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LoanRequestService extends BaseService {
    @Autowired
    private LoanRequestDao dao;

    public List<LoanRequest> getLoanRequestList(LoanRequest loanRequest) {
        List<LoanRequest> loanRequests = dao.getLoanRequestList(loanRequest);

        LibrarySearch librarySearch = new LibrarySearch();

        librarySearch.setSearch_start_date(loanRequest.getSearch_start_request_date());
        librarySearch.setSearch_end_date(loanRequest.getSearch_end_request_date());


        for (LoanRequest one: loanRequests) {
            // 복귀 상태 이거나 반납 상태일때만 대출 상태 관련해서 가져오도록 설정
            if ("2002".equals(one.getRequest_status()) || "1002".equals(one.getRequest_status())) {
                try {
                    librarySearch.setUserkey(one.getUser_key());

                    Map<String, Object> result = LibSearchAPI.getBookLoanHistory(librarySearch);
                    List<Map<String, Object>> list = null;

                    if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
                        list = LibSearchAPI.getListData(result);

                        for (Map<String, Object> retrunData : list) {
                            if (one.getLoan_date() != null) {
                                String db_loan_date = one.getLoan_date().replaceAll("-", "");
                                String map_loan_date = (String) retrunData.get("LOAN_DATE");
                                String map_manage_code = (String) retrunData.get("MANAGE_CODE");
                                String map_reg_no = (String) retrunData.get("REG_NO");

                                if (map_loan_date.replaceAll("/", "").equals(db_loan_date) && map_manage_code.equals(one.getManage_code()) && map_reg_no.equals(one.getReg_no())) {
                                    String map_return_date = (String) retrunData.get("RETURN_DATE");
                                    one.setReturn_date(map_return_date.replaceAll("/", "-"));
                                    break;
                                }
                            } else {
                                break;
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        return loanRequests;
    }

    public int getLoanRequestCount(LoanRequest loanRequest) {
        return dao.getLoanRequestCount(loanRequest);
    }

    public int insertLoanRequest(LoanRequest loanRequest) {
        return dao.insertLoanRequest(loanRequest);
    }

    @Transactional
    public String updateStatus(LoanRequest loanRequest){
        int result = 0;
        boolean success = true;
        String message = "success";

        try {
            LoanRequest one = dao.getLoanRequestOne(loanRequest);

            if ("2000".equals(loanRequest.getRequest_status())) { // 수령시 SMS 발송
                success = false;
                String mes = "신청하신 드론대출 도서[" + one.getBook_name() + "]이 수령장소에 도착했습니다.";
                ApiResponse apiResult = LibSearchAPI.sendSms(apiParameter(one, loanRequest.getRequest_status()), mes, one.getAdd_ip());
                success = apiResult.getStatus();
            } else if ("2001".equals(loanRequest.getRequest_status())) { // 대출시 대출API 호출
                success = false;
                ApiResponse apiResult = LibSearchAPI.unmannedloan(apiParameter(one, loanRequest.getRequest_status()), one.getAdd_ip());

                if (apiResult.getStatus()) {
                    Map<String, Object> loanResult = LibSearchAPI.getBookLoanList(one.getUser_key(), one.getManage_code(), 1 ,10);

                    List<Map<String, Object>> listData = LibSearchAPI.getListData(loanResult);

                    if (listData.size() > 0) {

                        for (Map<String, Object> loneData : listData) {
                            String reg_no =(String) loneData.get("REG_NO");

                            if (reg_no.equals(one.getReg_no())) {
                                String loan_date = (String) loneData.get("LOAN_DATE");

                                if (StringUtils.isNotEmpty(loan_date)) {
                                    loanRequest.setLoan_date((String) ((String) loneData.get("LOAN_DATE")).replaceAll("/", "-"));
                                    success = apiResult.getStatus();
                                }
                            }
                        }
                    }
                } else {
                    message = apiResult.getMessage();
                }
            } else if ("1002".equals(loanRequest.getRequest_status())) {
                success = false;

                ApiResponse apiResult = LibSearchAPI.unmannedreturn(apiParameter(one, loanRequest.getRequest_status()), one.getAdd_ip());

                if (apiResult.getStatus()) {
                    success = apiResult.getStatus();
                } else {
                    message = apiResult.getMessage();
                }
            }

            if (success) {
                loanRequest.setPrev_request_status(one.getRequest_status());

                result += dao.updateLoanRequestStatus(loanRequest);
                if (result > 0) {
                    result += dao.insertLoanRequestLog(loanRequest);
                }
            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return message;
    }

    public LoanRequest getLoanRequestOne(LoanRequest loanRequest) {
        return dao.getLoanRequestOne(loanRequest);
    }

    public List<LoanRequest> getLoanRequestLogList(LoanRequest loanRequest) {
        return dao.getLoanRequestLogList(loanRequest);
    }

    public LibrarySearch apiParameter(LoanRequest loanRequest, String request_status) {
        LibrarySearch librarySearch = new LibrarySearch();
        librarySearch.setUserkey(loanRequest.getUser_key());
        librarySearch.setManageCode(loanRequest.getManage_code());

        if ("2001".equals(request_status) || "1002".equals(request_status)) {
            librarySearch.setReg_no(loanRequest.getReg_no());
            librarySearch.setDevice_code(loanRequest.getDevice_code());
        }

        return librarySearch;
    }

    public List<LoanRequest> getHomepageLoneReqeustList(LoanRequest loanRequest) {
        return dao.getHomepageLoneReqeustList(loanRequest);
    }

    public int getHomepageLoneReqeustCount(LoanRequest loanRequest) {
        return dao.getHomepageLoneReqeustCount(loanRequest);
    }

    public int getDayLoanCount(LoanRequest loanRequest) {
        // 일 대출 건수
        return dao.getDayLoanCount(loanRequest);
    }

    public int getPersonalLoanCount(LoanRequest loanRequest) {
        // 개인 대출 건수
        return dao.getPersonalLoanCount(loanRequest);
    }

    public String getReqeustBookYn(LoanRequest loanRequest) {
        return dao.getReqeustBookYn(loanRequest);
    }

    public String getBookLoanYn(LoanRequest loanRequest) {
        return dao.getBookLoanYn(loanRequest);
    }
}
