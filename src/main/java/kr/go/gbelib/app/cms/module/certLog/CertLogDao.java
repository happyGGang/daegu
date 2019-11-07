package kr.go.gbelib.app.cms.module.certLog;

import java.util.List;

public interface CertLogDao {

	public int addLog(CertLog certLog);
	
	public List<CertLog> getCertLogList();
	
}
