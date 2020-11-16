<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<div id="footer">

		<div class="bottom">
			<div class="section" style="position:relative;">
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
							<li class="disabled"><a title="시청작은도서관" href="/dmsl/index.do">시청작은도서관</a></li>
							</ul>
						</div>
						<a href="#" class="btn">이동</a>
					</div>
					<div>
						<homepageTag:siteLink recommendSiteList="${recommendSiteList}" defaultStr="교육 및 지역관련기관"/>
					</div>
				</div>
				<div class="foot-info">
					<div class="info">
						<a href=""><b>개인정보처리방침</b></a>
						<span class="bar">|</span>
						<a href="">이메일무단수집거부</a>
						<span class="bar">|</span>
						<a href="">이용약관</a>
						<span class="bar">|</span>
						<a href="">배너모음</a>
					</div>
				</div>
				<address>
					<p>
						<em>(${homepage.zipcode}) ${homepage.address1}</em><br class="mobileBr"/>
						<em>전화 : 
							<b>${homepage.homepage_tell}</b></em>
						<!--<em>/</em>
						<em>팩스 <b>${homepage.homepage_fax }</b></em> -->
					</p>
					<span>COPYRIGHT⒞ DAEGU METROPOLITAN SMALL LIBRARY.  <br class="mobileBr"/>ALL RIGHTS RESERVED.</span>
				</address>

			</div>
		</div>

		<div class="home-up">
			<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
		</div>
	</div>
