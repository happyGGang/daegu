<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<div class="mFooter">
		<div class="top">
			<div class="main-section">
				<div class="overflow-x">
					<div class="info">
						<a href="/${homepage.context_path}/html.do?menu_idx=75"><b>개인정보처리방침</b></a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=76">영상정보처리방침</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=77">이용약관</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=78">도서관서비스헌장</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=79">저작권보호정책</a>
						<span class="bar">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=80">뷰어다운로드</a>
					</div>
				</div>

				<p class="homepage-name">${homepage.homepage_name}</p>
				<p>
					<em>(${homepage.zipcode}) ${homepage.address1}</em><br class="mobileBr"/>
					<em>전화 <b>${fn:split(homepage.homepage_tell,',')[0]}</b></em>
					<em>팩스 <b>${homepage.homepage_fax }</b></em>
				</p>
			</div>
		</div>

		<div class="bottom">
			<div class="main-section">
				<p class="copyright">Copyright © 2023 National Debt Compensation Movement Memorial Library. aLL RIGHTS RESERVED.</p>
				<div class="site_link">
					<div>
						<select name="select01" id="library-link" title="새창열림">
							<option value="http://library.daegu.go.kr/dgportal/index.do">대구광역시통합도서관</option>
							<option value="http://library.daegu.go.kr/228/index.do">대구2ㆍ28기념학생도서관</option>
							<option value="http://library.daegu.go.kr/228lib/index.do">대구2ㆍ28민주운동기념회관</option>
							<option value="http://library.daegu.go.kr/nambu/index.do">대구광역시립 남부도서관</option>
							<option value="http://library.daegu.go.kr/dalseong/index.do">대구광역시립 달성도서관</option>
							<option value="http://library.daegu.go.kr/dongbu/index.do">대구광역시립 동부도서관</option>
							<option value="http://library.daegu.go.kr/duryu/index.do">대구광역시립 두류도서관</option>
							<option value="http://library.daegu.go.kr/bukbu/index.do">대구광역시립 북부도서관</option>
							<option value="http://library.daegu.go.kr/seobu/index.do">대구광역시립 서부도서관</option>
							<option value="http://library.daegu.go.kr/suseong/index.do">대구광역시립 수성도서관</option>
							<option value="http://library.daegu.go.kr/jungang/index.do">대구광역시립 중앙도서관</option>
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
						</select>
						<a href="#" class="btn sel-btn" id="library-link-btn">이동</a>
					</div>
					<div>
						<select name="select02" id="organization-link" title="새창열림">
							<option value="#">교육 및 지역관련기관</option>
							<option value="http://www.dge.go.kr">대구광역시교육청</option>
							<option value="http://www.dgdbe.go.kr/dgdbe/main.do">동부교육지원청</option>
							<option value="http://www.dgsbe.go.kr">서부교육지원청</option>
							<option value="http://www.dgnbe.go.kr">남부교육지원청</option>
							<option value="http://www.dgdse.go.kr">달성교육지원청</option>
							<option value="http://edu.deti.or.kr">대구광역시교육연수원</option>
							<option value="http://www.dge.go.kr/dicce">대구창의융합교육원</option>
							<option value="http://www.dge.go.kr/dccs">대구학생문화센터</option>
							<option value="http://www.dge.go.kr/dferi">대구미래교육연구원</option>
							<option value="http://www.dge.go.kr/dgsea">대구교육해양수련원</option>
							<option value="http://www.dge.go.kr/daegu-i">대구광역시유아교육진흥원</option>
							<option value="http://www.dge.go.kr/dgeriver">대구교육낙동강수련원</option>
							<option value="http://www.dge.go.kr/palgongsan">대구교육팔공산수련원</option>
							<option value="http://www.dge.go.kr/dme">대구교육박물관</option>
							<option value="http://www.dge.go.kr/defsc">대구교육시설지원센터</option>
							<option value="https://tong.daegu.go.kr/">대구평생학습포털</option>
						</select>
						<a href="#" class="btn sel-btn" id="organization-link-btn">이동</a>
					</div>
				</div>
			</div>
		</div>

	</div>

	<div class="home-up">
		<img src="/resources/homepage/${homepage.context_path}/img/m-top-btn.png" alt="위로" id="homeup">
	</div>
