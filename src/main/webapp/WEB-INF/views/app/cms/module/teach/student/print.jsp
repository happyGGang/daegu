<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
div#printPage table {
	font-size : 24px;
	width:100%; 
	heigth:100%;
}

div#printPage th {
	text-align: left;
	width : 40%;
}

</style>
<h1 style="text-align: center;">[ 독서 문화 강좌 ] 수강생 신청서 </h1>
<form id="printForm" method="post" action="save.do">
<input type="hidden" name="_csrf" value="${_csrf.token}">
	<table class="type2">
		<colgroup>
	       <col width="250" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>신청자-ID</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
			<tr>
	         	<th>신청자-명</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
        	<tr>
	         	<th>신청자-생년월일</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
        	<tr>
	         	<th>신청자-성별</th>
	         	<td>
	        		<input type="checkbox" id="" /> 남자
	        		<input type="checkbox" id="" /> 여자
	      		</td>
	        </tr>
	        <tr>
	         	<th>신청자-우편번호</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
	        <tr>
	         	<th>신청자-주소</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
			<tr> 
				<th>신청자-휴대전화번호</th>
				<td style="border: 1px solid #666 !important;"></td>
			</tr>
			<tr>
				<th>수강생 동일여부</th>
	        	<td>
	        		<input type="checkbox" id="" /> 같음
	        		<input type="checkbox" id="" /> 다름
	      		</td>
			</tr>
			<tr>
	         	<th>수강생-명</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
        	<tr>
	         	<th>수강생-생년월일</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
        	<tr>
	         	<th>수강생-나이</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
        	<tr>
	         	<th>수강생-성별</th>
	         	<td>
	         		<input type="checkbox" id="" /> 남자
	        		<input type="checkbox" id="" /> 여자
         		</td>
	        </tr>
	        <tr>
	         	<th>수강생-우편번호</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
	        <tr>
	         	<th>수강생-주소</th>			
	         	<td style="border: 1px solid #666 !important;">
	         	</td>
        	</tr>
        	<tr>
        		<th>수강생-사진촬영동의여부</th>
        		<td style="border: 1px solid #666 !important;">
        		</td>
        	</tr>
        	<tr>
	         	<th>수강생-학교</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
        	<tr>
	         	<th>수강생-학년</th>			
	         	<td style="border: 1px solid #666 !important;"></td>
        	</tr>
			<tr>
	         	<th>개인정보 동의 여부</th>
	         	<td >
	         		<input type="checkbox" id="" /> 동의
	        		<input type="checkbox" id="" /> 미동의
         		</td>
	        </tr>
	        <tr>
	        	<th>보호자 동일여부</th>
	        	<td>
	        		<input type="checkbox" id="" /> 같음
	        		<input type="checkbox" id="" /> 다름
	        	</td>
	        </tr>
	        <tr>
				<th>보호자 관계</th>
				<td style="border: 1px solid #666 !important;"></td>
			</tr>
			<tr>
				<th>보호자 이름</th>
				<td style="border: 1px solid #666 !important;"></td>
			</tr>
			<tr>
				<th>보호자 연락처</th>
				<td style="border: 1px solid #666 !important;"></td>
			</tr>
			<tr>
				<th>보호자 동의여부</th>
				<td>
					<input type="checkbox" id="" /> 동의
	        		<input type="checkbox" id="" /> 미동의
       			</td>
			</tr>
			<tr>
				<th>보호자SMS수신동의여부</th>
				<td>
					<input type="checkbox" id="" /> 동의
					<input type="checkbox" id="" /> 미동의
				</td>
			</tr>
	        <tr>
				<th>기관</th>
				<td style="border: 1px solid #666 !important;"></td>
			</tr>
	        <tr>
				<th>직급</th>
				<td style="border: 1px solid #666 !important;"></td>
			</tr>
	        <tr>
				<th>연수수강여부</th>
				<td>
					<input type="checkbox" id="" /> 이수
	        		<input type="checkbox" id="" /> 미이수
       			</td>
			</tr>

		</tbody>
	</table>
</form>
