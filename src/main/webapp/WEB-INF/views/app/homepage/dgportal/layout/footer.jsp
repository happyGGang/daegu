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
					<div class="out">
						<div>
							<a class="fsite type1">
								<span class="f1">대구광역시 통합도서관</span>
							</a>
							<ul style="display:none">
							<li class="disabled"><a href="#">대구광역시 통합도서관</a></li>
							<li class="disabled"><a title="대구2ㆍ28기념학생도서관" href="http://library.daegu.go.kr/228/index.do">대구2ㆍ28기념학생도서관</a></li>
							<li class="disabled"><a title="대구2ㆍ28민주운동기념회관" href="http://library.daegu.go.kr/228lib/index.do">대구2ㆍ28민주운동기념회관</a></li>
							<li class="disabled"><a title="대구광역시립 남부도서관" href="http://library.daegu.go.kr/nambu/index.do">대구광역시립 남부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 달성도서관" href="http://library.daegu.go.kr/dalseong/index.do">대구광역시립 달성도서관</a></li>
							<li class="disabled"><a title="대구광역시립 동부도서관" href="http://library.daegu.go.kr/dongbu/index.do">대구광역시립 동부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 두류도서관" href="http://library.daegu.go.kr/duryu/index.do">대구광역시립 두류도서관</a></li>
							<li class="disabled"><a title="대구광역시립 북부도서관" href="http://library.daegu.go.kr/bukbu/index.do">대구광역시립 북부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 서부도서관" href="http://library.daegu.go.kr/seobu/index.do">대구광역시립 서부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 수성도서관" href="http://library.daegu.go.kr/suseong/index.do">대구광역시립 수성도서관</a></li>
							<li class="disabled"><a title="대구광역시립 중앙도서관" href="http://library.daegu.go.kr/jungang/index.do">대구광역시립 중앙도서관</a></li>
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

					<div class="out">
						<div>
							<a class="fsite type1">
								<span class="f1">교육 및 지역관련기관</span>
							</a>
							<ul style="display:none">
							<li class="disabled"><a href="#">교육 및 지역관련기관</a></li>
							<li class="disabled"><a title="대구평생학습포털" href="https://tong.daegu.go.kr/">대구평생학습포털</a></li>
							<li class="disabled"><a title="대구2ㆍ28기념학생도서관" href="http://www.nl.go.kr/nl/">국립중앙도서관</a></li>
							<li class="disabled"><a title="대구2ㆍ28민주운동기념회관" href="https://www.nanet.go.kr/main.do">국회도서관</a></li>
							<li class="disabled"><a title="대구광역시립 남부도서관" href="http://www.dlibrary.go.kr/JavaClient/jsp/ndli/index.jsp?LOGSTATUS=notok&NLSSOTOKEN=">국가전자도서관</a></li>
							<li class="disabled"><a title="대구광역시립 달성도서관" href="https://library.scourt.go.kr/main.jsp">법원도서관</a></li>
							<li class="disabled"><a title="대구광역시립 동부도서관" href="https://www.libsta.go.kr/">국가도서관통계시스템</a></li>
							<li class="disabled"><a title="한국도서관협회" href="https://www.kla.kr/jsp/main.do">한국도서관협회</a></li>
							<li class="disabled"><a title="문화체육관광부" href="https://www.mcst.go.kr/kor/main.jsp">문화체육관광부</a></li>
							<li class="disabled"><a title="공공데이터포털" href="https://www.data.go.kr/">공공데이터포털</a></li>
							<li class="disabled"><a title="대한민국정부포털" href="https://www.gov.kr/portal/main">대한민국정부포털</a></li>
							</ul>
						</div>
						<a href="#" class="btn">이동</a>
					</div>
					<!-- <select id="recommendSite1" class="recommendSite1" style="color:#fff;">
						<option value="" style="color:#000;">대구광역시립도서관</option>
						<option value="http://library.daegu.go.kr/228/index.do" label="대구2·28기념학생도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/228lib/index.do" label="대구2·28민주운동기념회관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/nambu/index.do" label="대구광역시립 남부도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/dalseong/index.do" label="대구광역시립 달성도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/dongbu/index.do" label="대구광역시립 동부도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/duryu/index.do" label="대구광역시립 두류도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/bukbu/index.do" label="대구광역시립 북부도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/seobu/index.do" label="대구광역시립 서부도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/suseong/index.do" label="대구광역시립 수성도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/jungang/index.do" label="대구광역시립 중앙도서관" style="color:#000;"></option>
						<option value="http://library.daegu.go.kr/dgportal/index.do" label="대구광역시립 통합도서관" style="color:#000;"></option>
					</select>

					<select id="recommendSite2" class="recommendSite2" style="color:#fff;">
						<option value="" style="color:#000;">관련사이트</option>
						<option value="http://www.nl.go.kr/nl/" label="국립중앙도서관" style="color:#000;"></option>
						<option value="https://www.nanet.go.kr/main.do" label="국회도서관" style="color:#000;"></option>
						<option value="http://www.dlibrary.go.kr/JavaClient/jsp/ndli/index.jsp?LOGSTATUS=notok&NLSSOTOKEN=" label="국가전자도서관" style="color:#000;"></option>
						<option value="https://library.scourt.go.kr/main.jsp" label="법원도서관" style="color:#000;"></option>
						<option value="https://www.libsta.go.kr/" label="국가도서관통계시스템" style="color:#000;"></option>
						<option value="https://www.kla.kr/jsp/main.do" label="한국도서관협회" style="color:#000;"></option>
						<option value="https://www.mcst.go.kr/kor/main.jsp" label="문화체육관광부" style="color:#000;"></option>
						<option value="https://www.data.go.kr/" label="공공데이터포털" style="color:#000;"></option>
						<option value="https://www.gov.kr/portal/main" label="대한민국정부포털" style="color:#000;"></option>
					</select> -->


				</div>

				<div class="info-box">
					<div class="info">
						<a href="http://www.daegu.go.kr/index.do?menu_id=00050250" target="_blank"><b>개인정보처리방침</b></a>
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
			Copyright © Daegu Metropolitan City Integration Library. <br class="mobileBr"/>All rights reserved.
		</div>

		<div class="home-up">
			<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
		</div>

	</div>



</body>
</html>