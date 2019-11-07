<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {	
	$('#module_table .checkAll').on('click', function(e) {
		if($("#module_table .checkAll").prop("checked")) {
			$("input[class=checkOne]").not(":disabled").prop("checked",true);
		} else {
			$("input[class=checkOne]").prop("checked",false);
		}
	});
	
	$('#loan_search_table .checkAll').on('click', function(e) {
		if($("#loan_search_table .checkAll").prop("checked")) {
			$("input[class=checkOne]").not(":disabled").prop("checked",true);
		} else {
			$("input[class=checkOne]").prop("checked",false);
		}
	});
	
	//select box 제어
	if($('select#codeList_1').val() == '1') {
		$('div.selectBox').css('display','none');
	
		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		
		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');
		
		$('div > ul > li > a#tabLi4').css('display','block');
		$('div > ul > li > a#tabLi3').css('display','block');
		$('div > ul > li > a#tabLi2').css('display','block');
		
		$('div > ul > li > a#tabLi1').text('참여');
		$('div > ul > li > a#tabLi2').text('후보');
		$('div > ul > li > a#tabLi3').text('취소');
		
	} else if($('select#codeList_1').val() == '2') {
		$('div.selectBox').css('display','none');
		
		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		$('div > ul > li > a#tabLi2').css('display','block');
		
		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');
		$('#div_select_list5').css('display','inline');
		
		$('div > ul > li > a#tabLi1').text('승인');
		$('div > ul > li > a#tabLi2').text('대기');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');
		
	} else if($('select#codeList_1').val() == '3') {
		$('div.selectBox').css('display','none');
		
		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		$('div > ul > li > a#tabLi2').css('display','block');
		
		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');
		
		$('div > ul > li > a#tabLi1').text('완료');
		$('div > ul > li > a#tabLi2').text('접수');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');
		
	} else if($('select#codeList_1').val() == '4') {
		$('div.selectBox').css('display','none');
		
		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		$('div > ul > li > a#tabLi2').css('display','block');		
		
		$('#div_select_list2').css('display','inline');
		
		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('미승인');
		$('li#table3').css('display','none');
		
		$('div > ul > li > a#tabLi1').text('승인');
		$('div > ul > li > a#tabLi2').text('미승인');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');
		
	} else if($('select#codeList_1').val() == '5') {
		$('div.selectBox').css('display','none');
		
		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		$('div > ul > li > a#tabLi2').css('display','block');
		
		$('#div_select_list2').css('display','inline');
		
		$('#table1 > a > font').text('배정완료');
		$('#table2 > a > font').text('대기자');
		$('li#table3').css('display','none');
		
		$('div > ul > li > a#tabLi1').text('배정완료');
		$('div > ul > li > a#tabLi2').text('대기자');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');
	} else if($('select#codeList_1').val() == '6') {
		$('div.selectBox').css('display','none');		
		
		$('div#module_table').css('display','block');
		$('div#loan_search_table').css('display','none');
		
		$('#div_datepicker').css('display','inline');
		$('div > ul > li > a#tabLi2').css('display','block');
		
		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('미승인');
		$('li#table3').css('display','none');
		
		$('div > ul > li > a#tabLi1').text('승인');
		$('div > ul > li > a#tabLi2').text('미승인');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');
	} else if($('select#codeList_1').val() == '7') {
		$('div.selectBox').css('display','none');				
		$('#div_datepicker').css('display','inline');
		
		$('div#module_table').css('display','none');
		$('div#loan_search_table').css('display','block');
		
		$('#loan_member_search').css('display','inline');
		
		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('미승인');		
		$('li#table3').css('display','none');
		
		$('div > ul > li > a#tabLi1').text('회원');		
		$('div > ul > li > a#tabLi2').css('display','none');
		$('div > ul > li > a#tabLi3').css('display','none');
		$('div > ul > li > a#tabLi4').css('display','none');
	} else {
		$('div.selectBox').css('display','none');
	}
	
	if($('div#module_table').css('display') == 'block') {
		$('font#reception').text($("#module_table input[class=checkOne]").not(":disabled").length);
		$('font#notreception').text($("#module_table input[class=checkOne]").not(":enabled").length);	
	} 
	if($('div#loan_search_table').css('display') == 'block') {
		$('font#reception').text($("#loan_search_table input[class=checkOne]").not(":disabled").length);
		$('font#notreception').text($("#loan_search_table input[class=checkOne]").not(":enabled").length);
	}
	
	var currDate = new Date();
	var currYear = currDate.getFullYear();
	var currMonth = currDate.getMonth()+1;
	if (currMonth < 10) {
		currMonth = '0'+currMonth;
	}
	
	if($('#start_date').val() == '') {		
		$('#start_date').val(currYear + "-" + currMonth + "-01");		
	}
	
	if($('#end_date').val() == '') {		
		$('#end_date').val(currYear + "-" + currMonth + "-" + currDate.getDate());
	}
	
});
</script>
<div style="float:left;width:50%" id="listCount">
<!-- 	<font color="blue;">※사용자 정보가 조회 되지 않는 사용자는 수신여부가 'X'로 표기됩니다.</font> -->
	총 : ${fn:length(applyList)}명
</div>
<div style="float:right;width:50%" align="right">
	
	수신가능 : <font id="reception"></font>명 
<!-- 	수신불가 : <font id="notreception"></font>명 -->
</div>

<div class="table-wrap">
	<div class="table-scroll">
		<div id="module_table" style="display:block;">
			<table id="table1" class="type1 center">
				<thead>
					<tr>
						<th style="width:10px;"><input type="checkbox" id="checkAll" class="checkAll" name="checkbox"/></th>
						<th style="width:65px;">이름</th>
						<th style="width:100px;">전화번호</th>
						<th style="width:100px;">수신여부</th>
						<th style="width:200px;">기타</th>
					</tr>
				</thead>
				<tbody style="height:360px">
					<c:forEach var="i" varStatus="status" items="${applyList}">
						<c:if test="${i.sms_yn eq 'Y'}">
						<tr>
							<td style="width:10px;">
								<input type="checkbox" id="c${status.index}" class="checkOne" name="checkbox" value="${i.member_phone }"<c:if test="${i.sms_yn ne 'Y' or i.member_phone eq ''}">disabled="true"</c:if>/></label>
							</td>
							<td style="width:65px;">
								<label for="c${status.index}">${i.member_name}</label>
							</td>
							<td style="width:100px;">
								${i.member_phone }
							</td>
							<td style="width:100px;">
								${i.sms_yn}
							</td>
							<td style="width:200px;">
								${i.imsi_v_1}
								<c:if test="${i.sms_yn eq 'X' }">
									(사용자 정보 조회할수 없음)
								</c:if>
							</td>
						</tr>
						</c:if>
					</c:forEach>
					<c:if test="${fn:length(applyList) < 1}">
						<tr>
							<td colspan="5" style="height:100%">조회된 데이터가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div id="loan_search_table" style="display:none;">
			<table id="table1" class="type1 center">
				<thead>
					<tr>
						<th style="width:10px;"><input type="checkbox" id="checkAll" class="checkAll" name="checkbox"/></th>
						<th style="width:50px;">회원번호</th>
						<th style="width:50px;">전화번호</th>
						<th style="width:50px;">수신여부</th>
						<th style="width:30px;">신분</th>
						<th style="width:30px;">성별</th>
						<th style="width:50px;">생년월일</th>
						<th style="width:100px;">주소</th>
						<th style="width:75px;">기관/소속</th>
					</tr>
				</thead>
				<tbody style="height:360px">
					<c:forEach var="i" varStatus="status" items="${applyList}">					
						<c:if test="${i.SMS_CHECK eq 'Y'}">
							<tr>
								<td style="width:10px;">
									<input type="checkbox" id="c${status.index}" class="checkOne" name="checkbox" value="${i.MOBILE_NO }" <c:if test="${i.SMS_CHECK ne 'Y' }">disabled="true"</c:if>/></label>
								</td>
								<td style="width:50px;">
									<label for="c${status.index}">${i.USER_NO}</label>
								</td>
								<td style="width:50px;">${fn:substring(i.MOBILE_NO, 0, 3)}<br/> ${fn:substring(i.MOBILE_NO, 3, 7)}<br/>${fn:substring(i.MOBILE_NO, 7, 11)}</td>
								<th style="width:50px;">
									<c:if test="${i.SMS_CHECK ne ''}">
										${i.SMS_CHECK }
									</c:if>
									<c:if test="${i.SMS_CHECK eq ''}">
										X
									</c:if>
								</th>
								<td style="width:30px;">${i.USER_POSITN_NAME}</td>
								<td style="width:30px;">${i.SEX_NAME}</td>
								<td style="width:50px;">${fn:substring(i.BIRTHD, 0, 4)}<br/>${fn:substring(i.BIRTHD, 4, 8)}</td>
								<td style="width:100px;">${i.ADDRS}</td>
								<td style="width:75px;">${i.CMPNY_NAME}</td>
							</tr>
						</c:if>
					</c:forEach>
					<c:forEach var="i" varStatus="status" items="${applyList}">					
						<c:if test="${i.SMS_CHECK eq 'Q'}">
<!-- 							미수신자는 목록에 표시하지 않는다. 미수신자는 SMS_CHECK == N -->
							<tr>
								<td style="width:10px;">
									<input type="checkbox" id="c${status.index}" class="checkOne" name="checkbox" value="${i.MOBILE_NO }" <c:if test="${i.SMS_CHECK ne 'Y' }">disabled="true"</c:if>/></label>
								</td>
								<td style="width:50px;">
									<label for="c${status.index}">${i.USER_NO}</label>
								</td>
								<td style="width:50px;">${fn:substring(i.MOBILE_NO, 0, 3)}<br/> ${fn:substring(i.MOBILE_NO, 3, 7)}<br/>${fn:substring(i.MOBILE_NO, 7, 11)}</td>
								<th style="width:50px;">
									<c:if test="${i.SMS_CHECK ne ''}">
										${i.SMS_CHECK }
									</c:if>
									<c:if test="${i.SMS_CHECK eq ''}">
										X
									</c:if>
								</th>
								<td style="width:30px;">${i.USER_POSITN_NAME}</td>
								<td style="width:30px;">${i.SEX_NAME}</td>
								<td style="width:50px;">${fn:substring(i.BIRTHD, 0, 4)}<br/>${fn:substring(i.BIRTHD, 4, 8)}</td>
								<td style="width:100px;">${i.ADDRS}</td>
								<td style="width:75px;">${i.CMPNY_NAME}</td>
							</tr>
						</c:if>
					</c:forEach>
					<c:if test="${fn:length(applyList) < 1}">
						<tr>
							<td colspan="8" style="height:100%">조회된 데이터가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
$('div#loading2, img#loading_img2').hide();
</script>
