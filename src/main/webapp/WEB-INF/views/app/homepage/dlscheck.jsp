<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<form name="frm_board_change" id="frm_board_change" method="post" action="http://reading.edunavi.kr/r/reading/search/ebookView_dg_ck.jsp">
	<input name="return_url" type="hidden" value="http://library.daegu.go.kr/dgportal/html/dlscheck.do"/>
	<input name="reading_id" type="text" value="" placeholder='아이디'/>
	<input name="reading_pw" type="password" value="" placeholder='비번' />
	<input name="reading_name" type="text" value="" placeholder='이름' />
	<input type='submit' value='확인'/>
</form>

