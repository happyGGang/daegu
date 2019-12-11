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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.config.Config;
import kr.go.gbelib.app.cms.module.elib.config.ConfigService;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;

@Service
public class KyoboAPIService extends BaseService {
	
	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final String LEND_URL = "http://ebook.busan.go.kr:8091/Kyobo_T3/Process/%s.asp";
	private static final String MEMBER_URL = "http://ebook.busan.go.kr:8091/member_sync.asp";
	private static final String VIEW_URL = "http://ebook.busan.go.kr:8091/borrow_data.asp";
	private static final int TIMEOUT = 30 * 1000;
	
	@Autowired
	ConfigService configService;
	
	private Map<String, String> parse(String xml, String encoding) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String msgcode = "";
		
		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes(encoding));
			doc = builder.parse(input);
			XPath xPath =  XPathFactory.newInstance().newXPath();
			String resultPath = "/if_res/result/text()";
			String msgcodePath = "/if_res/msgcode/text()";
			XPathExpression resultExpr = xPath.compile(resultPath);
			XPathExpression msgExpr = xPath.compile(msgcodePath);
			result = (String) resultExpr.evaluate(doc, XPathConstants.STRING);
			msgcode = (String) msgExpr.evaluate(doc, XPathConstants.STRING);
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
	
	private Map<String, String> parse2(String xml, String encoding) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String msgcode = "";
		String msg = "";
		String borrowid = "";
		
		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes(encoding));
			doc = builder.parse(input);
			XPath xPath =  XPathFactory.newInstance().newXPath();
			String resultPath = "/channel/result/text()";
			String msgcodePath = "/channel/msgcode/text()";
			String msgPath = "/channel/msg/text()";
			String borrowidPath = "/channel/borrowid/text()";
			XPathExpression resultExpr = xPath.compile(resultPath);
			XPathExpression msgcodeExpr = xPath.compile(msgcodePath);
			XPathExpression msgExpr = xPath.compile(msgPath);
			XPathExpression borrowidExpr = xPath.compile(borrowidPath);
			result = (String) resultExpr.evaluate(doc, XPathConstants.STRING);
			msgcode = (String) msgcodeExpr.evaluate(doc, XPathConstants.STRING);
			msg = (String) msgExpr.evaluate(doc, XPathConstants.STRING);
			borrowid = (String) borrowidExpr.evaluate(doc, XPathConstants.STRING);
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
		map.put("msg", msg);
		map.put("borrowid", borrowid);

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
	
	private Map<String, String> parse3(String xml, String encoding) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = null;
		ByteArrayInputStream input = null;
		Document doc = null;
		Map<String, String> map = new HashMap<String, String>();
		
		try {
			builder = factory.newDocumentBuilder();
			input = new ByteArrayInputStream(xml.getBytes(encoding));
			doc = builder.parse(input);
			
			map.put("borrowID", getText(doc, "/BorrowData/BorrowID/text()"));
			map.put("type", getText(doc, "/BorrowData/filetype/text()"));
			map.put("libraryCd", getText(doc, "/BorrowData/libraryCd/text()"));
			map.put("drmHost", getText(doc, "/BorrowData/drmHost/text()"));
			map.put("libraryUrl", getText(doc, "/BorrowData/libraryUrl/text()"));
			map.put("libraryNm", getText(doc, "/BorrowData/libraryNm/text()"));
			map.put("result", getText(doc, "/BorrowData/result/text()"));

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
		
		log.debug("@@@@@@@@@@ KyoboAPIService send url: " + url + "?" + pairsToString(params));
		System.out.println("@@@@@@@@@@ KyoboAPIService send url: " + url + "?" + pairsToString(params));
		
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
		
		log.debug("@@@@@@@@@@ KyoboAPIService send result: " + resultString);
		System.out.println("@@@@@@@@@@ KyoboAPIService send result: " + resultString);
		
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
	public Map<String, String> view(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		
		params.add(new BasicNameValuePair("barcode", book.getBook_code()));
		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		
		return parse3(send(VIEW_URL, params, "UTF-8"), "UTF-8");
	}
	
	/**
	 * 대출
	 * @param book
	 * @return
	 */
	public Map<String, String> lend(Book book) {
		int lend_max_term = 7;
		Config config =  configService.getConfig();
		
		if(config != null) lend_max_term = config.getLend_max_term();
		
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("barcode", book.getBook_code()));
		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		params.add(new BasicNameValuePair("borrow_type", "W"));
		params.add(new BasicNameValuePair("borrow_date", String.valueOf(lend_max_term+1)));

		return parse2(send(String.format(LEND_URL, "Content_Borrow_Proc_If"), params, "EUC-KR"), "EUC-KR");
	}
	
	/**
	 * 반납
	 * @param book
	 * @return
	 */
	public Map<String, String> rtn(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("barcode", book.getBook_code()));
		params.add(new BasicNameValuePair("user_id", book.getMember_id()));

		return parse2(send(String.format(LEND_URL, "Content_Return_Proc_If"), params, "EUC-KR"), "EUC-KR");
	}

	/**
	 * 예약
	 * @param book
	 * @return
	 */
	public Map<String, String> reserve(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("barcode", book.getBook_code()));
		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		params.add(new BasicNameValuePair("reserve_type", "W"));

		return parse2(send(String.format(LEND_URL, "Content_Reserve_Proc_If"), params, "EUC-KR"), "EUC-KR");
	}
	
	/**
	 * 예약 취소
	 * @param book
	 * @return
	 */
	public Map<String, String> cancel(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("barcode", book.getBook_code()));
		params.add(new BasicNameValuePair("user_id", book.getMember_id()));

		return parse2(send(String.format(LEND_URL, "Content_Reserve_Cancel_Proc_If"), params, "EUC-KR"), "EUC-KR");
	}
	
	/**
	 * 연장
	 * @param book
	 * @return
	 */
	public Map<String, String> extend(Book book) {
		int lend_max_term = 7;
		Config config =  configService.getConfig();
		
		if(config != null) lend_max_term = config.getLend_max_term();
		
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("barcode", book.getBook_code()));
		params.add(new BasicNameValuePair("user_id", book.getMember_id()));
		params.add(new BasicNameValuePair("borrow_date", String.valueOf(lend_max_term)));

		return parse2(send(String.format(LEND_URL, "Content_Extend_Proc_If"), params, "EUC-KR"), "EUC-KR");
	}
	
	private List<NameValuePair> makeParamPairs(String cmd, ElibMember member) {
		String user_id = member.getMember_id();
		String user_ps = member.getSeq_no();
		String user_name = member.getMember_id();
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("cmd", cmd));
		params.add(new BasicNameValuePair("user_id", user_id));
		params.add(new BasicNameValuePair("user_ps", user_ps));
		params.add(new BasicNameValuePair("user_name", user_name));
		params.add(new BasicNameValuePair("user_type", "T1"));
		params.add(new BasicNameValuePair("user_type_name", "T1"));
		
		return params;
	}
	
	/**
	 * 회원 가입
	 * @param member
	 * @return
	 */
	public Map<String, String> signup(ElibMember member, Book book) {
		return parse(send(MEMBER_URL, makeParamPairs("I", member), "EUC-KR"), "EUC-KR");
	}
	
	/**
	 * 회원 정보 수정
	 * @param member
	 * @return
	 */
	public Map<String, String> edit(ElibMember member) {
		return parse(send(MEMBER_URL, makeParamPairs("U", member), "EUC-KR"), "EUC-KR");
	}
	
	/**
	 * 회원 탈퇴
	 * @param member
	 * @return
	 */
	public Map<String, String> delete(ElibMember member) {
		return parse(send(MEMBER_URL, makeParamPairs("D", member), "EUC-KR"), "EUC-KR");
	}
	
}
