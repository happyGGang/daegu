<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<c:choose>
	<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
	<script type="text/javascript">
	$(function() {
		alert('비대면인증 회원은 서비스 이용이 불가능 하며 전자도서관만 이용가능 합니다.');
		location.href='/${homepage.context_path}/index.do';
		return;
	});
	</script>
	</c:when>
	<c:otherwise>
	<script type="text/javascript">
	$(function() {
		$('#save-btn').on('click', function(e) {
			e.preventDefault();

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

			if ($('select#manageCode option:selected').val() != '') {
				$('input[name="homepage_id"]').val($('select#manageCode option:selected').data('hid'));
			}


			doAjaxPost($('#reqHopeForm'));
		});

		$('#not-save-btn').on('click', function(e) {
			e.preventDefault();
			alert('2021년도 희망도서 신청이 마감되었습니다.'); return false;
		});

		doAjaxLoad('div#searchBox', 'search.do');
	});
	$(document).on("keyup", "input:text[numberOnly]", function() {
		$(this).val($(this).val().replace(/[^0-9]/gi, ""));
	});
	</script>
	</c:otherwise>
</c:choose>

<!-- contents-title-->
<c:choose>
<c:when test="${homepage.context_path eq 'bukgs' || homepage.context_path eq 'buktj' || homepage.context_path eq 'bukdh'}">
	<div style='border:1px solid #ddd;box-sizing:border-box;border-radius:3px;padding:18px;margin-bottom:15px;'>
		<ul>
			<li>※ 이미 신청 중이거나 소장중인 자료가 아닌 지 먼저 검색하세요</li>
			<li>※ (    )는 빼고 검색한 후, 희망도서를 신청하세요</li>
			<li>※ 신청 후 처리 현황은 ‘나의도서관’ → ‘도서관련’ → ‘희망도서신청현황’에서 확인하세요</li>
		</ul>
	</div>
</c:when>
<c:when test="${homepage.context_path eq 'dalseolib'}">
	<!--<div style='border:1px solid #ddd;box-sizing:border-box;border-radius:3px;padding:18px;margin-bottom:15px;text-align:center;color:blue;font-weight:bold;'>
		2021년 달서구립도서관 희망도서 신청은 예산 소진으로 종료하며, 2022년 1월부터 희망도서를 다시 신청할 수 있습니다.
	</div>-->
</c:when>
<c:otherwise>
<div id="contents-title">
	<h2>희망도서신청<span style="font-weight:300">을 하고 싶으세요?</span></h2>
</div>
</c:otherwise>
</c:choose>
<!-- /contents-title-->

<div id="searchBox">

</div>
<img id="refImg" src="/resources/common/img/noimg-gall.png" alt="refImg" style="display: none;">

<c:if test="${homepage.context_path eq 'yonghak'}">
	<p style="font-weight:bold;margin-bottom:10px;">
		* 무학숲도서관은 생태·환경 관련 도서 위주로 신청받고 있으며, 기타 도서는 취소될 수 있으니 타도서관으로 신청 부탁드립니다.
	</p>
</c:if>

<form:form id="reqHopeForm" modelAttribute="librarySearch" action="save.do" method="post">
	<form:hidden path="editMode" value="ADD"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" name="homepage_id" value="${homepage.homepage_id}"/>
	<table class="edit">
		<tbody>
		<!-- 신청도서관 부분 추가 : 한개의 검색대에서 두개 이상의 도서관이 존재하여 신청 도서관을 선택해야하는 경우를 생각하여 CMS관리자에서 신청도서관 설정할수 있도록 하는게 맞을것 같음.  -->
		<tr>
			<th>신청도서관 <em><font color="red">(*)</font></em></th>
			<td>
				<c:choose>
				<c:when test="${homepagePath eq 'bukgs'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="BA">구수산도서관</form:option>
					<form:option value="GP">노원동 작은도서관</form:option>
					<form:option value="HD">노원행복도서관</form:option>
					<!-- <form:option value="GM">북구영어작은도서관</form:option> -->
					<form:option value="GL">산격1동 작은도서관</form:option>
					<form:option value="HB">서변동작은도서관</form:option>
					<form:option value="GN">침산1동 작은도서관</form:option>
					<!-- <form:option value="GJ">태전1동 작은도서관</form:option> -->	
					<form:option value="HE">한강공원부키도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${homepagePath eq 'bukdh'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="BB">대현도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>

				<c:when test="${homepagePath eq 'buktj'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="BC">태전도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>

				<c:when test="${homepagePath eq 'buks'}">
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

				<c:when test="${homepagePath eq 'beomeo' || homepagePath eq 'yonghak' || homepagePath eq 'gosan' || homepagePath eq 'bookforest' || homepagePath eq 'mulmangi' || homepagePath eq 'padong' || homepagePath eq 'muhaksup' || homepagePath eq 'sawol'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<!-- <form:option value="BD">범어도서관</form:option> -->
					<!-- <form:option value="BE">용학도서관</form:option> -->
					<!-- <form:option value="BF">고산도서관</form:option> -->
					<!-- <form:option value="BJ">책숲길도서관</form:option>
					<form:option value="BK">물망이도서관</form:option>
					<form:option value="BG">파동도서관</form:option>
					<form:option value="BH">무학숲도서관</form:option> -->
				</form:select> <!--* 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.--> * 희망도서 신청이 마감되어 희망도서 신청을 중지합니다.
				</c:when>

				<c:when test="${homepagePath eq 'junggu'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="FF">남산4동작은도서관</form:option>
					<form:option value="FQ">동인 느티나무 도서관</form:option>
					<form:option value="FS">대구중구영어도서관</form:option>
					<!-- <form:option value="FY">중구청교양정보실</form:option> -->
					<!-- <form:option value="GG">대신동작은도서관</form:option> -->
					<!-- <form:option value="HA">삼덕마루 작은도서관</form:option> -->
					<form:option value="HF">대봉2동작은도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				
				<c:when test="${homepagePath eq 'seogulib'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="BL">서구어린이도서관</form:option>
					<form:option value="BQ">비산도서관</form:option>
					<form:option value="BP">서구영어도서관</form:option>
					<form:option value="BM">비원도서관</form:option>
					<form:option value="BN">원고개도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${homepagePath eq 'bisan'}">
				<form:select path="manageCode">
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'seoguenglish'}">
				<form:select path="manageCode">
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'biwon'}">
				<form:select path="manageCode">
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'wongogae'}">
				<form:select path="manageCode">
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'seogumini'}">
				<form:select path="manageCode">
					<form:option value="FH">새마을문고대구서구지부작은도서관</form:option>
					<form:option value="FT">서구청 작은도서관</form:option>
					<form:option value="FU">내당4동어린이도서관</form:option>
					<form:option value="FZ">비산7동 작은도서관</form:option>
					<form:option value="GQ">내당2,3동 드림도서관</form:option>
					<form:option value="HC">달성토성마을 다락방 작은도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${homepagePath eq 'dalseonglib'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="BR">달성군립도서관</form:option>
					<form:option value="GA">화원읍작은도서관</form:option>
					<form:option value="GB">논공읍작은도서관</form:option>
					<form:option value="GD">다사읍서재작은도서관</form:option>
					<form:option value="GF">유가읍작은도서관</form:option>
					<form:option value="GH">옥포읍작은도서관</form:option>
					<form:option value="FR">가창면참꽃작은도서관</form:option>
					<form:option value="GE">하빈면작은도서관</form:option>
					<form:option value="GC">구지면작은도서관</form:option>
					<form:option value="FN">달성군청소년센터</form:option>
					<form:option value="FJ">달성군청도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${homepagePath eq 'dalseongsmall'}">
				<form:select path="manageCode">
					<form:option value="FR">가창면 참꽃작은도서관</form:option>
					<form:option value="GA">화원읍작은도서관</form:option>
					<form:option value="GB">논공읍작은도서관</form:option>
					<form:option value="GC">구지면작은도서관</form:option>
					<form:option value="GD">다사읍서재작은도서관</form:option>
					<form:option value="GE">하빈면작은도서관</form:option>
					<form:option value="GF">유가읍작은도서관</form:option>
					<form:option value="GH">옥포읍작은도서관</form:option>
					<form:option value="FJ">달성군청도서관"</form:option>
					<form:option value="FN">달성군청소년센터</form:option>
					<form:option value="HG">다사읍작은도서관"</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${homepagePath eq 'namic'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="BT">이천어울림도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'namdm'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="BS">대명어울림도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'dalseolib'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="BW">도원도서관</form:option>
					<form:option value="BV">달서어린이</form:option>
					<form:option value="BU">성서도서관</form:option>
					<form:option value="BX">본리도서관</form:option>
					<form:option value="BY">달서가족문화도서관</form:option>
					<form:option value="BZ">달서영어도서관</form:option>
				</form:select> * 신청하실 도서관을 먼저 선택 후 검색하시기 바랍니다.
				</c:when>
				<c:when test="${homepagePath eq 'dssmalllib'}">
				<form:select path="manageCode">
					<form:option value="FA">이곡2동공립작은도서관</form:option>
					<form:option value="FB">용산1동작은도서관</form:option>
					<form:option value="FC">장기동작은도서관</form:option>
					<form:option value="FD">죽전동공립작은도서관</form:option>
					<form:option value="FW">웃는얼굴아트센터 도서실</form:option>
					<form:option value="FX">행정정보문고센터</form:option>
					<form:option value="GK">학산작은도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'donggu' || homepagePath eq 'donggusm'}">
				<select id="manageCode" name="manageCode" class="new_select_box">
					<option value="CA">안심도서관</option>
					<!--<option value="CB">신천도서관</option>-->
					<option value="GR">신암2동 작은도서관</option>
					<option value="GS">신암3동 작은도서관</option>
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
				</select>
				</c:when>
				<c:when test="${homepagePath eq 'sincheon'}">
				<select id="manageCode" name="manageCode" class="new_select_box">
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
				</select>
				</c:when>
				<c:when test="${homepagePath eq 'jungang'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AD">중앙도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'dongbu'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AH">동부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'seobu'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AF">서부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'nambu'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AG">남부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'bukbu'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AC">북부도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'duryu'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AB">두류도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq '228'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AA">228기념학생도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq '228lib'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AL">228민주운동</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'suseong'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AE">수성도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'dalseong'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="AJ">달성도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'std'}">
				<form:select path="manageCode">
					<form:option value="AK">대구학생문화센터</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'dmsl'}">
				<form:select path="manageCode" cssClass="new_select_box">
					<form:option value="FV">대구시청작은도서관</form:option>
				</form:select>
				</c:when>
				<c:when test="${homepagePath eq 'dgoti'}">
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
			<td><form:input path="publer_year" style="width:10%" class="text" type="text" numberOnly="true" maxlength="4"/></td>
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
			<td><form:input path="price" style="width:20%" class="text" type="text" maxlength="10" numberOnly="true" /><font color="red"> *정가로 기입해 주세요</font></td>
		</tr>
		<c:if test="${homepage.context_path ne 'nambu' and homepage.context_path ne 'std'}">
		<tr>
			<th>우선대출예약여부</th>
			<td><form:checkbox path="reservation_yn" class="text" value="Y" checked="checked"/> <label for="reservation_yn1">우선대출을 원하실 경우 체크를 해주세요</label></td>
		</tr>
		</c:if>
	</tbody></table>
</form:form>

<div class="kbtn txt-center">
<c:choose>
	<c:when test="${homepagePath eq 'dalseonglib' || homepagePath eq 'beomeo' || homepagePath eq 'yonghak
' || homepagePath eq 'gosan'}">
	<a id="not-save-btn" href="" class="btn btn5"><span>신청하기</span></a>
	</c:when>
	<c:otherwise>
	<a id="save-btn" href="" class="btn btn5"><span>신청하기</span></a>
	</c:otherwise>
</c:choose>
</div>

