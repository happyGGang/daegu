package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice;

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
public class NeighborhoodLibraryDeviceService extends BaseService{
	
	@Autowired
	private NeighborhoodLibraryDeviceDao dao;


	public int addNeighborhoodLibraryDevice(NeighborhoodLibraryDevice neighborhoodLibraryDevice) {
		return dao.addNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
	}

	public List<NeighborhoodLibraryDevice> getNeighborhoodLibraryDeviceAll(NeighborhoodLibraryDevice neighborhoodLibraryDevice) {
		return dao.getNeighborhoodLibraryDeviceAll(neighborhoodLibraryDevice);
	}
	
	public int getNeighborhoodLibraryDeviceCount(NeighborhoodLibraryDevice neighborhoodLibraryDevice) {
		return dao.getNeighborhoodLibraryDeviceCount(neighborhoodLibraryDevice);
	}

	public NeighborhoodLibraryDevice getNeighborhoodLibraryDeviceOne(NeighborhoodLibraryDevice neighborhoodLibraryDevice) {
		return	dao.getNeighborhoodLibraryDeviceOne(neighborhoodLibraryDevice);
	}

	public int modifyNeighborhoodLibraryDevice(NeighborhoodLibraryDevice neighborhoodLibraryDevice) {
		return dao.modifyNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
	}

	public int deleteNeighborhoodLibraryDevice(NeighborhoodLibraryDevice neighborhoodLibraryDevice) {
		return dao.deleteNeighborhoodLibraryDevice(neighborhoodLibraryDevice);
	}

	public List<NeighborhoodLibraryDevice> getNeighborhoodLibraryDeviceList(NeighborhoodLibraryDevice neighborhoodLibraryDevice) {
		return dao.getNeighborhoodLibraryDeviceList(neighborhoodLibraryDevice);
	}

}
