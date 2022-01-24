<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#accessHistory'));
		doGetLoad('index.do', param);
		e.preventDefault();
	});

	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('form#accessHistory'));
		doGetLoad('index.do', param);
	});

	$('input#search_text_board').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#accessHistory'));
			doGetLoad('index.do', param);
		}
	});
});

</script>

<c:if test="${homepage.context_path eq 'dongbu'}">
<div class="summaryDesc">
  <div class="innerBox">
    <div class="img ticon_01"></div>
    <div class="desc">
      <h3>올해의 한책</h3>
      <p>지역 주민 모두가 한 권의 책을 함께 읽고 토론함으로써, 책과 책읽기에 대한 관심과 흥미를 불러   일으키고, 책과 문화를 통한 다양한 계층의 주민들이 함께 공감하고 화합하여 지역사회 통합에   기여하고자 하는 풀뿌리 독서운동입니다.</p>
    </div>
  </div>
</div>
<h3>배경</h3>
<div class="txt-box">
  <p>‘대구시립도서관 한 책 읽기’의 전신인 '한 도시 한 책 읽기’는 1998년 미국 시애틀에서 시작됐다. 당시 미국 시애틀 공공도서관의 Washington Center fot the Book이 ‘만약 온 시애틀이 같은 책을 읽는다면’이라는 프로젝트명으로 이 운동을 펼칠 때는 문자문명의 재정립을 도모하고 토론문화를 통한 성숙한 시민사회를 만들고자 시작되었다. 곧 이 운동은 2001년 시카고 등 미국 전역에 확산되었으며, 영국 브리스톨을 비롯하여 캐나다 등 영미권 나라를 중심으로 급속히 확산되고 있다.
    이 운동이 우리나라에 도입된 것은 2003년으로, 서산시와 순천시의 시범사업이 진행되었고 이듬해부터 부산, 서울, 원주, 익산 등으로 점차 확산되었다. 대구는 2008년 ‘한 도시 한 책 읽기’사업을 시작하여 총 10권의 대구의 책을 선정하였으며, 2017년부터 ‘한 도서관 한 책 읽기’로 전환하였다가 2018년부터 “대구시립도서관 한 책 읽기‘로 독서운동을 전개하고 있다. </p>
</div>
</c:if>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<c:forEach items="${boyList}" var="i" varStatus="status">
<div class="book-wr mg20t">
    <div class="book-box">
      <div class="book-thum"><span class="img"> <img alt="" src="${i.book_img_url}"> </span> </div>
      <div class="book-cont">
        <h3 class="byear">${i.selection_year}년 선정도서</h3>
        <p class="btit">${i.book_name}</p>
        <p class="bname">저자명 : ${i.book_author}｜출판사 : ${i.book_publisher}｜출판년도 : ${i.book_year}</p>
        <p class="btxt">
        	<c:set value="${fn:replace(i.book_content, crlf, '<br/>')}" var="content"></c:set>
			${content}
        </p>
      </div>
    </div>
  </div>
</c:forEach>


<c:if test="${homepage.context_path eq 'dongbu'}">
<h3>문의</h3>
<ul class="con">
  <li>독서문화과(☎231-2043) </li>
</ul>
</c:if>