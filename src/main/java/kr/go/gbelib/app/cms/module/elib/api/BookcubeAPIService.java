package kr.go.gbelib.app.cms.module.elib.api;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
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
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;

@Service
public class BookcubeAPIService extends BaseService {
	
	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final String LEND_URL = "http://elib.gbelib.kr:8080/FxLibrary%s/RESTful";
	private static final String MEMBER_URL = "http://elib.gbelib.kr:8080/FxLibrary%s/RESTful/userReg";
	private static final String APP_URL = "http://elib.gbelib.kr:8080/FxLibrary%s/app/appCall";
	private static final int TIMEOUT = 30 * 1000;
	
	private Map<String, String> parse(String xml) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String desc = "";
		
		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			doc = builder.parse(input);
			XPath xPath =  XPathFactory.newInstance().newXPath();
			String resultPath = "//result/text()";
			String descPath = "//desc/text()";
			XPathExpression resultExpr = xPath.compile(resultPath);
			XPathExpression descExpr = xPath.compile(descPath);
			result = (String) resultExpr.evaluate(doc, XPathConstants.STRING);
			desc = (String) descExpr.evaluate(doc, XPathConstants.STRING);
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (XPathExpressionException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		map.put("result", result);
		map.put("desc", desc);
		
		return map;
	}
	
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
	
	private Map<String, String> parse2(String xml) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String desc = "";
		
		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			doc = builder.parse(input);
			map.put("result", getText(doc, "//result/text()"));
			map.put("appurl", getText(doc, "//appurl/text()"));
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
		
		log.debug("BookcubeAPIService send url: " + url);
		System.out.println("@@@@@@@@@ BookcubeAPIService send url: " + url);
		
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
		
		log.debug("BookcubeAPIService send result: " + resultString);
		System.out.println("@@@@@@@@@@@@@@ BookcubeAPIService send result: " + resultString);
		
		return resultString;
	}
	
	private String getLibrary(Book book) {
		String library_code = book.getLibrary_code();
		
		if("00147009".equals(library_code)) {
		    // 성주
			return "_sj";
		} else if("00147002".equals(library_code)) {
		    // 고령
			return "_go";
		} else if("00147010".equals(library_code)) {
		    // 안동
			return "_ad";
		} else if("00147031".equals(library_code)) {
		    // 영덕
			return "_yd";
		} else if("00147012".equals(library_code)) {
		    // 영양
			return "_yy";
		} else if("00147013".equals(library_code)) {
		    // 영일
			return "_yi";
		} else if("00147032".equals(library_code)) {
		    // 영주
			return "_yj";
		} else if("00147014".equals(library_code)) {
		    // 영천금호
			return "_yk";
		} else if("00147017".equals(library_code)) {
		    // 울릉
			return "_ul";
		} else if("00147018".equals(library_code)) {
		    // 울진
			return "_uj";
		} else {
		    // 통합
			return "";
		}
	}
	
	private String makeURL(String ifcode, Book book) {
		String url = String.format(LEND_URL, getLibrary(book));
		return String.format(url + "/%s/%s/%s", ifcode, book.getMember_id(), book.getBook_code());
	}
	
	private String makeURL2(ElibMember member, Book book) {
		String url = String.format(MEMBER_URL, getLibrary(book));
		return String.format(url + "/%s/%s/%s/%s/%s", member.getMember_id(), member.getMember_id(), member.getMember_id(), "general", "");
	}
	
	/**
	 * 대출
	 * @param book
	 * @return
	 */
	public Map<String, String> lend(Book book) {
		return parse(send(makeURL("lend", book), new ArrayList<NameValuePair>()));
	}
	
	/**
	 * 반납
	 * @param book
	 * @return
	 */
	public Map<String, String> rtn(Book book) {
		return parse(send(makeURL("return", book), new ArrayList<NameValuePair>()));
	}

	/**
	 * 예약
	 * @param book
	 * @return
	 */
	public Map<String, String> reserve(Book book) {
		return parse(send(makeURL("reserve", book), new ArrayList<NameValuePair>()));
	}
	
	/**
	 * 예약 취소
	 * @param book
	 * @return
	 */
	public Map<String, String> cancel(Book book) {
		return parse(send(makeURL("reserveCancel", book), new ArrayList<NameValuePair>()));
	}
	
	/**
	 * 연장
	 * @param book
	 * @return
	 */
	public Map<String, String> extend(Book book) {
		return parse(send(makeURL("extend", book), new ArrayList<NameValuePair>()));
	}
	
	/**
	 * 회원 가입
	 * @param member
	 * @return
	 */
	public Map<String, String> signup(ElibMember member, Book book) {
		String member_id = member.getMember_id();
		String url = String.format(MEMBER_URL, getLibrary(book));
		return 	parse(send(String.format(url + "/%s/%s/%s/%s/%s", member_id, member_id, member_id, "general", ""), new ArrayList<NameValuePair>()));
	}

	/**
	 * 북큐브내서재 앱 호출 URL
	 * @param book
	 * @return
	 */
	public Map<String, String> appUrl(Book book, ElibMember member, String device) {
		String url = String.format(APP_URL, getLibrary(book));
		String member_id = member.getMember_id();
		String library_code = book.getLibrary_code();
		String fxli_library_code = "bcp00206";
		if("00147002".equals(library_code)) {
			fxli_library_code = "krl00306";
		} else if("00147009".equals(library_code)) {
			fxli_library_code = "bcp00095";
		} else if("00147010".equals(library_code)) {
			fxli_library_code = "bcp00112";
		} else if("00147031".equals(library_code)) {
			fxli_library_code = "bcp00063";
		} else if("00147012".equals(library_code)) {
			fxli_library_code = "bcp00090";
		} else if("00147002".equals(library_code)) {
			fxli_library_code = "bcp00111";
		} else if("00147032".equals(library_code)) {
			fxli_library_code = "bcp00196";
		} else if("00147014".equals(library_code)) {
			fxli_library_code = "bcp00089";
		} else if("00147017".equals(library_code)) {
			fxli_library_code = "bcp00082";
		} else if("00147018".equals(library_code)) {
			fxli_library_code = "bcp00124";
		}
		return parse2(send(String.format(url + "/%s/%s/%s/%s/%s/%s/%s/%s", device, fxli_library_code, book.getBook_code(), member_id, member_id, member_id, "general", member_id), new ArrayList<NameValuePair>()));
	}
	
}
