package kr.go.gbelib.app.common.api;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import javax.net.ssl.HttpsURLConnection;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class CommonAPI {
	protected final static Logger log = LoggerFactory.getLogger(CommonAPI.class);

	public final static String ILUS_API_URL = ResourceBundle.getBundle("api").getString("ilus.api.url");
	public final static String LIBONE_API_URL = ResourceBundle.getBundle("api").getString("libone.api.url");
	public final static String KEYWORD_API_URL = ResourceBundle.getBundle("api").getString("keyword.api.url");

	public final static String NAVER_LIST_API_URL = "https://openapi.naver.com/v1/search/book.xml";
	public final static String NAVER_DETAIL_API_URL = "https://openapi.naver.com/v1/search/book_adv.xml";
	public final static String ALADIN_LIST_API_URL = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx";
	public final static String ALADIN_DETAIL_API_URL = "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx";

	public final static String KCMS_API_URL = ResourceBundle.getBundle("api").getString("kcms.api.url");
	public final static String KCMS_PRIVATE_API_URL = ResourceBundle.getBundle("api").getString("kcms.private.api.url");
	public final static String SANGHO_API_URL = ResourceBundle.getBundle("api").getString("sangho.api.url");

	public final static String DATA_4_LIBRARY_API_URL = ResourceBundle.getBundle("api").getString("data4library.api.url");
	public final static String DATA_4_LIBRARY_API_KEY = ResourceBundle.getBundle("api").getString("data4library.api.key");

	public final static String LIBRARY_API_URL = ResourceBundle.getBundle("api").getString("libraryapi.api.url");

	public final static String KAKAO_LIST_API_URL = "https://dapi.kakao.com/v3/search/book";
	
	public static HttpURLConnection initConn(String urlStr) throws Exception {
		URL url = new URL(urlStr);

		HttpURLConnection connection = null;
		connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Accept-Charset", "UTF-8");
		connection.setRequestProperty("Accept-Language", "utf-8,ko;q=0.8,en-us;q=0.5,en;q=0.3");
		connection.setDoOutput(true);
		connection.setConnectTimeout(10000);
		connection.setReadTimeout(10000);
		return connection;
	}
	
	public static HttpsURLConnection initHttpsConn(String urlStr) throws Exception {
		URL url = new URL(urlStr);
		
		HttpsURLConnection connection = null;
		connection = (HttpsURLConnection) url.openConnection();
		connection.setRequestMethod("GET");
		connection.setRequestProperty("Accept-Charset", "UTF-8");
		connection.setRequestProperty("Accept-Language", "utf-8,ko;q=0.8,en-us;q=0.5,en;q=0.3");
		connection.setRequestProperty("User-Agent", "Mozilla/5.0"); // https를 호출시 user-agent 필요
		
		connection.setDoOutput(true);
		connection.setConnectTimeout(10000);
		connection.setReadTimeout(10000);
		return connection;
	}

	/**
	 * 대구 통합도서관 KCMS API
	 * @author SUNGHWAN 2022. 11. 02.
	 * @param requestName - 요청명
	 * @param param 파라미터
	 * @return
	 */
	public static Map<String, Object> sendKCMS(String requestName, Map<String, Object> param) {
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = null;
		try {
			String apiUrl = KCMS_API_URL + requestName;
			connection = initConn(apiUrl);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(wr, "UTF-8"));

			if ( param != null ) {
				Set<String> keys = param.keySet();
				List<String> paramList = new ArrayList<String>();
				for ( String oneKey : keys ) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
				log.error("@@@@@@@@@@@@@@@@@@ KCMS_API_URL : " + apiUrl + "?" + StringUtils.join(paramList, "&"));

				writer.write(StringUtils.join(paramList, "&"));
			}

			writer.close();
			wr.close();
			wr.flush();

			String result = IOUtils.toString(connection.getInputStream(), "UTF-8").trim();
			ObjectMapper om = new ObjectMapper();
			resultMap = om.readValue(result, new TypeReference<Map<String, Object>>(){});
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return resultMap;
	}

	/**
	 * 대구통합도서관 BOOK SEACH API
	 * @author YONGJU 2021. 10. 27.
	 * @param requestName - 요청명
	 * @param param 파라미터
	 * @return
	 */
	public static Map<String, Object> sendKEYWORD(String requestName, Map<String, Object> param) {
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = null;
		try {
			String apiUrl = KEYWORD_API_URL + requestName;
			connection = initConn(apiUrl);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(wr, "UTF-8"));

			if ( param != null ) {
				Set<String> keys = param.keySet();
				List<String> paramList = new ArrayList<String>();
				
				
				for ( String oneKey : keys ) {
					if (oneKey.equals("keyword")) {
						String[] keywords = param.get(oneKey).toString().split(",");
						
						for (int i = 0; i < keywords.length; i++) {
							paramList.add(String.format("%s=%s", oneKey, keywords[i]));
						}
					} else {
						paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
					}
				}
				log.error("@@@@@@@@@@@@@@@@@@ keyword.api.url : " + apiUrl + "?" + StringUtils.join(paramList, "&"));

				writer.write(StringUtils.join(paramList, "&"));
			}

			writer.close();
			wr.close();
			wr.flush();

			String result = IOUtils.toString(connection.getInputStream(), "UTF-8").trim();
			ObjectMapper om = new ObjectMapper();
			resultMap = om.readValue(result, new TypeReference<Map<String, Object>>(){});
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return resultMap;
	}

	@SuppressWarnings ("unchecked")
	public static Map<String, Object> sendSANGHO(Map<String, Object> param) {
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = null;
		BufferedReader br = null;

		try {
			String url = SANGHO_API_URL;
			List<String> paramList = new ArrayList<String>();
			if (param != null) {
				Set<String> keys = param.keySet();
				for (String oneKey : keys) {
					paramList.add(String.format("%s=%s", oneKey, URLEncoder.encode(String.valueOf(param.get(oneKey)), "UTF-8")));
				}
			}

			connection = initConn(url + "?" + StringUtils.join(paramList, "&"));
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();

			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			} else {  // 에러 발생
				br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			log.error("@@@@@@@@@@@@@@@@@@ SANGHO API : " + url + "?" + StringUtils.join(paramList, "&"));
			try {
				resultMap = xmlToJson(response.toString()).toMap();
			}
			catch ( Exception e ) {
			}
			resultMap = xmlToJson(response.toString()).toMap();
			resultMap = (Map<String, Object>) resultMap.get("DATA");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) {
					br.close();
				}
				if (connection != null) {
					connection.disconnect();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return resultMap;

	}

	public static Document sendILUS(Map<String, Object> param) {
		return sendILUS(param, "POST");
	}

	public static final Charset UTF_8 = Charset.forName("UTF-8");

	public static Document sendILUS(Map<String, Object> param, String post) {
		long start = System.currentTimeMillis();
		Document doc = null;
		CloseableHttpClient client = HttpClients.createDefault();
		try {

			HttpPost httpPost = new HttpPost(ILUS_API_URL);

			httpPost.addHeader("content-type", "application/x-www-form-urlencoded");
			List<NameValuePair> postParams = new ArrayList<NameValuePair>();

			if (param != null) {
				Set<String> keys = param.keySet();
				for (String oneKey : keys) {
					postParams.add(new BasicNameValuePair(oneKey, String.valueOf(param.get(oneKey))));
				}
				log.error("@@@@@@@@@@@@@@@@@@ ILUS API : " + ILUS_API_URL + "?" + StringUtils.join(postParams, "&"));
			}

			httpPost.setEntity(new UrlEncodedFormEntity(postParams, UTF_8));
			CloseableHttpResponse response = client.execute(httpPost);

			DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = builderFactory.newDocumentBuilder();

			doc = builder.parse(response.getEntity().getContent());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (client != null) {
				try {
					client.close();
				} catch (IOException e) {}
			}
		}

		long end = System.currentTimeMillis();

		log.error("@@@@@@@@@@@@@@@@@@ ILUS API TIME : " + (end-start)/1000.0);

		return doc;
	}

	public static Map<String, Object> sendLIBONE(Map<String, Object> param) {
		long start = System.currentTimeMillis();
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = null;
		try {
			connection = initConn(LIBONE_API_URL);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(wr, "UTF-8"));

			if (param != null) {
				Set<String> keys = param.keySet();
				List<String> paramList = new ArrayList<String>();
				for (String oneKey : keys) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
//				log.error("@@@@@@@@@@@@@@@@@@ LIBONE API : " + LIBONE_API_URL + "?" + StringUtils.join(paramList, "&"));
				writer.write(StringUtils.join(paramList, "&"));

			}

			writer.close();
			wr.close();
			wr.flush();

			String result = IOUtils.toString(connection.getInputStream(), "UTF-8").trim();
			ObjectMapper om = new ObjectMapper();
			if (result.startsWith("[")) {
				result = "{\"data\":" + result;
				result = result + "}";
			}
			resultMap = om.readValue(result, new TypeReference<Map<String, Object>>() {});

			// BR 검색 엔진에서 썸네일 주소를 이중으로 URL인코딩함. 이걸 풀어주기 위해 추가. 2019.04.03
			try {
				@SuppressWarnings ("unchecked")
				List<Map<String, Object>> data = (List<Map<String, Object>>) resultMap.get("data");
				if(data != null) {
					for(Map<String, Object> item: data) {
						String img = String.valueOf(item.get("img"));
						if(img != null && !"null".equalsIgnoreCase(img)) {
							item.put("img", img.replaceAll("%25", "%"));
						}
					}
				}
			} catch(Exception e) {

			}

			connection.disconnect();

		} catch (Exception e) {

		}
		long end = System.currentTimeMillis();

//		log.error("@@@@@@@@@@@@@@@@@@ LIBONE API TIME : " + (end-start)/1000.0);

		return resultMap;
	}

	public static Map<String, Object> sendLIBONE2(Map<String, Object> param) {
		Map<String, Object> resultMap = null;
		BufferedReader br = null;
		try {

			CloseableHttpClient client = HttpClients.createDefault();
			HttpPost httpPost = new HttpPost(LIBONE_API_URL);

			httpPost.addHeader("content-type", "application/x-www-form-urlencoded");
			List<NameValuePair> postParams = new ArrayList<NameValuePair>();

			if (param != null) {
				Set<String> keys = param.keySet();
				for (String oneKey : keys) {
					postParams.add(new BasicNameValuePair(oneKey, String.valueOf(param.get(oneKey))));
				}
//				log.error("@@@@@@@@@@@@@@@@@@ LIBONE API 2 : " + LIBONE_API_URL + "?" + StringUtils.join(postParams, "&"));
			}

			httpPost.setEntity(new UrlEncodedFormEntity(postParams));
			CloseableHttpResponse response = client.execute(httpPost);

			br = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));

			String inputLine;
			StringBuffer sb = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine.trim());
			}

			ObjectMapper om = new ObjectMapper();
			if (sb.toString().startsWith("[")) {
				sb.insert(0, "{\"data\":");
				sb.append("}");
			}
			resultMap = om.readValue(sb.toString(), new TypeReference<Map<String, Object>>() {});
			client.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) {
					br.close();
				}
			} catch (IOException e) {}
		}

		return resultMap;

	}

	public static Map<String, Object> sendLIBONE1(Map<String, Object> param) {
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = null;
		BufferedReader br = null;
		try {

			List<String> paramList = new ArrayList<String>();
			if (param != null) {
				Set<String> keys = param.keySet();
				for (String oneKey : keys) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
			}
			connection = initConn(LIBONE_API_URL + "?" + StringUtils.join(paramList, "&"));
			connection.setRequestMethod("POST");
			int responseCode = connection.getResponseCode();
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
			}

			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine.trim());
			}

			ObjectMapper om = new ObjectMapper();
			if (response.toString().startsWith("[")) {
				response.insert(0, "{\"data\":");
				response.append("}");
			}
			resultMap = om.readValue(response.toString(), new TypeReference<Map<String, Object>>() {});
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				connection.disconnect();
			}
			try {
				if (br != null) {
					br.close();
				}
			} catch (IOException e) {}
		}
		return resultMap;
	}

	public static Map<String, Object> sendNAVER(Map<String, Object> param, String mode) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HttpURLConnection connection = null;
		String clientId = "WS4zSyLs1lwGo9UorU0Y";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "I4j6EIWUw7";// 애플리케이션 클라이언트 시크릿값";
		BufferedReader br = null;
		try {
			String url = mode.toLowerCase().equals("list") ? NAVER_LIST_API_URL : NAVER_DETAIL_API_URL;
			List<String> paramList = new ArrayList<String>();
			if (param != null) {
				Set<String> keys = param.keySet();
				for (String oneKey : keys) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
			}
			connection = initConn(url + "?" + StringUtils.join(paramList, "&"));
			connection.setRequestMethod("GET");
			connection.setRequestProperty("X-Naver-Client-Id", clientId);
			connection.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = connection.getResponseCode();

			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "UTF-8"));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
//			log.error("@@@@@@@@@@@@@@@@@@ NAVER API : " + url + "?" + StringUtils.join(paramList, "&"));
			resultMap = xmlToJson(response.toString()).toMap();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				connection.disconnect();
			}
			try {
				if (br != null) {
					br.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		connection.disconnect();
		return resultMap;
	}
	
	public static Map<String, Object> sendKAKAO(Map<String, Object> param, String mode) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HttpsURLConnection connection = null;
		String authorization = "KakaoAK 7469655c1f5e6608afccf48b46aabf0c";
		BufferedReader br = null;
		try {
			String url = KAKAO_LIST_API_URL;
			List<String> paramList = new ArrayList<String>();
			if (param != null) {
				Set<String> keys = param.keySet();
				for (String oneKey : keys) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
			}
			connection = initHttpsConn(url + "?" + StringUtils.join(paramList, "&"));
			connection.setRequestMethod("GET");
			connection.setRequestProperty("Content-Type", "application/json; UTF-8");
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			connection.setRequestProperty("Authorization", authorization);
			int responseCode = connection.getResponseCode();

			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			} else {
				br = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "UTF-8"));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			log.error("@@@@@@@@@@@@@@@@@@ KAKAO API : " + url + "?" + StringUtils.join(paramList, "&"));
			resultMap = toMap(response);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				connection.disconnect();
			}
			try {
				if (br != null) {
					br.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		connection.disconnect();
		return resultMap;
	}
	
	@SuppressWarnings("unchecked")
	private static Map<String, Object> toMap(StringBuffer response) {
		Map<String, Object> map = null;
	    
		  try {
		       map = new ObjectMapper().readValue(response.toString(), Map.class);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return map;
	}

	@SuppressWarnings ("unchecked")
	public static Map<String, Object> sendALADIN(Map<String, Object> param, String mode) {
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		BufferedReader br = null;

		try {
			String url = mode.toLowerCase().equals("list") ? ALADIN_LIST_API_URL : ALADIN_DETAIL_API_URL;

			List<String> paramList = new ArrayList<String>();
			param.put("ttbkey", "ttbinmypart1853007");
			param.put("Cover", "Big");
			param.put("optResult", "toc");
			if (param != null) {
				Set<String> keys = param.keySet();
				for (String oneKey : keys) {
					paramList.add(String.format("%s=%s", oneKey, URLEncoder.encode(String.valueOf(param.get(oneKey)), "UTF-8")));
				}
				if (System.getProperty("spring.profiles.active").equals("localServer")) {
					log.error("@@@@@@@@@@@@@@@@@@ ALADIN API : " + url + "?" + StringUtils.join(paramList, "&"));
				}
			}
			connection = initConn(url + "?" + StringUtils.join(paramList, "&"));
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();

			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "UTF-8"));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}

			try {
				resultMap = (Map<String, Object>) xmlToJson(response.toString()).toMap().get("object");
			} catch (Exception e) {
				resultMap = new HashMap<String, Object>();
			}

		} catch (Exception e) {} finally {
			try {
				if (br != null) {
					br.close();
				}
				if (connection != null) {
					connection.disconnect();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return resultMap;

	}

	/**
	 * 비대면 확인 API
	 * @author whalesoft YONGJU 2020. 4. 10.
	 * @param juminNo 주민등록번호
	 * @param name 성명
	 * @return
	 */
	public static Map<String, Object> sendUntact(String juminNo, String name) {
		long startTime = System.currentTimeMillis();
		String rnd1 = Double.toString(java.lang.Math.random()).substring(2, 6);
		String rnd2 = Double.toString(java.lang.Math.random()).substring(2, 6);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS", Locale.KOREA);
		String cur = sdf.format(new Date());
		String transactionUniqueId = cur + rnd1 + rnd2;

		NewGpkiUtil g = null;
		String xml = null;

		boolean useGPKI = true;

		StringBuffer sb = new StringBuffer();

		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\t\n");
		sb.append("<Envelope xmlns=\"http://schemas.xmlsoap.org/soap/envelope/\">\n");
		sb.append("   <Header>\n");
		sb.append("      <commonHeader xmlns=\"http://ccais.mopas.go.kr/dh/jmn/services/jumin/ResideInsttCnfirm/types\">\n");
		sb.append("         <serviceName>ResideInsttCnfirmService</serviceName>\n");
		sb.append("         <useSystemCode>6271102CMC</useSystemCode>\n");
		sb.append("         <certServerId>SVR6271102001</certServerId>\n");
		sb.append("         <transactionUniqueId>" + transactionUniqueId + "</transactionUniqueId>\n");
		sb.append("         <userDeptCode>6271102</userDeptCode>\n");
		sb.append("         <userName>이경애</userName>\n");
		sb.append("      </commonHeader>\n");
		sb.append("   </Header>\n");
		sb.append("   <Body>\n");
		sb.append("      <getResideInsttCnfirm xmlns=\"http://ccais.mopas.go.kr/dh/jmn/services/jumin/ResideInsttCnfirm/types\">\n");
		sb.append("         <orgCode>1174000001</orgCode>\n");
		sb.append("         <id>" + juminNo + "</id>\n");
		sb.append("         <name>" + name + "</name>\n");
		sb.append("      </getResideInsttCnfirm>\n");
		sb.append("   </Body>\n");
		sb.append("</Envelope>\n");

		xml = sb.toString();

		// 행정망
//		String serviceUrl = "http://hub.share.go.kr/jmn/infoservice/jumin/ResideInsttCnfirmService";
		String serviceUrl = "http://10.50.3.97/jmn/infoservice/jumin/ResideInsttCnfirmService";

		String dcriptMsg = "";

		if (useGPKI) {

			String encoded = null;
			String requestXml = null;
			try {
				String targetServerId = "SVR1311000030"; // 수정금지
				g = ShareGpki.getGpkiUtil(targetServerId);

				String charset = "UTF-8";

				String original = xml.split("<getResideInsttCnfirm xmlns=\"http://ccais.mopas.go.kr/dh/jmn/services/jumin/ResideInsttCnfirm/types\">")[1].split("</getResideInsttCnfirm>")[0];

				byte[] encrypted = g.encrypt(original.getBytes(charset), targetServerId);
				byte[] signed = g.sign(encrypted);
				encoded = g.encode(signed);

//				System.out.println(xml);

				requestXml = xml;
				{
					requestXml = requestXml.replace(original, encoded);
				}

//				System.out.println(requestXml);

			} catch (Throwable e) {
				e.printStackTrace();
			}

			String responseMsg = GpkiClient.doService(serviceUrl, requestXml);
//			System.out.println(responseMsg);
			String responseEncData = responseMsg.split("<getResideInsttCnfirmResponse xmlns=\"http://ccais.mopas.go.kr/dh/jmn/services/jumin/ResideInsttCnfirm/types\">")[1]
					.split("</getResideInsttCnfirmResponse>")[0];

//			System.out.println(responseMsg);

			String decrypted = "";
			{
				byte[] decoded;
				try {
					decoded = g.decode(responseEncData);
					byte[] validated = g.validate(decoded);
					decrypted = new String(g.decrypt(validated), "UTF-8");
					decrypted = decrypted.replace("><", ">\n<");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			dcriptMsg = responseMsg.replace(responseEncData, decrypted);
//			System.out.println(dcriptMsg);

			System.out.println("응답시간 : " + (System.currentTimeMillis() - startTime) + " ms");

		} else {
			String responseMsg = GpkiClient.doService(serviceUrl, xml);
			System.out.println(responseMsg);
		}


		return xmlToJson(dcriptMsg).toMap();
	}
	
	public static Map<String, Object> sendMARC(String requestName, Map<String, Object> param) {
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = null;
		try {
			String apiUrl = KCMS_API_URL + requestName;
			connection = initConn(apiUrl);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(wr, "UTF-8"));
			
			if ( param != null ) {
				Set<String> keys = param.keySet();
				List<String> paramList = new ArrayList<String>();
				for ( String oneKey : keys ) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
				log.error("@@@@@@@@@@@@@@@@@@ KCMS_API_URL : " + apiUrl + "?" + StringUtils.join(paramList, "&"));

				writer.write(StringUtils.join(paramList, "&"));
			}

			writer.close();
			wr.close();
			wr.flush();

			String result = IOUtils.toString(connection.getInputStream(), "UTF-8").trim();
			result = result.replace("&", "&amp;");
			
			resultMap = xmlToJson(result).toMap();
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return resultMap;
	}

	public static String getElementValueByName(Document doc, String elementName) {
		String result = "";
		if (doc != null) {
			NodeList nodeList = doc.getElementsByTagName(elementName);

			for (int i = 0; i < nodeList.getLength(); i++) {
				result = nodeList.item(i).getTextContent();
			}
		}

		return result;
	}

	public static Map<String, String> getFieldData(Document doc) {
		Map<String, String> result = new HashMap<String, String>();
		NodeList nodeList = doc.getElementsByTagName("field");
		for (int i = 0; i < nodeList.getLength(); i++) {
			Node oneNode = nodeList.item(i);
			if (!"#text".equals(oneNode.getNodeName())) {
				NamedNodeMap attributes = oneNode.getAttributes();
				result.put(attributes.getNamedItem("name").getNodeValue(), oneNode.getTextContent());
			}
		}
		return result;
	}

	public static List<Map<String, String>> getFieldDataList(Document doc) {
		List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		NodeList itemList = doc.getElementsByTagName("item");

		if (itemList != null) {
			for (int i = 0; i < itemList.getLength(); i++) {
				Map<String, String> oneCodeInfo = new HashMap<String, String>();

				Node oneItem = itemList.item(i);
				NodeList childList = oneItem.getChildNodes();
				for (int j = 0; j < childList.getLength(); j++) {
					Node oneChild = childList.item(j);
					String nodeName = oneChild.getNodeName();
					if (!"#text".equals(nodeName)) {
						NamedNodeMap attributes = oneChild.getAttributes();
						oneCodeInfo.put(attributes.getNamedItem("name").getNodeValue(), oneChild.getTextContent());
					}
				}
				result.add(oneCodeInfo);
			}
		} else {
			return null;
		}

		return result;
	}

	public static String getCrypt(String text) {
		return getCrypt(text, null);
	}

	public static String getCrypt(String text, String browser) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkCrypt");
		param.put("vType", "en_duplex");
		if (StringUtils.isNotEmpty(text)) {
			try {
				param.put("vText", URLEncoder.encode(text, "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				param.put("vText", text);
			}
		} else {
			return "";
		}
		if (!StringUtils.isEmpty(browser)) {
			param.put("vBrowser", browser);
		}

		Document doc = CommonAPI.sendILUS(param, "POST");
		String code = CommonAPI.getElementValueByName(doc, "code");
		String field = CommonAPI.getElementValueByName(doc, "field");
		if (StringUtils.equals(field, "ERROR")) {
			field = "";
		}

		if ("0".equals(code)) {
			return field;
		} else {
			return null;
		}
	}

	public static String getCryptSimplex(String text) {
		return getCryptSimplex(text, null);
	}

	public static String getCryptSimplex(String text, String browser) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkCrypt");
		param.put("vType", "en_simplex");
		try {
			param.put("vText", URLEncoder.encode(text, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// try {
		// param.put("vText", URLEncoder.encode(text, "UTF-8"));
		// } catch (UnsupportedEncodingException e) {
		// return null;
		// }
		if (!StringUtils.isEmpty(browser)) {
			param.put("vBrowser", browser);
		}

		Document doc = CommonAPI.sendILUS(param, "POST");
		String code = CommonAPI.getElementValueByName(doc, "code");

		String field = CommonAPI.getElementValueByName(doc, "field");
		if (StringUtils.equals(field, "ERROR")) {
			field = "";
		}

		if ("0".equals(code)) {
			return field;
		} else {
			return null;
		}
	}

	/**
	 * list - item - field 순서로 파싱
	 *
	 * @param doc
	 */
	public static Map<String, Object> parseXml(Document doc) {
		Map<String, Object> result = null;
		if (doc != null) {
			NodeList listNodes = doc.getElementsByTagName("list");

			if (listNodes != null) {
				result = new HashMap<String, Object>();
				for (int i = 0; i < listNodes.getLength(); i++) {
					Node listNode = listNodes.item(i);
					String listNodeKey = listNode.getAttributes().getNamedItem("name").getNodeValue();
					NodeList itemNodes = listNode.getChildNodes();

					if (itemNodes != null) {
						List<Object> itemList = new ArrayList<Object>();

						for (int j = 0; j < itemNodes.getLength(); j++) {
							if (itemNodes.item(j).getNodeName().equals("item")) {
								Node itemNode = itemNodes.item(j);
								NodeList fieldNodes = itemNode.getChildNodes();

								if (fieldNodes != null) {
									Map<String, Object> itemInfo = new HashMap<String, Object>();

									for (int k = 0; k < fieldNodes.getLength(); k++) {
										if (fieldNodes.item(k).getNodeName().equals("field")) {
											String fieldKey = fieldNodes.item(k).getAttributes().getNamedItem("name").getNodeValue();
											String fieldValue = fieldNodes.item(k).getTextContent();
											itemInfo.put(fieldKey, fieldValue);
										}
									}
									itemList.add(itemInfo);
								}
							}
						}
						result.put(listNodeKey, itemList);
					}
				}
			}
		}

		return result;
	}

	public static JSONObject xmlToJson(String xmlString) {
		JSONObject json = XML.toJSONObject(xmlString);
		return json;
	}

	/**
	 * 도서관 정보나루
	 * @author YONGJU 2017. 12. 22.
	 * @param param
	 * @param mode
	 * @return
	 */
	public static Map<String, Object> sendData4Library(Map<String, Object> param, String mode) {

		BufferedReader br = null;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HttpURLConnection connection = null;
		try {
			String url = DATA_4_LIBRARY_API_URL + mode;
			List<String> paramList = new ArrayList<String>();
			param.put("authKey", DATA_4_LIBRARY_API_KEY);
			if (param != null) {
				Set<String> keys = param.keySet();
				for (String oneKey : keys) {
					if (oneKey.equals("authKey")) {
						paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
					} else {
						paramList.add(String.format("%s=%s", oneKey, URLEncoder.encode(String.valueOf(param.get(oneKey)), "UTF-8")));
					}
				}
			}
			connection = initConn(url + "?" + StringUtils.join(paramList, "&"));
			connection.setRequestMethod("GET");
			int responseCode = connection.getResponseCode();

			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			} else {  // 에러 발생
				br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			log.error("@@@@@@@@@@@@@@@@@@ DATA_4_LIBRARY_API : " + url + "?" + StringUtils.join(paramList, "&"));
			log.error("@@@@@@@@@@@@@@@@@@ DATA_4_LIBRARY_API RESULT : " + response.toString());
			resultMap = xmlToJson(response.toString()).toMap();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) {
					br.close();
				}
				if (connection != null) {
         			connection.disconnect();
         		}
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}
		return resultMap;

	}

	/**
	 * 대구 통합도서관 희망도서 바로대출 서비스 API
	 * @author HWAN 2022. 06. 22.
	 * @param requestName - 요청명
	 * @param param 파라미터
	 * @return
	 */
	public static Map<String, Object> libraryapi(String requestName, Map<String, Object> param) {
		HttpsURLConnection connection = null;
		Map<String, Object> resultMap = null;
		try {
			String apiUrl = LIBRARY_API_URL + requestName;
			connection = initHttpsConn(apiUrl);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(connection.getOutputStream(), "UTF-8"));

			if ( param != null ) {
				Set<String> keys = param.keySet();
				List<String> paramList = new ArrayList<String>();
				for ( String oneKey : keys ) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
				log.error("@@@@@@@@@@@@@@@@@@ LIBRARY_API_URL : " + apiUrl + "?" + StringUtils.join(paramList, "&"));

				writer.write(StringUtils.join(paramList, "&"));
			}

			writer.close();
			wr.close();
			wr.flush();

			String result = IOUtils.toString(connection.getInputStream(), "UTF-8").trim();
			ObjectMapper om = new ObjectMapper();
			resultMap = om.readValue(result, new TypeReference<Map<String, Object>>(){});
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 대구 사립도서관 KCMS API
	 * @author SUNGHWAN 2022. 11. 08.
	 * @param requestName - 요청명
	 * @param param 파라미터
	 * @return
	 */
	public static Map<String, Object> sendPrivateKCMS(String requestName, Map<String, Object> param) {
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = null;
		try {
			String apiUrl = KCMS_PRIVATE_API_URL + requestName;
			connection = initConn(apiUrl);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(wr, "UTF-8"));

			if ( param != null ) {
				Set<String> keys = param.keySet();
				List<String> paramList = new ArrayList<String>();
				for ( String oneKey : keys ) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
				log.error("@@@@@@@@@@@@@@@@@@ KCMS_PRIVATE_API_URL : " + apiUrl + "?" + StringUtils.join(paramList, "&"));

				writer.write(StringUtils.join(paramList, "&"));
			}

			writer.close();
			wr.close();
			wr.flush();

			String result = IOUtils.toString(connection.getInputStream(), "UTF-8").trim();
			ObjectMapper om = new ObjectMapper();
			resultMap = om.readValue(result, new TypeReference<Map<String, Object>>(){});
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * 대구 사립도서관 KCMS API
	 * @author SUNGHWAN 2022. 11. 08.
	 * @param requestName - 요청명
	 * @param param 파라미터
	 * @return
	 */
	public static Map<String, Object> sendPrivateMARC(String requestName, Map<String, Object> param) {
		HttpURLConnection connection = null;
		Map<String, Object> resultMap = null;
		try {
			String apiUrl = KCMS_PRIVATE_API_URL + requestName;
			connection = initConn(apiUrl);

			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(wr, "UTF-8"));
			
			if ( param != null ) {
				Set<String> keys = param.keySet();
				List<String> paramList = new ArrayList<String>();
				for ( String oneKey : keys ) {
					paramList.add(String.format("%s=%s", oneKey, param.get(oneKey)));
				}
				log.error("@@@@@@@@@@@@@@@@@@ KCMS_PRIVATE_API_URL : " + apiUrl + "?" + StringUtils.join(paramList, "&"));

				writer.write(StringUtils.join(paramList, "&"));
			}

			writer.close();
			wr.close();
			wr.flush();

			String result = IOUtils.toString(connection.getInputStream(), "UTF-8").trim();
			result = result.replace("&", "&amp;");
			
			resultMap = xmlToJson(result).toMap();
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return resultMap;
	}
}
