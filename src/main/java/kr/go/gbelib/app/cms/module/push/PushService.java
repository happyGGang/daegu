package kr.go.gbelib.app.cms.module.push;

import java.io.File;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class PushService extends BaseService{

	@Autowired
	@Qualifier("pushStorage")
	private FileStorage pushStorage;
	
	@Autowired
	private PushDao dao;
	
	public List<Push> getPushList(Push push) {
		return dao.getPushList(push);
	}
	
	public int getPushListCount(Push push) {
		return dao.getPushListCount(push);
	}
	
	public Push getPushOne(Push push) {
		return dao.getPushOne(push);
	}
	
	public int addPush(Push push) {
		MultipartFile mFile = push.getFile();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String filePath 		= "/";
			
			File f = pushStorage.addFile(mFile, realFileName, filePath);
			
			push.setPush_url("http://www.gbelib.kr/data/push/" + realFileName);
		}	
		
		return dao.addPush(push);
	}
	
	public int modifyPush(Push push) {
		MultipartFile mFile = push.getFile();
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String filePath 		= "/";
			
			File f = pushStorage.addFile(mFile, realFileName, filePath);
			
			push.setPush_url("http://www.gbelib.kr/data/push/" + realFileName);
		}
		
		return dao.modifyPush(push);
	}
	
	public int deletePushFile(Push push) {
		push = dao.getPushOne(push);
		pushStorage.deleteFile(push.getPush_url().replace("/data/push/", ""), "/data/push");
		return dao.deletePushFile(push);
	}
	
}
