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
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;

@Service
public class YPAPIService extends BaseService {
	
	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final String LEND_URL = "http://elib.gbelib.kr:8083/y2books_api/%s.php";
	private static final String MEMBER_URL = "http://elib.gbelib.kr:8083/y2books_api/reg_member.php";
	private static final int TIMEOUT = 30 * 1000;
	
	private Map<String, String> parse(String xml) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String msgcode = "";
		
		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			doc = builder.parse(input);
			XPath xPath =  XPathFactory.newInstance().newXPath();
			String resultPath = "/if_res/result/text()";
			String msgcodePath = "/if_res/msgcode/text()";
			XPathExpression resultExpr = xPath.compile(resultPath);
			XPathExpression msgcodeExpr = xPath.compile(msgcodePath);
			result = (String) resultExpr.evaluate(doc, XPathConstants.STRING);
			msgcode = (String) msgcodeExpr.evaluate(doc, XPathConstants.STRING);
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
		}
		
		map.put("result", result);
		map.put("msgcode", msgcode);
		
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
		
		log.debug("YPAPIService send url: " + url + "?" + pairsToString(params));
		System.out.println("@@@@@@@@@@@@@ YPAPIService send url: " + url + "?" + pairsToString(params));
		
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
		
		log.debug("YPAPIService send result: " + resultString);
		System.out.println("@@@@@@@@@@@@@ YPAPIService send result: " + resultString);
		
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
	
	private List<NameValuePair> makeParamPairs(Book book) {
		String user_id = book.getMember_id();
		String book_code = book.getBook_code();
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", user_id));
		params.add(new BasicNameValuePair("book_code", book_code));
		params.add(new BasicNameValuePair("device", "P"));
		
		return params;
	}
	
	/**
	 * 대출
	 * @param book
	 * @return
	 */
	public Map<String, String> lend(Book book) {
		return parse(send(String.format(LEND_URL, "lend"), makeParamPairs(book)));
	}
	
	/**
	 * 반납
	 * @param book
	 * @return
	 */
	public Map<String, String> rtn(Book book) {
		return parse(send(String.format(LEND_URL, "return"), makeParamPairs(book)));
	}

	/**
	 * 예약
	 * @param book
	 * @return
	 */
	public Map<String, String> reserve(Book book) {
		return parse(send(String.format(LEND_URL, "reserve"), makeParamPairs(book)));
	}
	
	/**
	 * 예약 취소
	 * @param book
	 * @return
	 */
	public Map<String, String> cancel(Book book) {
		return parse(send(String.format(LEND_URL, "reserve_cancel"), makeParamPairs(book)));
	}
	
	/**
	 * 연장
	 * @param book
	 * @return
	 */
	public Map<String, String> extend(Book book) {
		return parse(send(String.format(LEND_URL, "extend"), makeParamPairs(book)));
	}
	
	private List<NameValuePair> makeParamPairs(ElibMember member) {
		String user_id = member.getMember_id();
		String user_pwd = member.getP_id();
		String user_name = member.getMember_id();
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", user_id));
		params.add(new BasicNameValuePair("user_pwd", user_pwd));
		params.add(new BasicNameValuePair("user_name", user_name));
		
		return params;
	}
	
	/**
	 * 회원 가입
	 * @param member
	 * @return
	 */
	public Map<String, String> signup(ElibMember member, Book book) {
		return parse(send(MEMBER_URL, makeParamPairs(member)));
	}
	
}
