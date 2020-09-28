<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
<!--
<script src="/resources/homepage/elib/js/moment.min.js"></script>
<script>

	var now = moment();
	var strTemp2 = "";

	//var now = moment().format('YYYYMMDDhhmmss');
	var d = new Date();

	var now =
	leadingZeros(d.getFullYear(), 4) + leadingZeros(d.getMonth() + 1, 2) + leadingZeros(d.getDate(), 2) + leadingZeros(d.getHours(), 2) + leadingZeros(d.getMinutes(), 2) + leadingZeros(d.getSeconds(), 2);
	//alert(now);
	var nowSec = now.substring(12,14);
	var strTemp1 = now.substring(2,12);

	var len = strTemp1.length;

	var i9 = 620 + parseInt(nowSec);

	var i;
	var j=0, k=1;
	for (i = 1; i <= len; i++){
		strTemp2 = strTemp1.substring(j++, k++) + strTemp2;

		if(i == 1)
		{
			strTemp2 = 310 + strTemp2;
		}
		if(i == 3)
		{
			strTemp2 = 580 + strTemp2;
		}
		if(i == 9)
		{
			strTemp2 = i9 + strTemp2;
		}
	}

	location.href = 'http://kiss.kstudy.com/?c_code='+strTemp2+'&code=0008';

	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();

		if (n.length < digits) 
		{
		for (i = 0; i < digits - n.length; i++)
		zero += '0';
		}
		return zero + n;
	 }

</script>
-->

<%!
	public String encription()
	{
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 

		String nowTime = sdf.format(new java.util.Date()); 
		String nowSec = nowTime.substring(12,14);
		String strTemp1 = nowTime.substring(2,12);
		
		int len = strTemp1.length();
		int j=0,k=1;

		String strTemp2="";
		int i9 = 620 +  Integer.parseInt(nowSec);


			for (int i=1;i<=len;i++){
			strTemp2 = strTemp1.substring(j++,k++) + strTemp2;
				if(i==1)
					strTemp2 = 310 + strTemp2;
				if(i==3)
					strTemp2 = 580 + strTemp2;		
				if(i==9)
					strTemp2 = i9 + strTemp2;	
			}
		String encription = strTemp2;
		return encription;
	}
%>
<script>
	location.href = 'http://kiss.kstudy.com/?c_code=<%=encription()%>&code=0008';
</script>
</c:when>
<c:otherwise>
<script>
	location.href = 'http://kiss.kstudy.com';
</script>
</c:otherwise>
</c:choose>