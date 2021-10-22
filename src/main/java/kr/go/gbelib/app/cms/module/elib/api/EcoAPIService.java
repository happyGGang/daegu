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

import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.book.Book;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;

@Service
public class EcoAPIService extends BaseService {
	
	private static final String USER_AGENT = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)";
	private static final String MEMBER_URL = "/ebookPlatform/Homepage/LoginUserInsert.do";
	private static final String LEND_URL   = "/ebookPlatform/Homepage/Loan.do";
	private static final String RETURN_URL = "/ebookPlatform/Homepage/Return.do";
	private static final String EXTEND_URL = "/ebookPlatform/Homepage/Extension.do";
	private static final String POLICY_URL = "/ebookPlatform/HompageAdmin/LoanRuleUpdate.do";
	private static final int TIMEOUT = 30 * 1000;
	
//	@Autowired
//	ConfigService configService;
	
	private String getServerUrl(Book book) {
		//return "http://e-lib.tglnet.or.kr:8099";
		return "http://elib.daegu.go.kr:8099";  //또는 8100포트
	}
	
	private Map<String, String> parse(String xml, String encoding) {
		ByteArrayInputStream input = null;
		Map<String, String> map = new HashMap<String, String>();
		String result = "";
		String msgcode = "";
		
		try {
			input = new ByteArrayInputStream(xml.getBytes(encoding));
			Map<String, Object> tmp = new ObjectMapper().readValue(input,  HashMap.class);
			tmp = (HashMap<String, Object>) tmp.get("Result");
			result = (String) tmp.get("ResultCode");
			msgcode = (String) tmp.get("ResultMessage");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		map.put("result", result);
		map.put("msg", msgcode);
		
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
		
		log.debug("@@@@@@@@@@ EcoAPIService send url: " + url + "?" + pairsToString(params));
//		System.out.println("@@@@@@@@@@ EcoAPIService send url: " + url + "?" + pairsToString(params));
		
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
		
		log.debug("@@@@@@@@@@ EcoAPIService send result: " + resultString);
//		System.out.println("@@@@@@@@@@ EcoAPIService send result: " + resultString);
		
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
	 * 대출
	 * @param book
	 * @return
	 */
	public Map<String, String> lend(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("contentKey", book.getBook_code()));
		params.add(new BasicNameValuePair("userId", book.getMember_id()));
		params.add(new BasicNameValuePair("ownerCode", "EC"));
		params.add(new BasicNameValuePair("userAppYN", "Y"));

		return parse(send(getServerUrl(book) + LEND_URL, params, "UTF-8"), "UTF-8");
	}
	
	/**
	 * 반납
	 * @param book
	 * @return
	 */
	public Map<String, String> rtn(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("contentKey", book.getBook_code()));
		params.add(new BasicNameValuePair("userId", book.getMember_id()));
		params.add(new BasicNameValuePair("userAppYN", "Y"));

		return parse(send(getServerUrl(book) + RETURN_URL, params, "UTF-8"), "UTF-8");
	}

	/**
	 * 연장
	 * @param book
	 * @return
	 */
	public Map<String, String> extend(Book book) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("contentKey", book.getBook_code()));
		params.add(new BasicNameValuePair("userId", book.getMember_id()));
		params.add(new BasicNameValuePair("ownerCode", "EC"));
		params.add(new BasicNameValuePair("userAppYN", "Y"));

		return parse(send(getServerUrl(book) + EXTEND_URL, params, "UTF-8"), "UTF-8");
	}
	
/*
	private List<NameValuePair> makeParamPairs(String cmd, ElibMember member) {
		String user_id = member.getMember_id();
		String user_ps = member.getP_id();
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
*/
	
	/**
	 * 회원 가입
	 * @param member
	 * @return
	 */
	public Map<String, String> signup(ElibMember member, Book book) {
		String user_id = member.getMember_id();
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("libCode", "123003"));
		params.add(new BasicNameValuePair("userName", user_id));
		params.add(new BasicNameValuePair("userId", user_id));
		params.add(new BasicNameValuePair("userLoanNo", user_id));
		params.add(new BasicNameValuePair("userEmail", "N"));

		return parse(send(getServerUrl(book) + MEMBER_URL, params, "UTF-8"), "UTF-8");
	}
	
	/**
	 * 대출정책 업데이트
	 * @param book
	 * @return
	 */
	public Map<String, String> policyUpdate(Book book, int loanCnt, int loanTerm, int loanDelayCnt, int reserveCnt, int loanDelayDate) {
		List<NameValuePair> params = new ArrayList<NameValuePair>();

		params.add(new BasicNameValuePair("libCode", "123003"));
		params.add(new BasicNameValuePair("contentsType", "EB"));
		params.add(new BasicNameValuePair("loanCnt", String.valueOf(loanCnt)));
		params.add(new BasicNameValuePair("loanTerm", String.valueOf(loanTerm)));
		params.add(new BasicNameValuePair("loanDelayCnt", String.valueOf(loanDelayCnt)));
		params.add(new BasicNameValuePair("reserveCnt", String.valueOf(reserveCnt)));
		params.add(new BasicNameValuePair("loanDelayDate", String.valueOf(loanDelayDate)));

		return parse(send(getServerUrl(book) + POLICY_URL, params, "UTF-8"), "UTF-8");
	}
	
}
