package kr.co.whalesoft.app.cms.module.mediaFactory;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.mediaFactory.apply.MediaFactoryApply;
import kr.co.whalesoft.app.cms.module.mediaFactory.apply.MediaFactoryApplyService;
import kr.co.whalesoft.framework.base.BaseService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MediaFactoryService extends BaseService {
	
	@Autowired
	private MediaFactoryDao Dao;
	
	@Autowired
	private MediaFactoryApplyService applyService;
	
	public List<Calendar> getCalendar(MediaFactory mediaFactory) {
		return Dao.getCalendar(mediaFactory);
	}
	
	public List<MediaFactory> getMediaFactory(MediaFactory mediaFactory) {
		List<MediaFactory> list = Dao.getMediaFactory(mediaFactory);
		for (MediaFactory mediaFactory1 : list) {
			if (StringUtils.isEmpty(mediaFactory1.getCode_name())) {
				mediaFactory1.setCode_name(Dao.getCodeName(mediaFactory1));
			}
		}
		return list;
	}
	
	public List<CalendarStatus> getMediaFactoryStatus(CalendarStatus calendarStatus) {
		return Dao.getMediaFactoryStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getMediaFactoryMonthStatus(CalendarStatus calendarStatus) {
		return Dao.getMediaFactoryMonthStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getMediaFactoryYearStatus(CalendarStatus calendarStatus) {
		return Dao.getMediaFactoryYearStatus(calendarStatus);
	}
	
	public MediaFactory getMediaFactoryOne(MediaFactory mediaFactory) {
		return Dao.getMediaFactoryOne(mediaFactory);
	}
	
	public int getMediaFactoryDateCheck(MediaFactoryApply apply) {
		return Dao.getMediaFactoryDateCheck(apply);
	}
	
	public int addMediaFactory(MediaFactory mediaFactory) {
		return Dao.addMediaFactory(mediaFactory);
	}
	
	public int modifyCalendarManage(MediaFactory mediaFactory) {
		return Dao.modifyMediaFactory(mediaFactory);
	}
	
	public int deleteMediaFactory(MediaFactory mediaFactory) {
		return Dao.deleteMediaFactory(mediaFactory);
	}
	
	public int countMediaFactory(MediaFactory mediaFactory) {
		return Dao.countMediaFactory(mediaFactory);
	}
	
	public int countClosedMediaFactory(MediaFactory mediaFactory) {
		return Dao.countClosedMediaFactory(mediaFactory);
	}

	@Transactional
	public void deleteMediaFactoryBatch(MediaFactory mediaFactory) {
		for (int i : mediaFactory.getMediaFactory_idx_arr()) {
			MediaFactory oneMediaFactory = new MediaFactory();
			oneMediaFactory.setHomepage_id(mediaFactory.getHomepage_id());
			oneMediaFactory.setMediaFactory_idx(i);
			
			MediaFactoryApply oneApply = new MediaFactoryApply();
			oneApply.setHomepage_id(mediaFactory.getHomepage_id());
			oneApply.setMediaFactory_idx(i);
			
			Dao.deleteMediaFactory(oneMediaFactory);
			applyService.deleteApplyAll(oneApply);
		}
	}
}
