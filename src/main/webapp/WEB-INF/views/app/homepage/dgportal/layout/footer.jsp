<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<div id="footer">
		<div class="top">
			<div class="section">
				<div class="footer-logo">
					<img src="/resources/homepage/${homepage.context_path}/img/footer_logo.png" alt="대구광역시 통합도서관" />
				</div>
				<div class="site_link">
					<select id="recommendSite1" class="recommendSite1" style="color:#fff;">
						<option value="" style="color:#000;">대구통합공공도서관</option>
						<option value="http://library.daegu.go.kr/dgportal/index.do" label="통합도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/elib/index.do" label="전자도서관" style="color:#000;"></option>
					</select>

					<select id="recommendSite2" class="recommendSite2" style="color:#fff;">
						<option value="" style="color:#000;">관련사이트</option>
						<option value="http://library.daegu.go.kr/dgportal/index.do" label="통합도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/elib/index.do" label="전자도서관" style="color:#000;"></option>
					</select>
				</div>

				<div class="info-box">
					<div class="info">
						<a href="/${homepage.context_path}/html.do?menu_idx=46"><b>개인정보처리방침</b></a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=49">도서관서비스헌장</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=52">저작권정책</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=50">이메일무단수집거부</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=51">뷰어다운로드</a>
					</div>
				</div>
			</div>
		</div>

		<div class="bottom">
			<div class="section" style="position:relative;">
				<address>
					<p>
						<em>(${homepage.zipcode}) <br class="mobileBr"/>${homepage.address1}</em><br class="mobileBr"/>
						<em>전화 ${fn:split(homepage.homepage_tell,',')[0]}</em>
						<em>팩스 ${homepage.homepage_fax }</em>
					</p>
				</address>
			</div>
		</div>

		<div class="copyright">
			Copyright © 2020 DAEGU METROPOLITAN INTEGRATION LIBRARY, <br class="mobileBr"/>All rights reserved.
		</div>

		<div class="home-up">
			<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
		</div>

	</div>



</body>
</html>