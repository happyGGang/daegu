<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<tiles:insertAttribute name="header" />

<style>
	body, html {
		margin: 0;
		padding: 0;
		height: 100%;
	}

	.center-wrap {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		flex-direction: column;
		text-align: center;
	}

	.center-wrap img {
		max-width: 500px;
		height: auto;
		margin-bottom: 20px;
	}
</style>

<div class="center-wrap">
	<img src="/resources/common/img/comming_soon.jpg" alt="홈페이지 준비중" />
</div>

</body>
</html>
