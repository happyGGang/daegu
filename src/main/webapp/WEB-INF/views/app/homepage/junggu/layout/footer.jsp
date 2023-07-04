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
						<a href="#" class="btn fsitebtn">이동</a>
					</div>
					<!-- <div>
						<homepageTag:siteLink recommendSiteList="${recommendSiteList}" defaultStr="교육 및 지역관련기관"/>
					</div> -->
				</div>

				<div class="top-info">
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
				<address>
					<p>
						<!--<em>(${homepage.zipcode}) <br class="mobileBr"/>${homepage.address1}</em><br class="mobileBr"/>
						<em>전화
							<b>${fn:split(homepage.homepage_tell,',')[0]}</b></em>
						<em>/</em>
						<em>팩스 <b>${homepage.homepage_fax }</b></em> -->
<!-- 하단정보 -->
						<div class="finfo">
							<ul>
								<li>
									<dl>
										<dt>중구영어도서관</dt>
										<dd>(41951)대구광역시 중구 달구벌대로 440길 27</dd>
										<dd class="tel">053-661-3960</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>동인 느티나무 도서관</dt>
										<dd>(41905)대구광역시 중구 동덕로 38길 47</dd>
										<dd class="tel">053-661-3325</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>중구청 교양정보실</dt>
										<dd>(41908)대구광역시 중구 국채보상로 139길 1</dd>
										<dd class="tel">053-661-3241</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>삼덕마루</dt>
										<dd>(41946)대구광역시 중구 동덕로 26길 103</dd>
										<dd class="tel">053-661-3603</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>대신동 작은도서관</dt>
										<dd>(41928)대구광역시 중구 큰장로 26안길 65</dd>
										<dd class="tel">053-661-3685</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>남산4동 작은도서관</dt>
										<dd>(41977)대구광역시 중구 남산로 1길 42</dd>
										<dd class="tel">053-661-3765</dd>
									</dl>
								</li>						
								<li>
									<dl>
										<dt>청소년문화의집 작은도서관</dt>
										<dd>(41959)대구광역시 중구 봉산문화길 40</dd>
										<dd class="tel">053-661-3278</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>중구노인복지관 작은도서관</dt>
										<dd>(41901)대구광역시 중구 태평로 45</dd>
										<dd class="tel">053-257-2577</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>대봉2동 작은도서관</dt>
										<dd>(41955)대구광역시 중구 대봉로 47길 31</dd>
										<dd class="tel">053-661-3800</dd>
									</dl>
								</li>
							</ul>
						</div>
						<!-- //하단정보 -->
					</p>
					<span>Copyright © 2020 DAEGU METROPOLITAN JUNGANG LIBRARY, <br class="mobileBr"/>All rights reserved.</span>
				</address>

			</div>
		</div>

		<div class="home-up">
			<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
		</div>
	</div>


