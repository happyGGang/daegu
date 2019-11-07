<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('div#member-layer').load('memberList.do', serializeCustom($('form#emailSendForm')));
	
	$('div.tabmenu > ul > li > a').on('click', function(e) {

		if($('#codeList_1').val() == '') {
			alert('메뉴구분을 선택해주세요.');
			return false;
		}
			
		$('#tab_status').val($(this).attr('keyValue'));
		
		if($('#tab_status').val() == 'table1') {
			$('#apply_status').val('1');
		} else if($('#tab_status').val() == 'table2') {
			$('#apply_status').val('2');
		} else if($('#tab_status').val() == 'table3') {
			$('#apply_status').val('3');
		} else if($('#tab_status').val() == 'table4') {
			if($('#codeList_4').val() == '') {
				alert('강사현황을 보시려면 강좌를 선택해주세요.');
				return;
			}
			$('#apply_status').val('4');
		}
		
		$('div.tabmenu > ul > li').removeClass('active');
		$(this).parent().addClass('active');
		
		$('div#member-layer').load('memberList.do', serializeCustom($('form#emailSendForm')));
	});
});
</script>

<!--// 문자 전송 -->
<div style="float:left;width:700px;padding:0px 0px 0px 50px;">
	<div class="tabmenu tab1" style="padding:0px;">
		<ul>
			<li class="active"><a href="#" keyValue="table1" id="tabLi1">참여</a></li>
			<li class=""><a href="#" keyValue="table2" id="tabLi2">후보</a></li>
			<li class=""><a href="#" keyValue="table3" id="tabLi3">취소</a></li>
			<li class=""><a href="#" keyValue="table4" id="tabLi4">강사</a></li>
		</ul>
	</div>
	<div id="member-layer">
	
	</div>
</div>
