package kr.go.gbelib.app.cms.module.authenticationLog;

import kr.co.whalesoft.app.cms.member.Member;

public interface AuthenticationLogDao {

  void insertAuthenticationLog(Member member);
}
