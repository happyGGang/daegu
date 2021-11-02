package kr.go.gbelib.app.cms.module.elib.api;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;

@Service
public class Yes24APIService extends BaseService {

	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final String LEND_URL = "http://e-lib.tglnet.or.kr:8081/YES24/yes24_action_new.asp";
	private static final String MEMBER_URL = "http://e-lib.tglnet.or.kr:8081/YES24/yes24_member_sync.asp";
	private static final String APP_URL = "http://e-lib.tglnet.or.kr:8081/YES24/api/device_url.asp";
	private static final String BOOKINFO_URL = "http://e-lib.tglnet.or.kr:8081/YES24/bookinfo.asp";
	private static final int TIMEOUT = 30 * 1000;

	private String getText(Document doc, String path) {
		XPath xPath =  XPathFactory.newInstance().newXPath();
		XPathExpression resultExpr = null;
		try {
			resultExpr = xPath.compile(path);
		} catch (XPathExpressionException e) {
			return "";
		}
		try {
			return (String) resultExpr.evaluate(doc, XPathConstants.STRING);
		} catch (XPathExpressionException e) {
			return "";
		}
	}

	private Map<String, String> parse(String xml) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();

		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			doc = builder.parse(input);
			map.put("result", getText(doc, "//result/text()"));
			map.put("msgcode", getText(doc, "//Message/text()"));
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}

	private String send(String url, List<NameValuePair> params) {
		RequestConfig config = RequestConfig.custom()
		  .setConnectTimeout(TIMEOUT)
		  .setConnectionRequestTimeout(TIMEOUT)
		  .setSocketTimeout(TIMEOUT).build();
		CloseableHttpClient  client = HttpClientBuilder.create().setDefaultRequestConfig(config).build();
		HttpPost post = new HttpPost(url);
		CloseableHttpResponse response = null;
		BufferedReader rd = null;
		StringBuilder result = new StringBuilder();
		String line = "";

		log.debug("Yes24APIService send url: " + url + "?" + pairsToString(params));
		System.out.println("@@@@@@@@@@@@@@ Yes24APIService send url: " + url + "?" + pairsToString(params));

		try {
			post.setHeader("User-Agent", USER_AGENT);
			post.setEntity(new UrlEncodedFormEntity(params));
			response = client.execute(post);
			rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
			while((line = rd.readLine()) != null) {
				result.append(line);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(response != null) try { response.close(); } catch (IOException e) {
				e.printStackTrace();
			}
		}

		String resultString = result.toString();

		log.debug("Yes24APIService send result: " + resultString);
		System.out.println("@@@@@@@@@@@@@@ Yes24APIService send result: " + resultString);

		return resultString;
	}

	private Map<String, String> parse2(String xml) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();

		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			doc = builder.parse(input);
			map.put("result", getText(doc, "//result/text()"));
			map.put("appurl", getText(doc, "//appURL/text()"));
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}

	private Map<String, String> parse3(String xml) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			doc = builder.parse(input);
			map.put("result", getText(doc, "//ResultCode/text()"));
			map.put("message", getText(doc, "//Message/text()"));
			map.put("bookcode", getText(doc, "//bookcode/text()"));
			map.put("book_status", getText(doc, "//book_status/text()"));
			map.put("library", getText(doc, "//library/text()"));
			map.put("category", getText(doc, "//category/text()"));
			map.put("title", getText(doc, "//title/text()"));
			map.put("author", getText(doc, "//author/text()"));
			map.put("publisher", getText(doc, "//publisher/text()"));
			map.put("publication_date", getText(doc, "//publication_date/text()"));
			map.put("cover", getText(doc, "//cover/text()"));
			map.put("format", getText(doc, "//format/text()"));
			map.put("loan_cnt", getText(doc, "//loan_cnt/text()"));
			map.put("max_loan_cnt", getText(doc, "//max_loan_cnt/text()"));
			map.put("reserve_cnt", getText(doc, "//reseve_cnt/text()"));
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
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

	private List<NameValuePair> makeParamPairs(String mode, Book book) {
		String user_id = book.getMember_id();
		String goods_id = book.getBook_code();
		String site_code = "";
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("mode", mode));
		params.add(new BasicNameValuePair("user_id", user_id));
		params.add(new BasicNameValuePair("goods_id", goods_id));
		params.add(new BasicNameValuePair("site_code", site_code));

		return params;
	}

	/**
	 * 대출
	 * @param book
	 * @return
	 */
	public Map<String, String> lend(Book book) {


		return parse(send(LEND_URL, makeParamPairs("lent", book)));
	}

	/**
	 * 반납
	 * @param book
	 * @return
	 */
	public Map<String, String> rtn(Book book) {
		return parse(send(LEND_URL, makeParamPairs("return", book)));
	}

	/**
	 * 예약
	 * @param book
	 * @return
	 */
	public Map<String, String> reserve(Book book) {
		return parse(send(LEND_URL, makeParamPairs("reserve", book)));
	}

	/**
	 * 예약 취소
	 * @param book
	 * @return
	 */
	public Map<String, String> cancel(Book book) {
		return parse(send(LEND_URL, makeParamPairs("cancel", book)));
	}

	/**
	 * 연장
	 * @param book
	 * @return
	 */
	public Map<String, String> extend(Book book) {
		return parse(send(LEND_URL, makeParamPairs("extension", book)));
	}

	private List<NameValuePair> makeParamPairs(ElibMember member) {
		String user_id = member.getMember_id();
		String user_pw = member.getSeq_no();
		String user_nm = member.getMember_id();
		String site_code = "";
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", user_id));
		params.add(new BasicNameValuePair("user_pw", user_pw));
		params.add(new BasicNameValuePair("user_nm", user_nm));
		params.add(new BasicNameValuePair("user_group", "G1"));
		try {
			params.add(new BasicNameValuePair("user_group_name", URLEncoder.encode("대출회원", "UTF-8")));
		} catch (UnsupportedEncodingException e) {
			params.add(new BasicNameValuePair("user_group_name", "G1"));
		}
		params.add(new BasicNameValuePair("site_code", site_code));

		return params;
	}

	/**
	 * 회원 가입
	 * @param member
	 * @return
	 */
	public Map<String, String> signup(ElibMember member, Book book) {
		Map<String, String> result = null;
		String library_code = member.getLibrary_code();
		try {
			member.setLibrary_code(book.getLibrary_code());
			result = parse(send(MEMBER_URL, makeParamPairs(member)));
		} finally {
			member.setLibrary_code(library_code);
		}
		return result;
	}

	/**
	 * YES24 앱 호출 URL
	 * @param book
	 * @return
	 */
	public Map<String, String> appUrl(Book book, ElibMember member, String device) {
		String member_id = member.getMember_id();
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		
		params.add(new BasicNameValuePair("user_id", member_id));
		params.add(new BasicNameValuePair("goods_id", book.getBook_code()));
		params.add(new BasicNameValuePair("device_type", device));

		return parse2(send(APP_URL, params));
	}
	
	public Map<String, String> bookinfo(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		
		params.add(new BasicNameValuePair("bookcode", book.getBook_code()));
		
		return parse3(send(BOOKINFO_URL, params));
	}

}
