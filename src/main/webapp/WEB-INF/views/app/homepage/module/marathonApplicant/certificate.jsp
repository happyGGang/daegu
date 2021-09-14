<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
#printTable td {
	border-width: 0px !important;
	border-color: #f00 !important;
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
					var newWin = window.open("","_blank");
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
					$('#dialog-2').attr('style', 'display:none;');
				}
			}
		]
	});

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 850,
		height: 900
	});

});
</script>
	<c:set var="userAgentInfo" value="${header['User-Agent']}"/>
	<c:choose>
	<c:when test="${fn:contains(userAgentInfo, 'Chrome')}">
    <table id="printTable" class="center" style="text-align:center;width:80%;height:80%;border:2px solid black;margin-top:10%;margin-left:10%;border-collapse:collapse;">
    </c:when>
    <c:when test="${fn:contains(userAgentInfo, 'Trident')}">
    <table id="printTable" class="center" style="text-align:center;width:100%;height:100%;border:2px solid black;border-collapse:collapse;">
    </c:when>
    </c:choose>
      <tbody>
      	<tr>
      		<td><img src="/resources/homepage/dalseolib/img/symbol.png" alt="달서구 심볼" class="dalseo_symbol" height="41px;" width="109px;"/></td>
      		<td></td>
      		<td></td>
      		<td></td>
      		<td style="padding-left:10%;"><img src="/resources/homepage/dalseolib/img/slogan.png" alt="달서구 슬로건" class="dalseo_slogan" height="24px;" width="211px;"/></td>
      	</tr>
        <tr>
          <td colspan="5" height="18%"><h1 style="font-family:'HY견명조';font-size:70px;">완 주 증 서</h1></td>
        </tr>
        <tr>
        	<td colspan="5" style="font-family:'HY울릉도M';font-size:21px;height:40px;">
        		<div style="width:80%;max-width:600px;margin:0 auto;border-bottom:1px solid gray;font-size:21px;text-align:left;padding-bottom:5px;">
                   	<span style="padding-left:30px;"></span>
                   	성<span style="padding-left:60px;"></span>명
                   	<span style="padding-left:50px;"></span>
          			${certificateInfo.member_name}
          		</div>
          	</td>
        </tr>
        <c:choose>
	        <c:when test="${certificateInfo.age_type ne 'adult'}">
	        <tr>
	        	<td colspan="5" style="font-family:'HY울릉도M';font-size:21px;height:40px;">
	        		<div style="width:80%;max-width:600px;margin:0 auto;border-bottom:1px solid gray;font-size:21px;text-align:left;padding-bottom:5px;">
	            		<span style="padding-left:30px;"></span>
	            		학교(학년)
	            		<span style="padding-left:50px;"></span>
			            <c:if test="${certificateInfo.school_name ne '' && certificateInfo.school_name ne null}">
		          	  	${certificateInfo.school_name}(${fn:split(certificateInfo.school_class, ',')[0]}학년)
			            </c:if>
		            </div>
		         </td>
		    </tr>
	        </c:when>
	        <c:otherwise>
	        	<tr>
		            <td colspan="5" style="font-family:'HY울릉도M';font-size:21px;height:40px;">
		            	<div style="width:80%;max-width:600px;margin:0 auto;border-bottom:1px solid gray;font-size:21px;text-align:left;padding-bottom:5px;">         
		                <span style="padding-left:30px;"></span>            
		                            소<span style="padding-left:60px;"></span>속
		                <span style="padding-left:50px;"></span>
			            <c:choose>
			            	<c:when test="${certificateInfo.address_dong eq '10'}">
			            		갈산동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '20'}">
			            		감삼동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '30'}">
			            		대곡동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '40'}">
			            		대천동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '50'}">
			            		도원동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '60'}">
			            		두류1,2동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '70'}">
			            		두류3동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '80'}">
			            		본동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '90'}">
			            		본리동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '100'}">
			            		신당동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '110'}">
			            		성당동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '120'}">
			            		상인동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '130'}">
			            		상인1동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '140'}">
			            		상인2동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '150'}">
			            		상인3동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '160'}">
			            		송현동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '170'}">
			            		송현1동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '180'}">
			            		송현2동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '190'}">
			            		이곡1동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '200'}">
			            		이곡2동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '210'}">
			            		용산1동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '220'}">
			            		용산2동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '230'}">
			            		유천동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '240'}">
			            		월성동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '250'}">
			            		월성1동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '260'}">
			            		월성2동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '270'}">
			            		월암동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '280'}">
			            		진천동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '290'}">
			            		장동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '300'}">
			            		죽전동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '310'}">
			            		장기동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '320'}">
			            		파산동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '330'}">
			            		파호동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '340'}">
			            		호림동
			            	</c:when>
			            	<c:when test="${certificateInfo.address_dong eq '350'}">
			            		호산동
			            	</c:when>
			            	<c:otherwise>
			            		${certificateInfo.address_dong}
			            	</c:otherwise>
			            </c:choose>
			        	</div>
		            </td>
	        	</tr>
	        </c:otherwise>
        </c:choose>
        <tr>
        	<td colspan="5" style="font-family:'HY울릉도M';font-size:21px;height:40px;">
	           	<div style="width:80%;max-width:600px;margin:0 auto;border-bottom:1px solid gray;font-size:21px;text-align:left;padding-bottom:5px;">
		            <span style="padding-left:30px;"></span>
		                     부<span style="padding-left:60px;"></span>문
		            <span style="padding-left:50px;"></span>
		          	${certificateInfo.contest_type}
	          	</div>
          	</td>
        </tr>
        <tr>
        	<td colspan="5" style="font-family:'HY울릉도M';font-size:21px;height:40px;">
	           	<div style="width:80%;max-width:600px;margin:0 auto;border-bottom:1px solid gray;font-size:21px;text-align:left;padding-bottom:5px;">
           			<span style="padding-left:30px;"></span>
           			기<span style="padding-left:60px;"></span>록
           			<span style="padding-left:50px;"></span>
           			${fn:replace(finish_date, '-', '.')} (${certificateInfo.read_page_count_total}쪽)
           		</div>
           	</td>
        </tr>
        <tr>
          <td colspan="5" style="text-align:center;"><div style="width:90%;line-height:50px;margin:0 auto;">
              <h1 style="font-family:'HY견명조';display:inline-block;line-height:150%;font-size:26px;text-align:left;font-weight:bold;letter-spacing:-3px;">
                         위의 학생(분)은 제13회 달서독서마라톤 대회<br/>
              <span style="word-spacing:10px;">상기종목에 참가하여 성실한 독서활동으로</span><br/>
                         완주하였기에 이 증서를 드립니다.
              </h1>
            </div></td>
        </tr>
        <tr>
          <td colspan="5" style="text-align:center;font-family:'HY견명조';font-size:25px;">
          	<strong>${fn:split(marathonInfo.finish_day, '-')[0]}</strong>년
          	<strong><span style="padding-left:30px;"></span>
	          	<c:choose>
	          		<c:when test="${fn:substring(fn:split(marathonInfo.finish_day, '-')[1], 0, 1) == '0'}">
	          			${fn:substring(fn:split(marathonInfo.finish_day, '-')[1], 1, 2)}
	          		</c:when>
	          		<c:otherwise>
	          			${fn:split(marathonInfo.finish_day, '-')[1]}
	          		</c:otherwise>	
	          	</c:choose>
          	</strong>월
          	<strong><span style="padding-left:30px;"></span>
          		<c:choose>
          			<c:when test="${fn:substring(fn:split(marathonInfo.finish_day, '-')[2], 0, 1) == '0'}">
          				${fn:substring(fn:split(marathonInfo.finish_day, '-')[2], 1, 2)}
          			</c:when>
          			<c:otherwise>
          				${fn:split(marathonInfo.finish_day, '-')[2]}
          			</c:otherwise>
          		</c:choose>
          	</strong>일
          </td>
        </tr>
        <tr>
          <td colspan="5" height="100px" width="80%;" style="font-weight:bold;"><h1 style="text-align:center;font-family:'HY견명조';font-size:30px;letter-spacing:-3px;"><strong>대구광역시 달서구청장</strong> <span style="font-size:50px;"><strong>이 태 훈</strong></span></h1></td>
        </tr>
      </tbody>
    </table>


