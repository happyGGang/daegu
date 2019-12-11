/**
 *
 */
package kr.co.whalesoft.app.cms.privacyLog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

/**
 * 개인정보 열람, 추가, 수정, 삭제 로그
 *
 * @author whaleesoft YONGJU 2019. 12. 4.
 *
 */
@Service
public class PrivacyLogService extends BaseService {

	@Autowired
	private PrivacyLogDao dao;

	public int addPrivacyLog(PrivacyLog privacyLog) {
		return dao.addPrivacyLog(privacyLog);
	}
}
