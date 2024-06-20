<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.net.URLDecoder"%>
<%--
    String redirectURL = request.getParameter("url") == null ? "" : request.getParameter("url");
	String decoded = URLDecoder.decode(redirectURL);
    response.sendRedirect(redirectURL);
--%>
<script>
location.href = decodeURIComponent('${fn:replace(fn:replace(param.url, '<', ''), '>', '')}');
</script>