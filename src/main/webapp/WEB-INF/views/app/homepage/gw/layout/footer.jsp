<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
	<div id="footer">
		<div class="top-box">
			<div class="sections">
				<div class="info">
					<h3>${homepage.homepage_name}</h3>
					<address>
						<p>
							<em>(우 ${homepage.zipcode}) ${homepage.address1 }</em><br/>
							<em>전화 ${homepage.homepage_tell }</em><br class="mobile-view"/>
							<em>팩스 ${homepage.homepage_fax }</em>
						</p>
						<span>Copyright &copy; SAMGUKYUSA GUNWI <!--by ${homepage.homepage_eng_name}--> Library, All rights reserved.</span>
					</address>
				</div>
				<!-- <div class="info-right">
					<div class="site_link">
						<div class="sns title">SNS</div>
						<div class="sns">
							<a href="#"><img src="/resources/common/img/twitter-icon.png" onmouseover="this.src='/resources/common/img/twitter-icon-on.png'" onmouseout="this.src='/resources/common/img/twitter-icon.png'" alt="" target="_blank"/></a>
							<a href="#"><img src="/resources/common/img/facebook-icon.png" onmouseover="this.src='/resources/common/img/facebook-icon-on.png'" onmouseout="this.src='/resources/common/img/facebook-icon.png'" alt="" target="_blank"/></a>
							<a href="#"><img src="/resources/common/img/instagram-icon.png" onmouseover="this.src='/resources/common/img/instagram-icon-on.png'" onmouseout="this.src='/resources/common/img/instagram-icon.png'" alt="" target="_blank"/></a>
						</div>
					</div>
				</div> -->
			</div>
		</div>

		<div class="bottom-box">
			<div class="sections">
				<div class="">
					<div class="overflow-x">
					<div class="info">
						<!-- <a href="/${homepage.context_path}/html.do?menu_idx=194">도서관이용규정</a>
						<span class="txt-menu-bar"></span> -->
						<a href="/${homepage.context_path}/html.do?menu_idx=86">개인정보처리방침</a>
						<span class="txt-menu-bar"></span>
						<a href="/${homepage.context_path}/html.do?menu_idx=88">영상정보처리기기운영관리방침</a>
						<span class="txt-menu-bar"></span>
						<a href="/${homepage.context_path}/html.do?menu_idx=90">도서관서비스헌장</a>
						<span class="txt-menu-bar"></span>
						<a href="/${homepage.context_path}/html.do?menu_idx=232">찾아오시는길</a>
					</div>
					</div>

					<div class="info-right">
						<div class="site_link">
							<select name="select" id="library-location-select" title="새창열림">
								<option value="http://library.daegu.go.kr/dgportal/index.do">대구광역시통합도서관</option>
								<option value="http://library.daegu.go.kr/228/index.do">대구2ㆍ28기념학생도서관</option>
								<option value="http://library.daegu.go.kr/228lib/index.do">대구2ㆍ28민주운동기념회관</option>
								<option value="http://library.daegu.go.kr/gukbo/index.do">국채보상운동기념도서관</a></li>
								<option value="http://library.daegu.go.kr/nambu/index.do">남부도서관</a></li>
								<option value="http://library.daegu.go.kr/dalseong/index.do">달성도서관</a></li>
								<option value="http://library.daegu.go.kr/dongbu/index.do">동부도서관</a></li>
								<option value="http://library.daegu.go.kr/duryu/index.do">두류도서관</a></li>
								<option value="http://library.daegu.go.kr/bukbu/index.do">북부도서관</a></li>
								<option value="http://library.daegu.go.kr/gw/index.do">삼국유사군위도서관</a></li>
								<option value="http://library.daegu.go.kr/seobu/index.do">서부도서관</a></li>
								<option value="http://library.daegu.go.kr/suseong/index.do">수성도서관</a></li>
								<option value="http://library.daegu.go.kr/namdm/index.do">남구대명어울림도서관</option>
								<option value="http://library.daegu.go.kr/namic/index.do">남구이천어울림도서관</option>
								<option value="http://library.daegu.go.kr/dalseolib/index.do">달서구통합도서관</option>
								<option value="http://library.daegu.go.kr/dalseonglib/index.do">달성군립도서관</option>
								<option value="http://library.daegu.go.kr/donggu/index.do">동구통합도서관</option>
								<option value="http://library.daegu.go.kr/bukgs/index.do">북구구수산도서관</option>
								<option value="http://library.daegu.go.kr/bukdh/index.do">북구대현도서관</option>
								<option value="http://library.daegu.go.kr/buktj/index.do">북구태전도서관</option>
								<option value="http://library.daegu.go.kr/seogulib/index.do">서구통합도서관</option>
								<option value="http://library.daegu.go.kr/beomeo/index.do">수성구범어도서관</option>
								<option value="http://library.daegu.go.kr/yonghak/index.do">수성구용학도서관</option>
								<option value="http://library.daegu.go.kr/gosan/index.do">수성구고산도서관</option>
								<option value="http://library.daegu.go.kr/junggu/index.do">중구통합도서관</option>
								<option value="http://library.daegu.go.kr/center/index.do">대구혁신도시복합문화센터</option>
							</select>
							<a href="#move" class="sel-btn recommendSite11" title="새창열림">이동</a>
							<!-- <div>
								<homepageTag:siteLink homepageList="${homepageList}" width="200px" defaultStr="경상북도교육청 공공도서관" notIncludeHomepageId="c0,c1,h1,h30,h32,h27,h33,h34"/>
							</div> -->
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

