package kr.co.whalesoft.app.homepage.index;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.banner.Banner;
import kr.co.whalesoft.app.cms.banner.BannerService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.mainImg.MainImg;
import kr.co.whalesoft.app.cms.mainImg.MainImgService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import kr.co.whalesoft.app.cms.module.excursions.apply.ApplyService;
import kr.co.whalesoft.app.cms.news.News;
import kr.co.whalesoft.app.cms.news.NewsService;
import kr.co.whalesoft.app.cms.popup.Popup;
import kr.co.whalesoft.app.cms.popup.PopupService;
import kr.co.whalesoft.app.cms.popupZone.PopupZone;
import kr.co.whalesoft.app.cms.popupZone.PopupZoneService;
import kr.co.whalesoft.app.cms.quickMenu.QuickMenu;
import kr.co.whalesoft.app.cms.quickMenu.QuickMenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.elib.best.BestService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReq;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReqService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller(value = "userIndexController")
public class IndexController extends BaseController {

	private final String basePath = "/homepage/";

	@Autowired
	private BoardService boardService;

	@Autowired
	private QuickMenuService quickMenuService;

	@Autowired
	private PopupZoneService popupZoneService;

	@Autowired
	private PopupService popupService;

	@Autowired
	private MainImgService mainImgService;

	@Autowired
	private BannerService bannerService;

	@Autowired
	private NewsService newsService;

	@Autowired
	private CalendarManageService calendarManageService;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private TeachService teachService;

	@Autowired
	private FacilityReqService facilityReqService;

	@Autowired
	private BestService bestService;

	@Autowired
	private BoardManageService boardManageService;

	@RequestMapping(value = { "index.*" })
	public String index(Model model, HttpServletRequest request) {
		// return doIndexProc(model, request); //대표 홈페이지 이동
		return "redirect:/gbelib/index.do";
	}

	@RequestMapping(value = { "/{contextPath}/index.*" })
	public String index(Model model, HttpServletRequest request, @PathVariable String contextPath) {
		return doIndexProc(model, request, null);
	}

	@RequestMapping(value = { "/{contextPath}/calendar.*" })
	public String calendar(Model model, CalendarManage calendarManage, HttpServletRequest request, @PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");

		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage = new CalendarManage(sf.format(Calendar.getInstance().getTime()));
		}
		calendarManage.setHomepage_id(homepage.getHomepage_id());

		List<CalendarManage> calendarList = calendarManageService.getCalendar(calendarManage);

		CalendarManage closedDay = calendarManageService.getClosedDate2(calendarManage);

		model.addAttribute("calendar", calendarManage);
		model.addAttribute("calendarResult", getCalendarMarkCloseDay(closedDay, calendarList));
		model.addAttribute("closeDayList", calendarManageService.getClosedDate2(calendarManage));
		return "/homepage/calendar_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar2.*" }) // 휴관일만 가져오기
	public String calendar2(Model model, CalendarManage calendarManage, HttpServletRequest request,
			@PathVariable String contextPath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = homepage.getFolder() + "/closedCalendar";

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");

		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage = new CalendarManage(sf.format(Calendar.getInstance().getTime()));
		}
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("calendar", calendarManage);
		model.addAttribute("closeDayList", calendarManageService.getClosedDate2(calendarManage));
		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar3.*" }) // 1개월 가져오기
	public String calendar3(Model model, CalendarManage calendarManage, Board board, HttpServletRequest request,
			@PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/calendar";
		}

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
		if (StringUtils.isEmpty(calendarManage.getPlan_date())) {
			calendarManage = new CalendarManage(sf.format(Calendar.getInstance().getTime()));
		}

		SimpleDateFormat sf2 = new SimpleDateFormat ("yyyy.MM.dd");
		Date currentDay = new Date ();
		String currDate = sf2.format ( currentDay );

		calendarManage.setHomepage_id(homepage.getHomepage_id());
		board.setHomepage_id(homepage.getHomepage_id());
		board.setImsi_v_1(calendarManage.getPlan_date());

		CalendarManage closedDay = null;
		if("geic".equals(contextPath)) {
			closedDay = calendarManageService.getClosedDate3(calendarManage);
		} else {
			closedDay = calendarManageService.getClosedDate2(calendarManage);
		}
		calendarManage.setDate_type("2");
		List<CalendarManage> eventDay = calendarManageService.getCalendarManageDetail(calendarManage);
		calendarManage.setDate_type(null);
		List<Board> movieDay = boardService.getBoardMovie(board);
		List<Apply> applyDay = applyService.getOkApply(calendarManage);
		List<Teach> teachDay = teachService.getTeachListForCalendar(calendarManage);
		List<FacilityReq> facilityDay = facilityReqService.getFacilityReqCalendar(calendarManage);
		List<CalendarManage> calendarList = calendarManageService.getCalendar(calendarManage);
		model.addAttribute("currDate", currDate);
		model.addAttribute("calendar", calendarManage);
		model.addAttribute("calendarList", calendarList);
		model.addAttribute("calendarResult", getCalendarMarkGumi(calendarManage.getPlan_date(), closedDay, eventDay, movieDay, applyDay, teachDay, facilityDay));
		model.addAttribute("closeDayList", closedDay);
		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/calendar4.*" }) // 1일 가져오기
	public String calendar4(Model model, CalendarManage calendarManage, Board board, HttpServletRequest request,
			@PathVariable String contextPath) throws ParseException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/dailyCalendar";
		}

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		if (StringUtils.isEmpty(calendarManage.getPlan_day())) {
			calendarManage = new CalendarManage();
			calendarManage.setPlan_day(sf.format(Calendar.getInstance().getTime()));
		}

		SimpleDateFormat sf2 = new SimpleDateFormat ("yyyy.MM.dd");
		Date currentDay = new Date ();
		String currDate = sf2.format ( currentDay );

		calendarManage.setHomepage_id(homepage.getHomepage_id());
		board.setHomepage_id(homepage.getHomepage_id());
		board.setImsi_v_1(calendarManage.getPlan_day().substring(0,7));
		board.setImsi_v_2(calendarManage.getPlan_day().substring(8));

		CalendarManage closedDay = null;
		closedDay = calendarManageService.getClosedDate3(calendarManage);
		List<CalendarManage> eventDay = calendarManageService.getCalendarManageDetail(calendarManage);
		List<Board> movieDay = boardService.getBoardMovie(board);
		List<Apply> applyDay = applyService.getOkApply(calendarManage);
		List<Teach> teachDay = teachService.getTeachListForCalendar(calendarManage);
		List<FacilityReq> facilityDay = facilityReqService.getFacilityReqCalendar(calendarManage);
//		List<CalendarManage> calendarList = calendarManageService.getCalendar(calendarManage);
		model.addAttribute("currDate", currDate);
		model.addAttribute("calendar", calendarManage);
//		model.addAttribute("calendarList", calendarList);
		Map<String, List<String>> calendarMarkGumi = getCalendarMarkGumi(calendarManage.getPlan_day(), closedDay, eventDay, movieDay, applyDay, teachDay, facilityDay);
		String day = calendarManage.getPlan_day().split("-")[2];
		if (day.startsWith("0")) {
			day = day.replace("0", "");
		}
		List<String> calendarResult = calendarMarkGumi.get(day);
		model.addAttribute("calendarResult", calendarResult);
		model.addAttribute("closeDayList", closedDay);
		return basePath + filePath + "_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/newBook.*" })
	public String newBook(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		LibrarySearch ls = new LibrarySearch();
		ls.setManageCode(homepage.getManage_code());

		//기본값 '1달 전'
		//검색기간 설정
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		int beforeDays = -30;
		ls.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), beforeDays)));
		ls.setSearch_end_date(sf.format(new Date()));

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		ls.setBooktype("0");

		Map<String, Object> result = LibSearchAPI.getNewBookList(ls);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);
		ls.setTotalDataCount(count);

		if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

			list = LibSearchAPI.getListData(result);
			for (Map<String, Object> map : list) {
				if (map.containsKey("ISBN")) {
					//알라딘 API 결과 가져오기
					if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							map.put("aladin", aladinData.get("item"));
						}
					}
				}
			}
		}

		model.addAttribute("newBookList", list);
		return basePath + homepage.getFolder() + "/newBook_ajax";
	}

	@RequestMapping(value = { "/{contextPath}/bestBook.*" })
	public String bestBook(Model model, HttpServletRequest request, @PathVariable String contextPath) throws ParseException {
		Homepage homepage 	= (Homepage) request.getAttribute("homepage");
		LibrarySearch ls = new LibrarySearch();
		ls.setManageCode(homepage.getManage_code());

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		ls.setBooktype("0");

		Map<String, Object> result = LibSearchAPI.getBestBookList(ls);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		ls.setTotalDataCount(count);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			list = LibSearchAPI.getListData(result);
			for ( Map<String, Object> map : list ) {
				if ( map.containsKey("ISBN") ) {
					LibrarySearch book = new LibrarySearch();
					book.setIsbn(String.valueOf(map.get("ISBN")));
					book.setManageCode(ls.getManageCode());
					book.setRowCount(1);
					Map<String, Object> bookDetail = null;
					bookDetail = LibSearchAPI.getBookDetail(book);
					List<Map<String, Object>> detailList = LibSearchAPI.getListData(bookDetail);
					if ( detailList != null && detailList.size() > 0 ) {
						map.put("IMAGE", detailList.get(0).get("IMAGE"));
					}
				}
			}
		}


		model.addAttribute("bestBookList", list);
		return basePath + homepage.getFolder() + "/bestBook_ajax";
	}

	private String doIndexProc(Model model, HttpServletRequest request, Board board) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		String filePath = "";

		if (homepage != null) {
			filePath = homepage.getFolder() + "/index";
		}


		// model.addAttribute("lnkBookList", LibSearchAPI.getLnkBookList(new
		// LibrarySearch(homepage.getHomepage_code(), 0, 10), "Y"));
		model.addAttribute("newsList", newsService.getNewsListAll(new News(homepage.getHomepage_id())));
		model.addAttribute("bannerList", bannerService.getBannerAll(new Banner(homepage.getHomepage_id())));
		model.addAttribute("mainImgList", mainImgService.getMainImgListAll(new MainImg(homepage.getHomepage_id())));
		model.addAttribute("popupList", popupService.getPopupAll(new Popup(homepage.getHomepage_id())));
		model.addAttribute("popupZoneList", popupZoneService.getPopupZoneAll(new PopupZone(homepage.getHomepage_id())));
		model.addAttribute("quickMenuList", quickMenuService.getQuickMenuListAll(new QuickMenu(homepage.getHomepage_id())));

		//강좌목록
		if (homepage.getHomepage_id().equals("h7")) {
			Teach t = new Teach();
			t.setHomepage_id(homepage.getHomepage_id());
			model.addAttribute("teachList", teachService.getTeachListForUser(t));
		}


		setBoardListToModel(homepage.getHomepage_id(), model);


		// 전자도서관
		if (homepage.getHomepage_id().equals("h30")) {
			Book book = new Book();
			//신착도서
			book.setType("EBK");
			book.setSortField("BOOK_PUBDT");
			book.setSortType("DESC");
			book.setCate_id_1(74);//유아어린이 제외
			model.addAttribute("newBookList1", bestService.getMainBookList(book));
			book.setCate_id_1(0);
			book.setCate_id(74);//유아어린이만
			model.addAttribute("newBookList2", bestService.getMainBookList(book));
			book.setCate_id_1(0);
			book.setCate_id(0);
			book.setType("ADO");
			model.addAttribute("newBookList3", bestService.getMainBookList(book));

			//대출베스트
			book.setType("EBK");
			book.setSortField("BOOK_LEND");
			book.setSortType("DESC");
			book.setCate_id_1(74);//유아어린이 제외
			model.addAttribute("bestBookList1", bestService.getMainBookList(book));
			book.setCate_id_1(0);
			book.setCate_id(74);//유아어린이만
			model.addAttribute("bestBookList2", bestService.getMainBookList(book));
			book.setCate_id_1(0);
			book.setCate_id(0);
			book.setType("ADO");
			model.addAttribute("bestBookList3", bestService.getMainBookList(book));
		}

		log.debug("jsp Page : "+basePath + filePath);

		return basePath + filePath;
	}

	private void setBoardListToModel(String homepage_id, Model model) {
		try{
			String[] boardInfoList = ResourceBundle.getBundle("board").getString(homepage_id).split(",");
			for (String oneStr : boardInfoList) {
				if (!StringUtils.isEmpty(oneStr)) {
					String[] boardInfo = oneStr.split("/");
					String key = boardInfo[0];
					int manage_idx = Integer.parseInt(boardInfo[1]);
					int count = Integer.parseInt(boardInfo[2]);
					BoardManage boardManage = boardManageService.getBoardManageOne(new BoardManage(homepage_id, manage_idx));
					model.addAttribute(key, boardService.getBoardByMain(manage_idx, count, boardManage.getBoard_type()));
					model.addAttribute(key+"TopNotice", boardService.getBoardByMainTopNotice(manage_idx, 2, boardManage.getBoard_type()));
				}
			}
		}catch (MissingResourceException ex) {
			log.debug("MissingResourceException : "+ex);
		}
	}

	private List<CalendarManage> getCalendarMarkCloseDay(CalendarManage closedDay, List<CalendarManage> calendarList) {

		Map<Integer, Object> closedDayRepo = new HashMap<Integer, Object>();
		String[] closedDayList;

		if (closedDay != null) {
			closedDayList = closedDay.getDd().split(",");
			for (String one : closedDayList) {
				closedDayRepo.put(Integer.parseInt(one.trim()), null);
			}
		}

		for (CalendarManage oneCal : calendarList) {
			if (StringUtils.isNotEmpty(oneCal.getSun())) {
				int sun = Integer.parseInt(oneCal.getSun().trim());
				if (closedDayRepo.containsKey(sun)) {
					oneCal.setSun(String.format("<a class=\"type-e\">%s</a>", sun));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getMon())) {
				int mon = Integer.parseInt(oneCal.getMon().trim());
				if (closedDayRepo.containsKey(mon)) {
					oneCal.setMon(String.format("<a class=\"type-e\">%s</a>", mon));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getTue())) {
				int tue = Integer.parseInt(oneCal.getTue().trim());
				if (closedDayRepo.containsKey(tue)) {
					oneCal.setTue(String.format("<a class=\"type-e\">%s</a>", tue));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getWed())) {
				int wed = Integer.parseInt(oneCal.getWed().trim());
				if (closedDayRepo.containsKey(wed)) {
					oneCal.setWed(String.format("<a class=\"type-e\">%s</a>", wed));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getThu())) {
				int thu = Integer.parseInt(oneCal.getThu().trim());
				if (closedDayRepo.containsKey(thu)) {
					oneCal.setThu(String.format("<a class=\"type-e\">%s</a>", thu));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getFri())) {
				int fri = Integer.parseInt(oneCal.getFri().trim());
				if (closedDayRepo.containsKey(fri)) {
					oneCal.setFri(String.format("<a class=\"type-e\">%s</a>", fri));
				}
			}
			if (StringUtils.isNotEmpty(oneCal.getSat())) {
				int sat = Integer.parseInt(oneCal.getSat().trim());
				if (closedDayRepo.containsKey(sat)) {
					oneCal.setSat(String.format("<a class=\"type-e\">%s</a>", sat));
				}
			}
		}

		return calendarList;
	}

	private Map<String, List<String>> getCalendarMarkGumi(String planDate, CalendarManage closedDay, List<CalendarManage> eventDay, List<Board> movieDay, List<Apply> applyDay, List<Teach> teachDay, List<FacilityReq> facilityDayList) throws ParseException {
		Map<String, List<String>> planRepo = new HashMap<String, List<String>>();
		String[] pattern = {"yyyy-MM-dd"};

		if( closedDay != null) {
			String[] closedDayList = closedDay.getDd().split(",");
			for ( String oneClose : closedDayList ) {
				String key = oneClose.trim();
				if ( key.startsWith("0") ) {
					key = key.replace("0", "");
				}
				List<String> closedList = null;
				if ( planRepo.containsKey(key) ) {
					closedList = planRepo.get(key);
				}
				else {
					closedList = new ArrayList<String>();
				}

				closedList.add("[휴관일]");
				planRepo.put(key, closedList);
			}
		}

		for (CalendarManage event : eventDay) {
			List<String> eventList = null;

			String startDateStr 	= event.getStart_date();
			String endDateStr 		= event.getEnd_date();
			String startKey 		= event.getStart_date().substring(8,10);
			String endKey 			= event.getEnd_date().substring(8,10);
			SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}
			    if ( sf.format(startDate).startsWith(planDate) ) {
			      startKey = sf.format(startDate).substring(8, 10);
				    if ( startKey.startsWith("0") ) {
				  	  startKey = startKey.replace("0", "");
				    }
				    if ( planRepo.containsKey(startKey) ) {
				  	  eventList = planRepo.get(startKey);
				    }
				    else {
				  	  eventList = new ArrayList<String>();
				    }
				    if (!eventList.contains("[휴관일]")) {
				    	eventList.add(event.getTitle());
				    	planRepo.put(startKey, eventList);
				    }
			    }

			    startDate = DateUtils.addDays(startDate, 1);
			}
			if ( endKey.startsWith("0") ) {
				endKey = endKey.replace("0", "");
		    }
			if ( planRepo.containsKey(endKey) ) {
				eventList = planRepo.get(endKey);
			}
			else {
				eventList = new ArrayList<String>();
			}
			if (!eventList.contains("[휴관일]")) {
				eventList.add(event.getTitle());
		    	planRepo.put(endKey, eventList);
		    }
			planRepo.put(endKey, eventList);
		}

		for (Board movie : movieDay) {
			String key = movie.getImsi_v_2().trim();
			if ( key.startsWith("0") ) {
				key = key.replace("0", "");
			}
			List<String> planList = null;
			if ( planRepo.containsKey(key) ) {
				planList = planRepo.get(key);
			}
			else {
				planList = new ArrayList<String>();
			}

			if (!planList.contains("[휴관일]")) {
				planList.add("[영화]" + movie.getTitle());
		    	planRepo.put(key, planList);
		    }
		}



		for (Apply excursions : applyDay) {
			List<String> excursionsList = null;

			String startDateStr 	= excursions.getStart_date();
			String endDateStr 		= excursions.getEnd_date();
			String startKey 		= excursions.getStart_date().substring(8,10);
			String endKey 			= excursions.getEnd_date().substring(8,10);
			SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}

				if ( sf.format(startDate).startsWith(planDate) ) {
			      startKey = sf.format(startDate).substring(8, 10);
				    if ( startKey.startsWith("0") ) {
				  	  startKey = startKey.replace("0", "");
				    }
				    if ( planRepo.containsKey(startKey) ) {
				  	  excursionsList = planRepo.get(startKey);
				    }
				    else {
				  	  excursionsList = new ArrayList<String>();
				    }
				    if (!excursionsList.contains("[휴관일]")) {
				    	excursionsList.add("[견학]" + excursions.getAgency_name());
				    	planRepo.put(startKey, excursionsList);
				    }
			    }
			    startDate = DateUtils.addDays(startDate, 1);
			}
			if ( endKey.startsWith("0") ) {
				endKey = endKey.replace("0", "");
		    }
			if ( planRepo.containsKey(endKey) ) {
				excursionsList = planRepo.get(endKey);
			}
			else {
				excursionsList = new ArrayList<String>();
			}
			if (!excursionsList.contains("[휴관일]")) {
				excursionsList.add("[견학]" + excursions.getAgency_name());
		    	planRepo.put(endKey, excursionsList);
		    }
		}

		for (Teach teach : teachDay) {
			List<String> teachList = null;
			String[] teachDays 	= teach.getTeach_day().split(",");
			String startDateStr = teach.getStart_date();
			String endDateStr 	= teach.getEnd_date();
			String startKey 	= teach.getStart_date().substring(8,10);
			String endKey 		= teach.getEnd_date().substring(8,10);
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			Date startDate 	= DateUtils.parseDate(startDateStr, pattern);
			Date endDate 	= DateUtils.parseDate(endDateStr, pattern);

			while( !DateUtils.isSameDay(startDate, endDate) ) {
				if ( startDate.after(endDate) ) {
					break;
				}

				if ( sf.format(startDate).startsWith(planDate) ) {
			    	 Calendar cal = Calendar.getInstance() ;
				     cal.setTime(startDate);
				     int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
				     for ( String one : teachDays ) {
				    	  if ( dayNum == Integer.parseInt(one) ) {
				    		  startKey = sf.format(startDate).substring(8, 10);
				    		  if ( startKey.startsWith("0") ) {
				    			  startKey = startKey.replace("0", "");
					  		  }
				    		  if ( planRepo.containsKey(startKey) ) {
				    			  teachList = planRepo.get(startKey);
				    		  }
				    		  else {
				    			  teachList = new ArrayList<String>();
				    		  }
				    		  if (!teachList.contains("[휴관일]")) {
				    			  String teachStatus = "[강좌]";
				    			  if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
				    				  for ( String string : teach.getHolidays() ) {
				    					  if (StringUtils.equals(string, planDate +"-"+ startKey)) {
				    						  teachStatus = "[휴강]";
				    					  }
				    				  }
				    			  }
				    			  teachList.add(teachStatus + teach.getTeach_name());
						    	  planRepo.put(startKey, teachList);
						      }
				    	  }
				     }
			     }

			     startDate = DateUtils.addDays(startDate, 1);
			}
			if ( sf.format(startDate).startsWith(planDate) ) {
				Calendar cal = Calendar.getInstance() ;
			    cal.setTime(endDate);
			    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
			    for ( String one : teachDays ) {
			    	if ( dayNum == Integer.parseInt(one) ) {
			    		if ( endKey.startsWith("0") ) {
			    			endKey = endKey.replace("0", "");
				  		}
			    		if ( planRepo.containsKey(endKey) ) {
							teachList = planRepo.get(endKey);
						}
						else {
							teachList = new ArrayList<String>();
						}
			    		if (!teachList.contains("[휴관일]")) {
			    			String teachStatus = "[강좌]";
			    			  if (teach.getHolidays() != null && teach.getHolidays().size() > 0) {
			    				  for ( String string : teach.getHolidays() ) {
			    					  if (StringUtils.equals(string, planDate +"-"+ endKey)) {
			    						  teachStatus = "[휴강]";
			    					  }
			    				  }
			    			  }
			    			teachList.add(teachStatus + teach.getTeach_name());
					    	planRepo.put(endKey, teachList);
					    }
			    	}
			    }
		    }

		}

		for (FacilityReq facility : facilityDayList) {
			List<String> facilityList = null;
			String key 	= facility.getUse_date().substring(8, 10);

		    if ( key.startsWith("0") ) {
		    	key = key.replace("0", "");
	  		}
		    if ( planRepo.containsKey(key) ) {
		    	facilityList = planRepo.get(key);
		    }
		    else {
		    	facilityList = new ArrayList<String>();
		    }

		    if (!facilityList.contains("[휴관일]")) {
		    	facilityList.add(String.format("[시설물] %s (%s)", facility.getFacility_name(), facility.getMasking_name()));
		    	planRepo.put(key, facilityList);
		    }

		}
		return planRepo;
	}
}