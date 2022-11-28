<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {	
	$('#locker_td').css('rowspan', $('#row_no').val() - $('#add_row_no').val());
	
	$('a.use_edit').on('click',function(e){
		$('#dialog-1').load('use_edit.do?use_yn=N&device_idx=' + $(this).attr('keyValue1') + '&locker_idx=' + $(this).attr('keyValue2') + '&locker_each_idx=' + $(this).attr('keyValue3') , function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});	
		e.preventDefault();	
	});
		
	$('a.use_locker').on('click',function(e){
		if (confirm($(this).attr('keyValue2') + '번 사물함을 사용하시겠습니까?')) {
			$('#lockerUseEdit #use_yn').val('Y');
			$('#lockerUseEdit #locker_idx').val($(this).attr('keyValue1'));
			if(doAjaxPost($('#lockerUseEdit'))) {
				location.reload();
			}
		}
		e.preventDefault();	
	});

});


</script>
<style>
.locker_wrap_left{
	float:left;
	width:49%;
	height:100%;
}
.locker_wrap_right{
	float:right;
	width:49%;
	height:100%;
}

.table_left_tr{
	position: relative;
	height:70px;
}
table.table_left > thead > tr > th{
	text-align: center;
	font-size: 20px;
}
table .table_left_td{
	position: relative;
}
table .table_left_td > .table_td_use_yn{
	position: absolute;
    top: 0px;
    left: 0px;
    width: 100%;
    height: 100%;    
}

.table_td_div2 > .table_td_div2_div1{
 	width: 53%;
    height: 21px;
}

.table_td_div2 > .table_td_div2_div2{
 	width: 44%;
    height: 21px;
    margin-left: 4px;
}

.table_td_div2 > .use_btn{
	display:inline-block;
	float:left;
	margin-top: 3px;
}

.table_td_div3 > .use_btn{
	display:inline-block;
	margin-top: 3px;
}

.table_td_div3 > .table_td_div2_div1{
    width: 69px;
    height: 26px;
}

.table_td_div3 > .table_td_div2_div2{	
    width: 69px;
    height: 26px;
} 

.table_td_div2_div1 > .reserve_status{
	font-size: 14px;
	width: 87px;
	font-weight: bold; 	 
    border-radius: 9px 9px 9px 9px;
    text-align: center;
    
}
.table_td_div2_div2 > .reserve_bookInfo1{
	margin-top: 3px;
	text-align: right;
	display:block;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;	
}

.table_td_div2 > .table_td_div2_div3{
	position: relative;
    width: 100%;
    height: 25px;
}

.table_td_div2_div3 > .reserve_bookInfo2{
	position: absolute;
	position: absolute;
    width: 100%;
    height: 21px;
    font-size: 13px;    
    margin-top: 4px;
	text-align: right;
	display:block;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}


</style>

<form:form modelAttribute="neighborhoodLibraryLocker" id="lockerUseEdit" action="locker_each_edit.do">
<form:hidden path="use_yn"/>
<form:hidden path="locker_idx"/>
</form:form>

<form:form modelAttribute="neighborhoodLibraryLocker" id="reserveConfig">
<form:hidden path="row_no" value="${lockerOne.row_no}"/>
<form:hidden path="add_row_no" value="${lockerOne.add_row_no}"/>
<div class="page-subtitle">
	<h3>${locker.device_name } : 사물함 보기</h3>
</div>
<div class="locker_wrap_left">
	<table class="type1 table_left">
		<thead>	
			<tr>
				<c:forEach var="i" varStatus="status" begin="1" end="${lockerOne.col_no }">
				<th>${status.index }열</th>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="j" varStatus="status_row" begin="1" end="${lockerOne.row_no }">	<!--세로줄 그리기 -->
				<tr class="table_left_tr">
					<c:forEach var="k" varStatus="status_col" begin="1" end="${lockerOne.col_no}"> <!-- 가로줄 그리기 -->
						<td class="table_left_td" id="${status_col.index eq lockerOne.monitor_position and status_row.index eq 1 ? 'locker_td':'' }" style="${status_col.index eq lockerOne.monitor_position and status_row.index lt (lockerOne.row_no - lockerOne.add_row_no)? 'border-bottom-color:#e7e7e7;':'' }${status_col.index eq lockerOne.monitor_position and status_row.index lt ((lockerOne.row_no + 1) - lockerOne.add_row_no)?'background-color: #e7e7e7;':''}"> <!-- 사물함 display가 들어갈 위치만큼 칸수 합치고 스타일 주기 -->														
							<c:forEach var="v" items="${lockerOneList }"> <!-- 사물함 정보 가져오기(행번호,열번호,사물함번호,사용유무) -->
									<c:choose>
										<c:when test="${v.col_num eq status_col.index and v.row_num eq status_row.index }">	<!-- 사물함 정보에서 가로,세로 번호에 맞게 데이터 가져오기 -->
											<div class="table_td_use_yn" style="${v.use_yn eq 'N'? 'background-color:#ff000021;':''}"> <!-- 사용하지 않으면 칸 배경을 붉은색으로 -->
												<div class="table_td_div1" style="color:#4e4e4ead; font-weight:bold; position: absolute; top:8px; left:13px; width:22px; height:24px; text-align:center; outline:2px solid #999; border-radius: 5px 5px 5px 5px;">
													${v.locker_each_idx } <!-- 사물함번호 -->
												</div>
												<div class="table_td_div2" style="position: absolute; top:8px; left:48px; width:72%; height:24px;">
													<div class="table_td_div2_div1 use_btn">
													<c:set var="reserveBundleIdx" value="0"/> 
													<c:set var="bookCount" value="0"/>	
														<c:forEach var="k" items="${neighborhoodLibraryList }" varStatus="status"> <!-- 사물함 사용중인 대출정보 가져오기 -->
															<c:if test="${v.locker_each_idx eq k.locker_idx }">	<!-- 현재 사물함 번호와 대출정보에 사물함 번호가 같은 데이터가 있을경우 -->
																<c:set var="editYn" value="N"/>
																<c:set var="bookCount" value="${bookCount + 1 }"/> <!-- 현재 사물함에 도서가 몇개 들어가는지 카운트 -->
			 													<c:if test="${reserveBundleIdx ne k.reserve_bundle_idx }"> 
			 														<c:set var="reserveBundleIdx" value="${k.reserve_bundle_idx }"/>
				 													<c:choose>
																		<c:when test="${k.reserve_status eq '2' }">
																			<p class="reserve_status" style="background-color: #439bed; margin:0 auto; color: white;">예약확정</p>
																		</c:when>
																		<c:when test="${k.reserve_status eq '3' }">
																			<p class="reserve_status" style="background-color: #f5a639; margin:0 auto; color: white;">사물함투입</p>
																		</c:when>
																		<c:when test="${k.reserve_status eq '5' }">
																			<p class="reserve_status" style="background-color: #888; margin:0 auto; color: white;">회수대기</p>
																		</c:when>
																	</c:choose>
																</c:if>
															</c:if>
														</c:forEach>
													</div>
													<div class="table_td_div2_div2 use_btn">	
														<c:if test="${'0' lt bookCount}">
															<p class="reserve_bookInfo1" style="font-size: 12px;">
																수량 : ${bookCount } 권
															</p>
														</c:if>
													</div>
													<c:if test="${v.use_yn eq 'N' }">
														<div class="table_td_div2_div3">
															<p class="reserve_bookInfo2" title="${v.unused_reason }">
																${v.unused_reason }
															</p>
														</div>		
													</c:if>
												</div>
												<div class="table_td_div3" style="position: absolute; top:28px; right:5px; width:155px; height:30px; z-index: 1;">
		 											<div class="table_td_div2_div1 use_btn">
			 											<c:if test="${v.use_yn eq 'N' and '0' eq bookCount }"> <!-- 사물함 사용중지일 경우 -->
															<a href="#" class="btn use_locker" keyValue1="${v.locker_idx }" keyValue2="${v.locker_each_idx }">사용하기</a>
														</c:if>
													</div>
													<div class="table_td_div2_div2 use_btn">
														<c:if test="${v.use_yn eq 'Y' and '0' eq bookCount }"> <!--  사물함 사용중일 경우 -->
															<a href="#" class="btn use_edit" keyValue1="${v.device_idx }" keyValue2="${v.locker_idx }" keyValue3="${v.locker_each_idx }">사용중지</a>	
														</c:if>
													</div>
												</div>
											</div>
										</c:when>
									</c:choose>
							</c:forEach>
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
		</tbody>
	</table>	
</div>
<div class="locker_wrap_right">
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="50" />
			<col width="200" />
			<col width="120" />
			<col width="110" />
			<col width="90" />
			<col width="90" />
			<col width="80" />
		</colgroup>
		<thead>
			<tr>
				<th colspan="8">사물함별 대출정보</th>
			</tr>
			<tr style="outline:white 1px solid">
				<th>번호</th>
				<th>사물함번호</th>
				<th>도서명</th>
				<th>소장도서관</th>
				<th>등록번호</th>
				<th>대출자ID</th>
				<th>예약확정일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(neighborhoodLibraryList) > 0 }">
			<c:forEach var="i" items="${neighborhoodLibraryList }" varStatus="status">
				<tr>
					<td>${neighborhoodLibraryCount - status.index }</td>
					<td>${i.locker_idx }</td>
					<td>${i.book_name }</td>
					<td>${i.lib_name }</td>
					<td>${i.reg_no }</td>
					<td>${i.member_id }</td>
					<td>
						<fmt:formatDate value="${i.lend_date}" pattern="yyyy.MM.dd" />
					</td>
					<td>						
						<c:choose>
							<c:when test="${i.reserve_status eq '2'}">
								대출승인
							</c:when>
							<c:when test="${i.reserve_status eq '3'}">
								사물함투입
							</c:when>
							<c:when test="${i.reserve_status eq '5'}">
								회수대기
							</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${fn:length(neighborhoodLibraryList) <= 0 }">
				<tr>
					<td colspan=7>데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>		
		</tbody>
	</table>
</div>	
</form:form>

<div id="dialog-1" class="dialog-common" title="사물함 사용중지 설정"></div>

