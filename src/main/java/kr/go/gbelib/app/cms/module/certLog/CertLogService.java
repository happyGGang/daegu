package kr.go.gbelib.app.cms.module.certLog;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.AES128;

@Service
public class CertLogService extends BaseService {

	@Autowired
	private CertLogDao dao;
	
	public int addLog(CertLog certLog) {
		CertLog log = new CertLog(certLog.getCert_mode(), certLog.getCert_type(), AES128.encrypt(certLog.getName()), AES128.encrypt(certLog.getBirthday()), AES128.encrypt(certLog.getCell_phone()), AES128.encrypt(certLog.getCi()), AES128.encrypt(certLog.getMsg()), certLog.getIp());
		return dao.addLog(log);
	}
	
	public List<CertLog> getCertLogList() {
		return dao.getCertLogList();
	}
	
}
