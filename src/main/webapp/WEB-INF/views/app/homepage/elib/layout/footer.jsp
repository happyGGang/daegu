<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>


		<div class="info">
			<div class="section">
				<ul>
					<li><a href="http://library.daegu.go.kr/dgportal/index.do" title="대구광역시통합도서관 홈페이지 바로가기(새창열림)" target="_blank">대구광역시통합도서관</a></li>
					<li><a href="https://nl.go.kr/" title="국립중앙도서관 홈페이지 바로가기(새창열림)" target="_blank">국립중앙도서관</a></li>
					<li><a href="https://www.nanet.go.kr/main.do" title="국립중앙도서관 홈페이지 바로가기(새창열림)" target="_blank">국회도서관</a></li>
					<li><a href="http://www.dlibrary.go.kr" title="국립중앙도서관 홈페이지 바로가기(새창열림)" target="_blank">국가전자도서관</a></li>
				</ul>
			</div>
		</div>

		<div class="section address">
			<div class="site_address">
				<address>
					<p>
						<em>(${homepage.zipcode}) <br class="mobileBr"/>${homepage.address1}</em><br class="mobileBr"/>
						<em>전화번호 : 053)231-2038  I  팩스 : 053)256-9973</em>
					</p> 
					
				</address>
			</div>

			<div class="site_link">
				<select id="recommendSite1" class="recommendSite1">
					<option value="" style="color:#000;">대구광역시 공공도서관</option>
					<!--option value="http://library.daegu.go.kr/dgportal/index.do" style="color:#000;">대구광역시통합도서관</option-->
					<option value="http://library.daegu.go.kr/228/index.do" style="color:#000;">대구2·28기념학생도서관</option>
					<option value="http://library.daegu.go.kr/228lib/index.do" style="color:#000;">대구2·28민주운동기념회관</option>
					<option value="http://library.daegu.go.kr/nambu/index.do" style="color:#000;">대구광역시립 남부도서관</option>
					<option value="http://library.daegu.go.kr/dalseong/index.do" style="color:#000;">대구광역시립 달성도서관</option>
					<option value="http://library.daegu.go.kr/dongbu/index.do" style="color:#000;">대구광역시립 동부도서관</option>
					<option value="http://library.daegu.go.kr/duryu/index.do" style="color:#000;">대구광역시립 두류도서관</option>
					<option value="http://library.daegu.go.kr/bukbu/index.do" style="color:#000;">대구광역시립 북부도서관</option>
					<option value="http://library.daegu.go.kr/seobu/index.do" style="color:#000;">대구광역시립 서부도서관</option>
					<option value="http://library.daegu.go.kr/suseong/index.do" style="color:#000;">대구광역시립 수성도서관</option>
					<option value="http://library.daegu.go.kr/jungang/index.do" style="color:#000;">대구광역시립 중앙도서관</option>
					<option value="http://www.donggu-lib.kr/" style="color:#000;">동구 통합도서관</option>
					<option value="http://lib.dgs.go.kr/main.do" style="color:#000;">서구 통합도서관</option>
					<option value="http://lib.nam.daegu.kr/main.do" style="color:#000;">남구 통합도서관</option>
					<option value="http://lib.hbcf.or.kr/intro/" style="color:#000;">북구 통합도서관</option>
					<option value="http://library.suseong.kr/" style="color:#000;">수성구 통합도서관</option>
					<option value="http://www.dalseolib.kr/main/" style="color:#000;">달서구 통합도서관</option>
					<option value="http://www.dalseonglib.kr/index.php" style="color:#000;">달성군 통합도서관</option>
				</select>
			</div>

			<div style="clear:both"></div>
		</div>

		<div class="copyright">
			<span>Copyright © Daegu Electronic Library. All rights reserved.</span>
		</div>
		<div class="home-up">
			<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
		</div>

