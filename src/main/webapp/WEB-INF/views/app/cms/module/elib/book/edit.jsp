<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
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
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if ( doAjaxPost($('#bookForm')) ) {
						location.reload();	
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 560
	});
	
	$('input#book_pubdt').datepicker();
	
	
});

function updateSubcategory_dialog(cate_id) {
	if(cate_id != null && cate_id != '' && cate_id != '0') {
		$.get('/cms/module/elib/category/${book.type}/getSubcategories.do?cate_id=' + cate_id, function(data) {
			var cate2 = $('select#cate2_dialog').empty();
			var selected = null;
			
			cate2.append($('<option>', { value: '0', text: '2차 카테고리 선택'}));
			$(data.data).sort(function(a, b) {
				return parseInt(a.display_seq) > parseInt(b.display_seq);
			}).each(function(i) {
				var attrs = { value: this.cate_id, text: this.cate_name };
				
				if('${book.cate_id}' == this.cate_id) {
					attrs.selected = 'selected';
				}
				
				cate2.append($('<option>', attrs));
			});
			
			cate2.select2('destroy');
			cate2.select2('');
		});
	}
}
</script>
<form:form id="bookForm" modelAttribute="book" method="post" action="save.do" >
	<form:hidden path="book_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="type"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>책코드</th>
	         	<td><form:input path="book_code" class="text" cssStyle="width:150px"/></td>
        	</tr>
			<tr>
	         	<th>제목</th>
	         	<td><form:input path="book_name" class="text" cssStyle="width:100%"/></td>
        	</tr>
			<tr>
	         	<th>저자</th>
	         	<td><form:input path="author_name" class="text" cssStyle="width:200px"/></td>
        	</tr>
			<tr>
	         	<th>출판사</th>
	         	<td><form:input path="book_pubname" class="text" cssStyle="width:200px"/></td>
        	</tr>
        	<c:if test="${book.type != 'WEB'}">
			<tr>
	         	<th>ISBN</th>
	         	<td><form:input path="isbn13" class="text" cssStyle="width:150px"/></td>
        	</tr>
        	</c:if>
			<tr>
	         	<th>포맷</th>
	         	<td><form:input path="format" class="text" cssStyle="width:100px"/></td>
        	</tr>
			<tr>
	         	<th>서적 이미지</th>
	         	<td><form:input path="book_image" class="text" cssStyle="width:100%"/></td>
        	</tr>
        	<tr>
        		<th>출판일자</th>
	         	<td>
					<form:input path="book_pubdt" class="text ui-calendar"/>
	         	</td>
        	</tr>
			<tr>
	         	<th>카테고리</th>
	         	<td>
       				<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/category_select.jsp">
	         			<jsp:param name="sym" value="_dialog"/>
	         		</jsp:include>
	         	</td>
        	</tr>
			<tr>
	         	<th>공급사</th>
	         	<td>
	         		<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/provider_select.jsp">
	         			<jsp:param name="sym" value="_dialog"/>
	         		</jsp:include>
	         	</td>
        	</tr>
			<tr>
	         	<th>도서관</th>
	         	<td>
	         		<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp">
	         			<jsp:param name="sym" value="_dialog"/>
	         		</jsp:include>
	         	</td>
        	</tr>
			<tr>
	         	<th>지원기기</th>
	         	<td>
	         		<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/device_select.jsp">
	         			<jsp:param name="sym" value="_dialog"/>
	         		</jsp:include>
	         	</td>
        	</tr>
        	<c:if test="${book.type == 'EBK'}">
			<tr>
	         	<th>최대대출권수</th>
	         	<td><form:input path="max_lend" class="text" numberonly="true"/></td>
        	</tr>
        	</c:if>
        	<c:if test="${book.type == 'ADO'}">
			<tr>
	         	<th>플레이타임</th>
	         	<td><form:input path="play_time" class="text" numberonly="true" cssStyle="width:50%"/></td>
        	</tr>
			<tr>
	         	<th>플레이어크기</th>
	         	<td><form:input path="play_size" class="text" numberonly="true" cssStyle="width:50%"/></td>
        	</tr>
			<tr>
	         	<th>링크주소</th>
	         	<td><form:input path="link_url" class="text" numberonly="true" cssStyle="width:50%"/></td>
        	</tr>
			<tr>
	         	<th>링크주소(모바일)</th>
	         	<td><form:input path="mobile_link_url" class="text" numberonly="true" cssStyle="width:50%"/></td>
        	</tr>
        	</c:if>
	        <tr>
	         	<th>사용여부</th>
	         	<td>
	         		<c:choose>
	         		<c:when test="${book.editMode == 'ADD'}">
	         		<form:checkbox path="use_yn" value="Y" class="Y" checked="checked"/><label for="use_yn" style="cursor:pointer;">사용함</label>
	         		</c:when>
	         		<c:otherwise>
	         		<form:checkbox path="use_yn" value="Y" class="Y"/><label for="use_yn" style="cursor:pointer;">사용함</label>
	         		</c:otherwise>
	         		</c:choose>
				</td>
	        </tr>
	        <tr>
	         	<th>책 소개</th>
	         	<td><form:textarea path="book_info" class="text" cssStyle="width:100%; height:150px"/></td>
	        </tr>
	        <tr>
	         	<th>저자 소개</th>
	         	<td><form:textarea path="author_info" class="text" cssStyle="width:100%; height:150px"/></td>
	        </tr>
	        <tr>
	         	<th>목차</th>
	         	<td><form:textarea path="book_table" class="text" cssStyle="width:100%; height:150px"/></td>
	        </tr>
		</tbody>
	</table>
</form:form>
