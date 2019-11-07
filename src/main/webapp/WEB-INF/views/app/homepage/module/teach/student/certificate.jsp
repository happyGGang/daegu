<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
#printTable td {
	border-width:0px !important;
	border-color:#f00 !important;
}
</style>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<table id="printTable" class="center" style="text-align: center; width:100%;height:100%;">
    <tbody >
    	<tr>
     		<td colspan="2" style="text-align:left;">제 ${certificateInfo.num} 호</td>
     		<td width="40%"></td>
     		<td colspan="2" style="text-align:right;">발급처 : ${certificateInfo.homepage_name}</td>
   		</tr>
   		<tr>
     		<td colspan="5" height="30%" style="font-size: 40px;"><h1>수 료 증</h1></td>
   		</tr>
    	<tr>
    		<td></td>
    		<td style="text-align:left;">성 명</td>
    		<td style="text-align:left;">: ${certificateInfo.student_name}</td>
    		<td colspan="2"></td>
    	</tr>
    	<tr>
    		<td></td>
    		<td style="text-align:left;">과 정 명</td>
    		<td colspan="2" style="text-align:left;">: ${certificateInfo.teach_name}</td>
    		<td ></td>
    	</tr>  	
    	<tr>
    		<td></td>
    		<td style="text-align:left;">과 정 기 간</td>
    		<td style="text-align:left;">: ${certificateInfo.teach_date}</td>
    		<td colspan="2"></td>
    	</tr>
    	<tr>
    		<td></td>
    		<td style="text-align:left;">장 소</td>
    		<td style="text-align:left;">: ${certificateInfo.teach_stage}</td>
    		<td colspan="2"></td>
    	</tr>
    	<tr>
     		<td colspan="5" height="50%"><h1>위 사람은 도서관에서 실시한 상기 과정을</h1><br/><h1>마쳤으므로 이 증서를 드립니다.</h1></td>
   		</tr>
   		<tr>
     		<td colspan="3" ></td>
     		<td colspan="2" >${fn:split(certificateInfo.end_date, '-')[0]}년 ${fn:split(certificateInfo.end_date, '-')[1]}월 ${fn:split(certificateInfo.end_date, '-')[2]}일</td>
   		</tr>
   		<tr>
     		<td colspan="5" height="100px"><h1>${certificateInfo.homepage_name}</h1></td>
   		</tr>
	</tbody>
</table>
