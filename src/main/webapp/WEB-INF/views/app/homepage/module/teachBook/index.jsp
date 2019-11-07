<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function(){
	$('div#teachBookLayer').load('teachBook.do?homepage_id=${teachBook.homepage_id}&group_idx=${teachBook.group_idx}&category_idx=${teachBook.category_idx}&teach_idx=${teachBook.teach_idx}&menu_idx=${teachBook.menu_idx}');
});	 
</script>
<div id="teachBookLayer">

</div>
