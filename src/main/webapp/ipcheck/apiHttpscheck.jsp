<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.net.ssl.HttpsURLConnection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%
try {
URL url = new URL("https://las.daegu.go.kr/baro/libraryapi/barodupbookfinfolist.do?lib_code=122004&isbn=9791191891096&search_type=equal");

HttpsURLConnection connection = null;
connection = (HttpsURLConnection) url.openConnection();
connection.setRequestProperty("Content-Type", "application/json; utf-8");
connection.setRequestProperty("Accept-Charset", "UTF-8");
connection.setRequestProperty("Accept-Language", "utf-8,ko;q=0.8,en-us;q=0.5,en;q=0.3");
connection.setRequestProperty("User-Agent", "Mozilla/5.0");
connection.setDoOutput(true);
connection.setConnectTimeout(10000);
connection.setReadTimeout(10000);

connection.setRequestMethod("GET");
int responseCode = connection.getResponseCode();

System.out.println("######################################################");
System.out.println("status code="+connection.getResponseCode());
System.out.println("content type="+connection.getContentType());
System.out.println("content length="+connection.getContentLength());
System.out.println("######################################################");

%>
<div align="left" style="font-size: 85px;">
<br/>
Status code : <%=connection.getResponseCode()%>
<br/>
Content type : <%=connection.getContentType()%>
ResponseMessage : <%=connection.getResponseMessage()%>
<br/>
Content length : <%=connection.getContentLength()%>
</div>
<%
}
catch ( Exception e ) {
	e.printStackTrace();
	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!에러 : " + e);
}
%>
</body>
</html>