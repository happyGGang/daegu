<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>


		<div class="info">
			<div class="section">
				<ul>
					<li><a href="/${homepage.context_path}/html.do?menu_idx=166" target="_blank">대구광역시통합도서관</a></li>
					<li><a href="http://www.nl.go.kr/nl/" title="국립중앙도서관 바로가기(새창열림)" target="_blank">국립중앙도서관</a></li>
					<li><a href="https://www.nanet.go.kr/main.do" title="국립중앙도서관 바로가기(새창열림)" target="_blank">국회도서관</a></li>
					<li><a href="http://www.dlibrary.go.kr" title="국립중앙도서관 바로가기(새창열림)" target="_blank">국가전자도서관</a></li>
				</ul>
			</div>
		</div>

		<div class="section address">
			<div class="site_address">
				<address>
					<p>
						<em>주소 : (41939) 대구광역시 중구 공평로 10길 25 (동인동 2가)</em><Br class="mobile-view" />
						<em>전화번호 : 053)231-2038  I  팩스 : 053)231-9973</em>
					</p>
					
				</address>
			</div>

			<div class="site_link">
				<select id="recommendSite1" class="recommendSite1">
					<option value="">대구통합공공도서관</option>
					<option value="http://library.daegu.go.kr/dgportal/index.do" label="통합도서관"></option>
					<option value="http://library.daegu.go.kr/elib/index.do" label="전자도서관"></option>
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

