<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('input#chkAll').on('click', function() {
		$('.categoryChk').prop('checked', false);
		$('#viewPage').val(1);
		doGetLoad('bundleList.do', $('form#bundleList').serialize());
	});
	
	$('.categoryChk').on('click', function() {
		$('input#chkAll').prop('checked', false);
		$('#viewPage').val(1);
		doGetLoad('bundleList.do', $('form#bundleList').serialize());
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('bundleList.do', $('form#bundleList').serialize());
	});
	
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${fn:length(bundleList)}' > 0) {
			$('#editMode').val('bundleList');
			$('#bundleList').attr('method', 'POST');
			$('#bundleList').attr('action', 'excelDownload.do').submit();
			$('form#bookPackage').submit();
			
			$('#bundleList').attr('method', 'GET');
			$('#bundleList').attr('action', 'bundleList.do');
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
		if(confirm('선택 항목들을 삭제하시겠습니까?\n꾸러미내 도서정보도 전부 삭제됩니다.')) {
			$('form#bundleList').attr('action', 'deleteBook.do');
			$('form#bundleList').attr('method', 'POST');
			$('#editMode').val('DELETE_CHECK');
			if(doAjaxPost($('form#bundleList'))) {
				location.reload();
			}
		}
	});
	
});

function addBook() {
	
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'addBook.do',
		method: 'GET',
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		width: 800,
		height: 410,
		resizable: false,
		modal: true,
		title: '학생추천도서 책 등록',
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
						url : 'saveBook.do',
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


function getBookDetail(book_package_bundle_detail_idx) {
	
	var ajaxData = {
		'book_package_bundle_detail_idx' : book_package_bundle_detail_idx
	};
	
	modal_layer_add('dialog_layer');

	$.ajax({
		type: "POST",
		url: 'getBookDetail.do',
		data: ajaxData,
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		width: 790,
		height: 400,
		resizable: false,
		modal: true,
		title: '학생추천도서 수정',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text: "수정",
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
						url : 'modifyBook.do?book_package_bundle_detail_idx=' + book_package_bundle_detail_idx,
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

function bookPackageBundleEdit(book_package_bundle_detail_idx) {
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'bookPackageBundleEdit.do',
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
				text : '저장',
				'class' : 'btn btn1',
				click : function() {
					bookPackageBundleSave();
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

function getBookPackage(book_package_bundle_detail_idx) {
	var ajaxData = {
		'book_package_bundle_detail_idx' : book_package_bundle_detail_idx
	};
	
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'getBookPackage.do',
		method: 'GET',
		data: ajaxData,
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		width: 700,
		height: 250,
		resizable: false,
		modal: true,
		title: '학생추천도서 꾸러미 담기',
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
					addBookPackageDetail();
				}
			},
			{
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

function waitingReservationStep() {
	if($('input:checkbox[name=book_package_bundle_detail_idx_arr]:checked').length < 1) {
		alert('꾸러미에 담을 도서를 선택해 주세요.');
	} else {
		modal_layer_add('dialog_layer');

		$.ajax({
			type: 'POST',
			url: 'getBookPackageAll.do',
			data: $('input[name=book_package_bundle_detail_idx_arr]').serialize(),
			success: function(html){
				$('#dialog_layer').html(html);
			},error: function(html){
			}
		});

		$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
			width: 700,
			height: 250,
			resizable: false,
			modal: true,
			title: '학생추천도서 꾸러미 담기',
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
						addBookPackageDetailAll();
					}
				},
				{
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
}
</script>
<style>
div#category-box {padding-bottom: 20px;border-bottom: 2px solid #554246;margin-bottom: 20px;}
input[type="checkbox"].customCheck {display: none;}
input[type="checkbox"].customCheck + label, input[type="checkbox"].customCheck:checked + label {display: inline-block;cursor: pointer;padding-left: 30px;padding-right: 15px;}
input[type="checkbox"].customCheck + label {color: #222;background: url("/resources/common/img/icon_cate_chk.png") no-repeat;}
input[type="checkbox"].customCheck:checked + label {color: #1ba8ed;background: url("/resources/common/img/icon_cate_chk_on.png") no-repeat;}

.group-box {position: relative;padding: 20px 10px;border-bottom: 1px solid #e5e5e5;}
.group-box::after {content:''; display:block; clear:both;}
.book_check {position: absolute;left: 0;}
.img-box {display:block;float:left;width: 120px;height: 170px;border: 1px solid #ccc;margin-left: 10px;}
.content-box {display: inline-block;width: 75%;padding: 0 20px;}
.subject a {display: inline-block;margin-right: 20px;font-size: 19px;font-weight: bold;color: #222;}
.subject .ing {display: inline-block;width: 35px;height: 35px;margin: 0 10px 8px 0;border-radius: 100%;background: #ff5700;font-size: 11px;line-height: 35px;color: #fff;letter-spacing: -0.075em;text-align: center;}
.step1 {border: 1px solid #1ec0b0;color: #1ec0b0;}
.step2 {border: 1px solid #f9a406;color: #f9a406;}
.step1, .step2 {display: inline-block;margin-right: 5px;padding: 3px 5px;font-family: 'dotum';font-size: 11px;line-height: 1;letter-spacing: -1px;text-align: center;}
ul.pub_info {padding: 10px 0 15px;}
ul.pub_info li {display: inline-block;font-size: 13px;padding-right: 15px;}
.book-desc {font-size: 13px;}
.keyword-box {border-top: 1px dashed #e5e5e5;padding-top: 14px;margin-top: 18px;}
.content-box span.keyword {display: inline-block;padding: 0 10px;background: #e8f2f7;border-radius: 20px;font-size: 12px;color: #7e8c93;}
.btn-box {position: absolute;top: 86px;right: 52px;text-align: center;}
.btn-box a {display: block;height: 32px;padding: 5px 20px 5px 22px;border-radius: 50px;line-height: 35px;}
.btn-box a.reserv {border: 2px solid #cbbcf2;color: #7d57de;}
span.loan-cnt {display: inline-block;width: 60px;height: 60px;margin: 30px auto 0;border-radius: 100%;background: #1ba8ed;text-align: center;font-size: 13px;color: #8dd4f6;}
span.loan-cnt strong {display: block;padding-top: 10px;font-family: 'Montserrat',sans-serif;font-size: 20px;letter-spacing: 0;color: #fff;}
</style>

<form:form id="bundleList" modelAttribute="bookPackageBundle" action="bundleList.do" method="GET">
<div id="category-box">
	<form:checkbox path="category" value="all" checked="${fn:contains(bookPackageBundle.category, 'all') ? 'checked' : ''}" label="전체" id="chkAll" class="customCheck"/>
	<form:checkbox path="category" value="000" checked="${fn:contains(bookPackageBundle.category, '000') ? 'checked' : ''}" label="총류" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="100" checked="${fn:contains(bookPackageBundle.category, '100') ? 'checked' : ''}" label="철학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="200" checked="${fn:contains(bookPackageBundle.category, '200') ? 'checked' : ''}" label="종교" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="300" checked="${fn:contains(bookPackageBundle.category, '300') ? 'checked' : ''}" label="사회과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="400" checked="${fn:contains(bookPackageBundle.category, '400') ? 'checked' : ''}" label="자연과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="500" checked="${fn:contains(bookPackageBundle.category, '500') ? 'checked' : ''}" label="기술과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="600" checked="${fn:contains(bookPackageBundle.category, '600') ? 'checked' : ''}" label="예술" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="700" checked="${fn:contains(bookPackageBundle.category, '700') ? 'checked' : ''}" label="언어" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="800" checked="${fn:contains(bookPackageBundle.category, '800') ? 'checked' : ''}" label="문학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="900" checked="${fn:contains(bookPackageBundle.category, '900') ? 'checked' : ''}" label="역사" class="customCheck categoryChk"/>
</div>
<div class="infodesk">
	<div class="button">
		<a href="javascript:void(0);" class="btn btn1 left" onclick="bookPackageBundleEdit();"><i class="fa fa-plus"></i><span>꾸러미 생성</span></a>
		<a href="javascript:void(0);" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>도서목록 다운받기</span></a>
		<a href="javascript:void(0);" class="btn btn5 left" onclick="addBook();"><i class="fa fa-plus"></i><span>도서 등록</span></a>
	</div>
</div>
<c:if test="${fn:length(bundleList) < 1}">
<div align="center">
	<h3>등록된 학생추천도서꾸러미 책 리스트가 없습니다.</h3>
</div>
</c:if>
<div>
	<c:forEach items="${bundleList}" var="i" varStatus="status">
	<div class="group-box">
		<form:checkbox path="book_package_bundle_detail_idx_arr" cssClass="book_check" value="${i.book_package_bundle_detail_idx}"/>
		<div class="img-box">
			<c:choose>
				<c:when test="${not empty i.image_link}">
				<a href="${i.desc_link}" target="_blank">
					<img src="${i.image_link}" alt="${i.book_package_name}" width="100%" height="100%">
				</a>
				</c:when>
				<c:when test="${not empty i.server_file_name}">
				<a href="#">
					<img src="${getContextPath}/data/bookPackageBundle/${i.server_file_name}" alt="${i.book_package_name}" width="100%" height="100%">
				</a>
				</c:when>
				<c:otherwise>
				<img src="/resources/common/img/noimg-gall.png" alt="no-image" height="100%">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="content-box">
			<div class="subject">
				<a href="javascript:void(0);" onclick="getBookDetail('${i.book_package_bundle_detail_idx}');">${i.book_package_name}</a>
			</div>
			<div>
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
				<c:forTokens items="${i.category}" delims="," var="category">
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
			</div>
			<div>
				<ul class="pub_info">
					<li>${i.author}</li>
					<li>|</li>
					<li>${i.publisher}</li>
					<li>|</li>
					<li>${i.publish_year}</li>
				</ul>
			</div>
			<div class="book-desc">
				${fn:substring(i.content, 0, 85)}<c:if test="${fn:length(i.content) > 85}">...</c:if>
			</div>
			<div class="keyword-box">
				<c:forTokens items="${i.keyword}" delims="," var="keyword">
				<span class="keyword">${keyword}</span>
				</c:forTokens>
			</div>
		</div>
		<div class="btn-box">
			<a href="javascript:void(0);" class="dialog-req reserv"  onclick="getBookPackage('${i.book_package_bundle_detail_idx}');">꾸러미 담기</a>
		</div>
	</div>
	</c:forEach>
	<br>
	<div class="ui-state-highlight">
		<em>* 꾸러미 생성 버튼을 클릭하셔야 꾸러미를 선택하실수 있습니다.</em><br>
		<em>* 꾸러미 담기를 클릭하시면 선택하신 도서가 꾸러미에 추가됩니다.(여러권을 선택 하셨다면 전체꾸러미 담기를 클릭해주세요.)</em>
	</div>
	<br>
	<a href="javascript:void(0);" id="all-check" class="btn" keyValue="N">전체 선택/해제</a>
	<a href="javascript:void(0);" id="delete-check" class="btn">선택 게시글삭제</a>
	<a href="javascript:void(0);" id="addBook" class="btn" onclick="waitingReservationStep();">전체 꾸러미 담기</a>
</div>

<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bundleList"/>
	<jsp:param name="pagingUrl" value="bundleList.do"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="book_package_name">서명</form:option>
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