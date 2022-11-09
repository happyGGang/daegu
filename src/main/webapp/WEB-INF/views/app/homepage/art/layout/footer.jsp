<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<div class="mFooter">
		<div class="middle">
			<div class="main-section">
				<div class="scroll-x">
					<div class="info">
						<a href="/lib/html.do?menu_idx=76"><b>개인정보처리방침</b></a>
						<span class="barss">|</span>
						<a href="/lib/html.do?menu_idx=77">영상정보처리기기운영관리방침</a>
						<span class="barss">|</span>
						<a href="/lib/html.do?menu_idx=78">행정서비스헌장</a>
					</div>
				</div>

				<div class="address">
					<p>
						<em>(${homepage.zipcode}) ${homepage.address1}</em><br class="mobileBr"/>
						<em>전화 <b>${fn:split(homepage.homepage_tell,',')[0]}</b></em>
						<em>팩스 <b>${homepage.homepage_fax }</b></em>
					</p>
					<p class="copyright">Copyright 2022. DAEGUBRAILLELIBRARY All Rights Reserved.</p>
				</div>

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
							<li class="disabled"><a title="대구광역시립 남부도서관" href="http://library.daegu.go.kr/nambu/index.do">대구광역시립 남부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 달성도서관" href="http://library.daegu.go.kr/dalseong/index.do">대구광역시립 달성도서관</a></li>
							<li class="disabled"><a title="대구광역시립 동부도서관" href="http://library.daegu.go.kr/dongbu/index.do">대구광역시립 동부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 두류도서관" href="http://library.daegu.go.kr/duryu/index.do">대구광역시립 두류도서관</a></li>
							<li class="disabled"><a title="대구광역시립 북부도서관" href="http://library.daegu.go.kr/bukbu/index.do">대구광역시립 북부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 북부도서관" href="http://library.daegu.go.kr/seobu/index.do">대구광역시립 서부도서관</a></li>
							<li class="disabled"><a title="대구광역시립 수성도서관" href="http://library.daegu.go.kr/suseong/index.do">대구광역시립 수성도서관</a></li>
							<li class="disabled"><a title="대구광역시립 중앙도서관" href="http://library.daegu.go.kr/jungang/index.do">대구광역시립 중앙도서관</a></li>
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
						<a href="#" class="btn">이동</a>
					</div>
				</div>
			</div>
		</div>
		<div class="end"></div>
	</div>