<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
	function moveToLibrary() {
		const librarySelect = document.getElementById("library");
		const selectedText = librarySelect.options[librarySelect.selectedIndex].text;
		const selectedValue = librarySelect.value;

		if (selectedText === "도서관 바로가기") {
			alert("도서관을 선택해주세요.");
			return;
		}

		if (selectedValue) {
			window.open(selectedValue, "_blank", "noopener,noreferrer");
		} else {
			alert("도서관을 선택해주세요.");
		}
	}
	function moveToOrgan() {
		const selectElement = document.getElementById("organ");
		const selectedText = selectElement.options[selectElement.selectedIndex].text;
		const selectedValue = selectElement.value;

		if (selectedText === "관련기관 바로가기") {
			alert("기관을 선택해주세요.");
			return;
		}

		if (selectedValue) {
			window.open(selectedValue, "_blank", "noopener,noreferrer");
		} else {
			alert("기관을 선택해주세요.");
		}
	}

</script>
<footer class="section fp-auto-height">
	<div class="footer">
		<div class="footer_content">
			<ul class="footer_link_list">
				<li onclick="window.open('https://www.dpfc.or.kr/sub.php?Page1=9&Page2=3')">개인정보처리방침</li>
				<li onclick="window.open('https://www.dpfc.or.kr/sub.php?Page1=9&Page2=4')">영상정보처리방침</li>
				<li onclick="window.open('https://www.dpfc.or.kr/sub.php?Page1=9&Page2=2')">이용약관</li>
				<li onclick="location.href='/${homepage.context_path}/sitemap/index.do?menu_idx=93'">사이트맵</li>
			</ul>
			<div class="detail_select_wrapper">
				<div class="site_detail">
					<div>대구혁신도시 복합문화센터 물빛서원</div>
					<div>(41067) 대구 동구 이노밸리로 180 &nbsp;&nbsp;<br/>TEL. 053-962-7600&nbsp;&nbsp;FAX. 053-962-7603</div>
					<div>
						Copyright ⓒ 대구혁신도시 복합문화센터 물빛서원.<br/>
						All rights reserved.
					</div>
				</div>
				<div class="select_wrapper">
					<div class="select">
						<label for="library">
							<select id="library">
								<option>도서관 바로가기</option>
								<option value="http://library.daegu.go.kr/dgportal/index.do">대구광역시통합도서관</option>
								<option value="http://library.daegu.go.kr/228/index.do">대구2ㆍ28기념학생도서관</option>
								<option value="http://library.daegu.go.kr/228lib/index.do">대구2ㆍ28민주운동기념회관</option>
								<option value="http://library.daegu.go.kr/gukbo/index.do">국채보상운동기념도서관</option>
								<option value="http://library.daegu.go.kr/nambu/index.do">남부도서관</option>
								<option value="http://library.daegu.go.kr/dalseong/index.do">달성도서관</option>
								<option value="http://library.daegu.go.kr/dongbu/index.do">동부도서관</option>
								<option value="http://library.daegu.go.kr/duryu/index.do">두류도서관</option>
								<option value="http://library.daegu.go.kr/bukbu/index.do">북부도서관</option>
								<option value="http://library.daegu.go.kr/gw/index.do">삼국유사군위도서관</option>
								<option value="http://library.daegu.go.kr/seobu/index.do">서부도서관</option>
								<option value="http://library.daegu.go.kr/suseong/index.do">수성도서관</option>
								<option value="http://library.daegu.go.kr/buksb/index.do">서변숲도서관</option>

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
						</label>
						<div onclick="moveToLibrary()">이동</div>
					</div>
					<div class="select">
						<label for="organ">
							<select id="organ">
								<option>관련기관 바로가기</option>
								<c:forEach items="${recommendSiteList}" var="i">
									<option value="${i.link_target}">${i.recommend_site_name}</option>
								</c:forEach>
							</select>
						</label>
						<div onclick="moveToOrgan()">이동</div>
					</div>
				</div>
			</div>
			<div class="scroll_top"></div>
		</div>
	</div>
</footer>
