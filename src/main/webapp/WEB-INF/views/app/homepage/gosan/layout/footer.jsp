<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<div class="mFooter">
		<div class="top">
			<div class="sections-align">
				<div class="overflow-x">
					<div class="info">
						<a href=""><b>개인정보처리방침</b></a>
						<span class="bar">|</span>
						<a href="">영상정보처리방침</a>
						<span class="bar">|</span>
						<a href="">이용약관</a>
						<span class="bar">|</span>
						<a href="">도서관서비스헌장</a>
						<span class="bar">|</span>
						<a href="">저작권보호정책</a>
						<span class="bar">|</span>
						<a href="">뷰어다운로드</a>
						<span class="bar">|</span>
						<a href="">배너모음</a>
					</div>
				</div>


				<div class="site_link">
					<div>
						<!-- <homepageTag:siteLink homepageList="${homepageList}" defaultStr="대구광역시 공공도서관" notIncludeHomepageId="${homepage.homepage_id},h30,h31,h33"/> -->
						<div>
							<a class="fsite type1">
							<span class="f1">대구광역시 공공도서관</span>
							<span class="f2"><i></i></span></a>
							<ul style="display:none">
							<li class="disabled"><a href="#">대구광역시 공공도서관</a></li>
							<li class="disabled"><a title="대구광역시통합도서관" href="http://library.daegu.go.kr/dgportal/index.do">대구광역시통합도서관</a></li>
							<li class="disabled"><a title="대구2ㆍ28기념학생도서관" href="http://library.daegu.go.kr/228/index.do">대구2ㆍ28기념학생도서관</a></li>
							<li class="disabled"><a title="대구2ㆍ28민주운동기념회관" href="http://library.daegu.go.kr/228lib/index.do">대구2ㆍ28민주운동기념회관</a></li>
							<li class="disabled"><a title="대구광역시립 남부도서관" href="http://library.daegu.go.kr/nambu/index.do">대구광역시립 남부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 달성도서관" href="http://library.daegu.go.kr/dalseong/index.do">대구광역시립 달성도서관</a></li>
							<li class="disabled"><a title="대구광역시립 동부도서관" href="http://library.daegu.go.kr/dongbu/index.do">대구광역시립 동부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 두류도서관" href="http://library.daegu.go.kr/duryu/index.do">대구광역시립 두류도서관</a></li>
							<li class="disabled"><a title="대구광역시립 북부도서관" href="http://library.daegu.go.kr/bukbu/index.do">대구광역시립 북부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 서부도서관" href="http://library.daegu.go.kr/seobu/index.do">대구광역시립 서부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 수성도서관" href="http://library.daegu.go.kr/suseong/index.do">대구광역시립 수성도서관</a></li>

							<li class="disabled"><a title="동구 통합도서관" href="http://www.donggu-lib.kr/">동구 통합도서관</a></li>
							<li class="disabled"><a title="서구 통합도서관" href="http://lib.dgs.go.kr/main.do">서구 통합도서관</a></li>
							<li class="disabled"><a title="남구 통합도서관" href="http://lib.nam.daegu.kr/main.do">남구 통합도서관</a></li>
							<li class="disabled"><a title="북구 통합도서관" href="http://lib.hbcf.or.kr/intro/">북구 통합도서관</a></li>
							<li class="disabled"><a title="수성구 통합도서관" href="http://library.suseong.kr/">수성구 통합도서관</a></li>
							<li class="disabled"><a title="달서구 통합도서관" href="http://www.dalseolib.kr/main/">달서구 통합도서관</a></li>
							<li class="disabled"><a title="달성군 통합도서관" href="http://www.dalseonglib.kr/index.php">달성군 통합도서관</a></li>
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

		<div class="bottom">
			<div class="sections">
				<p>
					<em>(${homepage.zipcode}) ${homepage.address1}</em><br class="mobileBr"/>
					<em>전화 <b>${fn:split(homepage.homepage_tell,',')[0]}</b></em>
					<em>팩스 <b>${homepage.homepage_fax }</b></em>
				</p>
				<p class="copyright">Copyright ⓒ 수성구립 고산도서관. All rights reserved.</p>
				<p class="f_logo"><img src="/resources/homepage/${homepage.context_path}/img/footer_logo.png" alt="고산도서관"></p>
			</div>
		</div>

	</div>

	<div class="home-up">
		<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
	</div>
