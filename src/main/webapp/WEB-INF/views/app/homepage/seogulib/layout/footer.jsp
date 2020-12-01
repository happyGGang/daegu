<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<div id="footer">
		<div class="top">
			<div class="section">
				<div class="foot-info">
					<div class="info">
						<a href="html.do?menu_idx=75"><b>개인정보처리방침</b></a>
						<span class="bar">|</span>
						<a href="board/index.do?menu_idx=76&manage_idx=789">영상정보처리방침</a>
						<span class="bar">|</span>
						<a href="html.do?menu_idx=77">이용약관</a>
						<span class="bar">|</span>
						<a href="html.do?menu_idx=78">도서관서비스헌장</a>
						<span class="bar">|</span>
						<a href="html.do?menu_idx=79">저작권보호정책</a>
						<span class="bar">|</span>
						<a href="html.do?menu_idx=80">뷰어다운로드</a>
					</div>
				</div>
			</div>
		</div>

		<div class="bottom">
			<div class="section" style="position:relative;">
				<address>
					<p>
						<em><b>서구어린이도서관</b> : (41758) <br class="mobileBr"/>대구광역시 서구 문화로 123</em><br class="mobileBr"/><em>전화 : 053-663-3701</em><em>FAX : 053-663-3709</em><br/>
						<em><b>비산도서관</b> : (41809) <br class="mobileBr"/>대구광역시 서구 달서로 14길 13</em><br class="mobileBr"/><em>전화 : 053-663-3721</em><em>FAX : 053-663-3729</em><br/>
						<em><b>비원도서관</b> : (41718) <br class="mobileBr"/>대구광역시 서구 달서천로 61안길 10</em><br class="mobileBr"/><em>전화 : 053-663-3871</em><em>FAX : 053-663-3879</em><br/>
						<em><b>영어도서관</b> : (41842) <br class="mobileBr"/>대구광역시 서구 평리로35길 90-6</em><br class="mobileBr"/><em>전화 : 053-663-3861</em><em>FAX : 053-663-3869</em><br/>
						<em><b>원고개도서관</b> : (41743) <br class="mobileBr"/>대구광역시 서구 달서로 43길 12</em><br class="mobileBr"/><em>전화 : 053-663-3941</em><em>FAX : 053-663-3949</em>
					</p>
					<span>Copyright ⓒ 서구통합도서관. All rights reserved.</span>
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