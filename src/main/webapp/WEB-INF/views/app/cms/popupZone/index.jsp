<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
		}
		else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${popupZone.homepage_id}', function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}

		e.preventDefault();
	});

	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=${popupZone.homepage_id}&popup_zone_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a#delete').on('click', function(e) {
		if(confirm('선택된 팝업존을 삭제 하시겠습니까?')) {
			$('input#popup_zone_idx_1').val($(this).attr('keyValue'));

			$.ajax({
				url : 'delete.do',
				async : false,
				data : serializeObject($('#popup_zone_1')),
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						location.reload();
					}
				}
			});
		}

		e.preventDefault();
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			doGetLoad('index.do', serializeCustom($('#popup_zone_1')));
		}

		e.preventDefault();
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#popup_zone_1')));
	});

	$('select#use_yn, select#rowCount').on('change', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#popup_zone_1')));
	});
	
	$('a#print_seq_up').on('click', function(e) {
		e.preventDefault();
		$('input#popup_zone_idx_print').val($(this).data('idx'));
		$('input#popup_zone_name_print').val($(this).data('name'));
		$('input#start_date_print').val($(this).data('startdate'));
		$('input#end_date_print').val($(this).data('enddate'));
		$('input#link_url_print').val($(this).data('url'));
		var print_seq = $(this).data('printseq');
		print_seq = Number(print_seq) + 1;
		
		$('input#print_seq_print').val(print_seq);

		jQuery.ajaxSettings.traditional = true;

		var option = {
			url : 'save.do',
			type : 'POST',
			data : $('#popup_zone_print_seq').serialize(),
			enctype : 'multipart/form-data',
			success: function(response) {
				 if(response.valid) {
					alert(response.message);
					location.reload();
				} else {
					if ( response.message != null ) {
						alert(response.message);
					}
					else {
						for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							$('#'+response.result[i].field).focus();
							break;
						}
					}
				}
	         },
	         error: function(jqXHR, textStatus, errorThrown) {
	             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
	         }
		};
		$('#popup_zone_print_seq').ajaxSubmit(option);
	});
	
	$('a#print_seq_down').on('click', function(e) {
		e.preventDefault();
		$('input#popup_zone_idx_print').val($(this).data('idx'));
		$('input#popup_zone_name_print').val($(this).data('name'));
		$('input#start_date_print').val($(this).data('startdate'));
		$('input#end_date_print').val($(this).data('enddate'));
		$('input#link_url_print').val($(this).data('url'));
		var print_seq = $(this).data('printseq');
		print_seq = Number(print_seq);
		if (print_seq < 1) {
			print_seq = 0;
		} else {
			print_seq = print_seq - 1;
		}
		
		$('input#print_seq_print').val(print_seq);

		jQuery.ajaxSettings.traditional = true;

		var option = {
			url : 'save.do',
			type : 'POST',
			data : $('#popup_zone_print_seq').serialize(),
			enctype : 'multipart/form-data',
			success: function(response) {
				 if(response.valid) {
					alert(response.message);
					location.reload();
				} else {
					if ( response.message != null ) {
						alert(response.message);
					}
					else {
						for(var i =0 ; i < response.result.length ; i++) {
							alert(response.result[i].code);
							$('#'+response.result[i].field).focus();
							break;
						}
					}
				}
	         },
	         error: function(jqXHR, textStatus, errorThrown) {
	             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
	         }
		};
		$('#popup_zone_print_seq').ajaxSubmit(option);
	});
});
</script>
<form:form id="popup_zone_print_seq" modelAttribute="popupZone" method="POST" action="save.do" encType="multipart/form-data">
<form:hidden path="homepage_id" id="homepage_id_print" value="${homepage.homepage_id}"/>
<form:hidden path="editMode" id="editMode_print" value="MODIFYPRINTSEQ"/>
<form:hidden path="popup_zone_idx" id="popup_zone_idx_print"/>
<form:hidden path="popup_zone_name" id="popup_zone_name_print"/>
<form:hidden path="start_date" id="start_date_print"/>
<form:hidden path="end_date" id="end_date_print"/>
<form:hidden path="link_url" id="link_url_print"/>
<form:hidden path="print_seq" id="print_seq_print"/>
</form:form>

<form:form id="popup_zone_1" modelAttribute="popupZone" method="POST" action="save.do" onsubmit="return false;">
<form:hidden id="editMode_1" path="editMode"/>
<form:hidden id="popup_zone_idx_1" path="popup_zone_idx"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>
<div id="editDisable" class="disableBox">
	<c:if test="${popupZone.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="infodesk">
		검색 결과 : ${paging.totalDataCount}건, 홈페이지 ID : ${popupZone.homepage_id}
		<form:select path="use_yn" class="selectmenu">
			<option value="">사용여부선택</option>
			<form:option value="Y">사용함</form:option>
			<form:option value="N">사용안함</form:option>
		</form:select>
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
		<div class="button btn-group inline">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>팝업존등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<thead>
			<tr>
				<th width="40">순번</th>
				<th width="">팝업존명</th>
				<th width="80">사용여부</th>
				<th width="300">게시기간</th>
				<th width="200">출력순서</th>
				<th width="120">등록일</th>
				<th width="100">기능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(popupZoneList) < 1}">
			<tr style="height:100%">
				<td colspan="7" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${popupZoneList}">
			<tr>
				<td>${popupZone.listRowNum - status.index}</td>
				<td class="left">${i.popup_zone_name}</td>
				<td>${i.use_yn eq 'Y' ? '사용함' : '사용안함'}</td>
				<td class="center">${i.start_date} ~ ${i.end_date}</td>
				<td>
					<a href="#" id="print_seq_up" data-idx="${i.popup_zone_idx}" data-name="${i.popup_zone_name}" data-startdate="${i.start_date}" data-enddate="${i.end_date}" data-url="${i.link_url}" data-printseq="${i.print_seq}">↑</a>
					<a href="#" id="print_seq_down" data-idx="${i.popup_zone_idx}" data-name="${i.popup_zone_name}" data-startdate="${i.start_date}" data-enddate="${i.end_date}" data-url="${i.link_url}" data-printseq="${i.print_seq}">↓</a>
					${i.print_seq}
				</td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
				<td>
					<c:if test="${authU}">
						<a href="" class="btn" id="dialog-modify" keyValue="${i.popup_zone_idx}">수정</a>
					</c:if>
					<c:if test="${authD}">
						<a href="" class="btn" id="delete" keyValue="${i.popup_zone_idx}">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#popup_zone_1"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="popup_zone_name">팝업존명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="팝업존 정보">
</div>