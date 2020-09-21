<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%

URL url = new URL("http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?Cover=Big&ItemIdType=ISBN13&optResult=toc&ItemId=9788983711892&ttbkey=ttbinmypart1853007");

HttpURLConnection connection = null;
connection = (HttpURLConnection) url.openConnection();
connection.setRequestProperty("Accept-Charset", "UTF-8");
connection.setRequestProperty("Accept-Language", "utf-8,ko;q=0.8,en-us;q=0.5,en;q=0.3");
connection.setDoOutput(true);
connection.setConnectTimeout(10000);
connection.setReadTimeout(10000);


connection.setRequestMethod("GET");
int responseCode = connection.getResponseCode();
BufferedReader br = null;
br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
String inputLine;
StringBuffer result = new StringBuffer();
while ((inputLine = br.readLine()) != null) {
	result.append(inputLine);
}

%>
ALADIN : <%=responseCode%>
<%
if (responseCode == 200) {
%>
<br/>
RESULT : <%=result.toString()%>
<%
}
%>
</body>
</html>