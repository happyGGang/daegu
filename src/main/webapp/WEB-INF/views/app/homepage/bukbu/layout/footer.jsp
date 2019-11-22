<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>

	<div id="footer">
		<div class="section">
			<div class="info">
				<a href="/${homepage.context_path}/html.do?menu_idx=153"><b>개인정보처리방침</b></a>
				<span class="bar">/</span>
				<a href="/${homepage.context_path}/html.do?menu_idx=154">영상정보처리기기운영관리방침</a>
				<span class="bar">/</span>
				<a href="/${homepage.context_path}/html.do?menu_idx=155">도서관서비스헌장</a>
				<span class="bar">/</span>
				<a href="/${homepage.context_path}/html.do?menu_idx=156">찾아오시는길</a>
			</div>
			<address>
				<p>
					<em>(우 ${homepage.zipcode }) ${homepage.address1 }</em>
					<em>전화 ${homepage.homepage_tell }</em>
					<em>/</em>
					<em>팩스 ${homepage.homepage_fax }</em>
				</p>
				<span>Copyright &copy; by ${homepage.homepage_eng_name}, All rights reserved.</span>
			</address>
			<div class="site_link">
				<div>
					<homepageTag:siteLink homepageList="${homepageList}" width="160px" defaultStr="경상북도교육청 공공도서관" notIncludeHomepageId="h6"/>
<!-- 				</div> -->
				<div>
					<homepageTag:siteLink siteList="${siteList}" width="160px" defaultStr="교육및지역관련기관"/>
				</div>
			</div>
		</div>
	</div>

</body>
</html>