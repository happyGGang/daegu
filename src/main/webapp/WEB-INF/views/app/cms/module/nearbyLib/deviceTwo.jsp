<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	
	$('.locker_wrap_left .copyright').remove();
	$('.locker_wrap_left .page-subtitle').remove();
	
	$('#trainingCategoryTerms a.add').on('click', function(e) {		
		if(doAjaxPost($('#trainingCategoryTerms'))) {				
			$("div#locker_wrap_left").load("edit_table.do?idx_param=${trainingCategoryTerms.idx_param}&index_no=${trainingCategoryTerms.index_no}");
		}	
	});		
});
</script>
<form:form id="nearbyLibLocker" modelAttribute="nearbyLibLocker" method="post" action="save.do">
	<table class="type1 table_left">
		<thead>
			<tr>
				<th colspan="6" style="text-align:center;">사물함별 대출정보</th>
			</tr>
		</thead>	
		<tbody>
			<tr>
				<td>
					1
				</td>
				<td>
					2
				</td>
				<td>
					3
				</td>
				<td>
					4
				</td>
				<td>
					5
				</td>
				<td>
					6
				</td>
			</tr>
			<tr>
				<td colspan=6 rowspan=3 style="background-color: #8080803b;"></td>
			</tr>
			<tr>
			</tr>
			<tr>
			</tr>
			<tr>
				<td colspan=2>
					7
				</td>
				<td colspan=2>
					8
				</td>
				<td colspan=2>
					9
				</td>
			</tr>
		</tbody>
	</table>	
</form:form>