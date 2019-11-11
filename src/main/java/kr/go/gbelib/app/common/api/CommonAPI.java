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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

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
	public final static String NAVER_LIST_API_URL = "https://openapi.naver.com/v1/search/book.xml";
	public final static String NAVER_DETAIL_API_URL = "https://openapi.naver.com/v1/search/book_adv.xml";

	public final static String KCMS_API_URL = ResourceBundle.getBundle("api").getString("kcms.api.url");
	public final static String SANGHO_API_URL = ResourceBundle.getBundle("api").getString("sangho.api.url");


	public static HttpURLConnection initConn(String urlStr) throws Exception {
		URL url = new URL(urlStr);

		HttpURLConnection connection = null;
		connection = (HttpURLConnection) url.openConnection();
		connection.setRequestProperty("Accept-Charset", "UTF-8");
		connection.setRequestProperty("Accept-Language", "utf-8,ko;q=0.8,en-us;q=0.5,en;q=0.3");
		connection.setDoOutput(true);
		return connection;
	}

	/**
	 * 인천 통합도서관 KCMS API
	 * @author YONGJU 2017. 12. 13.
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
				log.debug("@@@@@@@@@@@@@@@@@@ KCMS_API_URL : " + apiUrl + "?" + StringUtils.join(paramList, "&"));
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
			log.debug("@@@@@@@@@@@@@@@@@@ SANGHO API : " + url + "?" + StringUtils.join(paramList, "&"));
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
				log.debug("@@@@@@@@@@@@@@@@@@ ILUS API : " + ILUS_API_URL + "?" + StringUtils.join(postParams, "&"));
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

		log.debug("@@@@@@@@@@@@@@@@@@ ILUS API TIME : " + (end-start)/1000.0);

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
				log.debug("@@@@@@@@@@@@@@@@@@ LIBONE API : " + LIBONE_API_URL + "?" + StringUtils.join(paramList, "&"));
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

		log.debug("@@@@@@@@@@@@@@@@@@ LIBONE API TIME : " + (end-start)/1000.0);

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
				log.debug("@@@@@@@@@@@@@@@@@@ LIBONE API 2 : " + LIBONE_API_URL + "?" + StringUtils.join(postParams, "&"));
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
		return sendNAVER(param, mode, null);
	}

	public static Map<String, Object> sendNAVER(Map<String, Object> param, String mode, String libCode) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HttpURLConnection connection = null;
		String clientId = "TOqdlc19MURV_gFfLqbo";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "uYJq9oAl32";// 애플리케이션 클라이언트 시크릿값";
		if (StringUtils.isNotEmpty(libCode)) {
			clientId = "G89PYX54Bu3ztIwNpasJ";// 애플리케이션 클라이언트 아이디값";--정보센터
			clientSecret = "HC3Xprd_vh";// 애플리케이션 클라이언트 시크릿값";--정보센터
		}
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
				br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			log.debug("@@@@@@@@@@@@@@@@@@ NAVER API : " + url + "?" + StringUtils.join(paramList, "&"));
			resultMap = xmlToJson(response.toString()).toMap();;
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

}
