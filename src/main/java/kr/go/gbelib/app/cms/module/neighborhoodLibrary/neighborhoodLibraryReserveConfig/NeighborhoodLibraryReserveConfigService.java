package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryReserveConfig;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

/**
 * @author ttkaz
 * 2022. 10. 17.
 *
 */
@Service
public class NeighborhoodLibraryReserveConfigService extends BaseService{
	
	@Autowired
	private NeighborhoodLibraryReserveConfigDao dao;
	
	public List<NeighborhoodLibraryReserveConfig> getNeighborhoodLibraryReserveConfigAll(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigAll(neighborhoodLibraryReserveConfig);
	}

	public int getNeighborhoodLibraryReserveConfigCount(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigCount(neighborhoodLibraryReserveConfig);
	}
	
	public NeighborhoodLibraryReserveConfig getNeighborhoodLibraryReserveConfigOne(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigOne(neighborhoodLibraryReserveConfig);
	}

	public int addNeighborhoodLibraryReserveConfig(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.addNeighborhoodLibraryReserveConfig(neighborhoodLibraryReserveConfig);
	}

	public int modifyNeighborhoodLibraryDevice(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.modifyNeighborhoodLibraryDevice(neighborhoodLibraryReserveConfig);
	}

	public List<NeighborhoodLibraryReserveConfig> getNeighborhoodLibraryReserveConfigList(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigList(neighborhoodLibraryReserveConfig);
	}

}
