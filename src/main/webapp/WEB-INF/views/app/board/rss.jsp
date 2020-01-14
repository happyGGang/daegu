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
	kr.co.whalesoft.app.board.BoardService service = ac.getBean(kr.co.whalesoft.app.board.BoardService.class);

	kr.co.whalesoft.app.cms.homepage.Homepage homepage = (kr.co.whalesoft.app.cms.homepage.Homepage) request.getAttribute("homepage");
	kr.co.whalesoft.app.board.Board board = new kr.co.whalesoft.app.board.Board();
	board.setHomepage_id(homepage.getHomepage_id());
	String manage_idx_list = StringUtils.defaultString(request.getParameter("manage_idx_list")).replaceAll("[^0-9,]", "");
	board.setBoardIdxArray(manage_idx_list.split(","));

	List<kr.co.whalesoft.app.board.Board> boardList = service.getBoardRSS(board);
	for(kr.co.whalesoft.app.board.Board one: boardList) {
		String content = one.getContent();
		if(StringUtils.isNotEmpty(content)) {
			one.setContent(content.replaceAll("src=\"/data/board", "src=\"http://library.daegu.go.kr/data/board"));
		}
	}
	pageContext.setAttribute("boardList", boardList);
%>
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom"
	>

	<channel>
		<title>${homepage.homepage_name}</title>
		<atom:link href="http://library.daegu.go.kr/${homepage.context_path}/board/rss.do?manage_idx_list=<%=manage_idx_list.replaceAll(",", "%2C")%>" rel="self" type="application/rss+xml" />
		<link>http://library.daegu.go.kr/${homepage.context_path}/index.do</link>
		<description>${homepage.homepage_name} 홈페이지</description>
		<language>ko-KR</language>
		<%--<lastBuildDate>Mon, 30 Sep 2002 11:00:00 GMT</lastBuildDate>--%>
		<c:forEach var="i" varStatus="status" items="${boardList}">
		<item>
			<title><![CDATA[${i.title}]]></title>
			<link><![CDATA[http://library.daegu.go.kr/${homepage.context_path}/board/view.do?manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&menu_idx=${i.menu_idx}]]></link>
			<pubDate><fmt:setLocale value="en_US" scope="session"/><fmt:formatDate value="${i.add_date}" pattern="EEE, dd MMM yyyy HH:mm:ss Z" /></pubDate>
			<dc:creator><![CDATA[${i.user_name}]]></dc:creator>
			<guid isPermaLink="false">${i.board_idx}</guid>
			<description><![CDATA[${i.content_summary}]]></description>
			<content:encoded><![CDATA[${i.content}]]></content:encoded>
		</item>
		</c:forEach>
	</channel>
</rss>