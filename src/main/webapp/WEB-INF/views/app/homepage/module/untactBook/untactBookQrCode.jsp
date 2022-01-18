<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript" src="/resources/common/js/jquery.qrcode.js"></script>
<script type="text/javascript" src="/resources/common/js/qrcode.js"></script>

<script type="text/javascript">
    jQuery("#gcDiv").qrcode({   //qrcode 시작
        render : "canvas",      //table, canvas 형식 두 종류가 있다. 
        width : 350,            //넓이 조절
        height : 350,           //높이 조절
        text   : "${untactBookReservation.locker_password}"     //QR코드에 실릴 문자열
    });
</script>
<div id="gcDiv"></div>