<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
#finishCertificate{width:100%; padding:5%; border:solid 1px #ddd;}
#printTable td {
	border-width: 0px !important;
	border-color: #f00 !important;
}
.dalseo_logo {
	width: 100%;
	margin: 0 auto;
}
.dalseo_symbol {
	float: left;
	margin-left: 20px;
	;
}
.dalseo_slogan {
	float: right;
	margin-right: 20px;
	;
}
</style>
<script type="text/javascript">
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true,
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
			$('.ui-widget-overlay').removeClass('custom-overlay');
		},
		buttons: [
			{
				text: "출력",
				"class": 'btn btn1',
				click: function() {
				   if ((!!document.documentMode == true )) {

					var divToPrint = document.getElementById("printTable");
					var newWin = window.open("","_blank","width=700, height=880, left=500, top=0");
					   newWin.document.write(divToPrint.outerHTML);
					   newWin.document.close();
					   newWin.focus();
					   newWin.print();
					   newWin.close();

				   } else {

					var divToPrint = document.getElementById("printTable");
					var newWin = window.open("");
					   newWin.document.write(divToPrint.outerHTML);
					   newWin.print();
					   newWin.close();
				}

				}
			},{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 800
	});

});
</script>
	<fmt:formatDate value="${certificateInfo.finish_date}" pattern="yyyy-MM-dd" var="finish_date"/>
  <div id="finishCertificate">
    <div class="dalseo_logo"><img src="/resources/homepage/dalseolib/img/symbol.png" alt="달서구 심볼" class="dalseo_symbol"/><img src="/resources/homepage/dalseolib/img/slogan.png" alt="달서구 슬로건" class="dalseo_slogan"/></div>
    <table id="printTable" class="center" style="text-align:center;width:100%;height:100%;">
      <tbody>
        <tr>
          <td colspan="5" height="18%"><h1 style="font-family:'궁서체';font-size:55px;">완 주 증 서</h1></td>
        </tr>
        <tr>
          <td height="5%"></td>
          <td style="text-align:right;font-family:'궁서체';font-size:21px;">성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>
          <td colspan="3" style="text-align:left;font-family:'궁서체';font-size:21px;">: ${certificateInfo.member_name}</td>
        </tr>
        <tr>
          <td height="5%"></td>
          <td style="text-align:right;font-family:'궁서체';font-size:21px;">학 교(학 년)</td>
          <td colspan="3" style="text-align:left;font-family:'궁서체';font-size:21px;">:
	          <c:if test="${certificateInfo.school_name ne '' || certificateInfo.school_name ne null}">
	          	${certificateInfo.school_name}(${fn:split(certificateInfo.school_class, ',')[0]}학년)
	          </c:if>
          </td>
          
        </tr>
        <tr>
          <td height="5%"></td>
          <td style="text-align:right;font-family:'궁서체';font-size:21px;">부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;문</td>
          <td colspan="3" style="text-align:left;font-family:'궁서체';font-size:21px;">: ${certificateInfo.contest_type}</td>
        </tr>
        <tr>
          <td height="5%"></td>
          <td style="text-align:right;font-family:'궁서체';font-size:21px;">기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;록</td>
          <td colspan="3" style="text-align:left;font-family:'궁서체';font-size:21px;">: ${fn:replace(finish_date, '-', '.')} (${certificateInfo.read_page_count_total}쪽)</td>
        </tr>
        <tr>
          <td colspan="5" height="25%" style="text-align:center;"><div style="width:80%;margin:0 auto;">
              <h1 style="font-family:'궁서체';font-size:25px;text-align:left;">위의 학생(분)은 제13회 달서독서마라톤대회 상기종목에 참가하여 성실한 독서활동으로 완주하였기에 이 증서를 드립니다.</h1>
            </div></td>
        </tr>
        <tr>
          <td colspan="5" style="text-align:center;font-family:'궁서체';font-size:25px;"><strong>${fn:split(finish_date, '-')[0]}</strong>년<strong> ${fn:split(finish_date, '-')[1]}</strong>월<strong> ${fn:split(finish_date, '-')[2]}</strong>일</td>
        </tr>
        <tr>
          <td colspan="5" height="100px"><h1 style="text-align:center;font-family:'궁서체';font-size:30px;">대구광역시 달서구청장 이 태 훈</h1></td>
        </tr>
      </tbody>
    </table>
	</div>


