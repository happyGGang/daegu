<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
$(function() {

	var $form = $('form#librarySearch');

	//정렬, N개씩보기
	$('select#rowCount, select#sortType, select#sortField').on('change', function() {
		$('a#search-btn').click();
	});

	//소장정보 펼치기/접기
	$('a.showSlide').on('click', function(e) {
		e.preventDefault();

		var bci = $(this).parents('div.box').next('div.bci');
		var toggleState = $(bci).is(':hidden');
		if (toggleState)
		{
			$(this).css('background','#758194');
			$(this).text('소장정보');
			$(bci).slideToggle();
		} else {
			$(this).css('background','#a5856d');
			$(this).text('소장정보');
			$(bci).slideToggle();
		}
	});

	//이미지 목록형
	$('.imgView').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('on');
		$('.listView').removeClass('on');
		$('.search-results .cont ul').removeClass();
		if($(this).hasClass('on')){
			$('.search-results .textType').css('display','none');
			$('.search-results .imageType').css('display','block');
		}
	});

	//텍스트 목록형
	$('.listView').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('on');
		$('.imgView').removeClass('on');
		$('.search-results .cont ul').removeClass();
		if($(this).hasClass('on')){
			$('.search-results .imageType').css('display','none');
			$('.search-results .textType').css('display','block');
		}
	});

	//외국어 입력기
	$('#vk-popup').on('click', function(e) {
		PopupVirtualKeyboard.toggle('title','vk');
	});

	//전체 선택
	$('#checkAll').change(function(e) {
		$('div#libraryList input:checkbox, div#mapWrap input:checkbox').prop('checked', $(this).prop('checked'));
	});

	$('a#addMyLib').on('click', function(e) {
		e.preventDefault();
		var len = $('input.checkBook:checked').length;
		if (len < 1) {
			alert('선택된 책이 없습니다.');
			return false;
		}
		//TODO
		alert('준비중입니다');
		//내 보관함 이동.
	});

	//인기검색어
	$('div#hotTrend').load('hotTrend.do');

	//청구기호 인쇄
	$('a.btn_print').on('click', function(e) {
		e.preventDefault();
		var url = $(this).data('param').replace('detail', 'print');

		var popup = window.open(url, '_blank', 'toolbar=yes,scrollbars=yes,resizable=yes,top=100,left=100,width=700,height=500');
		popup.focus();
	});

	//검색하기
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();

		<c:choose>
		<c:when test="${context_path eq 'seogumini' || context_path eq 'buks' || context_path eq 'junggu' || context_path eq 'dalseongsmall' || context_path eq 'dssmalllib' || context_path eq 'sincheon' || context_path eq 'donggu' || context_path eq 'donggusm' || context_path eq 'seogumini' || context_path eq 'namdm' || context_path eq 'namic' || context_path eq 'bukgs' || context_path eq 'buktj' || context_path eq 'bukdh' || context_path eq 'beomeo' || context_path eq 'yonghak' || context_path eq 'gosan' || context_path eq 'bookforest' || context_path eq 'mulmangi' || context_path eq 'padong' || context_path eq 'muhaksup' || context_path eq 'sawol' || context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english' || context_path eq 'dssmalllib' || context_path eq 'dalseonglib' || context_path eq 'dalseongsmall'}">
			if( $("input:checkbox[name=libraryCodes]:checked").length == '0' )
			{
				alert('검색을 원하는 도서관을 선택하세요.');
				return false;
			}
			$('input#viewPage').val('1');
			doGetLoad('index.do', $form.serialize());
		</c:when>
		<c:otherwise>
			$('input#viewPage').val('1');
			doGetLoad('index.do', $form.serialize());
		</c:otherwise>
		</c:choose>

	});


	$('input#title').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#author').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#publer').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#keyword').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#search_start_date').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#search_end_date').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	//결과 내 재검색
	$('a#subSearch').on('click', function(e) {
		e.preventDefault();
		var type = $('select#subSearchType').val();
		var beforeText = $('input#'+type).val();
		var newText = (beforeText == '') ? newText = $('input#subSearchText').val() : $('input#'+type).val()+ ' ' +$('input#subSearchText').val();
		$('input#'+type).val(newText);
		$('input#viewPage').val('1');
		doGetLoad('index.do', $form.serialize());
	});

	//결과 내 재검색
	$('input#subSearchText').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#subSearch').click();
		}
	});

	//검색초기화
	$('a#reset-btn').on('click', function(e) {
		e.preventDefault();
		location.href='/intro/${context_path}/search/index.do';
		$('#title').focus();
	});



	<c:if test="${librarySearch.totalDataCount > 0}">
	location.href = '#search-btn';
	</c:if>

	<c:if test="${empty librarySearch.title}">
	</c:if>

	<c:if test="${empty librarySearch.title}">
		<c:choose>
			<c:when test="${context_path eq 'bolli'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_BX').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'seongseo'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_BU').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'kids'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_BV').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'english'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_BZ').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'family'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_BY').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'buks'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_GJ').prop('checked',true);
			$('div#libraryList input:checkbox.lib_GL').prop('checked',true);
			$('div#libraryList input:checkbox.lib_GM').prop('checked',true);
			$('div#libraryList input:checkbox.lib_GN').prop('checked',true);
			$('div#libraryList input:checkbox.lib_GP').prop('checked',true);
			$('div#libraryList input:checkbox.lib_HB').prop('checked',true);
			$('div#libraryList input:checkbox.lib_HD').prop('checked',true);
			$('div#libraryList input:checkbox.lib_HE').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'junggu'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_FS').prop('checked',true);
			$('div#libraryList input:checkbox.lib_FF').prop('checked',true);
			$('div#libraryList input:checkbox.lib_FQ').prop('checked',true);
			$('div#libraryList input:checkbox.lib_FY').prop('checked',true);
			$('div#libraryList input:checkbox.lib_GG').prop('checked',true);
			$('div#libraryList input:checkbox.lib_HA').prop('checked',true);
			$('div#libraryList input:checkbox.lib_HF').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'dalseongsmall'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			</c:when>
			<c:when test="${context_path eq 'dssmalllib'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_FA').prop('checked',true);
			$('div#libraryList input:checkbox.lib_FB').prop('checked',true);
			$('div#libraryList input:checkbox.lib_FC').prop('checked',true);
			$('div#libraryList input:checkbox.lib_FD').prop('checked',true);
			$('div#libraryList input:checkbox.lib_FW').prop('checked',true);
			$('div#libraryList input:checkbox.lib_FX').prop('checked',true);
			$('div#libraryList input:checkbox.lib_GK').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'sincheon'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_CB').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'muhaksup'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_BH').prop('checked',true);
			</c:when>
			<c:when test="${context_path eq 'padong'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_BG').prop('checked',true);
			</c:when>
		</c:choose>
	</c:if>


});
</script>
<form:form modelAttribute="librarySearch" id="detailForm" action="detail.do" method="post" >
	<form:hidden path="isbn"/>
	<form:hidden path="regNo"/>
	<form:hidden path="manageCode"/>
</form:form>

<form:form modelAttribute="librarySearch" action="index.do" method="get">
	<form:hidden path="viewPage"/>

	<!-- contents-title-->
	<div id="contents-title">
		<h2>어떤 도서<span style="font-weight:300">를 찾고 싶으세요?</span></h2>
	</div>
	<!-- /contents-title-->

	<div class="search-wrap">

		<div class="search-form">

			<!-- 검색하기_일반 -->
			<div class="searchbox detail_search">
				<div class="section">

					<div class="title-box">
						<form:input path="title" class="text-area" placeholder="도서 제목을 입력하세요"/>
					</div>
					<div class="end" style="padding:7px 0;"></div>
<!--
					<div class="vk-btn">
						<a id="vk-popup" class="btnNew2">다국어입력기</a>
					</div>
-->

<!-- 도서관 선택 분기처리 시작 -->
					<c:choose>
					<c:when test="${context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks'}">
					<div id="libraryList" class="libraryList">
						<div>
							<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
						</div>
						<div>
							<ul>
								<li>
									<form:checkbox path="libraryCodes" value="BA" class="libCheck lib_BA" label="구수산도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BB" class="libCheck lib_BB" label="대현도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BC" class="libCheck lib_BC" label="태전도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GL" class="libCheck lib_GL" label="산격1동 작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GM" class="libCheck lib_GM" label="북구영어작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GN" class="libCheck lib_GN" label="침산1동 작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GP" class="libCheck lib_GP" label="노원동 작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HB" class="libCheck lib_HB" label="서변동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HD" class="libCheck lib_HD" label="노원행복도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HE" class="libCheck lib_HE" label="한강공원부키도서관"/>
								</li>
							</ul>
						</div>
						<div class="end"></div>
					</div>
					<div class="end" style="padding:7px 0;"></div>
					</c:when>
					<c:when test="${context_path eq 'beomeo' || context_path eq 'yonghak' || context_path eq 'gosan' || context_path eq 'bookforest' || context_path eq 'mulmangi' || context_path eq 'padong' || context_path eq 'muhaksup' || context_path eq 'sawol'}">
					<div id="libraryList" class="libraryList">
						<div>
							<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
						</div>
						<div>
							<ul>
								<li>
									<form:checkbox path="libraryCodes" value="BD" class="libCheck lib_BD" label="범어도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BE" class="libCheck lib_BE" label="용학도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BF" class="libCheck lib_BF" label="고산도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BG" class="libCheck lib_BG" label="파동도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BH" class="libCheck lib_BH" label="무학숲도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BJ" class="libCheck lib_BJ" label="책숲길도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BK" class="libCheck lib_BK" label="물망이도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FG" class="libCheck lib_FG" label="사월역도서관"/>
								</li>
							</ul>
						</div>
						<div class="end"></div>
					</div>
					<div class="end" style="padding:7px 0;"></div>
					</c:when>
					<c:when test="${context_path eq 'junggu'}">
					<div id="libraryList" class="libraryList">
						<div>
							<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
						</div>
						<div>
							<ul>
								<li>
									<form:checkbox path="libraryCodes" value="FS" class="libCheck lib_FS" label="대구중구영어도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FF" class="libCheck lib_FF" label="남산4동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FQ" class="libCheck lib_FQ" label="동인 느티나무 도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FY" class="libCheck lib_FY" label="중구청교양정보실"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GG" class="libCheck lib_GG" label="대신동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HA" class="libCheck lib_HA" label="삼덕마루 작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HF" class="libCheck lib_HF" label="대봉2동작은도서관"/>
								</li>
							</ul>
						</div>
						<div class="end"></div>
					</div>
					<div class="end" style="padding:7px 0;"></div>
					</c:when>
					<c:when test="${context_path eq 'seogumini'}">
					<div id="libraryList" class="libraryList">
						<div>
							<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
						</div>
						<div>
							<ul>
								<li>
									<form:checkbox path="libraryCodes" value="GQ" class="libCheck lib_GQ" label="내당2,3동 드림도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FU" class="libCheck lib_FU" label="내당4동어린이도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FZ" class="libCheck lib_FZ" label="비산7동 작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FH" class="libCheck lib_FH" label="새마을문고대구서구지부작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FT" class="libCheck lib_FT" label="서구청작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HC" class="libCheck lib_HC" label="달성토성마을 다락방 작은도서관"/>
								</li>
							</ul>
						</div>
						<div class="end"></div>
					</div>
					<div class="end" style="padding:7px 0;"></div>
					</c:when>
					<c:when test="${context_path eq 'dalseonglib' || context_path eq 'dalseongsmall'}">
					<div id="libraryList" class="libraryList">
						<div>
							<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
						</div>
						<div>
							<ul>
								<li>
									<form:checkbox path="libraryCodes" value="BR" class="libCheck lib_BR" label="달성군립도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GA" class="libCheck lib_GA" label="화원읍작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GB" class="libCheck lib_GB" label="논공읍작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HG" class="libCheck lib_HG" label="다사읍작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GD" class="libCheck lib_GD" label="다사읍서재작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GF" class="libCheck lib_GF" label="유가읍작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GH" class="libCheck lib_GH" label="옥포읍작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FR" class="libCheck lib_FR" label="가창면참꽃작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GE" class="libCheck lib_GE" label="하빈면작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GC" class="libCheck lib_GC" label="구지면작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FN" class="libCheck lib_FN" label="달성군청소년센터"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FJ" class="libCheck lib_FJ" label="달성군청도서관"/>
								</li>
							</ul>
						</div>
						<div class="end"></div>
					</div>
					<div class="end" style="padding:7px 0;"></div>
					</c:when>
					<c:when test="${context_path eq 'namdm' || context_path eq 'namic'}">
					<div id="libraryList" class="libraryList">
						<div>
							<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
						</div>
						<div>
							<ul>
								<li>
									<form:checkbox path="libraryCodes" value="BT" class="libCheck lib_BT" label="이천어울림도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BS" class="libCheck lib_BS" label="대명어울림도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FE" class="libCheck lib_FE" label="꿈틀작은도서관"/>
								</li>
							</ul>
						</div>
						<div class="end"></div>
					</div>
					<div class="end" style="padding:7px 0;"></div>
					</c:when>
					<c:when test="${context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english' || context_path eq 'dssmalllib'}">
					<div id="libraryList" class="libraryList">
						<div>
							<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
						</div>
						<div>
							<ul>
								<li>
									<form:checkbox path="libraryCodes" value="BU" class="libCheck lib_BU" label="성서도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BV" class="libCheck lib_BV" label="달서어린이도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BW" class="libCheck lib_BW" label="도원도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BX" class="libCheck lib_BX" label="본리도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BY" class="libCheck lib_BY" label="달서가족문화도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="BZ" class="libCheck lib_BZ" label="달서영어도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FA" class="libCheck lib_FA" label="이곡2동공립작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FB" class="libCheck lib_FB" label="용산1동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FC" class="libCheck lib_FC" label="장기동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FD" class="libCheck lib_FD" label="죽전동공립작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FW" class="libCheck lib_FW" label="웃는얼굴아트센터 도서실"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FX" class="libCheck lib_FX" label="행정정보문고센터"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GK" class="libCheck lib_GK" label="학산작은도서관"/>
								</li>
							</ul>
						</div>
						<div class="end"></div>
					</div>
					<div class="end" style="padding:7px 0;"></div>
					</c:when>
					<c:when test="${context_path eq 'donggu' || context_path eq 'sincheon' || context_path eq 'donggusm'}">
					<div id="libraryList" class="libraryList">
						<div>
							<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
						</div>
						<div>
							<ul>
								<li>
									<form:checkbox path="libraryCodes" value="CA" class="libCheck lib_CA" label="안심도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="CB" class="libCheck lib_CB" label="신천도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GR" class="libCheck lib_GR" label="신암2동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GS" class="libCheck lib_GS" label="신암3동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HJ" class="libCheck lib_HJ" label="신암5동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FK" class="libCheck lib_FK" label="신천3동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GT" class="libCheck lib_GT" label="효목1동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FP" class="libCheck lib_FP" label="효목2동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FL" class="libCheck lib_FL" label="도평동 작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GU" class="libCheck lib_GU" label="불로어울림작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GV" class="libCheck lib_GV" label="지저동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GW" class="libCheck lib_GW" label="동촌역사작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GX" class="libCheck lib_GX" label="방촌동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="GY" class="libCheck lib_GY" label="해안동작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="FM" class="libCheck lib_FM" label="반야월역사작은도서관"/>
								</li>

								<li>
									<form:checkbox path="libraryCodes" value="HK" class="libCheck lib_HK" label="늘푸른작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HL" class="libCheck lib_HL" label="초록우산작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HM" class="libCheck lib_HM" label="꿈날자문고작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HN" class="libCheck lib_HN" label="행복작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HP" class="libCheck lib_HP" label="율하5주민작은도서관"/>
								</li>
								<li>
									<form:checkbox path="libraryCodes" value="HQ" class="libCheck lib_HQ" label="방촌어린이작은도서관"/>
								</li>
							</ul>
						</div>
						<div class="end"></div>
					</div>
					<div class="end" style="padding:13px 0;"></div>
					</c:when>
					<c:when test="${context_path eq 'bisan'}">
					<input type="hidden" name='libraryCodes' id='libraryCodes' value="BQ"/>
					</c:when>
					<c:when test="${context_path eq 'biwon'}">
					<input type="hidden" name='libraryCodes' id='libraryCodes' value="BM"/>
					</c:when>
					<c:when test="${context_path eq 'wongogae'}">
					<input type="hidden" name='libraryCodes' id='libraryCodes' value="BN"/>
					</c:when>
					<c:when test="${context_path eq 'seoguenglish'}">
					<input type="hidden" name='libraryCodes' id='libraryCodes' value="BP"/>
					</c:when>
					<c:otherwise>
					<form:hidden path="libraryCodes" value="" />
					</c:otherwise>
					</c:choose>
<!-- 도서관 선택 분기처리 끝 -->

					<dl>
						<dt><label for="author" class="title">저자</label></dt>
						<dd><form:input path="author" class="text-area"/></dd>
					</dl>

					<dl>
						<dt><label for="publer" class="title">발행처</label></dt>
						<dd><form:input path="publer" class="text-area"/></dd>
					</dl>
					<dl>
						<dt><label for="keyword" class="title">키워드</label></dt>
						<dd><form:input path="keyword" class="text-area"/></dd>
					</dl>

					<dl>
						<dt><label for="search_start_date" class="title">발행년도</label></dt>
						<dd>
							<div class="box">
								<form:input path="search_start_date" class="text-area2" title="시작년도" numberOnly="true" maxlength="4" />
								<span style="width:8%;text-align:center;">~</span>
								<form:input path="search_end_date" class="text-area2" title="마지막년도" numberOnly="true" maxlength="4" />
							</div>
						</dd>
					</dl>

					<dl>
						<dt><label for="subjectCode" class="title">주제</label></dt>
						<dd>
							<form:select path="subjectCode">
								<form:option value="">전체</form:option>
								<form:option value="0">총류</form:option>
								<form:option value="1">철학</form:option>
								<form:option value="2">종교</form:option>
								<form:option value="3">사회과학</form:option>
								<form:option value="4">순수과학</form:option>
								<form:option value="5">기술과학</form:option>
								<form:option value="6">예술</form:option>
								<form:option value="7">언어</form:option>
								<form:option value="8">문학</form:option>
								<form:option value="9">역사</form:option>
							</form:select>
						</dd>
					</dl>

					<!--dl>
						<dt><label for="manageCode" class="title">도서관</label></dt>
						<dd>
							<form:select path="manageCode">
								<form:option value="ALL">전체 도서관</form:option>
								<form:option value="${homepage.manage_code}">${homepage.homepage_name}</form:option>
							</form:select>
						</dd>
					</dl-->

					<dl>
						<dt><label for="booktype" class="title">자료형태</label></dt>
						<dd>
							<div class="" style="padding:6px 0 0 0px">
							<form:radiobutton path="booktype" value="BOOKANDNONBOOK" class="radiocheck" checked="checked"/><label for="booktype1" class="booktype">통합</label>
							<form:radiobutton path="booktype" value="BOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype2" class="booktype">도서</label>
							<form:radiobutton path="booktype" value="NONBOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype3" class="booktype">비도서</label>
<%-- 							<form:radiobutton path="booktype" value="SERIAL" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype3" class="booktype">간행물</label> --%>
							</div>
						</dd>
					</dl>

					<div class="end"></div>
				</div>
				<p class="btn_w">
					<a id="search-btn" class="btnNew">검색하기</a>
					<a id="reset-btn" class="btnNew1">검색초기화</a>
					<a id="vk-popup" class="btnNew1">다국어입력기</a>
					<!-- <input name="search_bt2" class="btnNew btn-warning btn-xs mT1" id="search-btn" type="submit" value="검색하기" /> -->
				</p>

			</div>
			<!--// 검색하기_일반 -->

			<br/>
			<div id="autoFill">
			</div>
		</div>

		<br/>

		<c:if test="${not empty paging and librarySearch.totalDataCount eq 0}">
		<p style="text-align: center;">
			<b>찾으시는 자료가 없습니다. </b>
		</p>
		</c:if>

		<c:if test="${librarySearch.totalDataCount > 0}">

		<!--search_result-->
		<div id="search_result" class="search_result">

			<div class="smain">
				<div class="box">
					<div class="search-info" >
						검색결과 총 <b>'<fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/>'</b>건이 검색되었습니다.
					</div>

					<div class="search-condition">

						<div class="mode">
							<ul>
								<li><a href="#;" class="btn-View imgView on">이미지형 표지형 설정</a></li>
								<li><a href="#;" class="btn-View listView">목록형 표지형 설정</a></li>
							</ul>
						</div>

						<div class="re-search">
							<select id="subSearchType">
								<option value="title">서명</option>
								<option value="author">저자</option>
								<option value="publer">발행처</option>
								<option value="keyword">키워드</option>
							</select>
							<input id="subSearchText" placeholder="결과 내 재검색">
							<a href="#" id="subSearch" class="btn">결과 내 재검색</a>
						</div>

						<div class="end"></div>
					</div>

					<div class="ws-toolbar">
						<div class="checkBoxAll">
							<input type="hidden" name="" value="on"/>
							<input id="checkAllBook" name="" type="checkbox" value="Y"/>
							<label for="checkAllBook">전체</label>
						</div>

						<div class="control">
							<form:select path="sortField">
								<form:option value="NONE">정렬없음</form:option>
								<form:option value="TITLE">제목</form:option>
								<form:option value="AUTHOR">저자</form:option>
								<form:option value="PUBLISHER">발행처</form:option>
								<form:option value="PUB_YEAR">발행년도</form:option>
								<form:option value="SHELF_DATE">배가일</form:option>
							</form:select>
							<form:select path="sortType">
								<form:option value="ASC">오름차순</form:option>
								<form:option value="DESC">내림차순</form:option>
							</form:select>
							<form:select path="rowCount">
								<form:option value="10" label="10건"></form:option>
								<form:option value="20" label="20건"></form:option>
								<form:option value="30" label="30건"></form:option>
								<form:option value="40" label="40건"></form:option>
								<form:option value="50" label="50건"></form:option>
								<form:option value="100" label="100건"></form:option>
							</form:select>

						</div>
					</div>

					<div id="search-results" class="search-results">
						<div class="imageType">
							<c:forEach items="${bookSearch}" var="i">
							<!-- 검색결과 루프 시작 -->
							<c:set var="detailURL" value="detail.do?isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK')}"></c:set>
							<div class="row">
								<p class="admin">
									<input name="print_param" type="checkbox" class="checkBook" value="${i.ST_CODE}_${i.MANAGE_CODE}"/>
								</p>
								<div class="thumb">
									<c:choose>
										<c:when test="${empty i.aladin or empty i.aladin.cover}">
											<a href="${detailURL}">
												<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="${i.TITLE_INFO}"/>
											</a>
										</c:when>
										<c:otherwise>
											<a href="${detailURL}">
												<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}"/>
											</a>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="box">
									<div class="item">
										<div class="bif">

											<a href="${detailURL}" class="book-title">
											<c:if test="${i.MEDIA_CODE eq 'PR'}">[도서]</c:if>
											<c:if test="${i.MEDIA_CODE ne 'PR'}">[비도서]</c:if>
											<c:if test="${librarySearch.booktype eq 'SERIAL'}">[간행물]</c:if>
											<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span>
											</a>

											<p><font style="color:#5e5e5e;">저자</font> : ${i.AUTHOR}</p>
											<p><font style="color:#5e5e5e">발행처</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}</p>
											<p><font style="color:#5e5e5e">소장도서관</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span> / <font style="color:#5e5e5e">소장위치</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span></p>
											<p><font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}</p>
											<p><font style="color:#5e5e5e">대출가능여부</font> :
												<!-- 대출가능 여부 [START] -->
												<c:choose>
													<c:when test="${i.MANAGE_CODE eq 'HM' || i.MANAGE_CODE eq 'HQ'}">
														<span style="color:#ff0000">대출불가(임시휴관)</span>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${i.LOAN_CODE eq 'OK'}">
																대출가능
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																		<span style="color:#ff0000">대출불가(관외대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:when test="${i.WORKING_STATUS == 'BOL213O'}">
																		<span style="color:#ff0000">대출불가(관외대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																		<span style="color:#ff0000">대출불가(관내대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																		<span style="color:#ff0000">대출불가(타관반납중)(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																		<span style="color:#ff0000">대출불가(타관대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${i.RESERVATION_CNT > 0}">
																				<span style="color:#ff0000">대출불가(예약대출 대기중)(예약 : ${i.RESERVATION_CNT}명)</span>
																			</c:when>
																			<c:otherwise>
																				<span style="color:#ff0000">대출불가</span>
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<!-- 대출가능 여부 [ END ] -->
											</p>
											<c:if test="${not empty i.APPENDIX_INFO}">
											<c:if test="${i.APPENDIX_LIST[0].LOAN_CODE eq 'OK'} ">
											<p><font style="color:#5e5e5e">부록여부</font> : ${i.APPENDIX_INFO[0].DESCRIPTION} (${i.APPENDIX_INFO[0].APPENDIX_CNT}개)</p>
											</c:if>
											</c:if>
											<!--
											JU : 아동, MS : 중학생, AD : 성인, PU : 일반, ES : 초등, HS : 고등, SP : 특수, TE : 청소년, 기타 : 
											-->
											<p><font style="color:#5e5e5e">이용대상</font> : 
														<c:choose>
															<c:when test="${i.USE_OBJECT_CODE eq 'JU'}">
																<span style="">아동</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'MS'}">
																<span style="">중학생</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'AD'}">
																<span style="">성인</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'PU'}">
																<span style="">일반</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'ES'}">
																<span style="">초등</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'HS'}">
																<span style="">고등</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'SP'}">
																<span style="">특수</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'TE'}">
																<span style="">청소년</span>
															</c:when>
															<c:otherwise>
																<span style="">기타</span>
															</c:otherwise>
														</c:choose>
											</p>
											<p><font style="color:#5e5e5e">매체구분</font> : <span style="">${i.MEDIA_NAME}</span></p>
											<c:if test="${context_path eq 'dalseolib' || context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' || context_path eq 'english' || context_path eq 'dssmalllib' || context_path eq 'bukgs' || context_path eq 'bukdh' || context_path eq 'buktj' || context_path eq 'buks'}">
											<p><font style="color:#5e5e5e">영어독서 레벨</font> : <span style="">${i.marc}</span></p>
											</c:if>
											<!-- <p><font style="color:#5e5e5e">소장위치</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span></p> -->
											<div class="stat">
												<a href="#showSlide" class="showSlide"><span>소장정보</span></a>
											</div>
										</div>
									</div>
								</div>

								<div class="bci" style="display:none;">
									<table summary="도서 상태 및 등록 정보" style="text-align:center" class="statusBox">
										<caption>도서 상태 및 등록 정보</caption>
										<colgroup>
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
										</colgroup>
										<thead>
											<tr>
												<th>소장<br class="mBr"/>위치</th>
												<th>등록<br class="mBr"/>번호</th>
												<th>대출가능<br class="mBr"/>여부</th>
												<th>반납<br class="mBr"/>예정일</th>
												<th>자료위치<br class="mBr"/>인쇄</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${i.SHELF_LOC_NAME}</td>
												<td>${i.REG_NO}</td>
												<td>
												<!-- 대출가능 여부 [START] -->
												<c:choose>
													<c:when test="${i.MANAGE_CODE eq 'HM' || i.MANAGE_CODE eq 'HQ'}">
														<span style="color:#ff0000">대출불가(임시휴관)</span>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${i.WORKING_STATUS == 'BOL112N'}">
																<c:choose>
																	<c:when test="${i.RESERVATION_CNT > '0'}">
																		<span style="color:#ff0000">대출불가(예약도서)</span>
																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${i.USE_LIMIT_CODE eq 'CD'}">
																				대출불가(열람제한도서)
																			</c:when>
																			<c:when test="${i.USE_LIMIT_CODE eq 'IZ'}">
																				귀중자료(관내열람만가능)
																			</c:when>
																			<c:otherwise>
																				<c:choose>
																					<c:when test="${i.SHELF_LOC_CODE eq 'AK03'}">
																						<span style="color:#ff0000">대출불가</span>
																					</c:when>
																					<c:when test="${i.SHELF_LOC_CODE eq 'BD10'}">
																						<span style="color:#ff0000">대출불가(스마트도서관자료)</span>
																					</c:when>
																					<c:otherwise>
																						<c:choose>
																							<c:when test="${i.SEPARATE_SHELF_CODE eq 'BQS' || i.SEPARATE_SHELF_CODE eq 'BQT'}">
																								<span style="color:#ff0000">대출불가</span>
																							</c:when>
																							<c:otherwise>
																								대출가능
																							</c:otherwise>
																						</c:choose>
																					</c:otherwise>
																				</c:choose>
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																		<span style="color:#ff0000">대출불가(관외대출중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																		<span style="color:#ff0000">대출불가(관내대출중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:when test="${i.WORKING_STATUS == 'BOL411O'}">
																		<span style="color:#ff0000">대출불가(책두레중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																		<span style="color:#ff0000">대출불가(타관반납중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																		<span style="color:#ff0000">대출불가(타관대출중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:when>
																	<c:otherwise>
																		<span style="color:#ff0000">대출불가</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<!-- 대출가능 여부 [ END ] -->
												</td>
												<td>
													${i.RETURN_PLAN_DATE}
												</td>
												<td>
												<c:choose>
													<c:when test="${i.WORKING_STATUS eq 'BOL112N'}">
														<c:choose>
															<c:when test="${i.RESERVATION_CNT > 0}">

															</c:when>
															<c:otherwise>

																		<a href="#" class="btn_print" data-param="${detailURL}" class="btn btn2" style="border:1px solid #ddd;border-radius:3px;box-sizing:border-box;padding:5px;color:#fff;background:#1367c6;">자료위치인쇄</a>
																
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							</c:forEach>
							<!-- 검색결과루프 끝 -->
							<jsp:include page="/WEB-INF/views/app/intro/search/paging.jsp" flush="false" />
						</div>

						<div class="textType" style="display:none">
							<!-- 검색결과 루프 시작 -->
							<c:forEach items="${bookSearch}" var="i">
							<c:set var="detailURL" value="detail.do?isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK')}"></c:set>
							<div class="row">
								<div class="box">
									<div class="item">
										<div class="bif">

										<input name="print_param" type="checkbox" class="checkBook" value="${i.ST_CODE}_${i.MANAGE_CODE}"/>

											<a href="${detailURL}" class="name">
											<c:if test="${i.MEDIA_CODE eq 'PR'}">[도서]</c:if>
											<c:if test="${i.MEDIA_CODE ne 'PR'}">[비도서]</c:if>
											<c:if test="${librarySearch.booktype eq 'SERIAL'}">[간행물]</c:if>
											<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span>
											</a>
											<p><font style="color:#5e5e5e;">저자</font> : ${i.AUTHOR}<br class="mobileBr"/><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span> <font style="color:#5e5e5e">발행처</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}<br class="mobileBr"/><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span><font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}<br class="mobileBr"/><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span><font style="color:#5e5e5e">매체구분</font> : ${i.MEDIA_NAME}<br/><font style="color:#5e5e5e">소장도서관 </font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span> <br class="mobileBr"/><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span><font style="color:#5e5e5e">소장위치</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span> <br class="mobileBr"/><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
											<font style="color:#5e5e5e">대출가능여부</font> :
												<!-- 대출가능 여부 [START] -->
												<c:choose>
													<c:when test="${i.WORKING_STATUS == 'BOL112N'}">
														<c:choose>
															<c:when test="${i.RESERVATION_CNT > '0'}">
																<span style="color:#ff0000">대출불가(예약도서)</span>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${i.USE_LIMIT_CODE eq 'CD'}">
																		대출불가(열람제한도서)
																	</c:when>
																	<c:when test="${i.USE_LIMIT_CODE eq 'IZ'}">
																		귀중자료(관내열람만가능)
																	</c:when>
																	<c:otherwise>
																			<c:choose>
																				<c:when test="${i.SEPARATE_SHELF_CODE eq 'BQS' || i.SEPARATE_SHELF_CODE eq 'BQT'}">
																					<span style="color:#ff0000">대출불가</span>
																				</c:when>
																				<c:otherwise>
																					대출가능
																				</c:otherwise>
																			</c:choose>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																<span style="color:#ff0000">대출불가(관외대출중) <span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span></span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																<span style="color:#ff0000">대출불가(관내대출중) <span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span></span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL411O'}">
																<span style="color:#ff0000">대출불가(책두레중) <span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span></span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																<span style="color:#ff0000">대출불가(타관반납중) <span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span></span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																<span style="color:#ff0000">대출불가(타관대출중) <span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span></span>
															</c:when>
															<c:otherwise>
																<span style="color:#ff0000">대출불가</span>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<!-- 대출가능 여부 [ END ] -->
												<c:if test="${not empty i.APPENDIX_INFO}">
												<br class="mobileBr"/><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
												<font style="color:#5e5e5e">부록여부</font> : ${i.APPENDIX_INFO[0].DESCRIPTION} (${i.APPENDIX_INFO[0].APPENDIX_CNT}개)
												</c:if>
												<br class="mobileBr"/><span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span> <font style="color:#5e5e5e">이용대상</font> : 
														<c:choose>
															<c:when test="${i.USE_OBJECT_CODE eq 'JU'}">
																<span style="">아동</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'MS'}">
																<span style="">중학생</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'AD'}">
																<span style="">성인</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'PU'}">
																<span style="">일반</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'ES'}">
																<span style="">초등</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'HS'}">
																<span style="">고등</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'SP'}">
																<span style="">특수</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'TE'}">
																<span style="">청소년</span>
															</c:when>
															<c:otherwise>
																<span style="">기타</span>
															</c:otherwise>
														</c:choose>
											</p>

											<div class="stat">
												<a href="#showSlide" class="showSlide" vLoca="747016" ><span>소장정보</span></a>
											</div>
										</div>
									</div>
								</div>
								<div class="bci" style="display:none;">
									<table summary="도서 상태 및 등록 정보" style="text-align:center" class="statusBox">
										<caption>도서 상태 및 등록 정보</caption>
										<colgroup>
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
										</colgroup>
										<thead>
											<tr>
												<th>소장<br class="mBr"/>위치</th>
												<th>등록<br class="mBr"/>번호</th>
												<th>대출가능<br class="mBr"/>여부</th>
												<th>반납<br class="mBr"/>예정일</th>
												<th>자료위치<br class="mBr"/>인쇄</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${i.SHELF_LOC_NAME}</td>
												<td>${i.REG_NO}</td>
												<td>
												<!-- 대출가능 여부 [START] -->
												<c:choose>
													<c:when test="${i.WORKING_STATUS == 'BOL112N'}">
														<c:choose>
															<c:when test="${i.RESERVATION_CNT > '0'}">
																<span style="color:#ff0000">대출불가(예약도서)</span>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${i.USE_LIMIT_CODE eq 'CD'}">
																		대출불가(열람제한도서)
																	</c:when>
																	<c:when test="${i.USE_LIMIT_CODE eq 'IZ'}">
																		귀중자료(관내열람만가능)
																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${i.SEPARATE_SHELF_CODE eq 'BQS' || i.SEPARATE_SHELF_CODE eq 'BQT'}">
																				<span style="color:#ff0000">대출불가</span>
																			</c:when>
																			<c:otherwise>
																				대출가능
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																<span style="color:#ff0000">대출불가(관외대출중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																<span style="color:#ff0000">대출불가(관내대출중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL411O'}">
																<span style="color:#ff0000">대출불가(책두레중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																<span style="color:#ff0000">대출불가(타관반납중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																<span style="color:#ff0000">대출불가(타관대출중)</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:otherwise>
																<span style="color:#ff0000">대출불가</span><br/><span style="font-weight:bold">(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<!-- 대출가능 여부 [ END ] -->
												</td>
												<td>
													${i.RETURN_PLAN_DATE}
												</td>
												<td>
												<c:choose>
													<c:when test="${i.WORKING_STATUS eq 'BOL112N'}">
														<c:choose>
															<c:when test="${i.RESERVATION_CNT > 0}">

															</c:when>
															<c:otherwise>

																<a href="#" class="btn_print" data-param="${detailURL}" class="btn btn2" style="border:1px solid #ddd;border-radius:3px;box-sizing:border-box;padding:5px;color:#fff;background:#1367c6;">자료위치인쇄</a>
																
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							</c:forEach>
							<!-- 검색결과루프 끝 -->
							<jsp:include page="/WEB-INF/views/app/intro/search/paging.jsp" flush="false" />
						</div>
					</div>
				</div>

				<div class="filter-section">
					<div class="ws-filter" id="hotTrend" style="height:370px;">
						<h4>실시간 검색어 순위</h4>
						<div style="text-align: center;" >
							불러오는 중...
						</div>
					</div>
				</div>

			</div>

		</div>

		</c:if>
	</div>
</form:form>
<div id="vk"></div>

