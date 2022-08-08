package kr.go.gbelib.app.cms.module.drone.loanRequest;

import java.util.List;

public interface LoanRequestDao {

    public List<LoanRequest> getLoanRequestList(LoanRequest loanRequest);

    public int getLoanRequestCount(LoanRequest loanRequest);

    public int insertLoanRequest(LoanRequest loanRequest);

    public int insertLoanRequestLog(LoanRequest loanRequest);

    public int updateLoanRequestStatus(LoanRequest loanRequest);

    public LoanRequest getLoanRequestOne(LoanRequest loanRequest);

    public List<LoanRequest> getLoanRequestLogList(LoanRequest loanRequest);

    public List<LoanRequest> getHomepageLoneReqeustList(LoanRequest loanRequest);

    public int getHomepageLoneReqeustCount(LoanRequest loanRequest);

    public int getDayLoanCount(LoanRequest loanRequest);

    public int getPersonalLoanCount(LoanRequest loanRequest);

    public String getReqeustBookYn(LoanRequest loanRequest);

}
