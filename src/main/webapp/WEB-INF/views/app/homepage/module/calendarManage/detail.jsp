<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('a#back-btn').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
});

</script>

<div class="op_wrap">
	<div class="sview">
		<div class="sinfo thumbno">
			<div class="info">
				<ul>
					<li class="first">
					<div>
						<strong>${calendarManage.title}</strong>
					</div>
					</li>
					<li><div>
						<label class="first th1">행사일자</label>
						<span class="important td1">
							<c:if test="${calendarManage.start_date eq calendarManage.end_date}">
								${calendarManage.start_date}
							</c:if>
							<c:if test="${calendarManage.start_date ne calendarManage.end_date}">
								${calendarManage.start_date} ~ ${calendarManage.end_date}
							</c:if>
						</span>
					</div></li>
					<li><div>
			         	<label class="label2">행사내용</label>			
			         	<span class="important last span2">
				         	<c:if test="${calendarManage.contents ne null}">
				         		${calendarManage.contents}</c:if>
							<c:if test="${calendarManage.contents eq null}">
								등록된 상세내용이 없습니다.
							</c:if>
						</span>
		        	</div></li>
				</ul>
			</div>
		</div>

		<div class="sbtn">
			<a id="back-btn" href="" class="btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
		</div>
	</div>
</div>
