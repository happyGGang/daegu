<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style type="text/css">
.starR1 {position: relative;display: inline-block;float: left;width: 17.5px;height: 30px;font-size: 35px;color:#ccc;overflow: hidden;z-index: 2;cursor: pointer;}
.starR2 {position: relative;display: inline-block;float: left;right: 17.5px;width: 30px;height: 30px;font-size: 35px;color:#ccc;margin-right: -18px;z-index: 1;cursor: pointer;}
.starR1.on {color: red;}
.starR2.on {color: red;}
</style>
<script type="text/javascript">
$(function() {
	$form = $('form#bookReviewEdit');

	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					var br_score = $('#starRevU .starR1.on, #starRevU .starR2.on').length * 0.5;
					$('form#bookReviewEdit input#br_score').val(br_score);
					doAjaxPost($form);
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 330
	});
	
	$('.starRev span').on('click', function() {
    	$(this).parent().children('span').removeClass('on');
    	$(this).addClass('on').prevAll('span').addClass('on');
    	return false;
    });

});
</script>
<form:form modelAttribute="bookReview" id="bookReviewEdit" method="post" action="/cms/module/bookReview/save.do">
	<form:hidden path="br_idx" id="br_idx_U"/>
	<form:hidden path="editMode" id="editMode_U"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
        	<tr id="memberIdTr">
	         	<th>작성자</th>
	         	<td>${bookReview.br_web_id}</td>
	       	</tr>
			<tr>
				<th>서평 점수</th>
				<td>
					<div class="starRev" id="starRevU">
						<span class="starR1 <c:if test="${bookReview.br_score >= 0.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${bookReview.br_score >= 1}">on</c:if>">★</span>
						<span class="starR1 <c:if test="${bookReview.br_score >= 1.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${bookReview.br_score >= 2}">on</c:if>">★</span>
						<span class="starR1 <c:if test="${bookReview.br_score >= 2.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${bookReview.br_score >= 3}">on</c:if>">★</span>
						<span class="starR1 <c:if test="${bookReview.br_score >= 3.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${bookReview.br_score >= 4}">on</c:if>">★</span>
						<span class="starR1 <c:if test="${bookReview.br_score >= 4.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${bookReview.br_score >= 5}">on</c:if>">★</span>
					</div>
					<form:hidden path="br_score"/>
				</td>
			</tr>
        	<tr>
	         	<th>서평 내용</th>
	         	<td>
	         		<form:textarea path="br_content" cols="40" rows="5"/>
	         	</td>
        	</tr>
		</tbody>
	</table>
</form:form>
