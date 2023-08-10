<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<link rel="stylesheet" href="/resources/common/css/search/jqcloud.css" type="text/css">
<script type="text/javascript" src="/resources/common/js/jqcloud.js"></script>
<script type="text/javascript">
$(function() {
	
	<%-- 내집앞도서관 대출 신청 --%>	
	$('a#neighborhoodLibrary-save').on('click',function(e){
		e.preventDefault();
		if (!confirm('1. "내 집 앞 도서관" 서비스 도서신청시 부록자료 및 딸림자료는 함께 대출되지 않습니다.\n\r2. "내 집 앞 도서관" 서비스를 이용하여 대출한 도서만 운영기기에서 반납이 가능합니다.\r ※ 도서관 및 타 기기에서 대출한 도서는 반납이 불가능합니다.\n\r 3. 예약도서 수령을 위해서는 반드시 알림톡에 포함된 바코드 정보가 필요합니다. 대구통합도서관 알림톡을 "차단"상태로 해두신 회원은 반드시 "알림톡 받기" 상태로 변경부탁드립니다. \n\r 4. 동부도서관 자료의 경우 이시아 폴리스 메가박스를 통해서만 대출, 반납이 가능합니다. 반드시 반납시 이시아 폴리스 메가박스의 반납기로 반납 부탁드립니다. \n\r내집앞도서관대출을 예약 하시겠습니까?')) {
			return false;
		}
		if ($('select#device_idx').val() == '') {
			alert('수령받을 장소를 선택하세요.');
			$('select#device_idx').focus();
			return false;
		}
		
		if (doAjaxPost($('form#neighborhoodLibrary'))) {
			location.href='../index.do?menu_idx=${neighborhoodLibrary.menu_idx}';
		}
	
	});
	
	$('a#history-back').on('click', function(e) {
		e.preventDefault();
		history.back();
	});

});
</script>
<form:form id="neighborhoodLibrary" modelAttribute="neighborhoodLibrary" action="../neighborhoodLibrary/save.do" method="post">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<form:hidden path="menu_idx"/>
	<form:hidden path="book_isbn" />
	<form:hidden path="reg_no"/>
	<form:hidden path="ctrl_no"/>
	<form:hidden path="call_no"/>
	<form:hidden path="img_url"/>
	<form:hidden path="manage_code"/>
	<form:hidden path="lib_name"/>
	<form:hidden path="publer"/>
	<form:hidden path="author"/>
	<form:hidden path="book_key"/>
	<form:hidden path="booktype"/>
	<form:hidden path="appendix_info"/>
	<form:hidden path="shelf_loc_name"/>
	<form:hidden path="return_plan_date"/>
	<form:hidden path="publisher"/>
	<form:hidden path="pub_year"/>
	<form:hidden path="media_name"/>
	<form:hidden path="media_code"/>
	<form:hidden path="price"/>
	<form:hidden path="title_info"/>
	<form:hidden path="page"/>
	<form:hidden path="book_size"/>

	<div class="" style="box-sizing:border-box;padding:25px;border:1px solid #eaeaea;">
		<h3 class="nbl">신청 유의 사항</h3>
		<ul class="nbl-list">
			<li>1. "내 집 앞 도서관" 서비스 도서신청시 부록자료 및 딸림자료는 함께 대출되지 않습니다.</li>
			<li>2. "내 집 앞 도서관" 서비스를 이용하여 대출한 도서만 운영기기에서 반납이 가능합니다.<br/> ※ 도서관 및 타 기기에서 대출한 도서는 반납이 불가능합니다.</li>
			<li>3. 예약도서 수령을 위해서는 반드시 알림톡에 포함된 바코드 정보가 필요합니다. 대구통합도서관 알림톡을 "차단"상태로 해두신 회원은 반드시 "알림톡 받기" 상태로 변경부탁드립니다. </li>
			<!--<li>4. 동부도서관 자료의 경우 이시아 폴리스 메가박스를 통해서만 대출, 반납이 가능합니다. <span style="color:#ff0000;">반납시 이시아 폴리스 메가박스의 반납기</span>로 반납 부탁드립니다.</li>-->
		</ul>
	</div>
	<br/>
	<div class="delibery_info">
        <div class="" style="padding:10px 0;font-size:120%">(<span style="color:red;font-weight:bold;">*</span>) 항목은 필수 선택값 입니다.</div>
        <table class="editTbl">
            <colgroup>
                <col width="28%" />
                <col width="*"/>
            </colgroup>
            <tbody>
            <tr>
                <th>신청인</th>
                <td>
                    ${sessionScope.member.member_name}
                </td>
            </tr>
            <tr>
                <th>(<span style="color:red;font-weight:bold;">*</span>)수령장소(장비)</th>
                <td>
                    <form:select path="device_idx">
						<option value="" label="- 수령장소를 선택 하세요 -"/>
						<c:forEach var="i" items="${deviceList }">
							<form:option value="${i.device_idx }" label="${i.device_name }"/>
						</c:forEach>						
					</form:select>
                </td>
            </tr>
            <tr>
                <th>도서명</th>
                <td>${neighborhoodLibrary.title_info} / ${neighborhoodLibrary.author}</td>
            </tr>
            <tr>
                <th>등록번호</th>
                <td>${neighborhoodLibrary.reg_no}</td>
            </tr>
            </tbody>
        </table>
        <div class="btnArea" style="text-align: center; padding-top: 25px;">
        	<a href="#" id="neighborhoodLibrary-save" class="btn">내 집 앞 도서관 대출 예약</a>
            <a href="javascript:history.back();" id="cancel-btn" class="btn btn02">취소</a>            
        </div>
    </div>
</form:form>