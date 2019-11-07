package kr.co.whalesoft.app.homepage.module.bookDream;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.StrUtil;
import kr.go.gbelib.app.cms.module.newBookDream.NewBookDream;
import kr.go.gbelib.app.common.api.CommonAPI;
import kr.go.gbelib.app.common.api.PushAPI;
import net.sf.jxls.transformer.XLSTransformer;

@Service
public class BookDreamService extends BaseService{

	@Autowired
	private BookDreamDao dao;

	@Autowired
	private HomepageService homepageService;

	protected Map<String, Object> getApiKey() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("X-Naver-Client-Id", "TOqdlc19MURV_gFfLqbo");
		map.put("X-Naver-Client-Secret", "uYJq9oAl32");

		return map;
	}

	public Map<String, Object> getNaverSearch(BookDream bookDream, String mode) {
		Map<String, Object> param = new HashMap<String, Object>();
		if (mode.equals("list")) {
			try {
				param.put("query", URLEncoder.encode(bookDream.getSearch_text(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				param.put("query", "");
			}
			param.put("start", bookDream.getViewPage());
		} else {
			param.put("d_isbn", bookDream.getIsbn());
		}
		return CommonAPI.sendNAVER(param, mode);
	}

	@Transactional
	public int addBookDream(BookDream bookDream) {
		if (dao.addBookDream(bookDream) > 0) {
			bookDream.setRh_type("insert");
			bookDream.setRh_set("10");
			bookDream.setRh_get("initialize");
			bookDream.setRh_post("initialize");
			bookDream.setRh_session("initialize");
			return dao.addBookDreamHistory(bookDream);
		}
		return 0;
	}

	public int getTotalPrice() {
		return Integer.parseInt(dao.getTotalPrice());
	}

	public int getCurrentTotalPrice() {
		return dao.getCurrentTotalPrice();
	}

	public int getDayCount() {
		return Integer.parseInt(dao.getDayCount());
	}

	public int getRequestCountByMember(BookDream bookDream) {
		return dao.getRequestCountByMember(bookDream);
	}

	public int getPriCount() {
		return Integer.parseInt(dao.getPriCount());
	}

	public int getMonthRequestCountByMember(BookDream bookDream) {
		return dao.getMonthRequestCountByMember(bookDream);
	}

	public int getRequestListCount(BookDream bookDream) {
		return dao.getRequestListCount(bookDream);
	}

	public List<BookDream> getRequestList(BookDream bookDream) {
		List<BookDream> list = dao.getRequestList(bookDream);
		for (BookDream bookDream2 : list) {
			bookDream2.setInnerList(dao.getRequestListOne(bookDream2));
		}
		return list;
	}

	public int getRequestListCountCMS(BookDream bookDream) {
		return dao.getRequestListCountCMS(bookDream);
	}

	public List<BookDream> getRequestListCMS(BookDream bookDream) {
		List<BookDream> list = dao.getRequestListCMS(bookDream);
		for (BookDream bookDream2 : list) {
			bookDream2.setInnerList(dao.getRequestListOne(bookDream2));
		}
		return list;
	}

	public BookDream getBookDreamOne(BookDream bookDream) {
		return dao.getBookDreamOne(bookDream);
	}

	public BookDream getMyRequestOne(BookDream bookDream) {
		return dao.getMyRequestOne(bookDream);
	}

	@Transactional
	public int modifyBookDream(BookDream bookDream) {
		if (dao.modifyBookDream(bookDream) > 0) {
			if (StringUtils.isEmpty(bookDream.getRh_set())) {
				bookDream.setRh_type("modify");
				bookDream.setRh_set("999");
			} else {
				bookDream.setRh_type("update");
			}
			bookDream.setRh_get(" ");
			bookDream.setRh_post(" ");
			bookDream.setRh_session(" ");
			return dao.addBookDreamHistory(bookDream);
		}
		return 0;
	}

	public int getMyRequestListCount(BookDream bookDream) {
		return dao.getMyRequestListCount(bookDream);
	}

	public List<BookDream> getMyRequestList(BookDream bookDream) {
		List<BookDream> list = dao.getMyRequestList(bookDream);
		for (BookDream bookDream2 : list) {
			bookDream2.setInnerList(dao.getRequestListOne(bookDream2));
		}
		return list;
	}

	public List<BookDream> getNewBookConfig() {
		return dao.getNewBookConfig();
	}

	public int modifyBookDreamConfig(NewBookDream newBookDream) {
		for (BookDream bd : newBookDream.getInnerList()) {
			dao.modifyBookDreamConfig(bd);
		}
		return 1;
	}

	public List<BookDream> getNewBookStore() {
		return dao.getNewBookStore();
	}

	public BookDream getNewBookStoreOne(NewBookDream bookDream) {
		return dao.getNewBookStoreOne(bookDream);
	}

	public void modifyBookDreamStore(NewBookDream newBookDream) {
		if (StringUtils.isNotEmpty(newBookDream.getS_pw())) {
			newBookDream.setS_pw(CalculateHashUtils.calculateHash(newBookDream.getS_pw()));
		}
		dao.modifyBookDreamStore(newBookDream);
	}

	public void deleteBookDreamStore(NewBookDream newBookDream) {
		dao.deleteBookDreamStore(newBookDream);
	}

	public List<BookDream> getBookDreamOneHistory(NewBookDream bookDream) {
		return dao.getBookDreamOneHistory(bookDream);
	}

	public BookDream getNewBookStoreAdmin(BookDream bookDream) {
		if (StringUtils.isNotEmpty(bookDream.getS_pw())) {
			bookDream.setS_pw(CalculateHashUtils.calculateHash(bookDream.getS_pw()));
		}
		return dao.getNewBookStoreAdmin(bookDream);
	}

	public String getBookDreamConfigOne(BookDream bookDream) {
		return dao.getBookDreamConfigOne(bookDream);
	}
	
	public BookDream getBookDreamConfigByState(BookDream bookDream) {
		return dao.getBookDreamConfigByState(bookDream);
	}

	public void procSchedule() {
		List<BookDream> d3List = dao.getD3List();
		List<BookDream> dDayList = dao.getDdayList();
		if (d3List != null && d3List.size() > 0) {
			for (BookDream bookDream : d3List) {
				String homepageCode = bookDream.getR_src();
				String fromTel = "";
//				00147010 안동
//				 * 00147011 용상
//				 * 00147039풍산
				if (homepageCode.equals("andong")) {
					homepageCode ="00147010";
					fromTel = bookDream.getFromTel();
				} else if (homepageCode.equals("yongsang")) {
					homepageCode ="00147011";
					fromTel = bookDream.getFromTel2();
				} else if (homepageCode.equals("pungsan")) {
					homepageCode ="00147039";
					fromTel = bookDream.getFromTel3();
				}

				Homepage homepage = new Homepage();
				homepage.setHomepage_code(homepageCode);
				homepage = homepageService.getHomepageOneByCode(homepage);

				bookDream.setC_no(14);
				String smsMsg = getBookDreamConfigOne(bookDream);
				smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(bookDream.getR_title(), 20));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				smsMsg =  smsMsg.replace("{{D_DAY}}", sdf.format(bookDream.getR_return_close()));
				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, bookDream.getR_hp(), smsMsg, fromTel, false);
				bookDream.setD3_send_yn("Y");
				dao.sendedMessage(bookDream);
			}
		}
		if (dDayList != null && dDayList.size() > 0) {
			for (BookDream bookDream : dDayList) {
				String homepageCode = bookDream.getR_src();
				String fromTel = "";
//				00147010 안동
//				 * 00147011 용상
//				 * 00147039풍산
				if (homepageCode.equals("andong")) {
					homepageCode ="00147010";
					fromTel = bookDream.getFromTel();
				} else if (homepageCode.equals("yongsang")) {
					homepageCode ="00147011";
					fromTel = bookDream.getFromTel2();
				} else if (homepageCode.equals("pungsan")) {
					homepageCode ="00147039";
					fromTel = bookDream.getFromTel3();
				}

				Homepage homepage = new Homepage();
				homepage.setHomepage_code(homepageCode);
				homepage = homepageService.getHomepageOneByCode(homepage);

				bookDream.setC_no(15);
				String smsMsg = getBookDreamConfigOne(bookDream);
				smsMsg =  smsMsg.replace("{{BookName}}", StrUtil.cutStr(bookDream.getR_title(), 20));
				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, bookDream.getR_hp(), smsMsg, fromTel, false);
				bookDream.setDday_send_yn("Y");
				dao.sendedMessage(bookDream);
			}
		}
	}
	
	public List<BookDream> getRequestListCMS2(BookDream bookDream) {
		return dao.getRequestListCMS2(bookDream);
	}

	public void writeExcelData(NewBookDream newBookDream, OutputStream outputStream, HttpServletRequest request) throws Exception {
		String sampleFilePath = request.getSession().getServletContext().getRealPath("/") + "/resources/module/newBookDream/sample.xls";
		Workbook workbook = null;
		newBookDream.setRowCount(200);
		newBookDream.setSortField("r_return");
//		List<BookDream> list = dao.getRequestListExcel(newBookDream);
		List<BookDream> list = dao.getRequestListCMS2(newBookDream);

		int totalPay = 0;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		for (BookDream bookDream : list) {
//			totalPay += bookDream.getR_pay();
//			bookDream.setA_name(sdf.format(bookDream.getR_created()));
//			try {
//				bookDream.setC_name(sdf.format(bookDream.getR_return()));
//			} catch ( Exception e ) {
//			}
//
//			//네이버에서 정가검색
//			bookDream.setViewPage(1);
//			String isbn = bookDream.getIsbn();
//
//			String isbn10 = String.valueOf(isbn).split(" ")[0];
//			String isbn13 = String.valueOf(isbn).split(" ").length > 1 ? String.valueOf(isbn).split(" ")[1] : "";
//
//			bookDream.setIsbn(isbn10);
//
//			Map<String, Object> naverSearch = getNaverSearch(bookDream, "isbn");
//			List<Map<String, Object>> itemList = null;
//
//			try {
//				String totalCount = String.valueOf(((Map<String, Object>)((Map<String, Object>)naverSearch.get("rss")).get("channel")).get("total"));
//				if ("1".equals(totalCount)) {
//					itemList = new ArrayList<Map<String, Object>>();
//					Map<String, Object> a = (Map<String, Object>)((Map<String, Object>)((Map<String, Object>)naverSearch.get("rss")).get("channel")).get("item");
//					itemList.add((Map<String, Object>)((Map<String, Object>)((Map<String, Object>)naverSearch.get("rss")).get("channel")).get("item"));
//				} else {
//					itemList = (List<Map<String, Object>>)((Map<String, Object>)((Map<String, Object>)naverSearch.get("rss")).get("channel")).get("item");
//				}
//			} catch(Exception e) {
////				e.printStackTrace(s);
//			}
//
//			if (itemList != null && itemList.size() > 0) {
//				for (Map<String, Object> map2 : itemList) {
//					String price = String.valueOf(map2.get("price"));
//					try {
//						bookDream.setR_pay(Integer.parseInt(price));
//					}
//					catch ( Exception e ) {
//						e.printStackTrace();
//					}
//					break;
//				}
//			}
//		}

//		int limitRowCount = 13;
//		if ( historyList.size() > limitRowCount ) {
//			while ( historyList.size() != limitRowCount ) {
//				historyList.remove(historyList.remove(0));
//			}
//		}
//		else if ( historyList.size() < limitRowCount ) {
//			while ( historyList.size() != limitRowCount ) {
//				historyList.add(new Teacher());
//			}
//		}
//
//		int sum_total_time = 0;
//		for ( Teacher one : historyList ) {
//			sum_total_time = sum_total_time + one.getTotal_time();
//		}
//		newBookDream.setSum_total_time(sum_total_time);
//

//
//		Date now = new Date();
//		String[] nows = sfYear.format(now).split("-");
//
		Map<String, Object> dataMap = new HashMap<String, Object>();
//		dataMap.put("curYear", nows[0]);
//		dataMap.put("curMonth", nows[1]);
		dataMap.put("totalPay", totalPay);
		dataMap.put("totalCount", list.size());
		dataMap.put("list", list);
//		dataMap.put("homepageName", newBookDream.getHomepage_name());


		workbook = new XLSTransformer().transformXLS(new BufferedInputStream(new FileInputStream(new File(sampleFilePath))), dataMap);

		workbook.write(outputStream);
	}

	public int getRequestCountByIsbn(BookDream bookDream) {
		return dao.getRequestCountByIsbn(bookDream);
	}

	@Transactional
	public int modifyState(NewBookDream newBookDream) {
		int result = 0;
		if (newBookDream.getChkOne() != null && newBookDream.getChkOne().length > 0) {
			for (int chkOne : newBookDream.getChkOne()) {
				BookDream b = new BookDream();
				b.setRh_ip(newBookDream.getRh_ip());
				b.setRh_referer(newBookDream.getRh_referer());
				b.setRh_url(newBookDream.getRh_url());
				b.setR_state(newBookDream.getBatch());
				b.setRh_set(newBookDream.getBatch());
				b.setR_no(chkOne);
				result += modifyBookDream(b);
			}
		}

		return result;
//		return dao.modifyState(newBookDream);
	}
}
