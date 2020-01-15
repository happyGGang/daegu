<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<div id="footer">
		<div class="top">
			<div class="section">
				<div class="info">
					<a href="/${homepage.context_path}/html.do?menu_idx=86"><b>개인정보처리방침</b></a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=88">영상정보처리방침</a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=90">도서관서비스헌장</a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=109">찾아오시는길</a>
				</div>
			</div>
		</div>

		<div class="bottom">
			<div class="section" style="position:relative;">
				<address>
					<p>
						<em>(${homepage.zipcode}) <br class="mobileBr"/>${homepage.address1}</em><br class="mobileBr"/>
						<em>전화 ${fn:split(homepage.homepage_tell,',')[0]}</em>
						<!--<em>/</em>
						<em>팩스 ${homepage.homepage_fax }</em> -->
					</p>
					<span>Copyright © 2020 DAEGU METROPOLITAN SEOBU LIBRARY, <br class="mobileBr"/>All rights reserved.</span>
				</address>
				<div class="site_link">
					<div>
						<homepageTag:siteLink homepageList="${homepageList}" defaultStr="대구광역시 공공도서관" notIncludeHomepageId="${homepage.homepage_id}"/>
					</div>
					<div>
						<homepageTag:siteLink recommendSiteList="${recommendSiteList}" defaultStr="교육및지역관련기관"/>
					</div>
				</div>
			</div>
		</div>

	</div>

	<div class="home-up">
		<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
	</div>

</body>
</html>