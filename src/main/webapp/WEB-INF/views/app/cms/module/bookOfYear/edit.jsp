<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {

	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
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
					doAjaxPost($('form#bookOfYear'));
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 800
	});


	$('a#getIlus').on('click', function(e) {
		e.preventDefault();
		if ('${homepage.context_path}' == '') {
			alert('홈페이지에서만 가능합니다');
		} else {
			var ilusList = window.open('/${homepage.context_path}/intro/search/indexForBoard.do', 'ilusLnkBook', 'width=800 height=600,scrollbars=yes');
		}
	});

});

function getLasData(arg) {
	arg = arg.split('///');
	<%--
	//${i.TITLE_INFO}///${i.PUB_YEAR}///${i.AUTHOR}///${i.PUBLISHER}///${fn:escapeXml(i.ST_CODE)}///${i.CALL_NO}///${imageUrl}///${i.SHELF_LOC_NAME}///${fn:escapeXml(i.REG_NO)}
	--%>
	$('input#book_name').val(arg[0]);
	$('input#book_year').val(arg[1]);
	$('input#book_author').val(arg[2]);
	$('input#book_publisher').val(arg[3]);
	$('input#book_isbn').val(arg[4]);
	$('input#book_img_url').val(arg[6]);
	$('input#book_regno').val(arg[8]);
	return false;
}

</script>
<form:form modelAttribute="bookOfYear" action="save.do" method="POST" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>선정년도(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<c:choose>
				<c:when test="${bookOfYear.editMode eq 'ADD'}">
				<form:input path="selection_year" cssClass="text" maxlength="4" cssStyle="width:10%;"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>* 숫자 4자리만 입력. 등록 후 수정 불가합니다.(수정 필요시 삭제 후 재 등록)</em>
				</div>
				</c:when>
				<c:otherwise>
				${bookOfYear.selection_year}
				<form:hidden path="selection_year" cssClass="text"/>
				</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>도서명(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="book_name" cssClass="text" cssStyle="width:75%;" />
				<a href="#" class="btn btn2" id="getIlus"><i class="fa fa-plus"></i><span>도서검색</span></a>
			</td>
		</tr>
		<tr>
			<th>저자</th>
			<td>
				<form:input path="book_author" cssClass="text" cssStyle="width:98%;" />
			</td>
		</tr>
		<tr>
			<th>출판사</th>
			<td>
				<form:input path="book_publisher" cssClass="text" cssStyle="width:98%;" />
			</td>
		</tr>
		<tr>
			<th>출판년도</th>
			<td>
				<form:input path="book_year" cssClass="text" />
			</td>
		</tr>
		<tr>
			<th>등록번호</th>
			<td>
				<form:input path="book_regno" cssClass="text" />
			</td>
		</tr>
		<tr>
			<th>ISBN</th>
			<td>
				<form:input path="book_isbn" cssClass="text" />
			</td>
		</tr>
		<tr>
			<th>도서이미지</th>
			<td>
				<form:input path="book_img_url" cssClass="text" cssStyle="width:98%;"/>
			</td>
		</tr>
		<tr>
			<th>도서내용</th>
			<td>
				<form:textarea path="book_content" cssStyle="width:98%;" rows="10"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>