<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	$('a#memberInfoBtn').on('click', function(e) {
		$('div#member_layer').show();
		$('div.calAll').show();
		e.preventDefault();
	});
	$('a#closeMemberInfo').on('click', function(e) {
		$('div#member_layer').hide();
	});
});
</script>
<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
<div style="padding:18px;box-sizing:border-box">
<div id="memberInfo">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
<div>
	<div class="inbox" id="member_layer">
		<div class="calAll" >
			<img class="boxnImg box1" id="loginIcon" src="/resources/common/img/login01.png" alt=""/>
			<div class="loginInfo">
				<div class="boxn box2_1">최근 로그인<br/> <span class="fontBlue"><fmt:formatDate value="${sessionScope.member.last_login}" pattern="yyyy.MM.dd HH:mm"/></span><br/></div>
				
				
				<div class="boxn box3_1">최근 접속 IP<br/> <span class="fontBlue">${sessionScope.member.last_login_ip}</span></div>
			</div>
			
			<div style="margin-top: -15px; text-align: center;"><img id="line" src="/resources/common/img/line01.png" style="width:96%;height: 6px;" alt=""></div> 
			 
			<div style="text-align: center;">
				<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/modifyForm.do?menu_idx=${modifyFormMenuIdx}" class="btn">회원정보수정</a>
				<c:if test="${sessionScope.member.link_member_yn eq 'Y' and member.login}">
					<c:if test="${sessionScope.member.loginType eq 'CMS'}">
				<a href="/intro/${homepage.context_path}/login/changeLoginType.do" class="btn btn4"><i class="fa fa-plus"></i><span>일반사용자 전환</span></a>
					</c:if>
					<c:if test="${sessionScope.member.loginType eq 'HOMEPAGE'}">
				<a href="/intro/${homepage.context_path}/login/changeLoginType.do" class="btn btn3"><i class="fa fa-plus"></i><span>관리자 전환</span></a>
					</c:if>
				</c:if>
			</div>
			
			<div class="memberCon" style="margin-top: 10px;">
				<div class="memberCon2">
					<strong>개인정보 재동의 기간</strong>: <span class="fontRed">~${sessionScope.member.agree_date_str}</span><br/><br/>
					<ol style="list-style-position: outside; list-style-type:disc; margin-left: 12px;">
						<c:if test="${sessionScope.member.auth_id eq '20000'}">
						<li>해당 년월일 동안 대출이력이 없으면 개인정보가 삭제됩니다.</li>
						</c:if>
						<c:if test="${sessionScope.member.auth_id eq '30000'}">
						<li>해당 년월일 이후 개인정보가 삭제됩니다.</li>
						</c:if>
						<li>회원자격 유지기간을 연장하려면 아래의 연장 버튼을 클릭하세요.</li>
					</ol>
					<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/reAgree.do?menu_idx=${modifyFormMenuIdx}" class="btn btnStyle">연장</a>
					<br/>
				</div>
			</div>
		</div>
		<c:choose>
		<c:when test="${homepage.context_path eq 'app'}">
		</c:when>
		<c:otherwise>
		<a href="#" id="closeMemberInfo" class="close" title="닫기"><i class="fa fa-close"></i></a>
		</c:otherwise>
		</c:choose>


	</div>
</div>
<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
</div>
</div>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>