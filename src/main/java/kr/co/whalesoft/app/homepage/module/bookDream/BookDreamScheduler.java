package kr.co.whalesoft.app.homepage.module.bookDream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class BookDreamScheduler {

	@Autowired
	private BookDreamService service;
	
	@Scheduled(cron="0 0 10 * * ?")//초 분 시 일 월 요
	public void periodPointSchedul() {
		service.procSchedule();
	}
}


