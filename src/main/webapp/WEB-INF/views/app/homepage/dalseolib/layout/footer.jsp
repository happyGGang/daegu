<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<div id="foot">
		<div class="section">
			<div id="footer">
				<div class="bottom">
					<div class="section" style="position:relative;">	
						<div class="site_link">
							<div>
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
									<li class="disabled"><a title="서변숲도서관" href="https://library.daegu.go.kr/buksb/index.do">서변숲도서관</a></li>

									<!-- <li class="disabled"><a href="#">대구광역시 공공도서관</a></li> -->
									<li class="disabled"><a title="남구대명어울림도서관" href="http://library.daegu.go.kr/namdm/index.do">남구대명어울림도서관</a></li>
									<li class="disabled"><a title="남구이천어울림도서관" href="http://library.daegu.go.kr/namic/index.do">남구이천어울림도서관</a></li>
									<li class="disabled"><a title="달서구립도서관" href="http://library.daegu.go.kr/dalseolib/index.do">달서구통합도서관</a></li>
									<li class="disabled"><a title="달성군립도서관" href="http://library.daegu.go.kr/dalseonglib/index.do">달성군립도서관</a></li>
									<li class="disabled"><a title="대구혁신도시복합문화센터" href="http://library.daegu.go.kr/center/index.do">대구혁신도시복합문화센터</a></li>
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
							<!-- <div>
								<homepageTag:siteLink recommendSiteList="${recommendSiteList}" defaultStr="교육 및 지역관련기관"/>
							</div> -->
						</div>
					</div>
				</div>
			</div>

			<div class="wsize">
				<div class="addr">
					<ul>
						<li class="personinfo"><a href="/${homepage.context_path}/html.do?menu_idx=75">개인정보처리방침</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=76">영상정보처리방침</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=77">이용약관</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=78">도서관서비스헌장</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=79">저작권보호정책</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=80">뷰어다운로드</a></li>
					</ul>
				</div>
				<div class="addr_bottom">
					<p class="flogo"><img src="/resources/homepage/${homepage.context_path}/img/footer_logo.gif" alt="달서구립도서관"></p>
					<div class="addr_right">
						<dl>
							<dt>도원도서관</dt>
							<dd>
								<p class="address">
									<strong>주소</strong><span class="eng">(42833)</span> 대구광역시 달서구 한실로 <span class="eng">113</span> (도원동)
								</p>
								<p><strong>전화</strong><span class="eng">053-667-4840</span></p>
								<p><strong>팩스</strong><span class="eng">053-667-4849</span></p>
							</dd>
						</dl>
						<dl class="dl_fr">
							<dt>성서도서관</dt>
							<dd>
								<p class="address">
									<strong>주소</strong><span class="eng">(42615)</span> 대구광역시 달서구 선원남로 <span class="eng">129</span> (이곡동)
								</p>
								<p><strong>전화</strong><span class="eng">053-667-4900</span></p>
								<p><strong>팩스</strong><span class="eng">053-667-4909</span></p>
							</dd>
						</dl>
						<dl>
							<dt>본리도서관</dt>
							<dd>
								<p class="address">
									<strong>주소</strong><span class="eng">(42676)</span> 대구광역시 달서구 당산로 <span class="eng">37-25</span> (본리동)
								</p>
								<p><strong>전화</strong><span class="eng">053-667-4930</span></p>
								<p><strong>팩스</strong><span class="eng">053-667-4939</span></p>
							</dd>
						</dl>
						<dl class="dl_fr">
							<dt class="overaddrname"><span class="dal_fam">달서가족</span><br> 문화도서관</dt>
							<dd>
								<p class="address">
									<strong>주소</strong><span class="eng">(42760)</span> 대구광역시 달서구 조암남로 <span class="eng">137</span> (대천동)
								</p>
								<p><strong>전화</strong><span class="eng">053-667-4970</span></p>
								<p><strong>팩스</strong><span class="eng">053-667-4979</span></p>
							</dd>
						</dl>
						<dl>
							<dt class="overaddrname"><span class="dal_chi">달서</span><br>어린이도서관</dt>
							<dd>
								<p class="address">
									<strong>주소</strong><span class="eng">(42802)</span> 대구광역시 달서구 송현로 <span class="eng">45</span> (상인동)
								</p>
								<p><strong>전화</strong><span class="eng">053-667-4860</span></p>
								<p><strong>팩스</strong><span class="eng">053-667-4879</span></p>
							</dd>
						</dl>
						<dl class="dl_fr">
							<dt class="overaddrname"><span class="dal_eng">달서</span><br> 영어도서관</dt>
							<dd>
								<p class="address">
									<strong>주소</strong><span class="eng">(42818)</span> 대구광역시 달서구 중흥로 <span class="eng">6</span>길 <span class="eng">10</span> (송현동)
								</p>
								<p><strong>전화</strong><span class="eng">053-667-4950</span></p>
								<p><strong>팩스</strong><span class="eng">053-667-4949</span></p>
							</dd>
						</dl>
						
					</div>
				</div>

			</div>

			<p class="copy eng">Copyright ⓒ 달서구립도서관. All rights reserved.</p>
		</div>
	</div>

	<!--
		<div class="top">
			<div class="section">
				<div class="info">
					<a href="/${homepage.context_path}/html.do?menu_idx=86"><b>개인정보처리방침</b></a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/board/index.do?menu_idx=87&manage_idx=184">이전개인정보처리방침</a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=89">이용약관</a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=88">영상정보처리방침</a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=90">도서관서비스헌장</a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=91">저작권신고</a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=92">사이트맵</a>
					<span class="bar">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=94">성고충상담창구</a>
				</div>
			</div>
		</div>

		<div class="bottom">
			<div class="section" style="position:relative;">
				<address>
					<p>
						<em>(${homepage.zipcode}) <br class="mobileBr"/>${homepage.address1}</em><br class="mobileBr"/>
						<em>전화
						<b>${fn:split(homepage.homepage_tell,',')[0]}</b></em>
					</p>
					<span>Copyright © 2020 DAEGU METROPOLITAN JUNGANG LIBRARY, <br class="mobileBr"/>All rights reserved.</span>
				</address>
				<div class="site_link">
					<div>
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


		<div class="home-up">
			<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
		</div>

	</div>
	-->


