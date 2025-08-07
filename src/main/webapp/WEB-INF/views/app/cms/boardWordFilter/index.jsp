<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('a#btn_save').on('click', function(e) {
		e.preventDefault();
		var content = $('textarea#word').val().trim();
		var useY = $('input#use_yn1').is(':checked');
		if (useY && content.length < 1) {
			alert('필터링할 단어를 입력해주세요. 필터링할 단어가 없을 경우 \'사용안함\'을 선택하세요.');
			return false;
		}
		if(doAjaxPost($('#boardWordFilter'))) {
			location.reload();
		}
	});
});
</script>
<div class="container-box">
    <div class="page-header">
        <div>게시글 불량단어 차단</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <form:form modelAttribute="boardWordFilter" action="save.do" method="post" onsubmit="return false;" cssStyle="width: 100%">
        <div class="table-action-wrapper">
            <div class="btn-wrapper">
                <p class="total-count">게시판 단어 필터링 사용유무 :</p>

                <div class="btn-wrapper">
                    <form:radiobutton path="use_yn" value="Y" />
                    <label for="">사용함</label>
                </div>

                <div class="btn-wrapper">
                    <form:radiobutton path="use_yn" value="N" />
                    <label for="">사용안함</label>
                </div>
            </div>

            <c:if test="${authC}">
                <a href="" class="icon-btn navy" id="btn_save">
                    <img src="/resources/cms/img/main/plus.svg" alt="">
                    <div>저장</div>
                </a>
            </c:if>
        </div>
        <form:textarea path="word" cssStyle="height:200px;width: -webkit-fill-available; margin-top: 10px; padding: 10px" cssClass="custom-input"/>
        <ul class="guide-line" style="margin-top: 10px">
            <li>단어와 단어를 , 로 구분하여 주세요. (예 : 개나리, 십장생)</li>
        </ul>
        </form:form>
    </div>
</div>