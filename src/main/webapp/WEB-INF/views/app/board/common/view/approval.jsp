<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.approval_yn eq 'Y'}">
<dd class="info info2 center">
	<div class="add-fields">
		<a href="" class="btn btn2" id="board_approval_btn" disabled><i class="fa fa-thumbs-up"></i><span>찬성${board.approval_count}</span></a>
		<a href="" class="btn btn5" id="board_contrary_btn"><i class="fa fa-thumbs-down"></i><span>반대${board.contrary_count}</span></a>
	</div>
</dd>
</c:if>