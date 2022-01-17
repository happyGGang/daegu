<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="banner_list txt-box">
	<homepageTag:bannermap bannerList="${bannerList}"/>
</div>