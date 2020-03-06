<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
//<![CDATA[

onload = function(){

<c:choose>
	<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
		alert("대출회원(정회원)으로 로그인 후 사용하세요.");
		window.opener = 'nothing';
		window.open('','_parent','');
		window.close();
	</c:when>
	<c:otherwise>
		$('#goEbookTest').submit();
	</c:otherwise>
</c:choose>

}

//]]>
</script>
<c:choose>
	<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
		<c:choose>
			<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
			</c:when>
			<c:otherwise>
				<c:set var="libCode" value="${sessionScope.member.user_no}"/>

				<form id="goEbookTest" action="https://real.e-lib.tglnet.or.kr/elib_sso.asp" method="post" accept-charset="utf-8"> 
		
				<c:if test="${homepage.context_path eq 'jungang' or homepage.context_path eq 'dgportal'}">
				<input type="hidden"  name="lib_code" value="122004" />
				</c:if>
				<c:if test="${homepage.context_path eq 'dongbu'}">
				<input type="hidden"  name="lib_code" value="122010" />
				</c:if>
				<c:if test="${homepage.context_path eq 'seobu'}">
				<input type="hidden"  name="lib_code" value="122008" />
				</c:if>
				<c:if test="${homepage.context_path eq 'nambu'}">
				<input type="hidden"  name="lib_code" value="122009" />
				</c:if>
				<c:if test="${homepage.context_path eq 'bukbu'}">
				<input type="hidden"  name="lib_code" value="122003" />
				</c:if>
				<c:if test="${homepage.context_path eq 'duryu'}">
				<input type="hidden"  name="lib_code" value="122002" />
				</c:if>
				<c:if test="${homepage.context_path eq 'suseong'}">
				<input type="hidden"  name="lib_code" value="122007" />
				</c:if>
				<c:if test="${homepage.context_path eq 'dalseong'}">
				<input type="hidden"  name="lib_code" value="122011" />
				</c:if>
				<c:if test="${homepage.context_path eq '228'}">
				<input type="hidden"  name="lib_code" value="122001" />
				</c:if>
				<c:if test="${homepage.context_path eq '228lib'}">
				<input type="hidden"  name="lib_code" value="127058" />
				</c:if>
				
				<input type="hidden"  name="user_id" value="${sessionScope.member.member_id}" />
				<input type="hidden"  name="name" value="${sessionScope.member.member_name}" />
				<input type="hidden"  name="next" value="default" />
				</form>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>




