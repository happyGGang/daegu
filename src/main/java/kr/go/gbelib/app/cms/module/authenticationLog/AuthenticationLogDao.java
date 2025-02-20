package kr.go.gbelib.app.cms.module.authenticationLog;

import java.util.List;
import kr.co.whalesoft.app.cms.member.Member;

public interface AuthenticationLogDao {

  void insertAuthenticationLog(Member member);

  int getAuthenticationLogCount(AuthenticationLog authenticationLog);

  List<AuthenticationLog> getAuthenticationLogList(AuthenticationLog authenticationLog);

  List<AuthenticationLog> getAuthenticationLogChartData(AuthenticationLog authenticationLog);
}
