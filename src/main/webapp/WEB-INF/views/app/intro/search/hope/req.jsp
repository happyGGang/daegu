<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<c:choose>
	<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
	<script type="text/javascript">
	$(function() {
		alert('죄송합니다. 비대면인증 회원은 서비스 이용이 불가능 하며 전자도서관만 이용가능 합니다.');
		location.href='/intro/${context_path}/index.do';
		return;
	});
	</script>
	</c:when>
	<c:otherwise>
	<script type="text/javascript">
	$(function() {
		<c:if test="${context_path eq 'beomeo'}">
			$("#manageCode").val("BD").prop("selected", true);
		</c:if>
		<c:if test="${context_path eq 'yonghak'}">
			$("#manageCode").val("BE").prop("selected", true);
		</c:if>
		<c:if test="${context_path eq 'gosan'}">
			$("#manageCode").val("BF").prop("selected", true);
		</c:if>
		<c:if test="${context_path eq 'bookforest'}">
			$("#manageCode").val("BJ").prop("selected", true);
		</c:if>
		<c:if test="${context_path eq 'mulmangi'}">
			$("#manageCode").val("BK").prop("selected", true);
		</c:if>
		<c:if test="${context_path eq 'padong'}">
			$("#manageCode").val("BG").prop("selected", true);
		</c:if>
		<c:if test="${context_path eq 'muhaksup'}">
			$("#manageCode").val("BH").prop("selected", true);
		</c:if>

		$('#save-btn').on('click', function(e) {
			
			<c:if test="${context_path eq 'bukgs' or context_path eq 'bukdh' or context_path eq 'buktj'}">
				var isbn = reqHopeForm.isbn.value;
				if (isbn == '') {
					alert('ISBN을 입력하세요.');
					$('input#isbn').focus();
					return false;
				}
			</c:if>

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
	</c:otherwise>
</c:choose>

<!-- contents-title-->
<div id="contents-title">
	<h2>희망도서신청<span style="font-weight:300">을 하고 싶으세요?</span></h2>
</div>
<!-- /contents-title-->

<!-- 
<div class="DepthBtn">
	<a href="/intro/${context_path}/search/hope/req.do" class="bBtn">희망도서신청</a>
	<a href="/intro/${context_path}/search/hope/index.do" class="bBtn">신청내역보기</a>
</div>
-->

<!-- 도서관 선택 분기처리 시작 -->
<c:choose>
<c:when test="${context_path eq 'bukgs'}">
<div class="hopeWarning" style="margin-bottom:20px;">
	<h3 style="font-weight:bold;font-size:15px;">※ 신청안내</h3>
	<div style="font-size:13px;">
		<b>- 신청방법 :</b> 도서관 홈페이지 로그인 후 신청 ※ 신청 시 기입한 휴대폰번호로 도착 알림문자 수신<br />
		<b>- 신청권수 :</b> 1인당 매월 2권 ※ 북구 구립도서관내에서 동일도서 중복 신청 불가<br />
		<b>- 신청기준</b><br />
		&nbsp;&nbsp;&nbsp;-> 1인 기준 1권당 50,000원 미만, 월 신청도서 정가의 합이 100,000원 미만<br />
		&nbsp;&nbsp;&nbsp;-> 신청일 기준 발행년도 제외 3년 이내 발간자료(2019~2022년)<br /><br />
	</div>
	<h3 style="font-weight:bold;font-size:15px;">※ 이용안내</h3>
	<div style="font-size:13px;">
		<b>- 이용방법</b><br />
		&nbsp;&nbsp;&nbsp;-> 희망도서 취소된 경우, 홈페이지 ‘나의도서관’에서 취소 사유 확인<br />
		&nbsp;&nbsp;&nbsp;-> 희망도서 선정되어 도착한 경우, 홈페이지 공지사항 게시 및 도착 알림문자 발송<br />
		&nbsp;&nbsp;&nbsp;-> 우선대출기간(5일, 휴관일 제외)내에 회원증 지참하여 대출<br />
		&nbsp;&nbsp;&nbsp;-> 희망도서 미대출 시 우선대출기간 다음날부터 1달간 희망도서 신청 제한<br />
		<b>- 처리기간 :</b> 근무일 기준 매월 1, 11, 21일에 이전 희망도서 신청 10일분을 취합하여 15일 이내 희망도서 비치함<br />
		&nbsp;&nbsp;&nbsp;※ 작은도서관 : 근무일 기준 매월 1, 16일에 이전 희망도서 신청 15일분 취합<br /><br />
	</div>
	<h3 style="font-weight:bold;font-size:15px;">※ 선정제외기준</h3>
	<div style="font-size:13px;">
		- 도서관운영본부 장서개발 계획(2021~2023)에 근거함<br />
		- 선정 제외 원칙<br /><br />
	</div>
	<table class="tbl-type01" summary="이 표는도서관운영본부 장서개발계획 원칙을 정리한 표입니다">
	<caption>
	도서관운영본부 장서개발계획 원칙
	</caption>
	<colgroup>
	<col width="30%" class="col1">
	<col width="70%" class="col2">
	</colgroup>
	<thead>
	  <tr>
		<th style="text-align:center;">구분</th>
		<th style="text-align:center;">세부지침</th>
	  </tr>
	</thead>
	<tbody>
	  <tr>
		<th style="text-align:center;">관내 소장 자료</th>
		<td>도서관 소장자료, 구입예정 및 정리 중인 자료<br>
		  (개정판이라도 내용변화가 미비하다고 판단될 시 구입 제외)</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">중복신청 자료</th>
		<td>희망도서 처리 기간 중 타 이용자와 중복 신청된 자료<br>
		  (신청일자순 반영)</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">서지사항 미비</th>
		<td>서지사항이 불분명한 도서(서명, 저자, 출판사, 출판년 등)</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">품절 및 절판</th>
		<td>품절 및 절판된 도서로 구입이 불가능한 자료</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">3년 이상된 자료</th>
		<td>발행 연도가 3년 이상된 자료(당해 연도 제외)</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">시리즈 및 전집류</th>
		<td>3권 이상의 시리즈 및 전집자료</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">개인학습자료</th>
		<td>참고서, 문제집,수험서,대학교재, 각종 시험대비 도서 등</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">미풍양속 저해</th>
		<td>유해자료 및 19세 이하 이용 불가능한 자료이거나 역사적 사실을 왜곡하는 자료</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">보존가치가 없는 자료</th>
		<td>판타지, 무협, 로맨스, 성인, 인터넷소설 등 단순 유흥적 자료<br>(교육만화,교양만화는 가능)</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">정치적 목적</th>
		<td>편향된 관점의 특정 종교 및 정치 도서</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">보존이 어려운 제본상태</th>
		<td>물리적 형태가 부적합한 자료<br>(포켓형,카드형,병풍형,스프링형,퍼즐북 등)</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">다중이용 불가자료</th>
		<td>다중이용이 곤란한 자료(스티커책, 워크북 등)</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">정기수서 자료</th>
		<td>국외도서,비도서(DVD,정기간행물</td>
	  </tr>
	  <tr>
		<th style="text-align:center;">자료선정기준 결격</th>
		<td>그 외 도서관의 장서로 부적합한 자료</td>
	  </tr>
	</tbody>
  </table>
</div>
</c:when>
<c:when test="${context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks'}">
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
<c:when test="${context_path eq 'padong'}">
	<div style='border:1px solid #ddd;box-sizing:border-box;border-radius:3px;padding:18px;margin-bottom:15px;text-align:center;color:blue;font-weight:bold;'>
		2022년 파동도서관 희망도서 신청은 예산 소진으로 종료합니다. 차후 재개시 안내드리겠습니다.
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
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<table class="edit">
		<tbody>
		<!-- 신청도서관 부분 추가 : 한개의 검색대에서 두개 이상의 도서관이 존재하여 신청 도서관을 선택해야하는 경우를 생각하여 CMS관리자에서 신청도서관 설정할수 있도록 하는게 맞을것 같음.  -->
		<tr>
			<th>신청도서관 <em><font color="red">(*)</font></em></th>
			<td>
				<c:choose>
				<c:when test="${context_path eq 'bukgs'}">
				<form:select path="manageCode">
					<form:option value="BA">구수산도서관</form:option>
					<!-- <form:option value="GP">노원동 작은도서관(폐관)</form:option> -->
					<form:option value="HD">노원행복도서관</form:option>
					<!-- <form:option value="GM">북구영어작은도서관</form:option> -->
					<!--<form:option value="GL">산격1동 작은도서관</form:option>-->
					<form:option value="HB">서변동작은도서관</form:option>
					<form:option value="GN">침산1동 작은도서관</form:option>
					<!-- <form:option value="GJ">태전1동 작은도서관</form:option>	 -->
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
					<!-- <form:option value="GM">북구영어작은도서관</form:option> -->
					<form:option value="GL">산격1동 작은도서관</form:option>
					<form:option value="HB">서변동작은도서관</form:option>
					<form:option value="GN">침산1동 작은도서관</form:option>
					<!-- <form:option value="GJ">태전1동 작은도서관</form:option>	 -->
					<form:option value="HE">한강공원부키도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>

				<c:when test="${context_path eq 'beomeo' || context_path eq 'yonghak' || context_path eq 'gosan' || context_path eq 'bookforest' || context_path eq 'mulmangi' || context_path eq 'padong' || context_path eq 'muhaksup' || context_path eq 'sawol'}">
				<form:select path="manageCode">
					<form:option value="BD">범어도서관</form:option>
					<form:option value="BE">용학도서관</form:option>
					<form:option value="BF">고산도서관</form:option>
					<form:option value="BJ">책숲길도서관</form:option>
					<form:option value="BK">물망이도서관</form:option>
					<form:option value="BG">파동도서관</form:option>
					<form:option value="BH">무학숲도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다. <!-- * 희망도서 신청이 마감되어 희망도서 신청을 중지합니다.-->
				</c:when>

				<c:when test="${context_path eq 'goldbook'}">
				<form:select path="manageCode">
					<form:option value="HR">황금책문화센터</form:option>
					<form:option value="BD">범어도서관</form:option>
					<form:option value="BE">용학도서관</form:option>
					<form:option value="BF">고산도서관</form:option>
					<form:option value="BJ">책숲길도서관</form:option>
					<form:option value="BK">물망이도서관</form:option>
					<form:option value="BG">파동도서관</form:option>
					<form:option value="BH">무학숲도서관</form:option>
				</form:select>
				</c:when>

				<c:when test="${context_path eq 'junggu'}">
				<form:select path="manageCode">
					<form:option value="FF">남산4동작은도서관</form:option>
					<form:option value="FQ">동인 느티나무 도서관</form:option>
					<form:option value="FS">대구중구영어도서관</form:option>
					<!-- <form:option value="FY">중구청교양정보실</form:option> -->
					<!-- <form:option value="GG">대신동작은도서관</form:option> -->
					<!-- <form:option value="HA">삼덕마루 작은도서관</form:option> -->
					<form:option value="HF">대봉2동작은도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				
				<c:when test="${context_path eq 'seogulib'}">
				<form:select path="manageCode">
					<form:option value="BL">서구어린이도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'bisan'}">
				<form:select path="manageCode">
					<form:option value="BQ">비산도서관</form:option>
				</form:select> 
				</c:when>
				<c:when test="${context_path eq 'seoguenglish'}">
				<form:select path="manageCode">
					<form:option value="BP">서구영어도서관</form:option>
				</form:select> 
				</c:when>
				<c:when test="${context_path eq 'biwon'}">
				<form:select path="manageCode">
					<form:option value="BM">비원도서관</form:option>
				</form:select> 
				</c:when>
				<c:when test="${context_path eq 'wongogae'}">
				<form:select path="manageCode">
					<form:option value="BN">원고개도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'seogumini'}">
				<form:select path="manageCode">
					<form:option value="FH">새마을문고대구서구지부작은도서관</form:option>
					<form:option value="FT">서구청 작은도서관</form:option>
					<form:option value="FU">내당4동어린이도서관</form:option>
					<form:option value="FZ">비산7동 작은도서관</form:option>
					<form:option value="GQ">내당2,3동 드림도서관</form:option>
					<form:option value="HC">달성토성마을 다락방 작은도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${context_path eq 'dalseonglib'}">
				<form:select path="manageCode">
					<form:option value="BR">달성군립도서관</form:option>
				</form:select><!--<span style="color:#ff0000"> * 2021년 희망도서 예산소진으로 인해서 희망도서 신청을 마감합니다. </span>-->
				</c:when>
				<c:when test="${context_path eq 'dalseongsmall'}">
				<form:select path="manageCode">
					<!-- <form:option value="GA">화원읍작은도서관</form:option>
					<form:option value="GB">논공읍작은도서관</form:option>
					<form:option value="GD">다사읍서재작은도서관</form:option>
					<form:option value="HG">다사읍작은도서관</form:option>
					<form:option value="GF">유가읍작은도서관</form:option>
					<form:option value="GH">옥포읍작은도서관</form:option>
					<form:option value="FR">가창면참꽃작은도서관</form:option>
					<form:option value="GE">하빈면작은도서관</form:option>
					<form:option value="GC">구지면작은도서관</form:option>
					<form:option value="FN">달성군청소년센터</form:option> -->
					<form:option value="FJ">달성군청도서관</form:option>
				</form:select> <span style="color:#ff0000">  * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.  <!-- * 달성군청도서관 외 희망도서 신청 마감합니다. --> </span>
				</c:when>
				<c:when test="${context_path eq 'namic'}">
				<form:select path="manageCode">
					<form:option value="BT">이천어울림도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'namdm'}">
				<form:select path="manageCode">
					<form:option value="BS">대명어울림도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dalseolib'}">
				<form:select path="manageCode">
					<!-- <form:option value="BW">도원도서관</form:option> -->
				</form:select><span style="color:#ff0000">  * 도원도서관 희망도서 신청 중지 </span>
				</c:when>
				<c:when test="${context_path eq 'kids'}">
				<form:select path="manageCode">
					<!-- <form:option value="BV">달서어린이</form:option> -->
				</form:select><span style="color:#ff0000">  * 달서어린이도서관 23.08.21 ~ 23.09.30 까지 희망도서 신청 중지 </span>
				</c:when>

				<c:when test="${context_path eq 'seongseo'}">
				<form:select path="manageCode">
					<%--<form:option value="BU">성서도서관</form:option>--%>
					<!--<option value="BU">성서도서관</option>-->
				</form:select><span style="color:#ff0000">  * 성서도서관 23.09.13 ~ 23.09.30 까지 희망도서 신청 중지 </span>
				</c:when>

				<c:when test="${context_path eq 'bolli'}">
				<form:select path="manageCode">
					<!-- <form:option value="BX">본리도서관</form:option> -->
				</form:select><span style="color:#ff0000">  * 본리도서관 희망도서 23.10.01. 오전 중 신청 재개 예정 입니다.</span>

				</c:when>
				<c:when test="${context_path eq 'family'}">
				<form:select path="manageCode">
					<form:option value="BY">달서가족문화도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'english'}">
				<form:select path="manageCode">
					<form:option value="BZ">달서영어도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dssmalllib'}">
				<form:select path="manageCode">
					<form:option value="FA">이곡2동공립작은도서관</form:option>
					<form:option value="FB">용산1동작은도서관</form:option>
					<form:option value="FC">장기동작은도서관</form:option>
					<form:option value="FD">죽전동공립작은도서관</form:option>
					<form:option value="FW">달서아트센터 도서관</form:option>
					<form:option value="FX">행정정보문고센터</form:option>
					<form:option value="GK">학산작은도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'donggu' || context_path eq 'donggusm'}">
				<form:select path="manageCode">
					<option value="CA">안심도서관</option>
					<option value="CB">신천도서관</option>
					<option value="GR">신암2동 작은도서관</option>
					<option value="GS">신암3동 작은도서관</option>
					<option value="GZ">동구청 작은도서관</option>
					<option value="GU">불로어울림 작은도서관</option>
					<option value="GV">지저동 작은도서관</option>
					<option value="FM">반야월역사 작은도서관</option>
					<option value="FL">도평동 작은도서관</option>
					<option value="GY">해안동 작은도서관</option>
					<option value="GX">방촌동 작은도서관</option>
					<option value="GW">동촌역사 작은도서관</option>
					<option value="GT">효목1동 작은도서관</option>
					<option value="FP">효목2동 작은도서관</option>
					<option value="FK">신천3동 작은도서관</option>
				</form:select><!-- <span style="color:#ff0000"> * 2022년 희망도서 예산소진으로 인해서 희망도서 신청을 마감합니다. </span> -->
				</c:when>
				<c:when test="${context_path eq 'sincheon'}">
				<!-- <select id="manageCode" name="manageCode"> -->
				<form:select path="manageCode">
					<option value="CB">신천도서관</option>
					<option value="CA">안심도서관</option>
					<option value="GR">신암2동 작은도서관</option>
					<option value="GS">신암3동 작은도서관</option>
					<option value="GZ">동구청 작은도서관</option>
					<option value="GU">불로어울림 작은도서관</option>
					<option value="GV">지저동 작은도서관</option>
					<option value="FM">반야월역사 작은도서관</option>
					<option value="FL">도평동 작은도서관</option>
					<option value="GY">해안동 작은도서관</option>
					<option value="GX">방촌동 작은도서관</option>
					<option value="GW">동촌역사 작은도서관</option>
					<option value="GT">효목1동 작은도서관</option>
					<option value="FP">효목2동 작은도서관</option>
					<option value="FK">신천3동 작은도서관</option>
				</form:select><!-- <span style="color:#ff0000"> * 2022년 희망도서 예산소진으로 인해서 희망도서 신청을 마감합니다. </span> -->
				<!-- </select> -->
				</c:when>
				<c:when test="${context_path eq 'jungang'}">
				<form:select path="manageCode">
					<form:option value="AD">중앙도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${context_path eq 'dongbu'}">
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
				<c:when test="${context_path eq 'gw'}">
				<form:select path="manageCode">
					<form:option value="AM">삼국유사군위도서관</form:option>
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
				<c:when test="${context_path eq 'wasabi'}">
				<form:select path="manageCode">
					<form:option value="NH">푸른초장공공도서관</form:option>
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
		<c:set var="readonly" value="${homepage.context_path eq 'bukgs' or homepage.context_path eq 'bukdh' or homepage.context_path eq 'buktj' or homepage.context_path eq 'gw' ? 'true' : 'false'}" />
		<tr>
			<th>제목 <em><font color="red">(*)</font></em></th>
			<td><form:input path="title" style="width:90%" class="text" type="text" readonly="${readonly}"/></td>
		</tr>
		<tr>
			<th>저자 <em><font color="red">(*)</font></em></th>
			<td><form:input path="author" style="width:90%" class="text" type="text" readonly="${readonly}"/></td>
		</tr>
		<tr>
			<th>출판사 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer" style="width:90%" class="text" type="text" readonly="${readonly}"/></td>
		</tr>
		<tr>
			<th>연도 <em><font color="red">(*)</font></em></th>
			<td><form:input path="publer_year" style="width:40%" class="text" type="text" numberOnly="true" maxlength="4" readonly="${readonly}"/></td>
		</tr>
		<tr>
			<th>ISBN<c:if test="${readonly}"><em><font color="red">(*)</font></em></c:if></th>
			<td><form:input path="isbn" style="width:40%" class="text" type="text" maxlength="13" readonly="${readonly}"/></td>
		</tr>
		<tr>
			<th>비고</th>
			<td><form:input path="recom_opinion" style="width:90%" class="text" type="text" maxlength="50"/></td>
		</tr>
		<tr>
			<th>가격 <em><font color="red">(*)</font></em></th>
			<td><form:input path="price" style="width:40%" class="text" type="text" maxlength="10" numberOnly="true" readonly="${readonly}"/></td>
		</tr>
		<c:if test="${context_path ne 'nambu' and context_path ne 'std' and context_path ne 'donggu' and context_path ne 'sincheon' and context_path ne 'donggusm'}">
		<tr>
			<th>우선대출예약여부</th>
			<td><form:checkbox path="reservation_yn" class="text" value="Y" checked="checked"/> <label for="reservation_yn1">우선대출을 원하실 경우 체크를 해주세요</label></td>
		</tr>
		</c:if>
		<c:if test="${context_path eq 'donggu' or context_path eq 'sincheon' or context_path eq 'donggusm'}">
		<tr>
			<th>우선대출예약여부</th>
			<td><b>신청자에게 1순위로 대출권한이 주어지며, 3일 이내에 대출해야 합니다.</b></td>
		</tr>
		</c:if>
	</tbody></table>
</form:form>

<div class="kbtn txt-center">
	<a id="save-btn" href="" class="btn btn5"><span>신청하기</span></a>
</div>

