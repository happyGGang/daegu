package kr.go.gbelib.app.cms.module.liboneManage;

import java.net.InetAddress;
import java.net.UnknownHostException;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LiboneManageService extends BaseService{

	private static LiboneManageDao dao;

	@Autowired(required=true)
	public void setDao(LiboneManageDao dao) {
		LiboneManageService.dao = dao;
	}
	
	
	public static void insertLiboneAPIConnectError(String exceptoinMessage) {
		LiboneManage liboneManage = new LiboneManage();
		liboneManage.setException_message(exceptoinMessage);
		InetAddress inet = null;
		try {
			inet = InetAddress.getLocalHost();
			liboneManage.setServer_ip(inet.getHostAddress());
		} catch (UnknownHostException e) {
			e.printStackTrace();
//			e.printStackTrace();
		}
		dao.insertLiboneAPIConnectError(liboneManage);
	}
	
}
