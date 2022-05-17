<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	// 책 꾸러미 대출 신청
	$('.dialog-req').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('loanEdit.do?editMode=ADD&book_package_bundle_idx='+$(this).attr('keyValue'), function(response, status, xhr) {
			$('#dialog-2').dialog('open');
		});
	});
	
	$('input#chkAll').on('click', function() {
		$('.categoryChk').prop('checked', false);
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackageBundle_1').serialize());
	});
	
	$('.categoryChk').on('click', function() {
		$('input#chkAll').prop('checked', false);
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackageBundle_1').serialize());
	});
	
	$('select#grade, select#lender_count').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackageBundle_1').serialize());
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackageBundle_1').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${fn:length(bookPackageBundleList)}' > 0) {
			$('#editMode').val('bookPackage');
			$('#bookPackageBundle_1').attr('method', 'POST');
			$('#bookPackageBundle_1').attr('action', 'excelDownload.do').submit();
			$('form#bookPackage').submit();
			
			$('#bookPackageBundle_1').attr('method', 'GET');
			$('#bookPackageBundle_1').attr('action', 'index.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
	});
	
	$('#all-check').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.book_check').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.book_check').prop('checked', false);
		}
	});
	
	$('#delete-check').on('click', function(e) {
		e.preventDefault();
		if($('input[name="book_package_bundle_idx_arr"]:checked').length < 1) {
			alert('삭제할 꾸러미를 선택하세요.');
			return false;
		}
		
		if(confirm('선택 항목들을 삭제하시겠습니까?\n꾸러미내 도서정보도 전부 삭제됩니다.')) {
			$('form#bookPackageBundle_1').attr('action', 'delete.do');
			$('form#bookPackageBundle_1').attr('method', 'POST');
			$('#editMode').val('DELETE_CHECK');
			if(doAjaxPost($('form#bookPackageBundle_1'))) {
				location.reload();
			}
		}
	});
	
});
function bookPackageBundleModify(book_package_bundle_idx) {
	var ajaxData = {
		'book_package_bundle_idx' : book_package_bundle_idx
	}; 
	
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'bookPackageBundleModify.do?book_package_bundle_idx=' + book_package_bundle_idx,
		method: 'GET',
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '학생추천도서 꾸러미 설정',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text : '수정',
				'class' : 'btn btn1',
				click : function() {
					modifyBookPackageBundle();
				}
			},
			{
				text: "닫기",
				"class": 'btn btn_round btn_gray',
				click: function() {
					$(this).dialog('close');
				}
			}
		]
	});

	$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 360
	});
	
}

function getBookPackage() {
	
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'getBookPackage.do',
		method: 'GET',
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		width: 800,
		height: 510,
		resizable: false,
		modal: true,
		title: '학생추천도서 꾸러미 등록',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

					if($('#doc_file').val() == '') {
						$('#doc_file').remove();
					}

					var file = $('#mfile');
					if ( $('#mfile').val() == '' ) {
						$('#mfile').remove();
					}

					jQuery.ajaxSettings.traditional = true;
					var option = {
						url : 'save.do',
						type : "POST",
						success: function(response) {
							 if(response.valid) {
				                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
									alert(response.message);
									location.reload();
				                 }
							} else {
				                for(var i =0 ; i < response.result.length ; i++) {
									alert(response.result[i].code);
									$('#'+response.result[i].field).focus();
									break;
								}
								$('td#doc_file_td').html('<input type="file" id="doc_file" name="doc_file" class="text" title="파일선택">');
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#bookPackageEdit').ajaxSubmit(option);
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
					$('#dialog_layer').remove();
				}
			}
		]
	});
}

function drawBookPackageDetailData(book_package_bundle_idx) {
	var ajaxData = {
			'book_package_bundle_idx' : book_package_bundle_idx
	};

	$.ajax({
		type: "POST",
		url: 'bookPackageBundleDetail.do',
		data: ajaxData,
		success: function(html){
			$('#dialog_layer_detail').html(html);
		},error: function(html){
		}
	});
	
}

function getBookPackageDetail(book_package_bundle_idx) {
	
	drawBookPackageDetailData(book_package_bundle_idx);

	$('#dialog_layer_detail').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '학생추천도서 꾸러미',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text: "닫기",
				"class": 'btn btn_round btn_gray',
				click: function() {
					$(this).dialog('close');
					location.reload();
				}
			}
		]
	});

	$("#dialog_layer_detail").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1300,
		height: 500
	});
}
</script>
<style>
div#category-box {padding-bottom: 20px;border-bottom: 2px solid #554246;margin-bottom: 20px;}
input[type="checkbox"].customCheck {display: none;}
input[type="checkbox"].customCheck + label, input[type="checkbox"].customCheck:checked + label {display: inline-block;cursor: pointer;padding-left: 30px;padding-right: 15px;}
input[type="checkbox"].customCheck + label {color: #222;background: url("/resources/common/img/icon_cate_chk.png") no-repeat;}
input[type="checkbox"].customCheck:checked + label {color: #1ba8ed;background: url("/resources/common/img/icon_cate_chk_on.png") no-repeat;}

.group-box {position: relative;padding: 38px 10px;border-bottom: 1px solid #e5e5e5;}
.group-box::after {content:''; display:block; clear:both;}
.book_check {position: absolute;left: 0;}
.content-box {display: inline-block;width: 75%;padding: 0 11px;}
.subject a {display: inline-block;margin-right: 20px;font-size: 20px;font-weight: bold;color: #222;}
.subject .ing {display: inline-block;width: 35px;height: 35px;margin: 0 10px 8px 0;border-radius: 100%;background: #ff5700;font-size: 11px;line-height: 35px;color: #fff;letter-spacing: -0.075em;text-align: center;}
.step1 {border: 1px solid #1ec0b0;color: #1ec0b0;}
.step2 {border: 1px solid #f9a406;color: #f9a406;}
.step1, .step2 {display: inline-block;margin-right: 5px;padding: 3px 5px;font-family: 'dotum';font-size: 11px;line-height: 1;letter-spacing: -1px;text-align: center;}
ul.pub_info {padding: 10px 0 15px;}
ul.pub_info li {display: inline-block;font-size: 13px;padding-right: 15px;}
/* .book-desc {font-size: 13px;} */
.book-desc {border-top: 1px dashed #e5e5e5;padding-top: 14px;margin-top: 18px;}
.keyword-box {border-top: 1px dashed #e5e5e5;padding-top: 14px;margin-top: 18px;}
.content-box span.keyword {display: inline-block;padding: 0 10px;background: #e8f2f7;border-radius: 20px;font-size: 12px;color: #7e8c93;}
.btn-box {position: absolute;top: 15px;right: 0;text-align: center;}
.btn-box a {display: block;height: 31px;padding: 0 20px 0 35px;border-radius: 50px;line-height: 32px;}
.btn-box a.modify {display: block;height: 31px;padding: 0 20px 0 22px;border-radius: 50px;line-height: 32px;}
.btn-box a.loan {border: 2px solid #d2dfe8;color: #5c90b5;background: url(/resources/common/img/icon_bt_apply01.png) no-repeat 14px 50%;}
.btn-box a.reserv {border: 2px solid #cbbcf2;color: #7d57de;background: url(/resources/common/img/icon_bt_apply01_3.png) no-repeat 14px 50%;}
.btn-box a.docfile {border: 2px solid #d2dfe8;color: #5c90b5;position: absolute;top: 0px;right: 130px;padding: 0 20px 0 25px;}
span.loan-cnt {display: inline-block;width: 60px;height: 60px;margin: 18px auto 19px;border-radius: 100%;background: #1ba8ed;text-align: center;font-size: 13px;color: #8dd4f6;}
span.loan-cnt strong {display: block;padding-top: 10px;font-family: 'Montserrat',sans-serif;font-size: 20px;letter-spacing: 0;color: #fff;}
</style>

<form:form id="bookPackageBundle_1" modelAttribute="bookPackageBundle" action="index.do" method="GET">
<form:hidden path="editMode"/>
<div id="category-box">
	<form:checkbox path="category" value="all" checked="${fn:contains(bookPackage.category, 'all') ? 'checked' : ''}" label="전체" id="chkAll" class="customCheck"/>
	<form:checkbox path="category" value="000" checked="${fn:contains(bookPackage.category, '000') ? 'checked' : ''}" label="총류" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="100" checked="${fn:contains(bookPackage.category, '100') ? 'checked' : ''}" label="철학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="200" checked="${fn:contains(bookPackage.category, '200') ? 'checked' : ''}" label="종교" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="300" checked="${fn:contains(bookPackage.category, '300') ? 'checked' : ''}" label="사회과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="400" checked="${fn:contains(bookPackage.category, '400') ? 'checked' : ''}" label="자연과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="500" checked="${fn:contains(bookPackage.category, '500') ? 'checked' : ''}" label="기술과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="600" checked="${fn:contains(bookPackage.category, '600') ? 'checked' : ''}" label="예술" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="700" checked="${fn:contains(bookPackage.category, '700') ? 'checked' : ''}" label="언어" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="800" checked="${fn:contains(bookPackage.category, '800') ? 'checked' : ''}" label="문학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="900" checked="${fn:contains(bookPackage.category, '900') ? 'checked' : ''}" label="역사" class="customCheck categoryChk"/>
</div>
<div class="infodesk">
	<form:select path="grade" cssClass="selectmenu">
		<form:option value="">수준별보기</form:option>
		<form:option value="3">초</form:option>
		<form:option value="4">중</form:option>
		<form:option value="5">고</form:option>
	</form:select>
	<form:select path="lender_count" cssClass="selectmenu">
		<form:option value="-1">상태전체</form:option>
		<form:option value="1">대출중</form:option>
		<form:option value="0">대출가능</form:option>
	</form:select>
	<div class="button">
		<a href="javascript:void(0);" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>꾸러미 도서목록 다운받기</span></a>
	</div>
</div>
<div>
	<c:forEach items="${bookPackageBundleList}" var="i" varStatus="status">
	<div class="group-box">
		<c:choose>
			<c:when test="${i.lender_count > 0}">
			</c:when>
			<c:otherwise>
				<form:checkbox path="book_package_bundle_idx_arr" cssClass="book_check" value="${i.book_package_bundle_idx}"/>
			</c:otherwise>
		</c:choose>
		<div class="content-box">
			<div class="subject">
				<c:if test="${i.lender_count > 0}"><span class="ing">대출중</span></c:if>
				<a href="javascript:void(0);" onclick="getBookPackageDetail('${i.book_package_bundle_idx}');">${i.book_package_bundle_title}</a>
			</div>
			<%-- <div>
				 <c:if test="${not empty i.grade}">
				<span class="step1">
				<c:choose>
					<c:when test="${i.grade eq '3'}">초등1-2학년</c:when>
					<c:when test="${i.grade eq '4'}">초등3-4학년</c:when>
					<c:when test="${i.grade eq '5'}">초등5-6학년</c:when>
					<c:when test="${i.grade eq '6'}">중학생</c:when>
					<c:when test="${i.grade eq '7'}">고등학생</c:when>
				</c:choose>
				</span>
				</c:if>
				<c:forEach items="${bookPackageCategoryList}" var="j" varStatus="status">
					<c:if test="${i.book_package_bundle_idx == j.book_package_bundle_idx}">
					<c:forTokens items="${j.category}" delims="," var="category">
						<span class="step2">
						<c:choose>
							<c:when test="${category eq '000'}">총류</c:when>
							<c:when test="${category eq '100'}">철학</c:when>
							<c:when test="${category eq '200'}">종교</c:when>
							<c:when test="${category eq '300'}">사회과학</c:when>
							<c:when test="${category eq '400'}">자연과학</c:when>
							<c:when test="${category eq '500'}">기술과학</c:when>
							<c:when test="${category eq '600'}">예술</c:when>
							<c:when test="${category eq '700'}">언어</c:when>
							<c:when test="${category eq '800'}">문학</c:when>
							<c:when test="${category eq '900'}">역사</c:when>
						</c:choose>
						</span>
					</c:forTokens>
					</c:if>
				</c:forEach> 
			</div>
			<div>
				<ul class="pub_info">
				</ul>
			</div> --%>
			<div class="book-desc">
				<c:forEach items="${bookPackageCategoryList}" var="j" varStatus="status">
					<c:if test="${i.book_package_bundle_idx == j.book_package_bundle_idx}">
						<c:forTokens items="${j.book_package_bundle_idx}" delims="," var="book_package_name">
						<span class="keyword">${fn:substring(j.book_package_name, 0, 85)}<c:if test="${fn:length(j.book_package_name) > 85}">...</c:if></span>
						</c:forTokens>
					</c:if>
				</c:forEach>
			</div>
			<div class="keyword-box">
				<%-- <c:forEach items="${bookPackageCategoryList}" var="j" varStatus="status">
					<c:if test="${i.book_package_bundle_idx == j.book_package_bundle_idx}">
						<c:forTokens items="${j.keyword}" delims="," var="keyword">
						<span class="keyword">${keyword}</span>
						</c:forTokens>
					</c:if>
				</c:forEach> --%>
			</div>
		</div>
		<div class="btn-box" style="margin-top: 10px;">
			<c:choose>
				<c:when test="${i.lender_count > 0}">
					<a href="javascript:void(0);" class="dialog-req reserv" keyValue="${i.book_package_bundle_idx}">예약신청</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:void(0);" class="dialog-req loan" keyValue="${i.book_package_bundle_idx}">대출신청</a>
				</c:otherwise>
			</c:choose>
			<span class="loan-cnt">
				<strong>${i.loan_count}</strong>권
			</span>
			<a href="javascript:void(0);" class="btn btn1 modify" onclick="bookPackageBundleModify('${i.book_package_bundle_idx}');">꾸러미 수정</a>
		</div>
	</div>
	</c:forEach>
	<c:if test="${fn:length(bookPackageBundleList) < 1}">
	<div align="center">
		<h3>등록된 학생추천도서꾸러미 리스트가 없습니다.</h3>
	</div>
	</c:if>
	<a href="javascript:void(0);" id="all-check" class="btn" keyValue="N">전체 선택/해제</a>
	<a href="javascript:void(0);" id="delete-check" class="btn">선택 꾸러미 삭제</a>
</div>

<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bookPackageBundle_1"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="book_package_bundle_title">꾸러미 제목</form:option>
			<form:option value="keyword">키워드</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="책 꾸러미 "></div>
<div id="dialog-2" class="dialog-common" title="책 꾸러미  신청"></div>
<div id="dialog_layer_detail" class="dialog-common" title="학생추천도서 꾸러미"></div>