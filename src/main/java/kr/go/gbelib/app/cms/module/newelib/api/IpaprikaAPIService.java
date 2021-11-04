package kr.go.gbelib.app.cms.module.newelib.api;

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

import org.apache.commons.lang3.StringUtils;
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

@Service(value = "ipaprikaAPIServiceNew")
public class IpaprikaAPIService extends BaseService {
	
	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final String LEND_URL = "http://e-lib.ice.go.kr:8180/Supply_Api/Api_Etc/In_Api_Order_Proc.aspx";
	private static final String MEMBER_URL = "http://e-lib.ice.go.kr:8180/Supply_Api/Api_Etc/In_Api_Member_Proc.aspx";
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
			map.put("result", getText(doc, "//ERROR_CODE/text()"));
			map.put("msg", getText(doc, "//ERROR_MSG/text()"));
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
		
		log.debug("IpaprikaAPIService send url: " + url + "?" + pairsToString(params));
		System.out.println("@@@@@@@@@@@@@@ IpaprikaAPIService send url: " + url + "?" + pairsToString(params));
		
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
		
		log.debug("IpaprikaAPIService send result: " + resultString);
		System.out.println("@@@@@@@@@@@@@@ IpaprikaAPIService send result: " + resultString);
		
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
	
	private List<NameValuePair> makeParamPairs(String mode, Book book) {
		String user_id = book.getMember_id();
		String eancode = book.getBook_code();
		String file_type = book.getFormat();
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("mode", mode));
		params.add(new BasicNameValuePair("user_id", user_id));
		params.add(new BasicNameValuePair("eancode", eancode));
		params.add(new BasicNameValuePair("file_type", file_type));
		params.add(new BasicNameValuePair("platform_type", "PC"));
		
		return params;
	}
	
	/**
	 * 대출
	 * @param book
	 * @return
	 */
	public Map<String, String> lend(Book book) {
		return parse(send(LEND_URL, makeParamPairs("LOAN", book)));
	}
	
	/**
	 * 반납
	 * @param book
	 * @return
	 */
	public Map<String, String> rtn(Book book) {
		return parse(send(LEND_URL, makeParamPairs("RET", book)));
	}

	/**
	 * 예약
	 * @param book
	 * @return
	 */
	public Map<String, String> reserve(Book book) {
		return parse(send(LEND_URL, makeParamPairs("WAIT", book)));
	}
	
	/**
	 * 예약 취소
	 * @param book
	 * @return
	 */
	public Map<String, String> cancel(Book book) {
		return parse(send(LEND_URL, makeParamPairs("C_WAIT", book)));
	}
	
	/**
	 * 연장
	 * @param book
	 * @return
	 */
	public Map<String, String> extend(Book book) {
		return parse(send(LEND_URL, makeParamPairs("EXTEND", book)));
	}
	
	private List<NameValuePair> makeParamPairs(ElibMember member) {
		String user_id = member.getMember_id();
		String user_pw = member.getSeq_no();
		String user_nm = member.getMember_id();
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("user_id", user_id));
		params.add(new BasicNameValuePair("user_pw", user_pw));
		params.add(new BasicNameValuePair("user_name", user_nm));
		
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
	
}
