<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#relayLectureView').serialize());
	});
	
	$('a.apply_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('step2.do', serializeCustom($('form#relayLectureView')));
	});
	
});
</script>

<form:form modelAttribute="relayLecture" id="relayLectureView" >
  <form:hidden path="homepage_id"/>
  <form:hidden path="menu_idx"/>
  <form:hidden path="lecture_idx"/>
  <table class="tbl-type01">
    <colgroup>
    <col width="20%">
    <col width="30%">
    <col width="20%">
    <col width="30%">
    </colgroup>
    <thead>
      <tr>
        <th class="center" colspan="4">${getRelayLecture.event_name}</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th>행사일자</th>
        <td>${getRelayLecture.event_start_date} ~ ${getRelayLecture.event_end_date}</td>
        <th>행사시간</th>
        <td>${getRelayLecture.event_start_time} ~ ${getRelayLecture.event_end_time}</td>
      </tr>
      <tr>
        <th>행사장소</th>
        <td>${getRelayLecture.event_place}</td>
        <th>모집인원</th>
        <td>${getRelayLecture.recruitment_number}명</td>
      </tr>
      <tr>
        <th>신청 가능 기간</th>
        <td colspan="3">${getRelayLecture.apply_start_date} ${getRelayLecture.apply_start_time} ~ ${getRelayLecture.apply_end_date} ${getRelayLecture.apply_end_time} </td>
      </tr>
      <tr>
        <td class="center" colspan="4" style="height: 100px; padding: 20px 0; vertical-align: top;"><div style="margin-bottom: 20px;">
            <c:choose>
              <c:when test="${getRelayLecture.apply_status eq '0'}"> <span class="btn btn4" style="padding: 10px; font-size: 20px;">신청 대기 기간입니다.</span> </c:when>
              <c:when test="${getRelayLecture.apply_status eq '1'}">
                <div class="link_btn02"> <a href="#" class="apply_btn" data-key="${i.lecture_idx}" >강연 신청하기</a> </div>
              </c:when>
              <c:when test="${getRelayLecture.apply_status eq '2'}"> <span class="btn btn5" style="padding: 10px; font-size: 20px;">접수가 마감 되었습니다.</span> </c:when>
              <c:when test="${getRelayLecture.apply_status eq '3'}"> <span class="btn btn6" style="padding: 10px; font-size: 20px;">신청가 마감 되었습니다.</span> </c:when>
            </c:choose>
          </div>
          <c:if test="${getRelayLecture.server_file_name ne NULL}">
            <div style="margin-bottom: 20px;"> <img src="${getContextPath}/data/relayLecture/${relayLecture.homepage_id}/${getRelayLecture.server_file_name}" alt="${getRelayLecture.event_name}"> </div>
          </c:if>
          ${getRelayLecture.conrtents} </td>
      </tr>
      <tr> </tr>
    </tbody>
  </table>
  <div class="button bbs-btn" style="margin-top: 10px; text-align: right;"> <a href="#" id="list_btn" class="btn btn2">목록으로</a> </div>
</form:form>
