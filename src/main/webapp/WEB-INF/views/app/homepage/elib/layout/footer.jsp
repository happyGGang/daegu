<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>


		<div class="info">
			<div class="section">
				<div class="left-link">
					<ul>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=166">행정서비스헌장</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=167">이메일무단수집거부</a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=168"><b>개인정보처리방침</b></a></li>
						<li><a href="/${homepage.context_path}/html.do?menu_idx=164">영상정보처리기기</a></li>
					</ul>
				</div>

				<div class="right-location">
					<select id="recommendSite1" class="recommendSite1">
						<option value="">유관기관</option>
						<option value="http://lib.sen.go.kr" label="통합도서관"></option>
						<option value="http://e-lib.sen.go.kr" label="전자도서관"></option>
					</select>

					<select id="recommendSite2" class="recommendSite2">
						<option value="">부산지역 도서관</option>
						<option value="http://lib.sen.go.kr" label="통합도서관"></option>
						<option value="http://e-lib.sen.go.kr" label="전자도서관"></option>
					</select>
				</div>
			</div>
		</div>

		<div class="section address">
			<div class="site_address">
				<address>
					<p>
						<em>(우 38637) 경북 경산시 원효로 60 (계양동, 경상북도교육청정보센터)</em><Br class="mobile-view" />
						<em>전화 053-810-9923</em>
						<em>팩스 053-810-9940</em>
					</p>
					<span>Copyright &copy; by Gyeongsangbuk-do office education Digital Library, All rights reserved.</span>
				</address>
			</div>

			<div class="site_sns">
				<ul>
					<li><a href="javascript:alert('준비중입니다.');"><img src="/resources/homepage/${homepage.context_path}/img/facebook-btn.png" alt="페이스북"></a></li>
					<li><a href="javascript:alert('준비중입니다.');"><img src="/resources/homepage/${homepage.context_path}/img/twitter-btn.png" alt="트위터"></a></li>
				</ul>
			</div>

			<div style="clear:both"></div>
		</div>

		<div class="home-up">
			<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
		</div>

