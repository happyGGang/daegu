<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<div id="footer">
		<div class="top">
			<div class="section">
				<div class="foot-info">
					<div class="info">
						<a href="/${homepage.context_path}/html.do?menu_idx=75"><b>개인정보처리방침</b></a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=76">영상정보처리방침</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=78">도서관서비스헌장</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=79">저작권보호정책</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=80">뷰어다운로드</a>
					</div>
				</div>
			</div>
		</div>

		<div class="bottom">
			<div class="section" style="position:relative;">
				<address>
					<p>
						<em><b>안심도서관</b> : (41103) <br class="mobileBr"/>대구광역시 동구 금호강변로 360</em><br class="mobileBr"/><em>전화 : 053-980-2600</em><em>FAX : 053-961-2345</em><br/>
						<em><b>신천도서관</b> : (41269) <br class="mobileBr"/>대구광역시 동구 동부로6길 65</em><br class="mobileBr"/><em>전화 : 053-980-2600</em><em>FAX : 053-662-4015</em>
					</p>
					<span>Copyright ⓒ 동구통합도서관. All rights reserved.</span>
				</address>
				<div class="site_link">
					<div>
						<!-- <homepageTag:siteLink homepageList="${homepageList}" defaultStr="대구광역시 공공도서관" notIncludeHomepageId="${homepage.homepage_id},h30,h31,h33"/> -->
						<div>
							<a class="fsite type1">
							<span class="f1">대구광역시 공공도서관</span>
							<span class="f2"><i></i></span></a>
							<ul style="display:none">
							<li class="disabled"><a href="#">대구광역시 공공도서관</a></li>
							<li class="disabled"><a title="동구통합도서관" href="/donggu/index.do">동구통합도서관</a></li>
							<li class="disabled"><a title="서구통합도서관" href="/seogulib/index.do">서구통합도서관</a></li>
							<li class="disabled"><a title="남구이천어울림도서관" href="/namic/index.do">남구이천어울림도서관</a></li>
							<li class="disabled"><a title="남구대명어울림도서관" href="/namdm/index.do">남구대명어울림도서관</a></li>
							<li class="disabled"><a title="북구구수산도서관" href="/bukgs/index.do">북구구수산도서관</a></li>
							<li class="disabled"><a title="북구대현도서관" href="/bukdh/index.do">북구대현도서관</a></li>
							<li class="disabled"><a title="북구태전도서관" href="/buktj/index.do">북구태전도서관</a></li>
							<li class="disabled"><a title="중구통합도서관" href="/junggu/index.do">중구통합도서관</a></li>
							<li class="disabled"><a title="수성구범어도서관" href="/beomeo/index.do">수성구범어도서관</a></li>
							<li class="disabled"><a title="수성구용학도서관" href="/yonghak/index.do">수성구용학도서관</a></li>
							<li class="disabled"><a title="수성구고산도서관" href="/gosan/index.do">수성구고산도서관</a></li>
							<li class="disabled"><a title="달서구립도서관" href="/dalseolib/index.do">달서구립도서관</a></li>
							<li class="disabled"><a title="달성군립도서관" href="/dalseonglib/index.do">달성군립도서관</a></li>
							</ul>
						</div>
						<a href="#" class="btn">이동</a>
					</div>
					<div>
						<homepageTag:siteLink recommendSiteList="${recommendSiteList}" defaultStr="교육 및 지역관련기관"/>
					</div>
				</div>
			</div>
		</div>


		<div class="home-up">
			<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
		</div>

	</div>



</body>
</html>