<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


	<div id="footer">
		<div class="top">
			<div class="section">
				<div class="info">
					<a href="/${homepage.context_path}/html.do?menu_idx=90">도서관서비스헌장</a>
					<span class="bar">|</span>

					<a href="/${homepage.context_path}/html.do?menu_idx=86"><b>개인정보처리방침</b></a>
					<span class="bar">|</span>

					<a href="/${homepage.context_path}/html.do?menu_idx=88">영상정보처리방침</a>
					<span class="bar">|</span>

					<a href="">저작권보호정책</a>
					<span class="bar">|</span>

					<a href="">뷰어다운로드</a>
				</div>
			</div>
		</div>

		<div class="bottom">
			<div class="section" style="position:relative;">
				<address>
					<!--<p>
						<em>(${homepage.zipcode}) <br class="mobileBr"/>${homepage.address1}</em><br class="mobileBr"/>
						<em>전화
							<b>${fn:split(homepage.homepage_tell,',')[0]}</b></em>
						<em>/</em>
						<em>팩스 <b>${homepage.homepage_fax }</b></em>
					</p>-->
                <div class="finfo">
							<ul>
								<li>
									<dl>
										<dt>서구어린이도서관</dt>
										<dd>(41758) 대구광역시 서구 문화로 123</dd>
										<dd class="tel">TEL: 053-663-3701</dd>
										<dd class="fax">FAX: 053-663-3709</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>비산도서관</dt>
										<dd>(41809) 대구광역시 서구 달서로 14길 13</dd>
										<dd class="tel">TEL: 053-663-3721</dd>
										<dd class="fax">FAX: 053-663-3729</dd>
									</dl>
								</li>
								<li>
						<dl>
										<dt>비원도서관</dt>
										<dd>(41718) 대구광역시 서구 달서천로 61안길 10</dd>
										<dd class="tel">TEL: 053-663-3871</dd>
										<dd class="fax">FAX: 053-663-3879</dd>
									</dl>
								</li>
								<li>
								<dl>
										<dt>영어도서관</dt>
										<dd>(41842) 대구광역시 서구 평리로35길 90-6</dd>
										<dd class="tel">TEL: 053-663-3861</dd>
										<dd class="fax">FAX: 053-663-3869</dd>
									</dl>
								</li>
								<li>
								<dl>
										<dt>원고개도서관</dt>
										<dd>(41743) 대구광역시 서구 달서로 43길 12</dd>
										<dd class="tel">TEL: 053-663-3941</dd>
										<dd class="fax">FAX: 053-663-3949</dd>
									</dl>
								</li>
							</ul>
						</div>
								<span>Copyright ⓒ 서구통합도서관. All rights reserved.</span>
                      </address>

				<div class="site_link">
					<div>
						<!-- <homepageTag:siteLink homepageList="${homepageList}" defaultStr="대구광역시 공공도서관" notIncludeHomepageId="${homepage.homepage_id},h30,h31,h33"/> -->
						<div>
							<a class="fsite type1">
							<span class="f1">관련사이트</span>
							<span class="f2" style="right:7px;"><i></i></span></a>
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
						<div class="br_none" style="width:52px !important;"><a href="#" class="btn fsitebtn">이동</a></div>
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