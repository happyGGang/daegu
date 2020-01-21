<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%pageContext.setAttribute("lf", "\n");%>
<style type="text/css">
.starRev .starR1, .starRev .starR2 {cursor: pointer;}
.starR1 {position: relative;display: inline-block;width: 14px;height: 23px;background: url("/resources/common/img/ico_star.png") no-repeat;background-size: 25px;overflow: hidden;z-index: 2;}
.starR2 {position: relative;display: inline-block;right: 18px;width: 28px;height: 24px;background: url("/resources/common/img/ico_star.png") no-repeat;background-size: 25px;margin-right: -25px;}
.starR1.on {background: url("/resources/common/img/ico_starColor.png") no-repeat;background-size: 25px;}
.starR2.on {background: url("/resources/common/img/ico_starColor.png") no-repeat;background-size: 25px;}

div.book-review-write {position: relative;padding: 21px 20px 22px 20px;z-index: 1;background-color: #f2f2f2}
div.book-review-write a {position: absolute;top: 0;right: 0;width: 100px;text-align: center;line-height: 73px;font-size: 110%;color: white;background: #959ca4;}
</style>
<script type="text/javascript">
$(document).ready(function() {

	$('.starRev span').on('click', function() {
		$(this).parent().children('span').removeClass('on');
		$(this).addClass('on').prevAll('span').addClass('on');
		return false;
	});

	$('#menu-rating-save').on('click', function(e) {
		e.preventDefault();
		var menu_rating_score = $('#starRevC .starR1.on, #starRevC .starR2.on').length * 0.5;
		$('form#menuRating input#menu_rating_score').val(menu_rating_score);
		doAjaxPost($('form#menuRating'), 'div#menuRatingDiv');
	});

});
</script>
<form:form modelAttribute="menuRating" action="/${homepage.context_path}/module/menuRating/save.do" method="POST">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="menu_rating_score"/>
</form:form>
<h5>만족도 평가</h5>
<div class="book-review-write">
	만족도를 평가해주세요.
	<div class="starRev" id="starRevC">
		<span class="starR1 on"></span>
		<span class="starR2"></span>
		<span class="starR1"></span>
		<span class="starR2"></span>
		<span class="starR1"></span>
		<span class="starR2"></span>
		<span class="starR1"></span>
		<span class="starR2"></span>
		<span class="starR1"></span>
		<span class="starR2"></span>
	</div>
	<a href="#" id="menu-rating-save">별점 등록</a>
</div>