<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script>
	var words = [];
	var color_rand = ['#3efffd', '#ffed27', '#fff' ,'#1444bf', '#ff0c00', '#a800ff', '#444444', '#48e22f', '#e22f6a', '#ff890a'];
	var weight_rand = ['100','200','300','400', '500', '600', '700', '800', '900'];
	
	<c:forEach var="i" varStatus="status" items="${bookKeywordList}">
		var obj = new Object();
		obj.text = '${i.keyword_name}';
		obj.color = color_rand[Math.floor(Math.random()*color_rand.length)];
		obj.weight = weight_rand[Math.floor(Math.random()*weight_rand.length)];
// 		obj.link = 'view.do?menu_idx='+menu_idx+'&keyword_name=${i.keyword_name}';
		words.push(obj);
		$('#demo_word_'+status.index).css('margin','15px')
	</c:forEach>
	
	$('#keyword').jQCloud(words, {});
</script>

<div id="keyword">
</div>