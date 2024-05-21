package kr.go.gbelib.app.intro.search;

import java.time.LocalDateTime;
import java.time.Month;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class LibrarySearchService extends BaseService {

	@Autowired
	private LibrarySearchDao dao;

	public String getImageUrl(Map<String, Object> map) {
		return dao.getImageUrl(map);
	}

	public String getImageUrl(String isbn) {
		return dao.getImageUrl(isbn);
	}

	public boolean isWalkingThroughTime() {

		boolean walkingThroughTime = false;

		LocalDateTime now = LocalDateTime.now();

		LocalDateTime period1Start = LocalDateTime.of(2024, Month.JUNE, 3, 12, 0);
		LocalDateTime period1End = LocalDateTime.of(2024, Month.JUNE, 4, 15, 0);
		LocalDateTime period2Start = LocalDateTime.of(2024, Month.JUNE, 4, 18, 0);
		LocalDateTime period2End = LocalDateTime.of(2024, Month.JUNE, 5, 15, 0);

		LocalDateTime unavailableStartTime = LocalDateTime.of(2024, Month.JUNE, 4, 15, 0);
		LocalDateTime unavailableEndTime = LocalDateTime.of(2024, Month.JUNE, 4, 18, 0);

//		LocalDateTime period1Start = LocalDateTime.of(2024, Month.MAY, 3, 12, 0);
//		LocalDateTime period1End = LocalDateTime.of(2024, Month.MAY, 4, 15, 0);
//		LocalDateTime period2Start = LocalDateTime.of(2024, Month.MAY, 4, 18, 0);
//		LocalDateTime period2End = LocalDateTime.of(2024, Month.MAY, 5, 15, 0);
//
//		LocalDateTime unavailableStartTime = LocalDateTime.of(2024, Month.MAY, 4, 15, 0);
//		LocalDateTime unavailableEndTime = LocalDateTime.of(2024, Month.MAY, 4, 18, 0);

		walkingThroughTime = (now.isEqual(period1Start) || now.isAfter(period1Start)) && now.isBefore(period1End) || (now.isEqual(period2Start) || now.isAfter(period2Start)) && now.isBefore(period2End);

		if ((now.isEqual(unavailableStartTime) || now.isAfter(unavailableStartTime)) && now.isBefore(unavailableEndTime)) {
			walkingThroughTime = false;
		}

		// 결과 출력
		System.out.println("값이 뭐야?" + walkingThroughTime);
		return walkingThroughTime;
	}
}
