<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

		<c:if test="${empty closeDayList.dd}">
		<div class="h_img_box"><img src="/resources/homepage/dalseongchild/img/common/holy_day.svg" alt="휴관일"/></div>
                    <div class="title close_ment_wrap">
                        <p class="holy_txt close_ment">등록된 휴일이 없습니다.</p>
                    </div>
			
		</c:if>
		<c:if test="${not empty closeDayList.dd}">
		<div class="h_img_box"><img src="/resources/homepage/dalseongchild/img/common/holy_day.svg" alt="휴관일"/></div>
                    <div class="title">
                        <p class="holy_txt">우리 도서관 <span class="holy_bold">12월 휴관일</span>을 확인하세요!</p>
                    </div>
					<c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>
				<c:forEach items="${dd}" var="i">
                    <div class="holiday-section"><span>${i}</span>
				</c:forEach>			
				
		</c:if>

