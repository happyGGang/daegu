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
					doAjaxPost($('form#bookOfFamous'));
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


	$('a#getBook').on('click', function(e) {
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
<form:form modelAttribute="bookOfFamous" action="save.do" method="POST" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden id="book_famous_idx" path="book_famous_idx"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>공지여부</th>
			<td>
				<form:radiobutton path="notice_yn" value="Y" label="예" cssStyle="cursor: pointer;" checked="checked"/>
				<form:radiobutton path="notice_yn" value="N" label="아니오" cssStyle="cursor: pointer;"/>
			</td>
		</tr>
		<tr>
			<th>추천명사(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="famous_name" cssClass="text" cssStyle="width:50%;"/>
			</td>
		</tr>
		<tr>
			<th>선정년도</th>
			<td>
				<form:input path="selection_year" cssClass="text" maxlength="4" />
			</td>
		</tr>
		<tr>
			<th>도서명(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="book_name" cssClass="text" cssStyle="width:75%;" />
				<a href="#" class="btn btn2" id="getBook"><i class="fa fa-plus"></i><span>도서검색</span></a>
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
				<form:input path="book_year" cssClass="text" maxlength="4" />
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