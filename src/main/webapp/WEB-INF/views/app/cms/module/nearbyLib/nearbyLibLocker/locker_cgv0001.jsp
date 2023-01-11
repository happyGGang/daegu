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
	
	$('a.use_edit').on('click',function(e){
		$('#dialog-1').load('use_edit.do?use_yn=N&device_idx=' + $(this).attr('keyValue1') + '&locker_idx=' + $(this).attr('keyValue2') + '&locker_each_idx=' + $(this).attr('keyValue3') , function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});	
		e.preventDefault();	
	});
	
	$('a.use_locker').on('click',function(e){
		if (confirm($(this).attr('keyValue2') + '번 사물함을 사용하시겠습니까?')) {
			$('#lockerUseEdit #use_yn').val('Y');
			$('#lockerUseEdit #locker_idx').val($(this).attr('keyValue2'));
			if(doAjaxPost($('#lockerUseEdit'))) {
				location.reload();
			}
		}
		e.preventDefault();	
	});
	
});
</script>
<style>
.table_left_cgv td{
	height:150px;
	width: 90px;
}
.line1{
	height:80px;
	width: 90px;
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
	height:  23px;
	margin: 10px auto;
}
.line1_3{
	height: 23px;
	margin-left: 10px;
	width:80px;
}
.line1_3 > p{
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}
.line2_1{
	height: 23px; 
	margin-left: 32px;
	border-radius: 5px 5px 5px 5px;
    text-align: center;
}
.line2_2{
	height: 23px;
	margin-left: 10px;
	border-radius: 5px 5px 5px 5px;
	text-align: center;
}
</style>

<form:form modelAttribute="nearbyLibLocker" id="lockerUseEdit" action="locker_each_edit.do">
<form:hidden path="use_yn"/>
<form:hidden path="locker_idx"/>
</form:form>

<form:form id="nearbyLibLocker" modelAttribute="nearbyLibLocker" method="post" action="save.do">
	<table class="table_left_cgv">
		<thead>
			<tr>
				<th colspan="7" style="text-align:center;">연경cgv 사물함 관리</th>
			</tr>
		</thead>	
		<tbody>
			<tr>
				<td ${lockerEach.no1.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no1"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no6.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no6"/>
					</jsp:include>
				</td>
				<td colspan=3 style="background-color: #8080803b; border-bottom-color: #9990;"></td>
				<td ${lockerEach.no17.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no17"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no22.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no22"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no2.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no2"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no7.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no7"/>
					</jsp:include>
				</td>
				<td colspan=3 style="background-color: #8080803b;"></td>
				<td ${lockerEach.no18.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no18"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no23.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no23"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no3.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no3"/>
					</jsp:include>
				</td>
				<td>
				</td>
				<td ${lockerEach.no8.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no8"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no11.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no11"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no14.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no14"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no19.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no19"/>
					</jsp:include>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no4.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no4"/>
					</jsp:include>
				</td>
				<td>
				</td>
				<td ${lockerEach.no9.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no9"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no12.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no12"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no15.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no15"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no20.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no20"/>
					</jsp:include>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no5.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no5"/>
					</jsp:include>
				</td>
				<td>
				</td>
				<td ${lockerEach.no10.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no10"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no13.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no13"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no16.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no16"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no21.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no21"/>
					</jsp:include>
				</td>
				<td>
				</td>
			</tr>
		</tbody>
	</table>	
</form:form>

<div id="dialog-1" class="dialog-common" title="사물함 사용설정"></div>