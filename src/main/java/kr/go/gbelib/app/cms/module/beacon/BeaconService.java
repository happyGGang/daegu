package kr.go.gbelib.app.cms.module.beacon;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.file.FileStorage;

@Service
public class BeaconService extends BaseService{

	@Autowired
	@Qualifier("beaconStorage")
	private FileStorage beaconStorage;
	
	@Autowired
	private BeaconDao dao;
	
	public List<Beacon> getBeaconList(Beacon beacon) {
		return dao.getBeaconList(beacon);
	}
	
	public int getBeaconListCount(Beacon beacon) {
		return dao.getBeaconListCount(beacon);
	}
	
	public Beacon getBeaconOne(Beacon beacon) {
		return dao.getBeaconOne(beacon);
	}
	
	public int addBeacon(Beacon beacon) {
		MultipartFile mFile = beacon.getFile();
		
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String filePath 		= "/";
			
			File f = beaconStorage.addFile(mFile, realFileName, filePath);
			
			beacon.setUrl("http://www.gbelib.kr/data/beacon/" + realFileName);
		}
		return dao.addBeacon(beacon);
	}
	
	public int modifyBeacon(Beacon beacon) {
		MultipartFile mFile = beacon.getFile();
		if ( mFile != null ) {
			String realFileName 	= Long.toString((System.currentTimeMillis()));
			String filePath 		= "/";
			
			File f = beaconStorage.addFile(mFile, realFileName, filePath);
			
			beacon.setUrl("http://www.gbelib.kr/data/beacon/" + realFileName);
		}
		
		return dao.modifyBeacon(beacon);
	}
	
	public int checkMinor(Beacon beacon) {
		return dao.checkMinor(beacon);
	}

	public int deleteBeaconFile(Beacon beacon) {
		beacon = dao.getBeaconOne(beacon);
		beaconStorage.deleteFile(beacon.getUrl().replace("/data/beacon/", ""), "/data/beacon");
		return dao.deleteBeaconFile(beacon);
	}

	/**
	 * 비콘 데이터 삭제
	 * @author YONGJU 2017. 11. 9.
	 * @param beacon
	 */
	public int deleteBeacon(Beacon beacon) {
		return dao.deleteBeacon(beacon);
	}
	
}
