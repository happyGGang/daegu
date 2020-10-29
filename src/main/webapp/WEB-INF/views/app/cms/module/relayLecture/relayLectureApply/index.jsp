<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('select#rowCount').on('change', function() {
		$('#viewPage_ajax').val(1);
		doAjaxLoad('#dialog-2', '/cms/module/relayLecture/relayLectureApply/index.do', $('form#relayLectureApply').serialize());
	});
	
 	$('a#dialog-applyAdd').on('click', function(e){
		e.preventDefault();
		$('#dialog-3').load('/cms/module/relayLecture/relayLectureApply/edit.do?editMode=ADD&homepage_id='+$('#homepage_id').val() + '&lecture_idx=${relayLectureApply.lecture_idx}', function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	}); 
	
	$('a.dialog-modify').on('click', function(e){
		e.preventDefault();
		$('#lecture_apply_idx').val($(this).data('key'));
		$('#dialog-3').load('/cms/module/relayLecture/relayLectureApply/edit.do?editMode=MODIFY&homepage_id='+$('#homepage_id').val() + '&lecture_idx=${relayLectureApply.lecture_idx}&lecture_apply_idx=' + $(this).data('key'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	}); 
	
	$('select.reception_status').on('change', function(e) {
		e.preventDefault();
		$('form#relayLectureApply').attr('action', '/cms/module/relayLecture/relayLectureApply/statusChange.do');
		$('#lecture_apply_idx').val($(this).data('key'));
		$('#reception_status').val($(this).val());
		doAjaxPost($('form#relayLectureApply'));
		
		if(doAjaxPost($('form#relayLectureApply'))) {
			var param = 'homepage_id='+$('#homepage_id').val() + '&lecture_idx='+$('form#relayLectureApply #lecture_idx').val() + '&reception_status='+$('button.btn1').data('status');
			$('#dialog-2').load('/cms/module/relayLecture/relayLectureApply/index.do?' + param);
		}
	});
	
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage_ajax').val(1);
		doAjaxLoad('#dialog-2', '/cms/module/relayLecture/relayLectureApply/index.do', $('form#relayLectureApply').serialize());
	});
	
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
		    {
				text: "취소",
				"class": 'btn',
				click: function() {
					location.reload();
					$(this).dialog('destroy');
				}
			}
		]
	});

	$('#dialog-2').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1100,
		height: 770
	});
	
	$('div#cms_paging_ajax a').on('click', function(e) {
		$('#viewPage_ajax').attr('value', $(this).attr('keyValue'));
		var param = $('#relayLectureApply').serialize();
		$('#dialog-2').load('/cms/module/relayLecture/relayLectureApply/index.do?' + param);
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		$('#relayLectureApply').attr('action', '/cms/module/relayLecture/relayLectureApply/excelDownload.do').submit();
		$('#relayLectureApply').attr('action', '/cms/module/relayLecture/relayLectureApply/save.do');
	});
	
	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#relayLectureApply').attr('action', '/cms/module/relayLecture/relayLectureApply/csvDownload.do').submit();
	});
	
	$('button.sort').on('click', function(e) {
		e.preventDefault();
		$('#viewPage_ajax').attr('value', 1);
		$('#reception_status').val($(this).data('status'));
		var param = $('#relayLectureApply').serialize();
		$('#dialog-2').load('/cms/module/relayLecture/relayLectureApply/index.do?' + param);
	});
	
});
</script>

<form:form modelAttribute="relayLectureApply">
<form:hidden path="homepage_id"/>
<form:hidden path="lecture_idx"/>
<form:hidden path="lecture_apply_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="reception_status"/>

	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		
		<form:select path="rowCount" cssClass="selectmenu">
			<form:option value="10">10개씩보기</form:option>
			<form:option value="20">20개씩보기</form:option>
			<form:option value="30">30개씩보기</form:option>
			<form:option value="50">50개씩보기</form:option>
			<form:option value="100">100개씩보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		<div class="button">
			<a href="#" class="btn btn2 left" id="excelDownload"><i class="fa fa-file-excel-o"></i><span>엑셀 다운로드</span></a>
			<a href="#" class="btn btn2 left" id="csvDownload"><i class="fa fa-file-excel-o"></i><span>csv 다운로드</span></a>
			<a href="#" class="btn btn5 left" id="dialog-applyAdd"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	
	<div class="infodesk">
		<button class="btn sort ${empty relayLectureApply.reception_status ? 'btn1' : '' }" data-status="" style="width: 100px;">전체</button>
		<button class="btn sort ${relayLectureApply.reception_status eq 'Y' ? 'btn1' : '' }" data-status="Y" style="width: 100px;">접수</button>
		<button class="btn sort ${relayLectureApply.reception_status eq 'N' ? 'btn1' : '' }" data-status="N" style="width: 100px;">취소</button>
	</div>
	
	<div>
		<table id="relayApplyTable" class="type1 center">
			<colgroup>
				<col width="5%" />
				<col width="15%"/>
				<col width="5%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width=""/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>신청자</th>
					<th>성별</th>
					<th>연령대</th>
					<th>핸드폰</th>
					<th>소속</th>
					<th>접수상태</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${relayLectureApplyList}">
					<tr class="sort relayApply_${i.reception_status}">
					<!-- <tr> -->
						<td>${paging.listRowNum - status.index}</td>
						<td>
							<a href="#" class="dialog-modify" data-key="${i.lecture_apply_idx}">
								${i.applicant_name}
							</a>
						</td>
						<td>${i.applicant_sex eq 'M' ? '남' : '여'}</td>
						<td>
							<c:choose>
								<c:when test="${i.applicant_age eq '0'}">영유아(0~7세)</c:when>
								<c:when test="${i.applicant_age eq '1'}">초등학생(8~13세)</c:when>
								<c:when test="${i.applicant_age eq '2'}">청소년(14~19세)</c:when>
								<c:when test="${i.applicant_age eq '3'}">20대(20~29세)</c:when>
								<c:when test="${i.applicant_age eq '4'}">30대(30~39세)</c:when>
								<c:when test="${i.applicant_age eq '5'}">40대(40~49세)</c:when>
								<c:when test="${i.applicant_age eq '6'}">50대(50~59세)</c:when>
								<c:otherwise>60대이상</c:otherwise>
							</c:choose>
						</td>
						<td>${i.applicant_phone}</td>
						<td>${i.applicant_belong}</td>
						<td>
							<select class="reception_status" data-key="${i.lecture_apply_idx}">
								<option value="Y" ${i.reception_status eq 'Y' ? 'selected' : ''}>접수</option>
								<option value="N" ${i.reception_status eq 'N' ? 'selected' : ''}>취소</option>
							</select>
						</td>
						<td>
							<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(relayLectureApplyList) < 1}">
					<tr>
						<td colspan="8">등록된 회원정보가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<form:hidden id="viewPage_ajax" path="viewPage"/>
		<div id="cms_paging_ajax" class="dataTables_paginate">
		<c:if test="${paging.firstPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
		</c:if>
		<c:if test="${paging.prevPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
		</c:if>	
			<span>
		<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
		<c:choose>
		<c:when test="${i eq paging.viewPage}">	
			<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
		</c:when>
		<c:otherwise>
			<a href="" class="paginate_button" keyValue="${i}">${i}</a>
		</c:otherwise>
		</c:choose>
		</c:forEach>
		<c:if test="${paging.nextPageNum > 0}">
			<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
		</c:if>
		<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
			<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
		</c:if>
			</span>
		</div>
		
		<div class="search txt-center" style="margin-top: 15px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu">
					<form:option value="applicant_name">신청자</form:option>
					<form:option value="applicant_phone">핸드폰</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			</fieldset>
		</div>
		
	</div>
	
</form:form>

<div id="dialog-3" class="dialog-common" title="릴레이강연 신청"></div>
