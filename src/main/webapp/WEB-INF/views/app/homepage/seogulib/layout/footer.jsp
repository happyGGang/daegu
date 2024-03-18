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
						<a href="/${homepage.context_path}/board/index.do?menu_idx=76&manage_idx=789">영상정보처리방침</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=77">이용약관</a>
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
						<em><b>서구어린이도서관</b> : (41758) <br class="mobileBr"/>대구광역시 서구 문화로 123</em><br class="mobileBr"/><em>전화 : 053-663-3701</em><em>FAX : 053-663-3709</em><br/>
						<em><b>비산도서관</b> : (41809) <br class="mobileBr"/>대구광역시 서구 달서로 14길 13</em><br class="mobileBr"/><em>전화 : 053-663-3721</em><em>FAX : 053-663-3729</em><br/>
						<em><b>비원도서관</b> : (41718) <br class="mobileBr"/>대구광역시 서구 달서천로 61안길 10</em><br class="mobileBr"/><em>전화 : 053-663-3871</em><em>FAX : 053-663-3879</em><br/>
						<em><b>영어도서관</b> : (41842) <br class="mobileBr"/>대구광역시 서구 평리로35길 90-6</em><br class="mobileBr"/><em>전화 : 053-663-3861</em><em>FAX : 053-663-3869</em><br/>
						<em><b>원고개도서관</b> : (41743) <br class="mobileBr"/>대구광역시 서구 달서로 43길 12</em><br class="mobileBr"/><em>전화 : 053-663-3941</em><em>FAX : 053-663-3949</em><br/>
						<em><b>New평리도서관</b> : (41826) <br class="mobileBr"/>대구광역시 서구 평리로73길 37</em><br class="mobileBr"/><em>전화 : 053-663-3881</em><br/>
						<em style="font-size:90%;"><b>대구 서구청</b> : (41777) <br class="mobileBr"/>대구광역시 서구 국채보상로 257 (평리동)</em><br class="mobileBr"/><em style="font-size:90%;">사업자등록번호: 503-83-00220</em>
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
							<li class="disabled"><a title="대구광역시통합도서관" href="http://library.daegu.go.kr/dgportal/index.do">대구광역시통합도서관</a></li>
							<li class="disabled"><a title="대구2ㆍ28기념학생도서관" href="http://library.daegu.go.kr/228/index.do">대구2ㆍ28기념학생도서관</a></li>
							<li class="disabled"><a title="대구2ㆍ28민주운동기념회관" href="http://library.daegu.go.kr/228lib/index.do">대구2ㆍ28민주운동기념회관</a></li>
							<li class="disabled"><a title="국채보상운동기념도서관" href="https://library.daegu.go.kr/gukbo/index.do">국채보상운동기념도서관</a></li>
							<li class="disabled"><a title="남부도서관" href="http://library.daegu.go.kr/nambu/index.do">남부도서관</a></li>
							<li class="disabled"><a title="달성도서관" href="http://library.daegu.go.kr/dalseong/index.do">달성도서관</a></li>
							<li class="disabled"><a title="동부도서관" href="http://library.daegu.go.kr/dongbu/index.do">동부도서관</a></li>
							<li class="disabled"><a title="두류도서관" href="http://library.daegu.go.kr/duryu/index.do">두류도서관</a></li>
							<li class="disabled"><a title="북부도서관" href="http://library.daegu.go.kr/bukbu/index.do">북부도서관</a></li>
							<li class="disabled"><a title="삼국유사군위도서관" href="http://library.daegu.go.kr/gw/index.do">삼국유사군위도서관</a></li>
							<li class="disabled"><a title="북부도서관" href="http://library.daegu.go.kr/seobu/index.do">서부도서관</a></li>
							<li class="disabled"><a title="수성도서관" href="http://library.daegu.go.kr/suseong/index.do">수성도서관</a></li>

							<!-- <li class="disabled"><a href="#">대구광역시 공공도서관</a></li> -->
							<li class="disabled"><a title="남구대명어울림도서관" href="http://library.daegu.go.kr/namdm/index.do">남구대명어울림도서관</a></li>
							<li class="disabled"><a title="남구이천어울림도서관" href="http://library.daegu.go.kr/namic/index.do">남구이천어울림도서관</a></li>
							<li class="disabled"><a title="달서구립도서관" href="http://library.daegu.go.kr/dalseolib/index.do">달서구통합도서관</a></li>
							<li class="disabled"><a title="달성군립도서관" href="http://library.daegu.go.kr/dalseonglib/index.do">달성군립도서관</a></li>
							<li class="disabled"><a title="동구통합도서관" href="http://library.daegu.go.kr/donggu/index.do">동구통합도서관</a></li>
							<li class="disabled"><a title="북구구수산도서관" href="http://library.daegu.go.kr/bukgs/index.do">북구구수산도서관</a></li>
							<li class="disabled"><a title="북구대현도서관" href="http://library.daegu.go.kr/bukdh/index.do">북구대현도서관</a></li>
							<li class="disabled"><a title="북구태전도서관" href="http://library.daegu.go.kr/buktj/index.do">북구태전도서관</a></li>
							<li class="disabled"><a title="서구통합도서관" href="http://library.daegu.go.kr/seogulib/index.do">서구통합도서관</a></li>
							<li class="disabled"><a title="수성구범어도서관" href="http://library.daegu.go.kr/beomeo/index.do">수성구범어도서관</a></li>
							<li class="disabled"><a title="수성구용학도서관" href="http://library.daegu.go.kr/yonghak/index.do">수성구용학도서관</a></li>
							<li class="disabled"><a title="수성구고산도서관" href="http://library.daegu.go.kr/gosan/index.do">수성구고산도서관</a></li>
							<li class="disabled"><a title="중구통합도서관" href="http://library.daegu.go.kr/junggu/index.do">중구통합도서관</a></li>
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