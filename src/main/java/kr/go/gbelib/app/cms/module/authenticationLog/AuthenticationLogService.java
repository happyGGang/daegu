package kr.go.gbelib.app.cms.module.authenticationLog;

import java.util.List;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationLogService extends BaseService {

  @Autowired
  AuthenticationLogDao dao;

  public void insertAuthenticationLog(Member member) {
    dao.insertAuthenticationLog(member);
  }

  public int getAuthenticationLogCount(AuthenticationLog authenticationLog) {
    return dao.getAuthenticationLogCount(authenticationLog);
  }

  public List<AuthenticationLog> getAuthenticationLogList(AuthenticationLog authenticationLog) {
    return dao.getAuthenticationLogList(authenticationLog);
  }

  public List<AuthenticationLog> getAuthenticationLogChartData(AuthenticationLog authenticationLog) {
    return dao.getAuthenticationLogChartData(authenticationLog);
  }
}
