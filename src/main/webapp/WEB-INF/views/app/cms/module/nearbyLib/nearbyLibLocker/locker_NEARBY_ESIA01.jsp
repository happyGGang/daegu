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
		if (confirm($(this).attr('keyValue3') + '번 사물함을 사용하시겠습니까?')) {
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
.table_left td{
	padding:0;
}
.line1{
	height:30px;
}
.line2{
	height:23px;
	margin:10px 0;
}
.line1_all{
	display: inline-block;
	float: left;
}
/*.line2_all{
	display: inline-block;
	float: left;	
}*/
.line1_1{
	background:rgba(0,0,0,0.5);
	width:15px;
	padding:5px 8px;
	text-align: center;
	font-size:12px;
	color:#fff;
	margin-top:0;
}
.line1_2{
	width: 90px;
	height:  23px;
	margin-left: 30px;
}
.line1_3{
	width: 100px;
	height: 23px;
	margin-left: 10px;
}
.line1_3 > p{
	float:right;
}
.line2_1{
	border-radius: 5px 5px 5px 5px;
    text-align: center;
}
.line2_2{
	text-align: center;
	position:relative;
	margin:0 auto;
}
</style>

<form:form modelAttribute="nearbyLibLocker" id="lockerUseEdit" action="locker_each_edit.do">
<form:hidden path="use_yn"/>
<form:hidden path="locker_idx"/>
</form:form>

<form:form id="nearbyLibLocker" modelAttribute="nearbyLibLocker" method="post" action="save.do">
	<table class="type1 table_left">
		<colgroup>
			<col width="33%">
			<col width="">
			<col width="33%">
		</colgroup>
		<thead>
			<tr>
				<th colspan="3" style="text-align:center;">이시아 메가박스 사물함 관리</th>
			</tr>
		</thead>	
		<tbody>
			<tr>
				<td ${lockerEach.no1.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no1"/>
					</jsp:include>
				</td>
				<td rowspan='18' style="background-color: #8080803b;"></td>
				<td  ${lockerEach.no19.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no19"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no2.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no2"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no20.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no20"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no3.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no3"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no21.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no21"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no4.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no4"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no22.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no22"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no5.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no5"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no23.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no23"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no6.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no6"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no24.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no24"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no7.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no7"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no25.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no25"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no8.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no8"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no26.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no26"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no9.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no9"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no27.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no27"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no10.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no10"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no28.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no28"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no11.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no11"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no29.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no29"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no12.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no12"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no30.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no30"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no13.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no13"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no31.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no31"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no14.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no14"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no32.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no32"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no15.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no15"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no33.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no33"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no16.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no16"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no34.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no34"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no17.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no17"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no35.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no35"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td ${lockerEach.no18.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no18"/>
					</jsp:include>
				</td>
				<td ${lockerEach.no36.use_yn eq 'N' ? 'style="background-color:#ff000014;"':''}>
					<jsp:include page="/WEB-INF/views/app/cms/module/nearbyLib/nearbyLibLocker/locker_inner_td.jsp" flush="false">
						<jsp:param name="lockerEachKey" value="no36"/>
					</jsp:include>
				</td>
			</tr>
		</tbody>
	</table>	
</form:form>

<div id="dialog-1" class="dialog-common" title="사물함 사용설정"></div>