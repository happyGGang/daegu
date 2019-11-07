<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function(){
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#adminTeachBookForm').submit();
		}
		
		e.preventDefault();
	});
	
	$('a.print-btn').on('click', function(e) {
		e.preventDefault();
		var divToPrint = $("table#teachBookArea").parent().clone();
		divToPrint.prepend('<h1>${teachBook.sel_date} [${teach.group_name}]${teach.category_name} : ${teach.teach_name}</h1>');
		divToPrint.find('table').css('text-align', 'center');
		divToPrint.find('tbody td').css('border', '1px solid #666');
	   	var newWin = window.open("");
	   	newWin.document.write(divToPrint[0].outerHTML);
	   	newWin.document.close();
	   	newWin.print();
	   	newWin.close();
	});
	
	var date = new Date($('input#sel_date').val());
	
	$('a#month_prev').on('click', function(e) {
		e.preventDefault();
		
		date.setMonth(date.getMonth()-1);
		var year = date.getFullYear();
		var month = date.getMonth()+1 < 10? '0'+(date.getMonth()+1) : date.getMonth()+1;

		$('input#sel_date').val(year+'-'+month);
		
		$('div#teachBookLayer').load('teachBook.do?'+serializeCustom($('form#teachBook')));
	});
	
	$('a#month_next').on('click', function(e) {
		e.preventDefault();
		
		date.setMonth(date.getMonth()+1);
		
		var year = date.getFullYear();
		var month = date.getMonth()+1 < 10? '0'+(date.getMonth()+1) : date.getMonth()+1;

		$('input#sel_date').val(year+'-'+month);
		
		$('div#teachBookLayer').load('teachBook.do?'+serializeCustom($('form#teachBook')));
	});
	
	$('a.status-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#saveForm #teach_idx').val() == 0 ) {
			alert('강좌정보가 없습니다.');
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
		var scrollLeftValue = $('div#teachBookScroll').scrollLeft();
		if ( doAjaxPost($('#saveForm')) ) {
			$('div#teachBookLayer').load('teachBook.do?'+serializeCustom($('#saveForm')), function() {
				$('div#teachBookScroll').scrollLeft(scrollLeftValue);
			});
		}
	});
	
	$('a.date-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#saveForm #teach_idx').val() == 0 ) {
			alert('강좌정보가 없습니다.');
			return;
		}
		var teachDate = $(this).attr('keyValue');
		
		$('#saveForm #editMode').val('TOPSAVE');
		$('#saveForm #teach_date').val(teachDate);
		var scrollLeftValue = $('div#teachBookScroll').scrollLeft();
		if ( doAjaxPost($('#saveForm')) ) {
			$('div#teachBookLayer').load('teachBook.do?'+serializeCustom($('#saveForm')), function() {
				$('div#teachBookScroll').scrollLeft(scrollLeftValue);
			});
		}
	});
	
	$('a.name-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('#saveForm #teach_idx').val() == 0 ) {
			alert('강좌정보가 없습니다.');
			return;
		}
		var studentIdx = $(this).attr('keyValue');
		$('#saveForm #editMode').val('LEFTSAVE');
		$('#saveForm #student_idx').val(studentIdx);
		var scrollLeftValue = $('div#teachBookScroll').scrollLeft();
		if ( doAjaxPost($('#saveForm')) ) {
			$('div#teachBookLayer').load('teachBook.do?'+serializeCustom($('#saveForm')), function() {
				$('div#teachBookScroll').scrollLeft(scrollLeftValue);
			});
		}
	})
	
	$('select.paySelect').change(function() {
		var studentIdx 	= $(this).attr('keyValue1');
		var payType 	= $(this).attr('keyValue2');
		var value 		= $(this).val();
		
		$('#saveForm #editMode').val('PAYSAVE');
		$('#saveForm #student_idx').val(studentIdx);
		$('#saveForm #pay_type').val(payType);
		$('#saveForm #pay_value').val(value);
		var scrollLeftValue = $('div#teachBookScroll').scrollLeft();
		if ( doAjaxPost($('#saveForm')) ) {
			$('div#teachBookLayer').load('teachBook.do?'+serializeCustom($('#saveForm')), function() {
				$('div#teachBookScroll').scrollLeft(scrollLeftValue);
			});
		}
	});
	//$('#teachBookArea thead th, #teachBookArea thead td').css('height', '20px');
	$('#teachBookArea tbody td').css('height', '50px');
});	 
</script>
<form:form id="saveForm" modelAttribute="teachBook" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="student_idx"/>
	<form:hidden path="status"/>
	<form:hidden path="teach_date"/>
	<form:hidden path="sel_date"/>
	<form:hidden path="pay_type"/>
	<form:hidden path="pay_value"/>
	<form:hidden path="menu_idx"/>
</form:form>

<div class="wrapper wrapper-white " >
	<form:form modelAttribute="teachBook" action="index.do" method="get">
		<form:hidden path="menu_idx"/>
		<form:hidden path="homepage_id"/>
		<form:hidden path="group_idx"/>
		<form:hidden path="category_idx"/>
		<form:hidden path="teach_idx"/>
		<form:hidden path="sel_date"/>
		<h3>${teach.teach_name}</h3>
		<div class="calendar" style="width: 100%;">
			<h4 class="blind">출석시간현황 </h4>
			<div class="infodesk center">
			
				<div class="monthYear"> 
					<a href="#" id="month_prev" class="btn prev"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
					<b>${teachBook.sel_date}</b>
					<a href="#" id="month_next" class="btn next"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
					<!-- <a class="btn btn2 print-btn" style="float:right;">인쇄</a> -->
			    </div>
			    <br/>
			    <div class="form-group menuTypeBox" style="display: inline-flex; float: left;">
				종류 : 
				<div class="radio" style="margin-left: 15px;">
					<input type="radio" name="status" id="radio10" value="1" <c:if test="${teachBook.status eq 1}">checked="checked"</c:if>/>
					<label for="radio10">출석 (●)</label>
				</div>
				<div class="radio" style="margin-left: 15px;">
					<input type="radio" name="status" id="radio11" value="2" <c:if test="${teachBook.status eq 2}">checked="checked"</c:if>/>
					<label for="radio11" >지각 (△)</label>
				</div>
				<div class="radio" style="margin-left: 15px;">
					<input type="radio" name="status" id="radio12" value="3" <c:if test="${teachBook.status eq 3}">checked="checked"</c:if>/>
					<label for="radio12" >결석 (×)</label>
				</div>
				<div class="radio" style="margin-left: 15px;">
					<input type="radio" name="status" id="radio13" value="0" <c:if test="${teachBook.status eq 0}">checked="checked"</c:if>/>
					<label for="radio13" >없음 (-)</label>
				</div>
			</div>
			</div>
			<div class="calendar-table">
				<div id="teachBookScroll" class="box auto-scroll" style="height:400px; width:100%">
						<table id="teachBookArea" class="type1 center" >
							<thead>
								<tr>
									<th rowspan="2" style="padding:0px">번호</th>
									<th rowspan="2" >성명</th>
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
																	<c:otherwise><a class="status-btn" keyValue1="0" keyValue2="${oneStudent.student_idx}" keyValue3="${plan_date}">-</a></c:otherwise>
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
	</div>
<div class="ui-state-highlight" style="width:100%">
	( ● : 출석&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;△ : 지각&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;× : 결석&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- : 데이터없음 ) 기호는 버튼 입니다. 상단 종류를 선택후 클릭하면 즉시 반영 됩니다.<br/>
	* 날짜 클릭시 해당 날짜에 대해 모든 수강생들을 '출석(●)' 처리 가능 합니다.<br/>
	* 수강생 이름 클릭시 해당 수강생에 대해 모든 날짜를 '출석(●)' 처리 가능 합니다.<br/>
	* 일괄 처리 시 다소 시간이 걸릴수 있습니다.
</div>	
