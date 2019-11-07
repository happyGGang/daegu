<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-2.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	    	location.reload();
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1000,
		height: 680
	});
	
	$('#dialog-2 a.mod-btn').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue1') + '&support_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('#dialog-2 a.del-btn').on('click', function(e) {
		e.preventDefault();
		if ( confirm('해당 정보를 정말 삭제하시겠습니까?') ) {
			$('form#schoolSupportList #editMode').val('DELETE');
			$('form#schoolSupportList #homepage_id').val($(this).attr('keyValue1'));
			$('form#schoolSupportList #support_idx').val($(this).attr('keyValue2'));
			
			if ( doAjaxPost($('form#schoolSupportList')) ) {
				doAjaxLoad('#dialog-2', 'list.do', serializeCustom($('form#schoolSupportList')));
			}	
		}
	});
	
	$('select#support_status').change(function() {
		doAjaxLoad('#dialog-2', 'list.do', serializeCustom($('form#schoolSupportList')));	
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage_ajax').val(1);
		doAjaxLoad('#dialog-2', 'list.do', serializeCustom($('form#schoolSupportList')));
		e.preventDefault();
	});
});
$(document).ready(function() {
	$('div#cms_paging a').on('click', function(e) {
		$('#viewPage_ajax').attr('value', $(this).attr('keyValue'));
		var param = $('#schoolSupportList').serialize();
		$('#dialog-2').load('list.do?' + param);
		e.preventDefault();
	});
});
</script>
<div class="infodesk">
검색 결과 : 총 ${schoolSupportListCount} 건
</div>
<form:form id="schoolSupportList" modelAttribute="schoolSupport" method="post" action="save.do" >
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="support_idx"/>
	<table class="type1 center">
		<colgroup>
	       	<col width="70" />
	       	<col width="120" />
	       	<col width="100" />
	       	<col width="80" />
	       	<col width="100" />
	       	<col width="100" />
	    </colgroup>
	    <thead>
	    	<tr>
	    		<th>지역</th>
	    		<th>학교명</th>
	    		<th>담당자직위</th>
	    		<th>담당자명</th>
	    		<th>신청상태</th>
	    		<th>기능</th>
	    	</tr>
	    </thead>
	    <tbody>
			<c:choose>
				<c:when test="${fn:length(schoolSupportList) > 0}">
					<c:forEach items="${schoolSupportList}" var="i" varStatus="status">
	    				<tr>
	         				<td>
	         					<c:forEach items="${areaList}" var="oneArea">
	         						<c:if test="${i.area_code eq oneArea.code_id }">${oneArea.code_name}</c:if>
	         					</c:forEach>
	         				</td>
				         	<td>${i.school_name}</td>
				         	<td>${i.member_position}</td>
				         	<td>${i.member_name}</td>
				         	<td>
				         		<c:choose>
				         			<c:when test="${i.support_status eq '0'}">신청</c:when>
				         			<c:when test="${i.support_status eq '1'}">1지망 확정</c:when>
				         			<c:when test="${i.support_status eq '2'}">2지망 확정</c:when>
				         		</c:choose>
			         		</td>
				         	<td>
				         		<a class="btn btn1 mod-btn" keyValue1="${i.homepage_id}" keyValue2="${i.support_idx}">수정</a>
				         		<a class="btn btn1 del-btn" keyValue1="${i.homepage_id}" keyValue2="${i.support_idx}">삭제</a>
							</td>
				        </tr>
	    			</c:forEach>	
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="8">조회된 정보가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>    
		</tbody>
	</table>
	<form:hidden id="viewPage_ajax" path="viewPage"/>
	<div id="cms_paging" class="dataTables_paginate">
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
	
	<%-- <jsp:include page="/WEB-INF/views/app/cms/common/paging_ajax.jsp" flush="false">
		<jsp:param name="formId" value="#schoolSupportList"/>
		<jsp:param name="layerId" value="#dialog-2"/>
		<jsp:param name="pagingUrl" value="list.do"/>
	</jsp:include> --%>
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="support_status" cssClass="selectmenu" cssStyle="width:150px">
		    	<form:option value="0" label="신청"/>
		    	<form:option value="1" label="1지망 확정"/>
		    	<form:option value="2" label="2지망 확정"/>
		    </form:select>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="SCHOOL_NAME">학교명</form:option>
				<form:option value="SUPPORT_REQ_FIRST">지원요청1순위</form:option>
				<form:option value="SUPPORT_REQ_SECOND">지원요청2순위</form:option>
				<form:option value="MEMBER_NAME">담당자명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>