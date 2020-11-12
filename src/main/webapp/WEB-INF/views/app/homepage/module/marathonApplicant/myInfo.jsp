<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(function() {
		$('button#back-btn').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	});
</script>
<table class="type2">
	<colgroup>
		<col width="160"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>신청일</th>
			<td><fmt:formatDate value="${marathonApplicant.add_date}" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${marathonApplicant.member_id}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${marathonApplicant.member_name}</td>
		</tr>
		<tr>
			<th>학교</th>
			<td>
				<c:set var="school_class" value="${fn:split(marathonApplicant.school_class, ',')}"/>
				<c:forEach var="school_class_split" items="${school_class}" varStatus="i">
					<c:if test="${i.count == 1}">${school_class_split}학년 </c:if>
					<c:if test="${i.last}">${school_class_split}반</c:if>
				</c:forEach> 
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				(${marathonApplicant.zipcode}) ${marathonApplicant.address_one} ${marathonApplicant.address_two}
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				${marathonApplicant.telephone}
			</td>
		</tr>
		<tr>
			<th>휴대전화번호</th>
			<td>
				${marathonApplicant.cellphone}
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				${marathonApplicant.email}
			</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				${marathonApplicant.gender == 'M' ? '남' : '여'}
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				${marathonApplicant.birthday}
			</td>
		</tr>
		<tr>
			<th>참가부문</th>
			<td>
				${marathonApplicant.contest_type} (${marathonApplicant.page_count}쪽)
			</td>
		</tr>
		<tr>
			<th>완주기념품</th>
			<td>
				${marathonApplicant.finish_memorial == 'document' ? '완주증서' : '완주메달'}
			</td>
		</tr>
		<tr>
			<th>각오한마디</th>
			<td>
				${marathonApplicant.determination_talk}
			</td>
		</tr>
	</tbody>
</table>
<br/>
<div class="button bbs-btn right">
	<button id="back-btn" class="btn"><i class="fa fa-reorder" title="뒤로가기"></i><span>뒤로가기</span></button>
</div>
