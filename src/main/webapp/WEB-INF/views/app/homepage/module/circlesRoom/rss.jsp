<%@ page language="java" contentType="application/rss+xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%
	ApplicationContext ac = RequestContextUtils.getWebApplicationContext(request);
	kr.go.gbelib.app.cms.module.circlesRoom.CirclesRoomService service = ac.getBean(kr.go.gbelib.app.cms.module.circlesRoom.CirclesRoomService.class);

	kr.co.whalesoft.app.cms.homepage.Homepage homepage = (kr.co.whalesoft.app.cms.homepage.Homepage) request.getAttribute("homepage");
	kr.go.gbelib.app.cms.module.circlesRoom.CirclesRoom circlesRoom = new kr.go.gbelib.app.cms.module.circlesRoom.CirclesRoom();
	circlesRoom.setHomepage_id(homepage.getHomepage_id());
	circlesRoom.setCircles_div(request.getParameter("circles_div"));
	circlesRoom.setVisit_date(request.getParameter("visit_date"));
	
	List<kr.go.gbelib.app.cms.module.circlesRoom.CirclesRoom> circlesRoomList = service.getCirclesRoomRss(circlesRoom);
	
	kr.co.whalesoft.app.cms.menu.MenuService menuService = ac.getBean(kr.co.whalesoft.app.cms.menu.MenuService.class);
	int menu_idx = menuService.getMenuIdxByLinkUrl(new kr.co.whalesoft.app.cms.menu.Menu(homepage.getHomepage_id(), "/module/circlesRoom/rss.do"));

	pageContext.setAttribute("circlesRoomList", circlesRoomList);
	pageContext.setAttribute("menu_idx", menu_idx);
%>
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom"
	>

	<channel>
		<title>시설물예약현황</title>
		<link>https://library.busan.go.kr/${homepage.context_path}/module/circlesRoom/index.do?menu_idx=${menu_idx}</link>
		<description>시설물예약현황</description>
		<language>ko-KR</language>
		<%--<lastBuildDate>Mon, 30 Sep 2002 11:00:00 GMT</lastBuildDate>--%>
		<c:forEach var="i" varStatus="status" items="${circlesRoomList}">
		<item>
			<reqname>${i.user_name}</reqname>
			<requsernum>${i.visit_num}</requsernum>
			<reqtime>${i.visit_date}</reqtime>
		</item>
		</c:forEach>
	</channel>
</rss>