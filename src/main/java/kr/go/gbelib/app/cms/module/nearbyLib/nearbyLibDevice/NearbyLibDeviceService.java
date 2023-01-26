package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibDevice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

/**
 * @author ttkaz
 * 2022. 9. 29.
 *
 */
@Service
public class NearbyLibDeviceService extends BaseService{
	
	@Autowired
	private NearbyLibDeviceDao dao;


	public int addNeighborhoodLibraryDevice(NearbyLibDevice neighborhoodLibraryDevice) {
		return dao.addNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
	}

	public List<NearbyLibDevice> getNeighborhoodLibraryDeviceAll(NearbyLibDevice neighborhoodLibraryDevice) {
		return dao.getNeighborhoodLibraryDeviceAll(neighborhoodLibraryDevice);
	}
	
	public int getNeighborhoodLibraryDeviceCount(NearbyLibDevice neighborhoodLibraryDevice) {
		return dao.getNeighborhoodLibraryDeviceCount(neighborhoodLibraryDevice);
	}

	public NearbyLibDevice getNeighborhoodLibraryDeviceOne(NearbyLibDevice neighborhoodLibraryDevice) {
		return	dao.getNeighborhoodLibraryDeviceOne(neighborhoodLibraryDevice);
	}

	public int modifyNeighborhoodLibraryDevice(NearbyLibDevice neighborhoodLibraryDevice) {
		return dao.modifyNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
	}

	public int deleteNeighborhoodLibraryDevice(NearbyLibDevice neighborhoodLibraryDevice) {
		return dao.deleteNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
	}

	public List<NearbyLibDevice> getNeighborhoodLibraryDeviceList(NearbyLibDevice neighborhoodLibraryDevice) {
		return dao.getNeighborhoodLibraryDeviceList(neighborhoodLibraryDevice);
	}

	public List<NearbyLibDevice> getNearbyLibDeviceList(NearbyLibDevice neighborhoodLibraryDevice) {
		return dao.getNearbyLibDeviceList(neighborhoodLibraryDevice);
	}

	public String getNearbyLibDeviceOne(int device_idx) {
		return dao.getNearbyLibDeviceOne(device_idx);
	}

}
