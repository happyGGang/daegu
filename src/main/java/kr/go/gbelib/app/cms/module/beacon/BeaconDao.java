package kr.go.gbelib.app.cms.module.beacon;

import java.util.List;

public interface BeaconDao {
	
	public List<Beacon> getBeaconList(Beacon beacon);
	
	public int getBeaconListCount(Beacon beacon);
	
	public Beacon getBeaconOne(Beacon beacon);
	
	public int addBeacon(Beacon beacon);
	
	public int modifyBeacon(Beacon beacon);
	
	public int checkMinor(Beacon beacon);

	public int deleteBeaconFile(Beacon beacon);

	/**
	 * 비콘 삭제
	 * @author YONGJU 2017. 11. 9.
	 * @param beacon
	 * @return
	 */
	public int deleteBeacon(Beacon beacon);
	
}
