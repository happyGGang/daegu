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
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;

@Service
public class BookcubeAPIService extends BaseService {
	
	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final String LEND_URL = "http://elib.daegu.go.kr:9080/FxLibrary/RESTful";
	private static final String MEMBER_URL = "http://elib.daegu.go.kr:9080/FxLibrary/RESTful/userReg";
	private static final String APP_URL = "http://elib.daegu.go.kr:9080/FxLibrary/app/appCall";
	private static final String BOOKINFO_URL = "http://elib.daegu.go.kr:9080/FxLibrary/dependency/program/api_book.jsp";
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
			map.put("reserve_cnt", getText(doc, "//reserve_cnt/text()"));
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
	
	private String makeURL(String ifcode, Book book) {
		return String.format(LEND_URL + "/%s/%s/%s", ifcode, book.getMember_id(), book.getBook_code());
	}
	
	private String makeURL2(ElibMember member, Book book) {
		return String.format(LEND_URL + "/%s/%s/%s/%s/%s", member.getMember_id(), member.getMember_id(), member.getMember_id(), "general", "");
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
		return 	parse(send(String.format(MEMBER_URL + "/%s/%s/%s/%s/%s", member_id, member_id, member_id, "general", ""), new ArrayList<NameValuePair>()));
	}

	/**
	 * 북큐브내서재 앱 호출 URL
	 * @param book
	 * @return
	 */
	public Map<String, String> appUrl(Book book, ElibMember member, String device) {
		String member_id = member.getMember_id();
		String fxli_library_code = "bcp00106";
		
		return parse2(send(String.format(APP_URL + "/%s/%s/%s/%s/%s/%s", device, fxli_library_code, book.getBook_code(), member_id, member_id, member_id), new ArrayList<NameValuePair>()));
	}
	
	public Map<String, String> bookinfo(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		
		params.add(new BasicNameValuePair("api_key", "26db46d3a9498def373ab866d893ef9fa76b530c913fcd093d461cd94348d972"));
		params.add(new BasicNameValuePair("bookcode", book.getBook_code()));
		
		return parse3(send(BOOKINFO_URL, params));
	}
	
}
