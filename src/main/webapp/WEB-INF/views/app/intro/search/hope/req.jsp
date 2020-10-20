<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {

		if ($('input#price').val() != '') {
			var price = $('input#price').val();
			if (!parseInt(price)) {
				alert('가격은 숫자만 입력가능합니다.');
				$('input#price').focus();
				return false;
			}
			var isbn = $('input#isbn').val();
			if (isbn != '' && !parseInt(isbn)) {
				alert('ISBN은 숫자만 입력가능합니다.');
				$('input#isbn').focus();
				return false;
			}
		}

		if ( doAjaxPost($('#reqHopeForm')) ) {
			doGetLoad('index.do');
		}
		e.preventDefault();
	});

	doAjaxLoad('div#searchBox', 'search.do?manageCode=${context_path}');
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<!-- contents-title-->
<div id="contents-title">
	<h2>희망도서신청<span style="font-weight:300">을 하고 싶으세요?</span></h2>
</div>
<!-- /contents-title-->

<div class="DepthBtn">
	<a href="/intro/${context_path}/search/hope/req.do" class="bBtn">희망도서신청</a>
	<a href="/intro/${context_path}/search/hope/index.do" class="bBtn">신청내역보기</a>
</div>

<!-- 도서관 선택 분기처리 시작 -->
<c:choose>
<c:when test="${context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks'}">
<div class="hopeWarning" style="margin-bottom:20px;">
<h3 style="font-weight:bold;font-size:15px;">※ 이용안내</h3>
<div style="font-size:13px;">
· 신청방법 : 도서관 홈페이지 로그인 후 신청 ※ 신청 시 기입한 휴대폰번호로 도착알림문자 수신<br/>
· 신청권수 : 매월 2권(동일도서 신청불가)<br/>
· 신청기준 <br/>
&nbsp;&nbsp;&nbsp;→ 1인 권당 25,000원 이하, 월 신청도서 정가의 합이 40,000원 이하<br/>
&nbsp;&nbsp;&nbsp;→ 발행년도가 신청일 기준 3년(당해년도 제외) 이내 발간자료(2017~2019년) <br/>
&nbsp;&nbsp;&nbsp;* 단, 컴퓨터, 지리(여행), 과학분야는 2년 미만 자료<br/>
· 이용방법 : 홈페이지 공지사항 확인 및 희망도서 도착알림 문자 수신 후, 우선대출기간(5일, 휴관일 제외)내에 회원증 지참하여 대출 <br/>
&nbsp;&nbsp;&nbsp;* 미 대출 시 우선대출기간 다음날부터 10일간 희망도서 신청에서 제외<br/><br/><br/>
</div>

<h3 style="font-weight:bold;font-size:15px;">※ 선정제외기준</h3>

<div style="font-size:13px;">
· 도서관 소장자료, 구입예정 및 정리중인 자료, 품절 및 절판 자료, 희귀자료, 비매품 <br/>
&nbsp;&nbsp;&nbsp;* 개정판이라도 내용변화가 미비하다고 판단될 시 구입 제외<br/>
· 3권 이상의 시리즈 및 전집자료 <br/>
· 서지사항이 불분명한 경우(서명, 저자, 출판사, 출판년 등)<br/>
· 개인의 학습 목적인 자료(참고서, 문제집, 수험서, 수기서, 대학교재, 각종 시험 대비 도서 등)  <br/>
· 미풍양속을 저해하고 역사적 사실을 왜곡하는 자료 <br/>
· 판타지, 무협, 로맨스, 웹툰, 성인소설, 공포소설, 만화책 등 단순 유흥적 자료(교육만화, 교양만화는 가능)<br/>
· 편향된 관점의 특정 종교 및 정치 도서<br/>
· 물리적 형태가 부적합한 자료(포켓형, 카드형, 병풍형, 스프링형, 퍼즐북 등)<br/>
· 다중이용이 곤란한 자료(스티커책, 워크북 등)<br/>
· 국외도서, 비도서(DVD), 정기간행물<br/>
· 그 외 도서관의 장서로 부적합한 자료
</div>
</div>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
<!-- 도서관 선택 분기처리 끝 -->

<div id="searchBox">

</div>
<img id="refImg" src="/resources/common/img/noimg-gall.png" alt="refImg" style="display: none;">

<form:form id="reqHopeForm" modelAttribute="librarySearch" action="save.do" method="post">
	<form:hidden path="editMode" value="ADD"/>
	<table class="edit">
		<tbody>
		<!-- 신청도서관 부분 추가 : 한개의 검색대에서 두개 이상의 도서관이 존재하여 신청 도서관을 선택해야하는 경우를 생각하여 CMS관리자에서 신청도서관 설정할수 있도록 하는게 맞을것 같음.  -->
		<tr>
			<th>신청도서관 <em><font color="red">(*)</font></em></th>
			<td>
				<c:choose>
				<c:when test="${context_path eq 'beomeo'}">
				<form:select path="manageCode">
					<form:option value="BD">범어도서관</form:option>
				</form:select> 
				</c:when>
				<c:when test="${context_path eq 'yonghak'}">
				<form:select path="manageCode">
					<form:option value="BE">용학도서관</form:option>
				</form:select> 
				</c:when>
				<c:when test="${context_path eq 'gosan'}">
				<form:select path="manageCode">
					<form:option value="BF">고산도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'bookforest'}">
				<form:select path="manageCode">
					<form:option value="BJ">책숲길도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'mulmangi'}">
				<form:select path="manageCode">
					<form:option value="BK">물망이도서관</form:option>
				</form:select> 
				</c:when>
				<c:when test="${context_path eq 'padong'}">
				<form:select path="manageCode">
					<form:option value="BG">파동도서관</form:option>
				</form:select> 
				</c:when>
				<c:when test="${context_path eq 'muhaksup'}">
				<form:select path="manageCode">
					<form:option value="BH">무학숲도서관</form:option>
				</form:select> 
				</c:when>
				<c:when test="${context_path eq 'sawol'}">
				<form:select path="manageCode">
					<form:option value="FG">사월역작은도서관</form:option>
				</form:select>
				</c:when>




				<c:when test="${context_path eq 'bukgs'}">
				<form:select path="manageCode">
					<form:option value="BA">구수산도서관</form:option>
					<form:option value="GP">노원동 작은도서관</form:option>
					<form:option value="HD">노원행복도서관</form:option>
					<form:option value="GM">북구영어작은도서관</form:option>
					<form:option value="GL">산격1동 작은도서관</form:option>
					<form:option value="HB">서변동작은도서관</form:option>
					<form:option value="GN">침산1동 작은도서관</form:option>
					<form:option value="GJ">태전1동 작은도서관</form:option>	
					<form:option value="HE">한강공원부키도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${context_path eq 'bukdh'}">
				<form:select path="manageCode">
					<form:option value="BB">대현도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>

				<c:when test="${context_path eq 'buktj'}">
				<form:select path="manageCode">
					<form:option value="BC">태전도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>

				<c:when test="${context_path eq 'buks'}">
				<form:select path="manageCode">
					<form:option value="GP">노원동 작은도서관</form:option>
					<form:option value="HD">노원행복도서관</form:option>
					<form:option value="GM">북구영어작은도서관</form:option>
					<form:option value="GL">산격1동 작은도서관</form:option>
					<form:option value="HB">서변동작은도서관</form:option>
					<form:option value="GN">침산1동 작은도서관</form:option>
					<form:option value="GJ">태전1동 작은도서관</form:option>	
					<form:option value="HE">한강공원부키도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${context_path eq 'jungang'}">
				<form:select path="manageCode">
					<form:option value="AD">중앙도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dongdu'}">
				<form:select path="manageCode">
					<form:option value="AH">동부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'seobu'}">
				<form:select path="manageCode">
					<form:option value="AF">서부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'nambu'}">
				<form:select path="manageCode">
					<form:option value="AG">남부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'bukbu'}">
				<form:select path="manageCode">
					<form:option value="AC">북부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'duryu'}">
				<form:select path="manageCode">
					<form:option value="AB">두류도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq '228'}">
				<form:select path="manageCode">
					<form:option value="AA">228기념학생도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq '228lib'}">
				<form:select path="manageCode">
					<form:option value="AL">228민주운동</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'suseong'}">
				<form:select path="manageCode">
					<form:option value="AE">수성도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dalseong'}">
				<form:select path="manageCode">
					<form:option value="AJ">달성도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'std'}">
				<form:select path="manageCode">
					<form:option value="AK">대구학생문화센터</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dmsl'}">
				<form:select path="manageCode">
					<form:option value="FV">대구시청작은도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dgoti'}">
				<form:select path="manageCode">
					<form:option value="HH">공무원연수원</form:option>
				</form:select>
				</c:when>
				<c:otherwise>
				<form:select path="manageCode">
					<form:option value="AD">중앙도서관</form:option>
				</form:select>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<!-- 신청도서관 부분 추가 -->
		<tr>
			<th>제목 <em><font color="red">(*)</font></em></th>
			<td><form:input path="title" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>저자 <em><font color="red">(*)</font></em></th>
			<td><form:input path="author" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>출판사 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer" style="width:90%" class="text" type="text"/></td>
		</tr>
		<tr>
			<th>연도 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer_year" style="width:40%" class="text" type="text" numberOnly="true" maxlength="4"/></td>
		</tr>
		<tr>
			<th>ISBN</th>
			<td><form:input path="isbn" style="width:40%" class="text" type="text" maxlength="13"/></td>
		</tr>
		<tr>
			<th>비고</th>
			<td><form:input path="user_remark" style="width:90%" class="text" type="text" maxlength="50"/></td>
		</tr>
		<tr>
			<th>가격 <em><font color="red">(*)</font></em></th>
			<td><form:input path="price" style="width:40%" class="text" type="text" maxlength="10" numberOnly="true" /></td>
		</tr>
		<c:if test="${context_path ne 'nambu' and context_path ne 'std'}">
		<tr>
			<th>우선대출예약여부</th>
			<td><form:checkbox path="reservation_yn" class="text" value="Y" checked="checked"/> <label for="reservation_yn1">우선대출을 원하실 경우 체크를 해주세요</label></td>
		</tr>
		</c:if>
	</tbody></table>
</form:form>

<div class="kbtn txt-center">
	<a id="save-btn" href="" class="btn btn5"><span>신청하기</span></a>
</div>

