<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<script type="text/javascript">
$(function(){
	var date = new Date($('#teachBook input#sel_date').val());
	
	$('a#month_prev').on('click', function(e) {
		e.preventDefault();
		
		date.setMonth(date.getMonth()-1);
		var year = date.getFullYear();
		var month = date.getMonth()+1 < 10? '0'+(date.getMonth()+1) : date.getMonth()+1;

		$('#teachBook input#sel_date').val(year+'-'+month);
		$('#excelDownForm #sel_date').val(year+'-'+month);
		var url = 'teachBook.do';
		var param = $('form#teachBook').serialize();
		
		doAjaxLoad('#teachBookLayer', url, param);
	});
	
	$('a#month_next').on('click', function(e) {
		e.preventDefault();
		
		date.setMonth(date.getMonth()+1);
		
		var year = date.getFullYear();
		var month = date.getMonth()+1 < 10? '0'+(date.getMonth()+1) : date.getMonth()+1;

		$('#teachBook input#sel_date').val(year+'-'+month);
		$('#excelDownForm #sel_date').val(year+'-'+month);
		var url = 'teachBook.do';
		var param = $('form#teachBook').serialize();
		
		doAjaxLoad('#teachBookLayer', url, param);
	});
	
	$('a.status-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#saveForm #teach_idx').val() == 0 ) {
			alert('강좌를 선택해주세요.');
			return;
		}
		var status 		= $('[name="status"]:checked').val();
		var studentIdx 	= $(this).attr('keyValue2');
		var teachDate 	= $(this).attr('keyValue3');
		
		if ( status == null ) {
			alert('출석 종류를 선택해주세요.');
			return;
		}
		
		$('#saveForm #editMode').val('ONESAVE');
		$('#saveForm #student_idx').val(studentIdx);
		$('#saveForm #status').val(status);
		$('#saveForm #teach_date').val(teachDate);
		if ( doAjaxPost($('#saveForm')) ) {
			$('#teachBookLayer').load('teachBook.do?homepage_id=' + $('#saveForm #homepage_id').val() + '&large_category_idx=' + $('#saveForm #large_category_idx').val() + '&group_idx=' + $('#saveForm #group_idx').val() + '&category_idx=' + $('#saveForm #category_idx').val() + '&teach_idx=' + $('#saveForm #teach_idx').val() + '&status='+status + '&sel_date='+$('#sel_date').val());
		}
	});
	
	$('a.date-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#saveForm #teach_idx').val() == 0 ) {
			alert('강좌를 선택해주세요.');
			return;
		}
		var teachDate = $(this).attr('keyValue');
		
		$('#saveForm #editMode').val('TOPSAVE');
		$('#saveForm #teach_date').val(teachDate);
		if ( doAjaxPost($('#saveForm')) ) {
			$('#teachBookLayer').load('teachBook.do?homepage_id=' + $('#saveForm #homepage_id').val() + '&large_category_idx=' + $('#saveForm #large_category_idx').val() + '&group_idx=' + $('#saveForm #group_idx').val() + '&category_idx=' + $('#saveForm #category_idx').val() + '&teach_idx=' + $('#saveForm #teach_idx').val() + '&status=1');
		}
	});
	
	$('a.name-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#saveForm #teach_idx').val() == 0 ) {
			alert('강좌를 선택해주세요.');
			return;
		}
		var studentIdx = $(this).attr('keyValue');
		$('#saveForm #editMode').val('LEFTSAVE');
		$('#saveForm #student_idx').val(studentIdx);
		if ( doAjaxPost($('#saveForm')) ) {
			$('#teachBookLayer').load('teachBook.do?homepage_id=' + $('#saveForm #homepage_id').val() + '&large_category_idx=' + $('#saveForm #large_category_idx').val() + '&group_idx=' + $('#saveForm #group_idx').val() + '&category_idx=' + $('#saveForm #category_idx').val() + '&teach_idx=' + $('#saveForm #teach_idx').val() + '&status=1');
		}
	});
	
	$('select.paySelect').change(function() {
		var studentIdx 	= $(this).attr('keyValue1');
		var payType 	= $(this).attr('keyValue2');
		var value 		= $(this).val();
		
		$('#saveForm #editMode').val('PAYSAVE');
		$('#saveForm #student_idx').val(studentIdx);
		$('#saveForm #pay_type').val(payType);
		$('#saveForm #pay_value').val(value);
		
		if ( doAjaxPost($('#saveForm')) ) {
			$('#teachBookLayer').load('teachBook.do?homepage_id=' + $('#saveForm #homepage_id').val() + '&large_category_idx=' + $('#saveForm #large_category_idx').val() + '&group_idx=' + $('#saveForm #group_idx').val() + '&category_idx=' + $('#saveForm #category_idx').val() + '&teach_idx=' + $('#saveForm #teach_idx').val() + '&status=1');
		}
	});
	
	$('#teachBookArea tbody td').css('height', '50px');
});	
</script> 
<div class="infodesk">
	<div class="button btn-group inline">
		
		<!-- <a href="" id="excel" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀 다운로드</span></a> -->
	</div>                                                                                                
</div>
<div class="form-group menuTypeBox">
	종류 : 
	<div class="radio">
		<input type="radio" name="status" id="radio10" value="1" <c:if test="${teachBook.status eq 1}">checked="checked"</c:if>/>
		<label for="radio10">출석 (●)</label>
	</div>
	<div class="radio">
		<input type="radio" name="status" id="radio11" value="2" <c:if test="${teachBook.status eq 2}">checked="checked"</c:if>/>
		<label for="radio11" >지각 (△)</label>
	</div>
	<div class="radio">
		<input type="radio" name="status" id="radio12" value="3" <c:if test="${teachBook.status eq 3}">checked="checked"</c:if>/>
		<label for="radio12" >결석 (×)</label>
	</div>
	<div class="radio">
		<input type="radio" name="status" id="radio13" value="4" <c:if test="${teachBook.status eq 4}">checked="checked"</c:if>/>
		<label for="radio13" >무단 (◇)</label>
	</div>
	<div class="radio">
		<input type="radio" name="status" id="radio14" value="5" <c:if test="${teachBook.status eq 5}">checked="checked"</c:if>/>
		<label for="radio14" >기타 (■)</label>
	</div>
	<div class="radio">
		<input type="radio" name="status" id="radio15" value="0" <c:if test="${teachBook.status eq 0}">checked="checked"</c:if>/>
		<label for="radio15" >없음 (-)</label>
	</div>
</div>
<form:form id="saveForm" modelAttribute="teachBook" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="student_idx"/>
	<form:hidden path="status"/>
	<form:hidden path="teach_date"/>
	<form:hidden path="sel_date"/>
	<form:hidden path="pay_type"/>
	<form:hidden path="pay_value"/>
</form:form>
<form:form modelAttribute="teachBook" action="teachBook.do" method="get">
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="sel_date"/>
	<div class="calendar" style="width: 97%;">
		<h4 class="blind">출석시간현황 </h4>
		<div class="calendar-head" style="margin-bottom:-40px;">
			<a href="#" id="month_prev" class="prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
			<b>${teachBook.sel_date}</b>
			<a href="#" id="month_next" class="next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
		</div>
		<div class="calendar-table">
			<div class="box" style="overflow: auto">
				<div class="stat-info auto-scroll"><p>${teachBook.sel_date}</p></div>
				<table id="teachBookArea" class="type1" style="width:99%;height:0px;" >
					<thead>
						<tr>
							<th rowspan="2" style="padding:0px">번호</th>
							<th rowspan="2">성명</th>
							<c:forEach var="i" varStatus="status" items="${calendar}">
								<c:choose>
									<c:when test="${i.sun ne null and i.sun > 0}">
										<th style="padding:0px">
											<a class="date-btn" keyValue="${teachBook.sel_date}-${fn:length(i.sun) < 2? '0' : ''}${i.sun}">${i.sun}</a>
										</th>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${i.mon ne null and i.mon > 0}">
										<th style="padding:0px">
											<a class="date-btn" keyValue="${teachBook.sel_date}-${fn:length(i.mon) < 2? '0' : ''}${i.mon}">${i.mon}</a>
										</th>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${i.tue ne null and i.tue > 0}">
										<th style="padding:0px">
											<a class="date-btn" keyValue="${teachBook.sel_date}-${fn:length(i.tue) < 2? '0' : ''}${i.tue}">${i.tue}</a>
										</th>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${i.wed ne null and i.wed > 0}">
										<th style="padding:0px">
											<a class="date-btn" keyValue="${teachBook.sel_date}-${fn:length(i.wed) < 2? '0' : ''}${i.wed}">${i.wed}</a>
										</th>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${i.thu ne null and i.thu > 0}">
										<th style="padding:0px">
											<a class="date-btn" keyValue="${teachBook.sel_date}-${fn:length(i.thu) < 2? '0' : ''}${i.thu}">${i.thu}</a>
										</th>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${i.fri ne null and i.fri > 0}">
										<th style="padding:0px">
											<a class="date-btn" keyValue="${teachBook.sel_date}-${fn:length(i.fri) < 2? '0' : ''}${i.fri}">${i.fri}</a>
										</th>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${i.sat ne null and i.sat > 0}">
										<th style="padding:0px">
											<a class="date-btn" keyValue="${teachBook.sel_date}-${fn:length(i.sat) < 2? '0' : ''}${i.sat}">${i.sat}</a>
										</th>
									</c:when>
								</c:choose>
							</c:forEach>
							<th rowspan="2" style="padding:0px">수강료</th>
							<th rowspan="2" style="padding:0px">교재비</th>
							<th rowspan="2" style="padding:0px">재료비</th>
						</tr>
						<tr>
							<c:forEach var="j" varStatus="status" items="${calendar}">
								<c:choose>
									<c:when test="${j.sun ne null and j.sun > 0}">
										<td>
											<fmt:parseDate var="curDate" value="${teachBook.sel_date}-${j.sun}" pattern="yyyy-MM-d"/>
											<fmt:formatDate value="${curDate}" type="both" pattern="E"/>
										</td>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${j.mon ne null and j.mon > 0}">
										<td>
											<fmt:parseDate var="curDate" value="${teachBook.sel_date}-${j.mon}" pattern="yyyy-MM-d"/>
											<fmt:formatDate value="${curDate}" type="both" pattern="E"/>
										</td>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${j.tue ne null and j.tue > 0}">
										<td>
											<fmt:parseDate var="curDate" value="${teachBook.sel_date}-${j.tue}" pattern="yyyy-MM-d"/>
											<fmt:formatDate value="${curDate}" type="both" pattern="E"/>
										</td>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${j.wed ne null and j.wed > 0}">
										<td>
											<fmt:parseDate var="curDate" value="${teachBook.sel_date}-${j.wed}" pattern="yyyy-MM-d"/>
											<fmt:formatDate value="${curDate}" type="both" pattern="E"/>
										</td>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${j.thu ne null and j.thu > 0}">
										<td>
											<fmt:parseDate var="curDate" value="${teachBook.sel_date}-${j.thu}" pattern="yyyy-MM-d"/>
											<fmt:formatDate value="${curDate}" type="both" pattern="E"/>
										</td>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${j.fri ne null and j.fri > 0}">
										<td>
											<fmt:parseDate var="curDate" value="${teachBook.sel_date}-${j.fri}" pattern="yyyy-MM-d"/>
											<fmt:formatDate value="${curDate}" type="both" pattern="E"/>								
										</td>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${j.sat ne null and j.sat > 0}">
										<td>
											<fmt:parseDate var="curDate" value="${teachBook.sel_date}-${j.sat}" pattern="yyyy-MM-d"/>
											<fmt:formatDate value="${curDate}" type="both" pattern="E"/>
										</td>
									</c:when>
								</c:choose>
							</c:forEach>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(studentList) > 0}">
								<c:forEach items="${studentList}" var="oneStudent" varStatus="k_Status">
									<tr>
										<td>${k_Status.count}</td>
										<td><a class="name-btn" keyValue="${oneStudent.student_idx}">${oneStudent.student_name}</a></td>
										<c:forEach var="k" varStatus="status" items="${calendar}">
											<c:choose>
												<c:when test="${k.sun ne null and k.sun > 0}">
													<td class="${oneStudent.student_idx}_${k.sun}">
														<c:set var="plan_date" value="${teachBook.sel_date}-${fn:length(k.sun) < 2? '0' : ''}${k.sun}" />
														<c:choose>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '1'}"><a class="status-btn" keyValue1="1" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">●</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '2'}"><a class="status-btn" keyValue1="2" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">△</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '3'}"><a class="status-btn" keyValue1="3" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">×</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '4'}"><a class="status-btn" keyValue1="4" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">◇</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '5'}"><a class="status-btn" keyValue1="5" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">■</a></c:when>
															
															<c:otherwise><a class="status-btn" keyValue1="0" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">-</a></c:otherwise>
														</c:choose>
													</td>
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${k.mon ne null and k.mon > 0}">
													<td>
														<c:set var="plan_date" value="${teachBook.sel_date}-${fn:length(k.mon) < 2? '0' : ''}${k.mon}" />
														<c:choose>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '1'}"><a class="status-btn" keyValue1="1" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">●</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '2'}"><a class="status-btn" keyValue1="2" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">△</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '3'}"><a class="status-btn" keyValue1="3" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">×</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '4'}"><a class="status-btn" keyValue1="4" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">◇</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '5'}"><a class="status-btn" keyValue1="5" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">■</a></c:when>
															<c:otherwise><a class="status-btn" keyValue1="0" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">-</a></c:otherwise>
														</c:choose>
													</td>
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${k.tue ne null and k.tue > 0}">
													<td>
														<c:set var="plan_date" value="${teachBook.sel_date}-${fn:length(k.tue) < 2? '0' : ''}${k.tue}" />
														<c:choose>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '1'}"><a class="status-btn" keyValue1="1" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">●</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '2'}"><a class="status-btn" keyValue1="2" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">△</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '3'}"><a class="status-btn" keyValue1="3" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">×</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '4'}"><a class="status-btn" keyValue1="4" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">◇</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '5'}"><a class="status-btn" keyValue1="5" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">■</a></c:when>
															<c:otherwise><a class="status-btn" keyValue1="0" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">-</a></c:otherwise>
														</c:choose>
													</td>
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${k.wed ne null and k.wed > 0}">
													<td>
														<c:set var="plan_date" value="${teachBook.sel_date}-${fn:length(k.wed) < 2? '0' : ''}${k.wed}" />
														<c:choose>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '1'}"><a class="status-btn" keyValue1="1" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">●</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '2'}"><a class="status-btn" keyValue1="2" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">△</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '3'}"><a class="status-btn" keyValue1="3" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">×</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '4'}"><a class="status-btn" keyValue1="4" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">◇</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '5'}"><a class="status-btn" keyValue1="5" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">■</a></c:when>
															<c:otherwise><a class="status-btn" keyValue1="0" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">-</a></c:otherwise>
														</c:choose>
													</td>
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${k.thu ne null and k.thu > 0}">
													<td>
														<c:set var="plan_date" value="${teachBook.sel_date}-${fn:length(k.thu) < 2? '0' : ''}${k.thu}" />
														<c:choose>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '1'}"><a class="status-btn" keyValue1="1" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">●</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '2'}"><a class="status-btn" keyValue1="2" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">△</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '3'}"><a class="status-btn" keyValue1="3" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">×</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '4'}"><a class="status-btn" keyValue1="4" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">◇</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '5'}"><a class="status-btn" keyValue1="5" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">■</a></c:when>
															<c:otherwise><a class="status-btn" keyValue1="0" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">-</a></c:otherwise>
														</c:choose>
													</td>
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${k.fri ne null and k.fri > 0}">
													<td>
														<c:set var="plan_date" value="${teachBook.sel_date}-${fn:length(k.fri) < 2? '0' : ''}${k.fri}" />
														<c:choose>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '1'}"><a class="status-btn" keyValue1="1" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">●</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '2'}"><a class="status-btn" keyValue1="2" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">△</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '3'}"><a class="status-btn" keyValue1="3" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">×</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '4'}"><a class="status-btn" keyValue1="4" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">◇</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '5'}"><a class="status-btn" keyValue1="5" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">■</a></c:when>
															<c:otherwise><a class="status-btn" keyValue1="0" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">-</a></c:otherwise>
														</c:choose>
													</td>
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${k.sat ne null and k.sat > 0}">
													<td>
														<c:set var="plan_date" value="${teachBook.sel_date}-${fn:length(k.sat) < 2? '0' : ''}${k.sat}" />
														<c:choose>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '1'}"><a class="status-btn" keyValue1="1" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">●</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '2'}"><a class="status-btn" keyValue1="2" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">△</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '3'}"><a class="status-btn" keyValue1="3" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">×</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '4'}"><a class="status-btn" keyValue1="4" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">◇</a></c:when>
															<c:when test="${teachBookRepo[oneStudent.student_idx][plan_date] eq '5'}"><a class="status-btn" keyValue1="5" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">■</a></c:when>															<c:otherwise><a class="status-btn" keyValue1="0" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">-</a></c:otherwise>
														</c:choose>
													</td>
												</c:when>
											</c:choose>
										</c:forEach>
										<td>
											<select name="pay1_yn" class="selectmenu paySelect" keyValue1="${oneStudent.student_idx}" keyValue2="pay1_yn">
												<option value="N" <c:if test="${oneStudent.pay1_yn eq 'N'}">selected="selected"</c:if>>×</option>
												<option value="Y" <c:if test="${oneStudent.pay1_yn eq 'Y'}">selected="selected"</c:if>>●</option>
											</select>
										<td>
											<select name="pay2_yn" class="selectmenu paySelect" keyValue1="${oneStudent.student_idx}" keyValue2="pay2_yn">
												<option value="N" <c:if test="${oneStudent.pay2_yn eq 'N'}">selected="selected"</c:if>>×</option>
												<option value="Y" <c:if test="${oneStudent.pay2_yn eq 'Y'}">selected="selected"</c:if>>●</option>
											</select>
										</td>
										<td>
											<select name="pay3_yn" class="selectmenu paySelect" keyValue1="${oneStudent.student_idx}" keyValue2="pay3_yn">
												<option value="N" <c:if test="${oneStudent.pay3_yn eq 'N'}">selected="selected"</c:if>>×</option>
												<option value="Y" <c:if test="${oneStudent.pay3_yn eq 'Y'}">selected="selected"</c:if>>●</option>
											</select>
										</td>
									</tr>
								</c:forEach>	
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="40" style="height:100%">조회된 데이터가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</form:form>
<div class="printTitle" hidden="hidden"><h1>${teachBook.sel_date} [${teach.group_name}]${teach.category_name} : ${teach.teach_name}</h1></div>