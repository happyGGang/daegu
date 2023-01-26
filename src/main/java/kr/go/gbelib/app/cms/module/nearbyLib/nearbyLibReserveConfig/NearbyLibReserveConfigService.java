package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage.NearbyLibManage;

/**
 * @author ttkaz
 * 2022. 10. 17.
 *
 */
@Service
public class NearbyLibReserveConfigService extends BaseService{
	
	@Autowired
	private NearbyLibReserveConfigDao dao;
	
	public List<NearbyLibReserveConfig> getNeighborhoodLibraryReserveConfigAll(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigAll(neighborhoodLibraryReserveConfig);
	}

	public int getNeighborhoodLibraryReserveConfigCount(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigCount(neighborhoodLibraryReserveConfig);
	}
	
	public NearbyLibReserveConfig getNeighborhoodLibraryReserveConfigOne(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigOne(neighborhoodLibraryReserveConfig);
	}

	public int addNeighborhoodLibraryReserveConfig(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.addNeighborhoodLibraryReserveConfig(neighborhoodLibraryReserveConfig);
	}

	public int modifyNeighborhoodLibraryDevice(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.modifyNeighborhoodLibraryDevice(neighborhoodLibraryReserveConfig);
	}

	public int modifyNearbyLibReserveConfig(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.modifyNearbyLibReserveConfig(neighborhoodLibraryReserveConfig);
	}

	public List<NearbyLibReserveConfig> getNeighborhoodLibraryReserveConfigList(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigList(neighborhoodLibraryReserveConfig);
	}

	public int getTakeTermOfReserveConfig() {
		return dao.getTakeTermOfReserveConfig();
	}

	public List<NearbyLibReserveConfig> getReserveConfigCalendar(NearbyLibManage nearbyLibManage) {
		return dao.getReserveConfigCalendar(nearbyLibManage);
	}

	public int getReserveConfigTodayCount(String nearbyLibManageCode) {
		return dao.getReserveConfigTodayCount(nearbyLibManageCode);
	}

	public NearbyLibReserveConfig getReserveConfigToday(String nearbyLibManageCode) {
		return dao.getReserveConfigToday(nearbyLibManageCode);
	}

	public boolean checkReserveTime(String nearbyLibManageCode) {
		int[] oracleDayOfWeek = {0, 2, 3, 4, 5, 6, 7, 1};

		LocalDateTime today = LocalDateTime.now();
		final int value = today.getDayOfWeek().getValue();
		final int dayOfWeek = oracleDayOfWeek[value];

		final NearbyLibManage nearbyLibManage = new NearbyLibManage(nearbyLibManageCode, "");
		final List<NearbyLibReserveConfig> reserveConfigCalendar = dao.getReserveConfigCalendar(nearbyLibManage);

		final NearbyLibReserveConfig todayConfig = reserveConfigCalendar.stream()
			.filter(config -> Integer.parseInt(config.getDay_of_week()) == dayOfWeek)
			.findFirst()
			.orElse(reserveConfigCalendar.get(0));

		final LocalTime localTime = today.toLocalTime();
		final int startHour = Integer.parseInt(todayConfig.getReserve_start_time().substring(0, 2));
		final int startMinute = Integer.parseInt(todayConfig.getReserve_start_time().substring(2));
		final boolean isYesterday = localTime.isBefore(LocalTime.of(startHour, startMinute));

		NearbyLibReserveConfig referenceConfig = todayConfig;
		if (isYesterday) {
			referenceConfig = reserveConfigCalendar.stream()
				.filter(config -> Integer.parseInt(config.getDay_of_week()) == yesterdayOfWeek(Integer.parseInt(todayConfig.getDay_of_week())))
				.findFirst()
				.orElse(todayConfig);
		}
		
		boolean checkTime = dao.checkTime(referenceConfig);

		return checkTime;
	}

	private int yesterdayOfWeek(int dayOfWeek) {
		if(dayOfWeek == 1) {
			return 7;
		}
		return dayOfWeek - 1;
	}

	public List<NearbyLibReserveConfig> getReserveConfigCalendarAll(NearbyLibManage nearbyLibManage) {
		return dao.getReserveConfigCalendarAll(nearbyLibManage);
	}

}
