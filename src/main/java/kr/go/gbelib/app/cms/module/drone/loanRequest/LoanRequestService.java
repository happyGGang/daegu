package kr.go.gbelib.app.cms.module.drone.loanRequest;

import java.util.List;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LoanRequestService extends BaseService {
    @Autowired
    private LoanRequestDao dao;

    public List<LoanRequest> getLoanRequestList(LoanRequest loanRequest) {
        return dao.getLoanRequestList(loanRequest);
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
                    success = apiResult.getStatus();
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
}
