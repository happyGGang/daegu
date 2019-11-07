<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	
	$('#save-btn').on('click', function() {
		$('#phone').val($('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val());
		$('#cell_phone').val($('#cell_phone1').val()+'-'+$('#cell_phone2').val()+'-'+$('#cell_phone3').val());		
		doAjaxPost($('#lockerEditForm'));
	});
	
	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/module/calendarManage/index.do';
		//var formData = $('#lockerEditForm').serialize();
		var formData = serializeParameter(['menu_idx']);
		doGetLoad(url, formData);
	});
	
});

</script>
<form:form id="teachEdit" modelAttribute="teach" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="category_idx"/>	
	<form:hidden path="teach_idx"/>		
	<form:hidden path="menu_idx"/>					
	<c:set var="start_date" value="${fn:split(teach.start_date,'-')}"/>
	<c:set var="end_date" value="${fn:split(teach.end_date,'-')}"/>
	<div id="calendar">
		<div class="calendar-view">
	
			<h2>이달의 행사 자세히 보기</h2>
			<p class="txt-box"><i class="fa fa-calendar"></i>${start_date[0]}년${start_date[1]}월${start_date[2]}일 ~ ${end_date[0]}년${end_date[1]}월${end_date[2]}일</p>
			<ul>
				<li><label>강의명 :</label> <span class="type-e"><i></i><em>[${teach.category_name}]${teach.teach_name }</em></span></li>
				<li><label>강의대상:</label> <span>${teach.teach_target }</span></li>							
				<li><label>강좌일 :</label>  <span>${start_date[0]}년${start_date[1]}월${start_date[2]}일 ~ ${end_date[0]}년${end_date[1]}월${end_date[2]}일</span></li>
				<li><label>강좌시간 :</label>  <span>${teach.start_time}시 ~ ${teach.end_time}시</span></li>
				<li><label>강의장소 :</label>  <span>${teach.teach_stage}</span></li>
				<li><label>모집제한 :</label>  <span>${teach.teach_limit_count}명</span></li>
				<li><label>후보제한 :</label>  <span>${teach.teach_backup_count}명</span></li>
				<li><label>참여인원 :</label>  <span>${teach.teach_join_count}명</span></li>
				<li><label>후보인원 :</label>  <span>${teach.teach_backup_join_count}명</span></li>
			</ul>
		</div>
	</div>
</form:form>
<br/>
<div class="button bbs-btn center">
	<button id="cancel-btn" class="btn"><i class="fa fa-reorder"></i><span>목록으로</span></button>
</div>
