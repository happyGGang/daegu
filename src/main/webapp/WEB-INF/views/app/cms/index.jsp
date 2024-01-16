<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>통합도서관</title>

</head>

<script>
	function getCookie(cookieName) {
		let cookieData = document.cookie;
		let cookieValue = "";
		let start = cookieData.indexOf(cookieName);

		if (start !== -1) {
			start += cookieName.length;
			let end = cookieData.indexOf(";", start);
			if (end === -1) end = cookieData.length;
			cookieValue = cookieData.substring(start+1, end);
		}

		return cookieValue;
	}

	function makeUrl(){
		if (window.frames[1].location.href != 'about:blank') {

			let protocol = window.frames[1].location.protocol + '//';
			let host = window.frames[1].location.host;

			let href = window.frames[1].location.href

			href = href.replace(protocol, '');
			href = href.replace(host, '');

			document.cookie = 'url = ' + href;
		}
	}

	function url() {
		let url = getCookie('url');


		if (url == '' || url == 'about:blank') {
			// url = $('div.aside ul a[href*=cms]:first').attr('href');
			url = '/cms/homepage/index.do';
			<c:if test="${!authR}">
				<c:set var="loop_flag" value="false" />
				<c:forEach items="${adminMenuList}" var="i" varStatus="status">
					<c:if test="${not loop_flag }">
						<c:if test="${not empty i.menu_url}">
							url = '${i.menu_url}'
							<c:set var="loop_flag" value="true" />
						</c:if>
					</c:if>
				</c:forEach>
			</c:if>
		}
		// document.cookie = 'url = ' + url;

		if (url != 'about:blank') {
			window.frames[1].location.href = url;
			//container.location.href= url;
		}
	}
	window.onload = function () {
		url();
	};
</script>

<frameset cols="270,*" frameborder="0">

	<c:choose>
	<c:when test="${member.admin}">
	<frame src="aside.do" name="aside" id="aside"></frame>
    <frame src="" name="container" id="container" onLoad="makeUrl()"></frame>
	</c:when>
	
	
	<c:otherwise>
	<frame src="aside.do" name="aside" id="aside"></frame>
    <frame src="" name="container" onLoad="makeUrl()" id="container"></frame>
	</c:otherwise>
	
	
	</c:choose>

    
</frameset>

<body>
<noframes>이 브라우저는 frame을 지원하지 않습니다.</noframes>

</body>
</html> 