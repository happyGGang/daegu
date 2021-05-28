<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<h3 class="contTit_line">구독형 전자책</h3>
<br/>
<ul class="con">
	<!-- <li> 구독형 전자책은 매년 도서목록을 갱신하여 연간단위로 이용하는 전자책서비스</li> -->
	<li> 이용대상: 도서관 회원(대출카드 소지자)</li>
	<li> 대출정책: 월(月) 7권<!-- <br/>※ 현재 한시적 10권, 소장형 전자책과 별도 이용 가능--></li>
	<li> 한 도서 당 이용자 수 제한 없이 이용 가능</li>
	<li> 전자책 대출 시 15일 후 자동반납</li>
	<li> PC에서 이용 시 실행프로그램 다운로드(최초 1회) 후 읽기 가능</li>
	<!-- <li> 예산 소진 시 서비스 조기 종료될 수 있음.</li> -->
</ul>


<form name="frm_kyobo_ebook" id="frm_kyobo_ebook" method="post" action="https://daegu.dkyobobook.co.kr/frontapi/mmbrLnkg.ink" accept-charset="UTF-8" target="_blank">
	<input id="user_id" name="user_id" type="hidden" value="${sessionScope.member.member_id}"/>
	<input type="hidden" name="user_type" value ="T1">
	<input type="hidden" name="user_type_name" value ="회원">
	<input id="libraryCode" name="libraryCode" type="hidden" value="24709" />
	<div class="btn_area txt-center">

<c:choose>
	<c:when test="${empty sessionScope.member.user_no or sessionScope.member.user_no eq '' or sessionScope.member.user_no eq 'null'}">
		<c:choose>
			<c:when test="${sessionScope.member.member_id eq 'ebookadmin'}">
				<a href="#" class="btn btn2 newWin" onclick="dwfrmsubmit();"> <b>구독형 전자책</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
			</c:when>
			<c:otherwise>
				<a href="#" class="btn btn2 newWin" onclick="alert('정회원만 이용가능합니다.');"> <b>구독형 전자책</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<a href="#" class="btn btn2 newWin" onclick="dwfrmsubmit();"> <b>구독형 전자책</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
	</c:otherwise>
</c:choose>

	</div>
</form>


<script type="text/javascript">
	function dwfrmsubmit() {
		$('#frm_kyobo_ebook').submit();
	}
</script>