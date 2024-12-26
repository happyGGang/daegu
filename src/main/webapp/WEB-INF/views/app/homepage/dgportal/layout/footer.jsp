<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<div class="mFooter">
		<div class="middle">
			<div class="wide-1686-sections">
				<div class="info">
					<a href="http://www.daegu.go.kr/index.do?menu_id=00050250" target="_blank" title="개인정보처리방침 바로가기(새창열림)"><b>개인정보처리방침</b></a>
					<span class="barss">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=49">도서관서비스헌장</a>
					<span class="barss">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=52">저작권정책</a>
					<span class="barss">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=50">이메일무단수집거부</a>
					<span class="barss">|</span>
					<a href="/${homepage.context_path}/html.do?menu_idx=51">뷰어다운로드</a>
				</div>
			</div>
		</div>

		<div class="bottom">
			<div class="wide-1686-sections">
				<p>
					<em>(${homepage.zipcode}) ${homepage.address1}</em><br class="mobileBr"/>
					<!-- &nbsp;&nbsp;<em>전화 <b>${fn:split(homepage.homepage_tell,',')[0]}</b></em>
					&nbsp;&nbsp;<em>팩스 <b>${homepage.homepage_fax }</b></em> -->
					&nbsp;&nbsp;<a href="/${homepage.context_path}/html.do?menu_idx=79"> <em style="color:#fff">문의처확인</em></a>
				</p>
				<p class="copyright">Copyright ⓒ 대구통합도서관. All rights reserved.</p>

				<div class="site_link">
					<div>
						<div>
							<a class="fsite type1">
							<span class="f1">공립공공도서관</span>
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
					<div>
						<div>
							<a class="fsite type1">
							<span class="f1">사립공공·전문도서관</span>
							<span class="f2"><i></i></span></a>
							<ul style="display:none">
							<li class="disabled"><a title="꿈꾸는마을도서관도토리" href="https://library.daegu.go.kr/dotory/index.do">꿈꾸는마을도서관도토리</a></li>
							<li class="disabled"><a title="대구점자도서관" href="https://library.daegu.go.kr/daegubl/index.do">대구점자도서관</a></li>
							<li class="disabled"><a title="더불어숲도서관" href="https://library.daegu.go.kr/with/index.do">더불어숲도서관</a></li>
							<li class="disabled"><a title="동일도서관" href="https://library.daegu.go.kr/dongil/index.do">동일도서관</a></li>
							<li class="disabled"><a title="비전도서관" href="https://library.daegu.go.kr/vision/index.do">비전도서관</a></li>
							<li class="disabled"><a title="새벗도서관" href="https://library.daegu.go.kr/saebut/index.do">새벗도서관</a></li>
							<li class="disabled"><a title="아트도서관" href="https://library.daegu.go.kr/art/index.do">아트도서관</a></li>
							<li class="disabled"><a title="연암도서관" href="https://library.daegu.go.kr/yeonam/index.do">연암공공도서관</a></li>
							<li class="disabled"><a title="푸른초장공공도서관" href="https://library.daegu.go.kr/wasabi/index.do">푸른초장공공도서관</a></li>
							<li class="disabled"><a title="한들마을도서관" href="https://library.daegu.go.kr/handle/index.do">한들마을도서관</a></li>
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
		<div class="end"></div>
	</div>
