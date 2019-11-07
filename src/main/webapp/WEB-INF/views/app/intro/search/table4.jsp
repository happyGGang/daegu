<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('a.doSearchYear2').on('click', function(e) {
		$('#search_type2').val($(this).attr('keyValue1'));
		$('#search_year').val($(this).attr('keyValue2'));
		jQuery.ajaxSettings.traditional = true;
		$('input#viewPage').val('1');
		var param = serializeObject($('#librarySearch'));
		var param2 = serializeObject($('#searchTableForm'));
		$('div#search-results').load('table.do', $.extend(true, param, param2));
		$('body').scrollTop(0);
		e.preventDefault();	
	});
});

</script>

<c:forEach items="${resultCountByYear.arr}" var="j">
	<c:set var="yearCnt" value="${j.totcnt}"></c:set>	
	<li><a href="#" class="doSearchYear2" keyValue1="L_YEAR" keyValue2="${j.code}"><span>${j.title}</span><em>(${j.count})</em></a></li>
</c:forEach>