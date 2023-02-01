<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<div class="mFooter">
		<div class="middle">
			<div class="main-section">
				<div class="scroll-x">
					<div class="info">
						<a href="/${homepage.context_path}/html.do?menu_idx=67"><b>개인정보처리방침</b></a>
						<span class="barss">|</span>
						<a href="/${homepage.context_path}/html.do?menu_idx=69">저작권보호정책</a>
					</div>
				</div>

				<div class="address">
					<p>
						<em>(${homepage.zipcode}) ${homepage.address1}</em><br class="mobileBr"/>
						<em>전화 <b>${fn:split(homepage.homepage_tell,',')[0]}</b></em>
						<em>팩스 <b>${homepage.homepage_fax }</b></em>
					</p>
					<p class="copyright">Copyright 2022. 대구점자도서관 All Rights Reserved.</p>
				</div>

				<div class="site_link">
					<div>
						<div>
							<a class="fsite type1">
							<span class="f1">사립공공·전문도서관</span>
							<span class="f2"><i></i></span></a>
							<ul style="display:none">
							<li class="disabled"><a title="" href="">사립공공·전문도서관</a></li>
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
						</div>
						<a href="#" class="btn">이동</a>
					</div>
				</div>
			</div>
		</div>
		<div class="end"></div>
	</div>