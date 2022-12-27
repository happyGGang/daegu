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
.table_left td{
	width:30%;
}
.line1{
	height:23px;
}
.line2{
	height:23px;
	margin-top: 8px;
}
.line1_all{
	display: inline-block;
	float: left;
}
.line2_all{
	display: inline-block;
	float: left;	
}
.line1_1{
	border: 1px solid gray;
	border-radius: 5px 5px 5px 5px;
	width:20px;
	height: 23px;
	text-align: center;
}
.line1_2{
	width: 90px;
	height:  23px;
	margin-left: 10px;
}
.line1_3{
	width: 125px;
	height: 23px;
	margin-left: 10px;
}
.line2_1{
	width: 100px;
	height: 23px; 
	margin-left: 32px;
	border-radius: 5px 5px 5px 5px;
    text-align: center;
}
.line2_2{
	width: 100px;
	height: 23px;
	margin-left: 10px;
	border-radius: 5px 5px 5px 5px;
	text-align: center;
}

</style>
<form:form id="nearbyLibLocker" modelAttribute="nearbyLibLocker" method="post" action="save.do">
	<table class="type1 table_left">
		<thead>
			<tr>
				<th colspan="3" style="text-align:center;">사물함별 대출정보</th>
			</tr>
		</thead>	
		<tbody>
			<tr>
				<td>
					<div class="line1">
						<div class="line1_1 line1_all">1</div>
						<div class="line1_2 line1_all">
							<c:if test="${lockerEach.no1.reserve_status ne 'no-data'}">
								<c:choose>
									<c:when test="${lockerEach.no1.reserve_status eq '2'}">
										<p style="background-color: #439bed; border-radius: 10px 10px 10px 10px; color:white; width:73px; text-align: center;">예약확정</p>
									</c:when>
									<c:when test="${lockerEach.no1.reserve_status eq '3'}">
										<p style="background-color: #f5a639; border-radius: 10px 10px 10px 10px; color:white; width:88px; text-align: center;">사물함투입</p>
									</c:when>
									<c:when test="${lockerEach.no1.reserve_status eq '5'}">
										<p style="background-color: #888; border-radius: 10px 10px 10px 10px; color:white; width:73px; text-align: center;">회수대기</p>
									</c:when>
								</c:choose>
							</c:if>
						</div>
						<div class="line1_3 line1_all">
							<c:if test="${lockerEach.no1.reserve_status ne 'no-data'}">
								<p>${lockerEach.no1.sameReserve} 권</p>
							</c:if>
						</div>	
					</div>
					<div class="line2">
						<div class="line2_1 line2_all">
							<c:if test="${lockerEach.no1.reserve_status ne 'no-data' and lockerEach.no1.use_yn eq 'N'}">
								<a href="javescript:void(0);" class="edit_use">
								<span style="border-radius:5px 5px 5px 5px; border:1px gray solid;">사용하기</span>
								</a>
							</c:if>
						</div>
						<div class="line2_2 line2_all">
							<c:if test="${lockerEach.no1.reserve_status ne 'no-data' and lockerEach.no1.use_yn eq 'Y'}">
								<a href="javescript:void(0);" class="edit_use" keyValue="${lockerEach.no1.locker_each_idx}">
									<span style="border-radius:5px 5px 5px 5px; border:1px gray solid;">사용중지</span>
								</a>
							</c:if>
						</div>	
					</div>
				</td>
				<td rowspan=16 style="background-color: #8080803b;"></td>
				<td>17</td>
			</tr>
			<tr>
				<td>2</td>
				<td>18</td>
			</tr>
			<tr>
				<td>3</td>
				<td>19</td>
			</tr>
			<tr>
				<td>4</td>
				<td>20</td>
			</tr>
			<tr>
				<td>5</td>
				<td>21</td>
			</tr>
			<tr>
				<td>6</td>
				<td>22</td>
			</tr>
			<tr>
				<td>7</td>
				<td>23</td>
			</tr>
			<tr>
				<td>8</td>
				<td>24</td>
			</tr>
			<tr>
				<td>9</td>
				<td>25</td>
			</tr>
			<tr>
				<td>10</td>
				<td>26</td>
			</tr>
			<tr>
				<td>11</td>
				<td>27</td>
			</tr>
			<tr>
				<td>12</td>
				<td>28</td>
			</tr>
			<tr>
				<td>13</td>
				<td>29</td>
			</tr>
			<tr>
				<td>14</td>
				<td>30</td>
			</tr>
			<tr>
				<td>15</td>
				<td>31</td>
			</tr>
			<tr>
				<td>16</td>
				<td>32</td>
			</tr>
		</tbody>
	</table>	
</form:form>