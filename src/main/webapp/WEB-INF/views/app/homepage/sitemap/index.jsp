<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>

<div class="sitemap">
<homepageTag:sitemap menuList="${menuTreeList}"/>
</div>