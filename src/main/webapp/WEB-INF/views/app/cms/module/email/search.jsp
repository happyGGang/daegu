<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>

<script type="text/javascript">
$(function() {
	if($('#loading2').length == 0) {
		$('<div id="loading2" class="loading2"></div><img id="loading_img2" alt="loading" src="/resources/common/img/viewLoading.gif" />').appendTo(document.body).hide();
	}
	
	//셀렉트 메뉴
	$('select.selectmenu-search').select2({
		//셀렉트 메뉴에 검색 기능 사용
	});

	$('select#homepage_id').on('change', function(e) {
		if($(this).val() != '') {
			$('select#codeList_1').val("");
			$('select#codeList_2').val("");
			$('select#codeList_3').val("");
			$('select#codeList_4').val("");

			$('#table1 tbody tr').remove();
			$('div#listCount').text('총 : 0 명');
			$('#status').val(null);

			$('div.tabmenu > ul > li').removeClass('active');
			$('#tabLi1').parent().addClass('active');


			$('div#module-search-layer').load('search.do?' + serializeCustom($('form#emailSendForm')));
			$('div#smsbox-layer').load('smsboxList.do', serializeCustom($('form#emailSendForm')));

		}

		e.preventDefault();
	});

	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('select#codeList_1').on('change', function(e) {
		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}

		if($(this).val() != '') {
			$('select#codeList_2').val("");
			$('select#codeList_3').val("");
			$('select#codeList_4').val("");

			//결과값 초기화
			$('#table1 tbody tr').remove();
			$('div#listCount').text('총 : 0 명');
			$('#status').val(null);
			$('div.tabmenu > ul > li').removeClass('active');
			$('#tabLi1').parent().addClass('active');

			$('div#module-search-layer').load('search.do?' + serializeCustom($('form#emailSendForm')));
		}
		e.preventDefault();
	});

	//select box 제어
	if($('select#codeList_1').val() == '1') {
		$('div.selectBox').css('display','none');

		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');

		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');

		$('div > ul > li > a#tabLi4').css('display','block');
		$('div > ul > li > a#tabLi3').css('display','block');
		$('div > ul > li > a#tabLi2').css('display','block');

		$('div > ul > li > a#tabLi1').text('참여');
		$('div > ul > li > a#tabLi2').text('후보');
		$('div > ul > li > a#tabLi3').text('취소');

		//결과값 초기화
		$('#table1 tbody tr').remove();
		$('div#listCount').text('총 : 0 명');
		$('#status').val(null);
		$('div.tabmenu > ul > li').removeClass('active');
		$('#tabLi1').parent().addClass('active');

	} else if($('select#codeList_1').val() == '2') {
		$('div.selectBox').css('display','none');

		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		$('div > ul > li > a#tabLi2').css('display','block');

		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');
		$('#div_select_list5').css('display','inline');

		$('div > ul > li > a#tabLi1').text('승인');
		$('div > ul > li > a#tabLi2').text('대기');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');

		//결과값 초기화
		$('#table1 tbody tr').remove();
		$('div#listCount').text('총 : 0 명');
		$('#status').val(null);
		$('div.tabmenu > ul > li').removeClass('active');
		$('#tabLi1').parent().addClass('active');

	} else if($('select#codeList_1').val() == '3') {
		$('div.selectBox').css('display','none');

		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		$('div > ul > li > a#tabLi2').css('display','block');

		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');

		$('div > ul > li > a#tabLi1').text('완료');
		$('div > ul > li > a#tabLi2').text('접수');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');

		//결과값 초기화
		$('#table1 tbody tr').remove();
		$('div#listCount').text('총 : 0 명');
		$('#status').val(null);
		$('div.tabmenu > ul > li').removeClass('active');
		$('#tabLi1').parent().addClass('active');

	} else if($('select#codeList_1').val() == '4') {
		$('div.selectBox').css('display','none');

		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		$('div > ul > li > a#tabLi2').css('display','block');

		$('#div_select_list2').css('display','inline');

		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('미승인');
		$('li#table3').css('display','none');

		$('div > ul > li > a#tabLi1').text('승인');
		$('div > ul > li > a#tabLi2').text('미승인');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');

		//결과값 초기화
		$('#table1 tbody tr').remove();
		$('div#listCount').text('총 : 0 명');
		$('#status').val(null);
		$('div.tabmenu > ul > li').removeClass('active');
		$('#tabLi1').parent().addClass('active');

	} else if($('select#codeList_1').val() == '5') {
		$('div.selectBox').css('display','none');

		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		$('div > ul > li > a#tabLi2').css('display','block');

		$('#div_select_list2').css('display','inline');

		$('#table1 > a > font').text('배정완료');
		$('#table2 > a > font').text('대기자');
		$('li#table3').css('display','none');

		$('div > ul > li > a#tabLi1').text('배정완료');
		$('div > ul > li > a#tabLi2').text('대기자');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');

		//결과값 초기화
		$('#table1 tbody tr').remove();
		$('div#listCount').text('총 : 0 명');
		$('#status').val(null);
		$('div.tabmenu > ul > li').removeClass('active');
		$('#tabLi1').parent().addClass('active');

	} else if($('select#codeList_1').val() == '6') {
		$('div.selectBox').css('display','none');

		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');

		$('#div_datepicker').css('display','inline');
		$('div > ul > li > a#tabLi2').css('display','block');

		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('미승인');
		$('li#table3').css('display','none');

		$('div > ul > li > a#tabLi1').text('승인');
		$('div > ul > li > a#tabLi2').text('미승인');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');

		//결과값 초기화
		$('#table1 tbody tr').remove();
		$('div#listCount').text('총 : 0 명');
		$('#status').val(null);
		$('div.tabmenu > ul > li').removeClass('active');
		$('#tabLi1').parent().addClass('active');

	} else if($('select#codeList_1').val() == '7') {
		$('div.selectBox').css('display','none');
		$('#div_datepicker').css('display','inline');

		$('div#module_table').css('display','none');
		$('div#loan_search_table').css('display','block');

		$('#loan_member_search').css('display','inline');

		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('미승인');
		$('li#table3').css('display','none');

		$('div > ul > li > a#tabLi1').text('회원');
		$('div > ul > li > a#tabLi2').css('display','none');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');

		//결과값 초기화
		$('#table1 tbody tr').remove();
		$('div#listCount').text('총 : 0 명');
		$('#status').val(null);
		$('div.tabmenu > ul > li').removeClass('active');
		$('#tabLi1').parent().addClass('active');

	} else if($('select#codeList_1').val() == '8') {
		$('div.selectBox').css('display','none');
		$('div#member-list-layer').load('memberLayer2.do');

	} else {
		$('div.selectBox').css('display','none');
	}

	$('select#codeList_2').on('change', function(e) {

		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}

		if($(this).val() != '') {
			$('div#module-search-layer').load('search.do?' + serializeCustom($('form#emailSendForm')));

			//결과값 초기화
			$('#table1 tbody tr').remove();
			$('div#listCount').text('총 : 0 명');
			$('#status').val(null);
			$('div.tabmenu > ul > li').removeClass('active');
			$('#tabLi1').parent().addClass('active');
		}
		e.preventDefault();
	});

	$('select#codeList_3').on('change', function(e) {

		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}

		if($(this).val() != '') {
			$('div#module-search-layer').load('search.do?' + serializeCustom($('form#emailSendForm')));

			//결과값 초기화
			$('#table1 tbody tr').remove();
			$('div#listCount').text('총 : 0 명');
			$('#status').val(null);
			$('div.tabmenu > ul > li').removeClass('active');
			$('#tabLi1').parent().addClass('active');
		}
		e.preventDefault();
	});

	$('select#codeList_4').on('change', function(e) {

		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}

		if($(this).val() != '') {
			$('div#module-search-layer').load('search.do?' + serializeCustom($('form#emailSendForm')));

			//결과값 초기화
			$('#table1 tbody tr').remove();
			$('div#listCount').text('총 : 0 명');
			$('#status').val(null);
			$('div.tabmenu > ul > li').removeClass('active');
			$('#tabLi1').parent().addClass('active');
		}
		e.preventDefault();
	});

	$('select#codeList_5').on('change', function(e) {

		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}

		if($(this).val() != '') {
			$('div#module-search-layer').load('search.do?' + serializeCustom($('form#emailSendForm')));

			//결과값 초기화
			$('#table1 tbody tr').remove();
			$('div#listCount').text('총 : 0 명');
			$('#status').val(null);
			$('div.tabmenu > ul > li').removeClass('active');
			$('#tabLi1').parent().addClass('active');
		}
		e.preventDefault();
	});


// 	if(!$('select#codeList_9').val() == '' && $('#codeList_10 > option').size() < 2) {
// 		$('div#module-search-layer').load('search.do?' + serializeCustom($('form#emailSendForm')));
// 	}

	$('select#codeList_9').on('change', function(e) {

		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}

		if($(this).val() != '') {
			$('div#module-search-layer').load('search.do?' + serializeCustom($('form#emailSendForm')));

			//결과값 초기화
			$('#table1 tbody tr').remove();
			$('div#listCount').text('총 : 0 명');
			$('#status').val(null);
			$('div.tabmenu > ul > li').removeClass('active');
			$('#tabLi1').parent().addClass('active');
		}
		e.preventDefault();
	});

	$('a.search_btn').on('click', function(e) {

		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}

		if($('select#codeList_2').val() == "" && $('select#codeList_1').val() != '7') {
			alert('검색조건을 선택하지 않고 조회 시 오래걸릴 수 있습니다. ');
		}

		if($('select#codeList_1').val() == '7') {

			if($('#codeList_9').val() == '') {
				alert('해당 도서관은 대출이력조회를 사용하실 수 없습니다.\n관리자에게 문의바랍니다.');
				return false;
			}

			if($('#start_date').val() == '' || $('#end_date').val() == '') {
				
				var user_positn = $('#codeList_6').val();
				
				if(user_positn != 'WEB' && user_positn != '0010' && user_positn != '9999') {
					alert('대출이력조회 시 기간은 필수선택 사항입니다.');
					return false;
				}
				
			}
		}

		$('#status').val('1');

		$('div#loading2, img#loading_img2').show();
		$('div#member-list-layer').load('memberLayer.do');
		e.preventDefault();
	});
});
</script>

<!-- 각 모듈 검색 조건 -->
<form:form id="emailSendForm" modelAttribute="emailSend" action="save.do" method="post" onsubmit="return false;">
	<form:hidden path="editMode"/>
	<form:hidden path="status"/>
	<form:hidden path="tab_status"/>
	<form:hidden path="apply_status"/>
	<form:hidden path="user_phone"/>
	<form:hidden path="homepage_code"/>
	<!-- 최고관리자 , 관리자 홈페이지 아이디 관련 -->
	<c:if test="${!member.admin}">
		<form:hidden path="homepage_id"/>
	</c:if>
	<c:if test="${member.admin}">
		<div class="search">
			<fieldset>
				<label class="blind">검색</label>
				<form:select class="selectmenu-search" style="width:250px" id="homepage_id" path="homepage_id">
					<option value="">홈페이지를 선택하세요.</option>
					<c:forEach var="i" varStatus="status" items="${homepageList}">
						<option value="${i.homepage_id}" <c:if test="${i.homepage_id eq emailSend.homepage_id }">selected="selected"</c:if>>${i.homepage_name}</option>
					</c:forEach>
				</form:select>
			</fieldset>
		</div>
	</c:if>

	<div class="search">
		<fieldset>
			메뉴구분 :
			<label class="blind">메뉴구분</label>
			<form:select path="codeList_1" cssStyle="height:24px;">
				<option value="">===선택===</option>
				<c:forEach var="i" varStatus="status" items="${menuType}">
					<option value="${i.code_id}" <c:if test="${i.code_id eq emailSend.codeList_1}">selected="selected"</c:if>>${i.code_name}</option>
				</c:forEach>
			</form:select>

			<div id="div_select_list2" class="selectBox" style="display:inline;">
				모듈2 :<label class="blind">모듈</label>
				<form:select path="codeList_2" cssStyle="height:24px;">
					<option value="">===선택===</option>
					<c:forEach var="i" varStatus="status" items="${codeList_2}">
						<c:if test="${!emailSend.code_type_2}">
							<option value="${i.code_id_2}" <c:if test="${i.code_id_2 eq emailSend.codeList_2}">selected="selected"</c:if>>${i.code_name_2}</option>
						</c:if>
						<c:if test="${emailSend.code_type_2}">
							<option value="${i.code_id}" <c:if test="${i.code_id eq emailSend.codeList_2}">selected="selected"</c:if>>${i.code_name}</option>
						</c:if>
					</c:forEach>
				</form:select>
			</div>

			<div id="div_select_list3" class="selectBox" style="display:inline;">
				모듈3 : <label class="blind">모듈</label>
				<form:select path="codeList_3" cssStyle="height:24px;">
					<option value="">===선택===</option>
					<c:forEach var="i" varStatus="status" items="${codeList_3}">
						<c:if test="${!emailSend.code_type_3}">
							<option value="${i.code_id_3}" <c:if test="${i.code_id_3 eq emailSend.codeList_3}">selected="selected"</c:if>>${i.code_name_3}</option>
						</c:if>
						<c:if test="${emailSend.code_type_3}">
							<option value="${i.code_id}" <c:if test="${i.code_id eq emailSend.codeList_3}">selected="selected"</c:if>>${i.code_name}</option>
						</c:if>
					</c:forEach>
				</form:select>
			</div>

			<div id="div_select_list4" class="selectBox" style="display:inline;">
				모듈4 :<label class="blind">모듈</label>
				<form:select path="codeList_4" cssStyle="height:24px;">
					<option value="">===선택===</option>
					<c:forEach var="i" varStatus="status" items="${codeList_4}">
						<c:if test="${!emailSend.code_type_4}">
							<option value="${i.code_id_4}" <c:if test="${i.code_id_4 eq emailSend.codeList_4}">selected="selected"</c:if>>${i.code_name_4}</option>
						</c:if>
						<c:if test="${emailSend.code_type_4}">
							<option value="${i.code_id}" <c:if test="${i.code_id eq emailSend.codeList_4}">selected="selected"</c:if>>${i.code_name}</option>
						</c:if>
					</c:forEach>
				</form:select>
			</div>

			<div id="div_select_list5" class="selectBox" style="display:inline;">
				모듈5 :<label class="blind">모듈</label>
				<form:select path="codeList_5" cssStyle="height:24px;">
					<option value="">===선택===</option>
					<c:forEach var="i" varStatus="status" items="${codeList_5}">
						<c:if test="${!emailSend.code_type_5}">
							<option value="${i.code_id_5}" <c:if test="${i.code_id_5 eq emailSend.codeList_5}">selected="selected"</c:if>>${i.code_name_5}</option>
						</c:if>
						<c:if test="${emailSend.code_type_5}">
							<option value="${i.code_id}" <c:if test="${i.code_id eq emailSend.codeList_5}">selected="selected"</c:if>>${i.code_name}</option>
						</c:if>
					</c:forEach>
				</form:select>
			</div>

			<div id="div_datepicker" class="selectBox" style="display:none;">
				기간 :<form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
			</div>

			<div id="loan_member_search" class="selectBox" style="display:none;">
				신분 :
				<form:select path="codeList_6" cssStyle="height:24px;">
					<option value="">===선택===</option>
					<c:forEach var="i" varStatus="status" items="${codeList_6}">
						<option value="${i.CODE}" <c:if test="${i.CODE eq emailSend.codeList_6}">selected="selected"</c:if>>${i.NAME}</option>
					</c:forEach>
				</form:select>
				나이(생년월일) :
					<form:input path="start_age" placeholder="19990919" cssStyle="width:80px;" maxlength="8" class="text"/>~
					<form:input path="end_age" placeholder="20120919" cssStyle="width:80px;" maxlength="8" class="text"/>
				성별 :
				<form:select path="codeList_8" cssStyle="height:24px;">
					<option value="">===선택===</option>
					<c:forEach var="i" varStatus="status" items="${codeList_8}">
						<option value="${i.CODE}" <c:if test="${i.CODE eq emailSend.codeList_8}">selected="selected"</c:if>>${i.NAME}</option>
					</c:forEach>
				</form:select>
<!-- 				기관 : -->
<%-- 				<form:select path="codeList_9" cssStyle="height:24px;" disabled="true">									 --%>
<!-- 					<option value="">===선택===</option> -->
<%-- 					<c:forEach var="i" varStatus="status" items="${codeList_9}">					 --%>
<%-- 						<option value="${i.CODE}" <c:if test="${i.CODE eq emailSend.homepage_code}">selected="selected"</c:if>>${i.NAME}</option> --%>
<%-- 					</c:forEach> --%>
<%-- 				</form:select> --%>
<!-- 				소속 : -->
<%-- 				<form:select path="codeList_10" cssStyle="height:24px;">									 --%>
<!-- 					<option value="">===선택===</option> -->
<%-- 					<c:forEach var="i" varStatus="status" items="${codeList_10}"> --%>
<%-- 						<option value="${i.CODE}" <c:if test="${i.CODE eq emailSend.codeList_10}">selected="selected"</c:if>>${i.NAME}</option> --%>
<%-- 					</c:forEach> --%>
<%-- 				</form:select> --%>
				<form:hidden path="codeList_9" value="${emailSend.homepage_code }"/>
			</div>

			<a class="btn search_btn">검색</a>
		</fieldset>
	</div>
</form:form>