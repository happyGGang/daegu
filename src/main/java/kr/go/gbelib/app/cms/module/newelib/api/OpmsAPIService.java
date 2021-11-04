package kr.go.gbelib.app.cms.module.newelib.api;

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
import kr.go.gbelib.app.cms.module.newelib.book.Book;
import kr.go.gbelib.app.cms.module.newelib.member.ElibMember;

@Service(value = "opmsAPIServiceNew")
public class OpmsAPIService extends BaseService {
	
	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final String LEND_URL = "http://elib.daegu.go.kr:8000/smt_api/eco/execute/%s.asp";
	private static final String MEMBER_URL = "http://elib.daegu.go.kr:8000/eco/eco_login_sso2.asp";
//	private static final String VIEW_URL = "/external/opms_pop.asp";
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
	
	private Map<String, String> parse(String xml, String encoding) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes(encoding));
			doc = builder.parse(input);
			
			map.put("result", getText(doc, "//sucess/text()"));
			map.put("message", getText(doc, "//Message/text()"));

		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (SAXException e) {
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
		HttpPost post = new HttpPost(url);
		CloseableHttpResponse response = null;
		BufferedReader rd = null;
		StringBuilder result = new StringBuilder();
		String line = "";
		
		log.debug("@@@@@@@@@@ OpmsAPIService send url: " + url + "?" + pairsToString(params));
		System.out.println("@@@@@@@@@@ OpmsAPIService send url: " + url + "?" + pairsToString(params));
		
		try {
			post.setHeader("User-Agent", USER_AGENT);
			post.setEntity(new UrlEncodedFormEntity(params));
			response = client.execute(post);
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
		} finally {
			if(response != null) try { response.close(); } catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		String resultString = result.toString();
		
		log.debug("@@@@@@@@@@ OpmsAPIService send result: " + resultString);
		System.out.println("@@@@@@@@@@ OpmsAPIService send result: " + resultString);
		
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
	
	/**
	 * 대출 정보 조회
	 * @param book
	 * @return
	 */
/*
	public Map<String, String> view(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		
		params.add(new BasicNameValuePair("eancode", book.getBook_code()));
		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		
		return parse3(send(getServerUrl(book) + VIEW_URL, params, "UTF-8"), "UTF-8");
	}
*/
	
	/**
	 * 대출
	 * @param book
	 * @return
	 */
	public Map<String, String> lend(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		params.add(new BasicNameValuePair("book_code", book.getBook_code()));

		return parse(send(String.format(LEND_URL, "lend"), params, "UTF-8"), "UTF-8");
	}
	
	/**
	 * 반납
	 * @param book
	 * @return
	 */
	public Map<String, String> rtn(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		params.add(new BasicNameValuePair("book_code", book.getBook_code()));

		return parse(send(String.format(LEND_URL, "return"), params, "UTF-8"), "UTF-8");
	}

	/**
	 * 예약
	 * @param book
	 * @return
	 */
	public Map<String, String> reserve(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		params.add(new BasicNameValuePair("book_code", book.getBook_code()));

		return parse(send(String.format(LEND_URL, "reserve"), params, "UTF-8"), "UTF-8");
	}
	
	/**
	 * 예약 취소
	 * @param book
	 * @return
	 */
	public Map<String, String> cancel(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		params.add(new BasicNameValuePair("book_code", book.getBook_code()));

		return parse(send(String.format(LEND_URL, "cancel"), params, "UTF-8"), "UTF-8");
	}
	
	/**
	 * 연장
	 * @param book
	 * @return
	 */
	public Map<String, String> extend(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		params.add(new BasicNameValuePair("book_code", book.getBook_code()));

		return parse(send(String.format(LEND_URL, "extend"), params, "UTF-8"), "UTF-8");
	}
	
	/**
	 * 회원 가입
	 * @param member
	 * @return
	 */
	public Map<String, String> signup(ElibMember member, Book book) {
		String user_id = member.getMember_id();
//		String user_pw = member.getP_id();
//		String user_name = member.getMember_id();
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("ID", user_id));
		params.add(new BasicNameValuePair("NAME", user_id));
		params.add(new BasicNameValuePair("PW", user_id));
		
		return parse(send(MEMBER_URL, params, "UTF-8"), "UTF-8");
	}
	
}
