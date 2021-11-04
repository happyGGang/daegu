package kr.go.gbelib.app.cms.module.newelib.api;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.newelib.book.Book;
import kr.go.gbelib.app.cms.module.newelib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.newelib.lending.Lending;

@SuppressWarnings("unchecked")
@Service(value = "dgElibAPIServiceNew")
public class DgElibAPIService extends BaseService {

	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final int TIMEOUT = 60 * 1000;

	private Map<String, Object> parse(String xml, String encoding) {
		ByteArrayInputStream input = null;
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			input = new ByteArrayInputStream(xml.getBytes(encoding));
			ObjectMapper om = new ObjectMapper();
			om.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			map = om.readValue(input, new TypeReference<Map<String, Object>>(){});
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return map;
	}

	private String send(String url, List<NameValuePair> params, String encoding) {
		RequestConfig config = RequestConfig.custom()
		  .setConnectTimeout(TIMEOUT)
		  .setConnectionRequestTimeout(TIMEOUT)
		  .setSocketTimeout(TIMEOUT).build();
		CloseableHttpClient  client = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
		HttpGet get = new HttpGet(url);
		URI uri = null;
		CloseableHttpResponse response = null;
		BufferedReader rd = null;
		StringBuilder result = new StringBuilder();
		String line = "";

		log.error("@@@@@@@@@@ DgElibAPIService send url: " + url + "?" + pairsToString(params));
//		System.out.println("@@@@@@@@@@ DgElibAPIService send url: " + url + "?" + pairsToString(params));

		try {
			uri = new URIBuilder(get.getURI()).addParameters(params).build();
			get.setHeader("User-Agent", USER_AGENT);
			get.setURI(uri);
			response = client.execute(get);
			rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), encoding));
			while((line = rd.readLine()) != null) {
				result.append(line);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} finally {
			if(response != null) try { response.close(); } catch (IOException e) { 	}
			if(rd != null) try { rd.close(); } catch (IOException e) { 	}
			if(client != null) try { client.close(); } catch (IOException e) { 	}
		}

		String resultString = result.toString();

//		log.debug("@@@@@@@@@@ DgElibAPIService send result: " + resultString);
//		System.out.println("@@@@@@@@@@ DgElibAPIService send result: " + resultString);

		return resultString;
	}

	private String pairsToString (List<NameValuePair> pairs) {
		StringBuilder sb = new StringBuilder();

		for(int i=0; i<pairs.size(); ++i) {
			if(i > 0) sb.append("&");

			NameValuePair p = pairs.get(i);
			sb.append(p.getName()+"="+p.getValue());
		}

		return sb.toString();
	}

	private static final DateTimeFormatter DTF = DateTimeFormat.forPattern("yyyyMMdd");
	private static final DateTimeFormatter DTF2 = DateTimeFormat.forPattern("yyyy-MM-dd");
	private static final DateTimeFormatter DTF3 = DateTimeFormat.forPattern("yyyy/MM/dd");

	private String str(Object o) {
		try {
			if(o == null)
				return null;
			else
				return String.valueOf(o);
		} catch(Exception e) {
			return null;
		}
	}

	private Integer num(Object o) {
		try {
			if(o == null)
				return null;
			else
				return Integer.parseInt(String.valueOf(o));
		} catch(Exception e) {
			return null;
		}
	}

	private String date(Object o) {
		try {
			if(o == null)
				return null;
			else
				return DTF.parseDateTime(String.valueOf(o)).toString(DTF2);
		} catch(Exception e) {
			return null;
		}
	}

	private String date2(Object o) {
		try {
			if(o == null)
				return null;
			else
				return DTF3.parseDateTime(String.valueOf(o)).toString(DTF2);
		} catch(Exception e) {
			return null;
		}
	}

	private Boolean bool(Object o) {
		try {
			if(o == null)
				return null;
			else
				return Boolean.parseBoolean(String.valueOf(o));
		} catch(Exception e) {
			return null;
		}
	}

	private int toZero(Integer i) {
		return i == null ? 0 : i;
	}

	private Book toBook(Map<String, Object> map) {
		return toBook(map, new Book());
	}

	private Book toBook(Map<String, Object> map, Book book) {
		String s = null;
		Integer i = 0;
		Boolean b = false;

		book.setType("EBK");
		if((s = date(map.get("reg_date"))) != null) book.setBook_regdt(s);
		if((s = str(map.get("cover_url"))) != null) book.setBook_image(s);
		if((i = num(map.get("contents_copy"))) != null) book.setMax_lend(i);
//		if((b = bool(map.get("resv_able"))) != null) book.setReservable(b);
		if((s = str(map.get("owner_code"))) != null) book.setCom_code(s);
		if((s = str(map.get("goods_id"))) != null) book.setBook_code(s);
		if((i = num(map.get("loan_count"))) != null) book.setBook_lend(i);
		if((i = num(map.get("resv_count"))) != null) book.setBook_reserve(i);
		if((s = str(map.get("abstracts_info"))) != null) book.setBook_info(s);
		if((s = StringUtils.isEmpty(str(map.get("title_info"))) ? str(map.get("title")) : str(map.get("title_info"))) != null) book.setBook_name(s);
//		if((b = bool(map.get("loan_able"))) != null) book.setLendable(b);
		if((s = str(map.get("pub_info"))) != null) book.setBook_pubname(s);
		if((s = str(map.get("lib_code_desc"))) != null) book.setLibrary_name(s);
		if((s = str(map.get("lib_code"))) != null) book.setLibrary_code(s);
		if((s = date2(map.get("pub_year_info"))) != null) book.setBook_pubdt(s);
		if((s = str(map.get("author_info"))) != null) book.setAuthor_name(s);
		if((i = num(map.get("contents_key"))) != null) book.setBook_idx(i);
		if((i = num(map.get("total_loan_cnt"))) != null) book.setLend_total(i);
		if((s = str(map.get("toc"))) != null) book.setBook_table(s);
		if((s = str(map.get("author_desc"))) != null) book.setAuthor_info(s);
		if((s = str(map.get("contents_file_type_desc"))) != null) book.setFormat(s);
		if((s = date2(map.get("pub_date"))) != null) book.setBook_pubdt(s);

		return book;
	}

	private Lending toLending(Map<String, Object> map) {
		return toLending(map, new Lending());
	}

	private Lending toLending(Map<String, Object> map, Lending lending) {
		String s = null;
		Integer i = 0;
		Boolean b = false;

		lending.setType("EBK");
		if((s = date(map.get("reg_date"))) != null) lending.setBook_regdt(s);
		if((s = str(map.get("cover_url"))) != null) lending.setBook_image(s);
		if((b = bool(map.get("resv_able"))) != null) lending.setReservable(b);
		if((s = str(map.get("owner_code"))) != null) lending.setCom_code(s);
		if((s = str(map.get("goods_id"))) != null) lending.setBook_code(s);
		if((i = num(map.get("loan_count"))) != null) lending.setBook_lend(i);
		if((i = num(map.get("resv_count"))) != null) lending.setBook_reserve(i);
		if((s = StringUtils.isEmpty(str(map.get("title_info"))) ? str(map.get("title")) : str(map.get("title_info"))) != null) lending.setBook_name(s);
		if((b = bool(map.get("loan_able"))) != null) lending.setLendable(b);
		if((s = str(map.get("pub_info"))) != null) lending.setBook_pubname(s);
		if((s = str(map.get("lib_code_desc"))) != null) lending.setLibrary_name(s);
		if((s = str(map.get("lib_code"))) != null) lending.setLibrary_code(s);
		if((s = date2(map.get("pub_year_info"))) != null) lending.setBook_pubdt(s);
		if((s = str(map.get("author_info"))) != null) lending.setAuthor_name(s);
		if((i = num(map.get("contents_key"))) != null) lending.setBook_idx(i);
		if((s = str(map.get("contents_file_type_desc"))) != null) lending.setFormat(s);
		if((s = date2(map.get("pub_date"))) != null) lending.setBook_pubdt(s);
		if((s = date2(map.get("loan_date"))) != null) lending.setLend_dt(s);
		if((s = date2(map.get("return_plan_date"))) != null) lending.setReturn_due_dt(s);
		if((i = num(map.get("loan_key"))) != null) lending.setLend_idx(i);
		if((i = num(map.get("loan_key"))) != null) lending.setReserve_idx(i);
		if((s = date2(map.get("reserve_date"))) != null) lending.setReserve_dt(s);
		if((s = str(map.get("viewer_url"))) != null) lending.setViewer_url(s);
		if((s = str(map.get("return_date"))) != null) lending.setReturn_dt(s);;

		return lending;
	}

	/**
	 * 신간e-book조회
	 * @param
	 * @return
	 */
	public List<Book> getNewEbook(Book book) {
		List<Book> bookList = new ArrayList<Book>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "getNewEbook"));
		params.add(new BasicNameValuePair("view_count", str(book.getRowCount())));
		params.add(new BasicNameValuePair("current_page", str(book.getViewPage() - 1)));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/MainPage.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return bookList;
		} else {
			book.setTotalDataCount(toZero(num(result.get("total_count"))));

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("search_data");
			for(Map<String, Object> m: list) {
				bookList.add(detailInfo(toBook(m)));
			}

			return bookList;
		}
	}

	/**
	 * 신간e-book조회 메인화면용
	 * @param
	 * @return
	 */
	public List<Book> getNewEbook(String count) {
		List<Book> bookList = new ArrayList<Book>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "getNewEbook"));
		params.add(new BasicNameValuePair("view_count", count));
		params.add(new BasicNameValuePair("current_page", "0"));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/MainPage.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return bookList;
		} else {

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("search_data");
			for(Map<String, Object> m: list) {
				bookList.add(detailInfo(toBook(m)));
			}

			return bookList;
		}
	}

	/**
	 * 대출베스트 조회 전체보기
	 * @param
	 * @return
	 */
	public List<Book> loanBestSearch(Book book) {
		List<Book> bookList = new ArrayList<Book>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "loanBestSearch"));
		params.add(new BasicNameValuePair("sort_field", "author"));
		params.add(new BasicNameValuePair("sort_option", "asc"));
		params.add(new BasicNameValuePair("current_page", str(book.getViewPage() - 1)));
		params.add(new BasicNameValuePair("list_count", "50"));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Search.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return bookList;
		} else {
			book.setTotalDataCount(toZero(num(result.get("total_count"))));

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("searchlist");
			for(Map<String, Object> m: list) {
				bookList.add(toBook(m));
			}

			return bookList;
		}
	}

//	메인화면용
	public List<Book> loanBestSearch(String count) {
		List<Book> bookList = new ArrayList<Book>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "loanBestSearch"));
		params.add(new BasicNameValuePair("sort_field", "author"));
		params.add(new BasicNameValuePair("sort_option", "asc"));
		params.add(new BasicNameValuePair("current_page", "0"));
		params.add(new BasicNameValuePair("list_count", count));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Search.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return bookList;
		} else {

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("searchlist");
			for(Map<String, Object> m: list) {
				bookList.add(toBook(m));
			}

			return bookList;
		}
	}

	/**
	 * 전체도서 조회
	 * @param
	 * @return
	 */
	public List<Book> allBookSearch(Book book) {
		List<Book> bookList = new ArrayList<Book>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "allBookSearch"));
		params.add(new BasicNameValuePair("sort_field", "sort_title"));
		params.add(new BasicNameValuePair("sort_option", "asc"));
		params.add(new BasicNameValuePair("current_page", str(book.getViewPage() - 1)));
		params.add(new BasicNameValuePair("list_count", str(book.getRowCount())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Search.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return bookList;
		} else {
			book.setTotalDataCount(toZero(num(result.get("total_count"))));

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("searchlist");
			for(Map<String, Object> m: list) {
				bookList.add(toBook(m));
			}

			return bookList;
		}
	}

	/**
	 * 전자책 키워드 검색
	 * @param
	 * @return
	 */
	public List<Book> simpleSearch(Book book) {
		List<Book> bookList = new ArrayList<Book>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "simpleSearch"));
		params.add(new BasicNameValuePair("keyword", book.getSearch_text()));
		params.add(new BasicNameValuePair("sort_field", book.getSortField()));
		params.add(new BasicNameValuePair("sort_option", book.getSortType()));
		params.add(new BasicNameValuePair("current_page", str(book.getViewPage() - 1)));
		params.add(new BasicNameValuePair("list_count", str(book.getRowCount())));
		params.add(new BasicNameValuePair("facet_lib_code", "000000"));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Search.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return bookList;
		} else {
			book.setTotalDataCount(toZero(num(result.get("total_count"))));

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("searchlist");
			for(Map<String, Object> m: list) {
				bookList.add(toBook(m));
			}

			return bookList;
		}
	}

	/**
	 * 카테고리 대분류 조회
	 * @param
	 * @return
	 */
	public List<ElibCategory> getLeftCategory() {
		List<ElibCategory> categoryList = new ArrayList<ElibCategory>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "getLeftCategory"));
		params.add(new BasicNameValuePair("facet_lib_code", "000000"));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/MainPage.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return categoryList;
		} else {
			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("ebooklist");

			for(Map<String, Object> m: list) {
				ElibCategory c = new ElibCategory();
				c.setDepth(1);
				c.setCate_name(str(m.get("class_name")));
//				c.setCate_id(str(m.get("class_code")));
				c.setParent_name(str(m.get("class_name")));
//				c.setParent_id(str(m.get("class_code")));
				categoryList.add(c);
			}

			return categoryList;
		}
	}

	/**
	 * 카테고리 중분류 조회
	 * @param
	 * @return
	 */
	public List<ElibCategory> getSubCategory(Book book) {
		List<ElibCategory> categoryList = new ArrayList<ElibCategory>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "getSubCategory"));
//		params.add(new BasicNameValuePair("majorCategory", book.getParent_id()));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Mobile.do", params, "UTF-8"), "UTF-8");
		List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("CategoryList");
		if(CollectionUtils.isEmpty(list)) {
			return categoryList;
		} else {
			book.setTotalDataCount(toZero(num(result.get("total_count"))));

			for(Map<String, Object> m: list) {
				ElibCategory c = new ElibCategory();
				c.setDepth(2);
				c.setCate_name(str(m.get("CategoryName")));;
//				c.setCate_id(str(m.get("subCategory")));
				c.setParent_id(book.getParent_id());
				categoryList.add(c);
			}

			return categoryList;
		}
	}

	/**
	 * 카테고리 선택시 도서 조회 결과
	 * @param
	 * @return
	 */
	public Map<String, Object> categorySearch(Book book) {
		Map<String, Object> returnResult = new HashMap<String, Object>();

		List<Book> bookList = new ArrayList<Book>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "categorySearch"));
//		params.add(new BasicNameValuePair("major_category", book.getParent_id()));
//		if(StringUtils.isNotEmpty(book.getCate_id()) && !StringUtils.equalsIgnoreCase("null", book.getCate_id())) {
//			params.add(new BasicNameValuePair("sub_category", book.getCate_id()));
//		}
		params.add(new BasicNameValuePair("sort_field", "sort_title"));
		params.add(new BasicNameValuePair("sort_option", "asc"));
		params.add(new BasicNameValuePair("current_page", str(book.getViewPage() - 1)));
		params.add(new BasicNameValuePair("list_count", str(book.getRowCount())));
		params.add(new BasicNameValuePair("facet_lib_code", "000000"));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Search.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return returnResult;
		} else {
			book.setTotalDataCount(toZero(num(result.get("total_count"))));

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("searchlist");
			for(Map<String, Object> m: list) {
				bookList.add(toBook(m));
			}
			returnResult.put("bookList", bookList);

			List<ElibCategory> categoryList = new ArrayList<ElibCategory>();
			Map<String, Object> categoryInfo = (Map<String, Object>) result.get("category_info");
			List<Map<String, Object>> categoryListTmp = (List<Map<String, Object>>) categoryInfo.get("category_list");
			for (Map<String, Object> m : categoryListTmp) {
				ElibCategory c = new ElibCategory();
				c.setDepth(2);
				c.setCate_name(str(m.get("sub_category_desc")));;
//				c.setCate_id(str(m.get("sub_category")));
				c.setParent_id(book.getParent_id());
				categoryList.add(c);
			}
			returnResult.put("subCategory", categoryList);


			return returnResult;
		}
	}

	/**
	 * 상세보기 조회
	 * @param
	 * @return
	 */
	public Book detailInfo(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "detailInfo"));
		params.add(new BasicNameValuePair("contents_key", str(book.getBook_idx())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Search.do", params, "UTF-8"), "UTF-8");
		if(result == null || StringUtils.isNotEmpty(str(result.get("MSG_KEY")))) {
			return book;
		} else {
			return toBook(result, book);
		}
	}

	/**
	 * 상세보기 조회
	 * @param
	 * @return
	 */
	public Lending detailInfo(Lending lending) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "detailInfo"));
		params.add(new BasicNameValuePair("contents_key", str(lending.getBook_idx())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Search.do", params, "UTF-8"), "UTF-8");
		if(result == null || StringUtils.isNotEmpty(str(result.get("MSG_KEY")))) {
			return lending;
		} else {
			return toLending(result, lending);
		}
	}

	/**
	 * 대출처리
	 * @param
	 * @return
	 */
	public Map<String, String> loan(Lending lending) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "Loan"));
		params.add(new BasicNameValuePair("user_id", lending.getMember_id()));
		params.add(new BasicNameValuePair("lib_code", lending.getLibcode()));
		params.add(new BasicNameValuePair("contents_key", str(lending.getBook_idx())));
		// TODO: 스마트폰일 때 loan_from에 넣을 값을 ECO에 문의해야 함
		params.add(new BasicNameValuePair("loan_from", "P".equals(lending.getDevice()) ? "PC" : "PC"));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Service.do", params, "UTF-8"), "UTF-8");
		Map<String, String> result2 = new HashMap<String, String>();
		result2.put("STATUS", str(result.get("STATUS")));
		result2.put("MSG_KEY", str(result.get("MSG_KEY")));

		return result2;
	}

	/**
	 * 반납하기
	 * @param
	 * @return
	 */
	public Map<String, String> rtn(Lending lending) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "Return"));
		params.add(new BasicNameValuePair("user_id", lending.getMember_id()));
		params.add(new BasicNameValuePair("lib_code", lending.getLibcode()));
		params.add(new BasicNameValuePair("loan_key", str(lending.getLend_idx())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Service.do", params, "UTF-8"), "UTF-8");
		Map<String, String> result2 = new HashMap<String, String>();
		result2.put("STATUS", str(result.get("STATUS")));
		result2.put("MSG_KEY", str(result.get("MSG_KEY")));

		return result2;
	}

	/**
	 * 예약 전 예약정보 확인
	 * @param
	 * @return
	 */
	public Map<String, String> resvInfo(Lending lending, Member member) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "ResvInfo"));
		params.add(new BasicNameValuePair("user_id", lending.getMember_id()));
		params.add(new BasicNameValuePair("lib_code", lending.getLibcode()));
		params.add(new BasicNameValuePair("contents_key", str(lending.getBook_idx())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Service.do", params, "UTF-8"), "UTF-8");
		Map<String, String> result2 = new HashMap<String, String>();
		result2.put("STATUS", str(result.get("STATUS")));
		result2.put("MSG_KEY", str(result.get("MSG_KEY")));

		return result2;
	}

	/**
	 * 예약하기
	 * @param
	 * @return
	 */
	public Map<String, String> resv(Lending lending, Member member) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "Resv"));
		params.add(new BasicNameValuePair("user_id", lending.getMember_id()));
		params.add(new BasicNameValuePair("lib_code", lending.getLibcode()));
		params.add(new BasicNameValuePair("contents_key", str(lending.getBook_idx())));
		// TODO: 스마트폰일 때 loan_from에 넣을 값을 ECO에 문의해야 함
		params.add(new BasicNameValuePair("loan_from", "P".equals(lending.getDevice()) ? "PC" : "PC"));
		params.add(new BasicNameValuePair("user_tel_num", StringUtils.defaultString(member.getCell_phone()).replaceAll("[/-]", "")));
		params.add(new BasicNameValuePair("tel_check", "Y"));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Service.do", params, "UTF-8"), "UTF-8");
		Map<String, String> result2 = new HashMap<String, String>();
		result2.put("STATUS", str(result.get("STATUS")));
		result2.put("MSG_KEY", str(result.get("MSG_KEY")));

		return result2;
	}

	/**
	 * 예약취소
	 * @param
	 * @return
	 */
	public Map<String, String> cancel(Lending lending) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "Resv_Cancle"));
		params.add(new BasicNameValuePair("user_id", lending.getMember_id()));
		params.add(new BasicNameValuePair("lib_code", lending.getLibcode()));
		params.add(new BasicNameValuePair("loan_key", str(lending.getReserve_idx())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Service.do", params, "UTF-8"), "UTF-8");
		Map<String, String> result2 = new HashMap<String, String>();
		result2.put("STATUS", str(result.get("STATUS")));
		result2.put("MSG_KEY", str(result.get("MSG_KEY")));

		return result2;
	}

	/**
	 * 대출현황 조회
	 * @param
	 * @return
	 */
	public List<Lending> loanList(Lending lending) {
		List<Lending> lendingList = new ArrayList<Lending>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "LoanList"));
		params.add(new BasicNameValuePair("user_id", lending.getMember_id()));
		params.add(new BasicNameValuePair("lib_code", lending.getLibcode()));
		params.add(new BasicNameValuePair("current_page", str(lending.getViewPage() - 1)));
		params.add(new BasicNameValuePair("list_count", str(lending.getRowCount())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/MyLibrary.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return lendingList;
		} else {
			lending.setTotalDataCount(toZero(num(result.get("total_count"))));

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("searchlist");
			for(Map<String, Object> m: list) {
				lendingList.add(detailInfo(loanInfo(toLending(m))));
			}

			return lendingList;
		}
	}

	/**
	 * 예약현황 조회
	 * @param
	 * @return
	 */
	public List<Lending> resvList(Lending lending) {
		List<Lending> lendingList = new ArrayList<Lending>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "ResvList"));
		params.add(new BasicNameValuePair("user_id", lending.getMember_id()));
		params.add(new BasicNameValuePair("lib_code", lending.getLibcode()));
		params.add(new BasicNameValuePair("current_page", str(lending.getViewPage() - 1)));
		params.add(new BasicNameValuePair("list_count", str(lending.getRowCount())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/MyLibrary.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return lendingList;
		} else {
			lending.setTotalDataCount(toZero(num(result.get("total_count"))));

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("searchlist");
			for(Map<String, Object> m: list) {
				lendingList.add(detailInfo(toLending(m)));
			}

			return lendingList;
		}
	}

	/**
	 * 대출이력 조회
	 * @param
	 * @return
	 */
	public List<Lending> loanHistoryList(Lending lending) {
		List<Lending> lendingList = new ArrayList<Lending>();

		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "LoanHistoryList"));
		params.add(new BasicNameValuePair("user_id", lending.getMember_id()));
		params.add(new BasicNameValuePair("lib_code", lending.getLibcode()));
		params.add(new BasicNameValuePair("current_page", str(lending.getViewPage() - 1)));
		params.add(new BasicNameValuePair("list_count", str(lending.getRowCount())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/MyLibrary.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return lendingList;
		} else {
			lending.setTotalDataCount(toZero(num(result.get("total_count"))));

			List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("searchlist");
			for(Map<String, Object> m: list) {
				lendingList.add(detailInfo(toLending(m)));
			}

			return lendingList;
		}
	}

	/**
	 * 책읽기 시 콘텐츠 연동정보 조회
	 * @param
	 * @return
	 */
	public Lending loanInfo(Lending lending) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "LoanInfo"));
		params.add(new BasicNameValuePair("loan_key", str(lending.getLend_idx())));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/MyLibrary.do", params, "UTF-8"), "UTF-8");
		if(result == null || "SUCCESS".equals(str(result.get("STATUS"))) == false) {
			return lending;
		} else {
			return toLending(result, lending);
		}
	}

	@Async
	public void elibLogin(Member member) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("method", "sso_excuteLoginMobile"));
		params.add(new BasicNameValuePair("userLoginId", member.getMember_id()));
		params.add(new BasicNameValuePair("libraryCode", member.getLib_code()));
		params.add(new BasicNameValuePair("userName", member.getMember_name()));
		params.add(new BasicNameValuePair("user_insert", "Y"));

		Map<String, Object> result = parse(send("http://e-lib.tglnet.or.kr/daegu/Login.do", params, "UTF-8"), "UTF-8");

	}

}
