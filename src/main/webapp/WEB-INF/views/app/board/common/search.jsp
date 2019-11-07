<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	String formId = request.getParameter("formId");
%>
<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
	<fieldset>
		<label class="blind">검색</label>
		<form:select path="search_type" cssClass="selectmenu" cssStyle="width:150px;">
			<form:option value="title+content">제목+내용</form:option>
			<form:option value="title">제목</form:option>
			<form:option value="user_name">글작성자</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" />
		<button><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$('button.btnSearch').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('<%=formId%>'));
		doGetLoad('index.do', param);
	});
	
	$('input#search_text').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('<%=formId%>'));
			doGetLoad('index.do', param);
		}
	});
});
</script>